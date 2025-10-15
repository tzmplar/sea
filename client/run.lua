---- environment ----

local serialize        = loadstring(game:HttpGet "https://gist.githubusercontent.com/tzmplar/e9de2052ca2479c8a2dc343daae58c98/raw/a37ffcac797eeb8c824a182f00c314ccb2ef3d47/serialize.luau")()

local u32, u16, u8     = serialize.u32, serialize.u16, serialize.u8
local string, float    = serialize.string, serialize.float
local color, vector    = serialize.color, serialize.vector
local cframe           = serialize.cframe

local readu8, readu64  = memory.readu8, memory.readu64
local readu16, readf32 = memory.readu16, memory.readf32

---- constants ----

local BasePart = { "Part", "MeshPart", "SpawnLocation", "WedgePart", "UnionPart" }

---- variables ----

local offset, payload = 0, buffer.create(1e7)

---- functions ----

local function pack(Object)
    local parent     = tonumber(Object.Parent and Object.Parent.Data) or 0
    local archivable = readu8(Object, 0x58)
    local class      = Object.ClassName

    offset = u32(payload, offset, parent)                                     -- Parent
    offset = string(payload, offset, class)                                   -- ClassName
    offset = u8(payload, offset, archivable)                                  -- Archivable
    offset = u32(payload, offset, tonumber(Object.Data) :: number)            -- Address
    offset = string(payload, offset, Object.Name)                             -- Name

    if(table.find(BasePart, class)) then
        local description = Object.Description
        if not description then description = Object.Description end
        
        local primitive = readu64(Object, 0x170)

        offset = u8(payload, offset, if description.CanCollide then 1 else 0) -- CanCollide
        offset = color(payload, offset, description.Color3)                   -- Color3
        offset = vector(payload, offset, description.Velocity)                -- Velocity
        offset = cframe(payload, offset, {
            Position = Object.Position,
            LookVector = Object.LookVector,
            RightVector = Object.RightVector,
            UpVector = Object.UpVector,
        })                                                                    -- CFrame

        offset = vector(payload, offset, description.Size)                    -- Size
        offset = u16(payload, offset, readu16(primitive, 0x246))              -- Material
        offset = float(payload, offset, readf32(Object, 0xEC))                -- Reflectance
        offset = float(payload, offset, description.Transparency)             -- Transparency
        offset = u8(payload, offset, readu8(primitive, 0xBA))                 -- Anchored
        offset = u8(payload, offset, readu8(Object, 0xF5))                    -- CastShadow
        offset = u8(payload, offset, readu8(Object, 0xF7))                    -- Massless
        offset = u8(payload, offset, readu8(Object, 0xF6))                    -- Locked
    end

    if class == "MeshPart" then
        offset = string(payload, offset, Object.MeshId)                       -- MeshId
        offset = string(payload, offset, Object.TextureId)                    -- TextureId
    end

    local children = Object:GetChildren(); do
        offset = serialize.u32(payload, offset, #children)

        for _, child in children do
            pack(child)
        end
    end

    return payload
end

---- runtime ----

local start = os.clock()
pack(game)
print(`packed in {os.clock() - start} seconds`)

local Connection = WebsocketClient.new("ws://localhost:8008"); do
    assert(Connection, "failed to connect to server")
    
    local actual = buffer.tostring(payload):sub(1, offset)
    Connection:Send(crypt.base64.encode(actual), true)
    print(`sent payload to the server`)
end
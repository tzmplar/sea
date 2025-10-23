---- environment ----

local Roblox      = require "@lune/roblox"
local network     = require "@lune/net"
local fs          = require "@lune/fs"

local deserialize = require("@self/deserialize")
local base64      = require("@self/base64")

---- constants ----

local BasePart = { "Part", "MeshPart", "SpawnLocation", "WedgePart", "UnionPart" }

---- variables ----

local dataModel
local offset = 0

---- functions ----

local function reconstruct(pos, right, up, look)
    local position = Roblox.Vector3.new(pos.x, pos.y, pos.z)
    local x = Roblox.Vector3.new(right.x, right.y, right.z)
    local y = Roblox.Vector3.new(up.x, up.y, up.z)
    look = Roblox.Vector3.new(look.x, look.y, look.z)

    return Roblox.CFrame.fromMatrix(position, x, y, look * -1)
end

local function unpack(data: buffer): (number, Roblox.Instance?)
    local class, archivable, name

    if offset + 4 > buffer.len(data) then
        print(`buffer overflow: offset: {offset}, length: {buffer.len(data)}`)
        return offset, nil
    end

    offset             = deserialize.u32(data, offset)    -- Parent
    offset, class      = deserialize.string(data, offset) -- ClassName
    offset, archivable = deserialize.u8(data, offset)     -- Archivable
    offset             = deserialize.u32(data, offset)    -- Address
    offset, name       = deserialize.string(data, offset) -- Name

    local Success, Instance = pcall(Roblox.Instance.new, class)

    if(Success) then
        pcall(function() Instance.Name = name end)
        Instance.Archivable = (archivable == 1)
    end

    if(table.find(BasePart, class)) then
        local collision, color, velocity, cframe, size
        local material, reflectance, transparency
        local anchored, shadow, massless, locked

        offset, collision    = deserialize.u8(data, offset)     -- CanCollide
        offset, color        = deserialize.color(data, offset)  -- Color3
        offset, velocity     = deserialize.vector(data, offset) -- Velocity
        offset, cframe       = deserialize.cframe(data, offset) -- CFrame
        offset, size         = deserialize.vector(data, offset) -- Size
        offset, material     = deserialize.u16(data, offset)    -- Material
        offset, reflectance  = deserialize.float(data, offset)  -- Reflectance
        offset, transparency = deserialize.float(data, offset)  -- Transparency
        offset, anchored     = deserialize.u8(data, offset)     -- Anchored
        offset, shadow       = deserialize.u8(data, offset)     -- CastShadow
        offset, massless     = deserialize.u8(data, offset)     -- Massless
        offset, locked       = deserialize.u8(data, offset)     -- Locked

        for index, item in Roblox.Enum.Material:GetEnumItems() do
            if(item.Value == material) then
                material = item

                break
            end
        end

        Instance.CanCollide   = (collision == 1)
        Instance.Color        = Roblox.Color3.fromRGB(color.r, color.g, color.b)
        Instance.Velocity     = Roblox.Vector3.new(velocity.x, velocity.y, velocity.z)
        Instance.CFrame       = reconstruct(cframe.Position, cframe.RightVector, cframe.UpVector, cframe.LookVector)

        Instance.Size         = Roblox.Vector3.new(size.x, size.y, size.z)
        if(type(material) == "userdata") then
            Instance.Material = material
        end

        Instance.Reflectance  = reflectance
        Instance.Transparency = transparency
        Instance.Anchored     = (anchored == 1)
        Instance.CastShadow   = (shadow == 1)
        Instance.Massless     = (massless == 1)
        Instance.Locked       = (locked == 1)
    end

    if class == "MeshPart" then
        local mesh, texture
        offset, mesh      = deserialize.string(data, offset)
        offset, texture   = deserialize.string(data, offset)
        offset, init      = deserialize.vector(data, offset)

        if string.match(mesh, "^http") or string.match(mesh, "^rbxassetid://") then
            Instance.MeshId = mesh
            Instance.InitialSize = init
        end

        if string.match(texture, "^http") or string.match(texture, "^rbxassetid://") then
            Instance.TextureID = texture
        end
    end

    local count
    offset, count = deserialize.u32(data, offset)
    assert(count <= 100000, `child count too high: {count} for {class} '{name}'`)

    for i = 1, count do
        local child
        offset, child = unpack(data)

        if(Success and Instance and child) then
            child.Parent = Instance
        end
    end

    return offset, if Success then Instance else nil
end

---- runtime ----

network.serve(8008, {
    handleWebSocket = function(socket)
        local payload = buffer.tostring(base64.decode(buffer.fromstring(socket:next())))
        print(`received payload ({#payload} bytes)`)

        _, dataModel = unpack(buffer.fromstring(payload))
        fs.writeFile("DataModel.rbxl", Roblox.serializePlace(dataModel))

        print('done')
    end
})

print(`serving on ws://localhost:8008`)

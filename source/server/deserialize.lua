---- environment ----

local readu8, readu16  = buffer.readu8, buffer.readu16
local readu32, readf32 = buffer.readu32, buffer.readf32
local len, readstring  = buffer.len, buffer.readstring

---- module ----

local deserialize = {}; do
    --- functions ---

    function deserialize.color(
        data: buffer,
        offset: number
    ): (number, { r: number, g: number, b: number })
        local r = readu8(data, offset + 0);
        local g = readu8(data, offset + 1);
        local b = readu8(data, offset + 2);

        return offset + 3, { r = r, g = g, b = b };
    end

    function deserialize.vector(
        data: buffer,
        offset: number
    ): (number, vector)
        local x = readf32(data, offset + 0);
        local y = readf32(data, offset + 4);
        local z = readf32(data, offset + 8);

        return offset + 12, vector.create(x, y, z);
    end

    function deserialize.cframe(
        data: buffer,
        offset: number
    ): (number, { Position: vector, LookVector: vector, RightVector: vector, UpVector: vector })
        local position;
        local look;
        local right;
        local up;

        offset, position = deserialize.vector(data, offset);
        offset, look = deserialize.vector(data, offset);
        offset, right = deserialize.vector(data, offset);
        offset, up = deserialize.vector(data, offset);

        return offset, {
            Position = position,
            LookVector = look,
            RightVector = right,
            UpVector = up
        };
    end

    function deserialize.string(
        data: buffer,
        offset: number
    ): (number, string)
        for i = offset, len(data) - 1 do
            if(0 == readu8(data, i)) then
                local str = readstring(data, offset, i - offset);
                return i + 1, str;
            end
        end

        return offset, "";
    end

    function deserialize.float(
        data: buffer,
        offset: number
    ): (number, number)
        local value = readf32(data, offset);
        return offset + 4, value;
    end

    function deserialize.u32(
        data: buffer,
        offset: number
    ): (number, number)
        local value = readu32(data, offset);
        return offset + 4, value;
    end

    function deserialize.u16(
        data: buffer,
        offset: number
    ): (number, number)
        local value = readu16(data, offset);
        return offset + 2, value;
    end

    function deserialize.u8(
        data: buffer,
        offset: number
    ): (number, number)
        local value = readu8(data, offset);
        return offset + 1, value;
    end
end

---- exports ----

return deserialize;
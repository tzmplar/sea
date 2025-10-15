---- environment ----

local assert, type       = assert, type
local writestring        = buffer.writestring
local writef32, writeu32 = buffer.writef32, buffer.writeu32
local writeu16, writeu8  = buffer.writeu16, buffer.writeu8

---- module ----

local serialize = {}; do
    --- functions ---

    function serialize.color(
        data: buffer,
        offset: number,
        value: vector | { r: number, g: number, b: number }
    ): number
        local r: number
        local g: number
        local b: number

        if("vector" == type(value)) then
            r = value.x
            g = value.y
            b = value.z
        else
            assert("table" == type(value), `invalid argument #1 to 'serialize.color' (vector or table expected, got {type(value)})`)

            r = value.r
            g = value.g
            b = value.b
        end

        serialize.u8(data, offset + 0, r);
        serialize.u8(data, offset + 1, g);
        serialize.u8(data, offset + 2, b);

        return offset + 3;
    end

    function serialize.vector(
        data: buffer,
        offset: number,
        value: vector | { x: number, y: number, z: number }
    ): number
        local x: number
        local y: number
        local z: number

        if("vector" == type(value)) then
            x = value.x
            y = value.y
            z = value.z
        else
            assert("table" == type(value), `invalid argument #1 to 'serialize.vector' (vector or table expected, got {type(value)})`)

            x = value.x
            y = value.y
            z = value.z
        end

        serialize.float(data, offset + 0, x);
        serialize.float(data, offset + 4, y);
        serialize.float(data, offset + 8, z);

        return offset + 12;
    end

    function serialize.cframe(
        data: buffer,
        offset: number,
        value: { Position: vector, LookVector: vector, RightVector: vector, UpVector: vector }
    ): number
        offset = serialize.vector(data, offset, value.Position);
        offset = serialize.vector(data, offset, value.LookVector);
        offset = serialize.vector(data, offset, value.RightVector);
        offset = serialize.vector(data, offset, value.UpVector);

        return offset;
    end

    function serialize.string(
        data: buffer,
        offset: number,
        value: string
    ): number
        assert("string" == type(value), `invalid argument #1 to 'serialize.string' (string expected, got {type(value)})`)

        writestring(data, offset, value);
        return offset + #value + 1;
    end

    function serialize.float(
        data: buffer,
        offset: number,
        value: number
    ): number
        assert("number" == type(value), `invalid argument #1 to 'serialize.float' (number expected, got {type(value)})`)

        writef32(data, offset, value);
        return offset + 4;
    end

    function serialize.u32(
        data: buffer,
        offset: number,
        value: number
    ): number
        assert("number" == type(value), `invalid argument #1 to 'serialize.u32' (number expected, got {type(value)})`)

        writeu32(data, offset, value);
        return offset + 4;
    end

    function serialize.u16(
        data: buffer,
        offset: number,
        value: number
    ): number
        assert("number" == type(value), `invalid argument #1 to 'serialize.u16' (number expected, got {type(value)})`)

        writeu16(data, offset, value);
        return offset + 2;
    end

    function serialize.u8(
        data: buffer,
        offset: number,
        value: number
    ): number
        assert("number" == type(value), `invalid argument #1 to 'serialize.u8' (number expected, got {type(value)})`)

        writeu8(data, offset, value);
        return offset + 1;
    end
end

---- exports ----

return serialize;
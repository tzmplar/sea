type color__DARKLUA_TYPE_a={r:number,g:number,b:number}local a={cache={}::any}do
do local function __modImpl()local b,c=assert,type local d=buffer.writestring
local e,f=buffer.writef32,buffer.writeu32 local g,h=buffer.writeu16,buffer.
writeu8 local i={}do function i.color(j:buffer,k:number,l:color__DARKLUA_TYPE_a|
vector):number local m:number local n:number local o:number if('vector'==c(l))
then m=(l::vector).x n=(l::vector).y o=(l::vector).z else b('table'==c(l),`invalid argument #1 to 'serialize.color' (vector or table expected, got {
c(l)})`)m=(l::color__DARKLUA_TYPE_a).r n=(l::color__DARKLUA_TYPE_a).g o=(l::
color__DARKLUA_TYPE_a).b end i.u8(j,k+0,m)i.u8(j,k+1,n)i.u8(j,k+2,o)return k+3
end function i.vector(j:buffer,k:number,l:vector|{x:number,y:number,z:number}):
number local m:number local n:number local o:number if('vector'==c(l))then m=l.x
n=l.y o=l.z else b('table'==c(l),`invalid argument #1 to 'serialize.vector' (vector or table expected, got {
c(l)})`)m=l.x n=l.y o=l.z end i.float(j,k+0,m)i.float(j,k+4,n)i.float(j,k+8,o)
return k+12 end function i.cframe(j:buffer,k:number,l:{Position:vector,
LookVector:vector,RightVector:vector,UpVector:vector}):number k=i.vector(j,k,l.
Position)k=i.vector(j,k,l.LookVector)k=i.vector(j,k,l.RightVector)k=i.vector(j,k
,l.UpVector)return k end function i.string(j:buffer,k:number,l:string):number b(
'string'==c(l),`invalid argument #1 to 'serialize.string' (string expected, got {
c(l)})`)d(j,k,l)return k+#l+1 end function i.float(j:buffer,k:number,l:number):
number b('number'==c(l),`invalid argument #1 to 'serialize.float' (number expected, got {
c(l)})`)e(j,k,l)return k+4 end function i.u32(j:buffer,k:number,l:number):number
b('number'==c(l),`invalid argument #1 to 'serialize.u32' (number expected, got {
c(l)})`)f(j,k,l)return k+4 end function i.u16(j:buffer,k:number,l:number):number
b('number'==c(l),`invalid argument #1 to 'serialize.u16' (number expected, got {
c(l)})`)g(j,k,l)return k+2 end function i.u8(j:buffer,k:number,l:number):number
b('number'==c(l),`invalid argument #1 to 'serialize.u8' (number expected, got {
c(l)})`)h(j,k,l)return k+1 end end return i end function a.a():typeof(__modImpl(
))local b=a.cache.a if not b then b={c=__modImpl()}a.cache.a=b end return b.c
end end end local b=a.a()local c=crypt.json.decode(game:HttpGet
[[https://raw.githubusercontent.com/tzmplar/sea/refs/heads/main/offsets.json]])
local d,e,f=b.u32,b.u16,b.u8 local g,h=b.string,b.float local i,j=b.color,b.
vector local k=b.cframe local l,m=memory.readu8,memory.readu64 local n,o=memory.
readu16,memory.readf32 local p=memory.readvector local q={'Part','MeshPart',
'SpawnLocation','WedgePart','UnionPart'}local r,s=0,buffer.create(1e9)
local function pack(t)local u=tonumber(t.Parent and t.Parent.Data)or 0 local v=
l(t,0x58)local w=t.ClassName r=d(s,r,u)r=g(s,r,w)r=f(s,r,v)r=d(s,r,tonumber(t.
Data)::number)r=g(s,r,t.Name)if(table.find(q,w))then local x=t.Description local
y=m(t,c.PVInstance.Primitive)r=f(s,r,if x.CanCollide then 1 else 0)r=i(s,r,x.
Color3)r=j(s,r,x.Velocity)r=k(s,r,{Position=t.Position,LookVector=t.LookVector,
RightVector=t.RightVector,UpVector=t.UpVector})r=j(s,r,x.Size)r=e(s,r,n(y,c.
Primitive.Material))r=h(s,r,o(t,c.Part.Reflectance))r=h(s,r,x.Transparency)r=f(s
,r,l(y,0xba))r=f(s,r,l(t,0xf5))r=f(s,r,l(t,0xf7))r=f(s,r,l(t,0xf6))end if(w==
'MeshPart')then r=g(s,r,t.MeshId)r=g(s,r,t.TextureId)r=j(s,r,p(t,0x220))end
local x=t:GetChildren()do r=b.u32(s,r,#x)for y,z in x do pack(z)end end return s
end pack(game)local t=WebsocketClient.new'ws://localhost:8008'do assert(t,
'failed to connect to server')local u=buffer.tostring(s):sub(1,r)t:Send(crypt.
base64.encode(u),true)print(`sent payload to the server | {#u} bytes`)end
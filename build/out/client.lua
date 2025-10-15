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
end end end local b=a.a()local c,d,e=b.u32,b.u16,b.u8 local f,g=b.string,b.float
local h,i=b.color,b.vector local j=b.cframe local k,l=memory.readu8,memory.
readu64 local m,n=memory.readu16,memory.readf32 local o={'Part','MeshPart',
'SpawnLocation','WedgePart','UnionPart'}local p,q=0,buffer.create(1e7)
local function pack(r)local s=tonumber(r.Parent and r.Parent.Data)or 0 local t=
k(r,0x58)local u=r.ClassName p=c(q,p,s)p=f(q,p,u)p=e(q,p,t)p=c(q,p,tonumber(r.
Data)::number)p=f(q,p,r.Name)if(table.find(o,u))then local v=r.Description local
w=l(r,0x170)p=e(q,p,if v.CanCollide then 1 else 0)p=h(q,p,v.Color3)p=i(q,p,v.
Velocity)p=j(q,p,{Position=r.Position,LookVector=r.LookVector,RightVector=r.
RightVector,UpVector=r.UpVector})p=i(q,p,v.Size)p=d(q,p,m(w,0x246))p=g(q,p,n(r,
0xec))p=g(q,p,v.Transparency)p=e(q,p,k(w,0xba))p=e(q,p,k(r,0xf5))p=e(q,p,k(r,
0xf7))p=e(q,p,k(r,0xf6))end if(u=='MeshPart')then p=f(q,p,r.MeshId)p=f(q,p,r.
TextureId)end local v=r:GetChildren()do p=b.u32(q,p,#v)for w,x in v do pack(x)
end end return q end pack(game)local r=WebsocketClient.new'ws://localhost:8008'
do assert(r,'failed to connect to server')local s=buffer.tostring(q):sub(1,p)r:
Send(crypt.base64.encode(s),true)print(`sent payload to the server | {#s} bytes`
)end
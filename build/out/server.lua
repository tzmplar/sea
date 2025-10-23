local a={cache={}::any}do do local function __modImpl()local b,c=buffer.readu8,
buffer.readu16 local d,e=buffer.readu32,buffer.readf32 local f,g=buffer.len,
buffer.readstring local h={}do function h.color(i:buffer,j:number):(number,{r:
number,g:number,b:number})local k=b(i,j+0)local l=b(i,j+1)local m=b(i,j+2)return
j+3,{r=k,g=l,b=m}end function h.vector(i:buffer,j:number):(number,vector)local k
=e(i,j+0)local l=e(i,j+4)local m=e(i,j+8)return j+12,vector.create(k,l,m)end
function h.cframe(i:buffer,j:number):(number,{Position:vector,LookVector:vector,
RightVector:vector,UpVector:vector})local k local l local m local n j,k=h.
vector(i,j)j,l=h.vector(i,j)j,m=h.vector(i,j)j,n=h.vector(i,j)return j,{Position
=k,LookVector=l,RightVector=m,UpVector=n}end function h.string(i:buffer,j:number
):(number,string)for k=j,f(i)-1 do if(0==b(i,k))then local l=g(i,j,k-j)return k+
1,l end end return j,''end function h.float(i:buffer,j:number):(number,number)
local k=e(i,j)return j+4,k end function h.u32(i:buffer,j:number):(number,number)
local k=d(i,j)return j+4,k end function h.u16(i:buffer,j:number):(number,number)
local k=c(i,j)return j+2,k end function h.u8(i:buffer,j:number):(number,number)
local k=b(i,j)return j+1,k end end return h end function a.a():typeof(__modImpl(
))local b=a.cache.a if not b then b={c=__modImpl()}a.cache.a=b end return b.c
end end do local function __modImpl()local b=buffer.create(64)local c=buffer.
create(256)local d=
[[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/]]local e=
string.byte'='for f=1,64 do local g=f-1 local h=string.byte(d,f)buffer.writeu8(b
,g,h)buffer.writeu8(c,h,g)end local function encode(f:buffer):buffer local g=
buffer.len(f)local h=math.ceil(g/3)local i=h*4 local j=buffer.create(i)for k=1,h
-1 do local l=(k-1)*3 local m=(k-1)*4 local n=bit32.byteswap(buffer.readu32(f,l)
)local o=bit32.rshift(n,26)local p=bit32.band(bit32.rshift(n,20),0b111111)local
q=bit32.band(bit32.rshift(n,14),0b111111)local r=bit32.band(bit32.rshift(n,8),
0b111111)buffer.writeu8(j,m,buffer.readu8(b,o))buffer.writeu8(j,m+1,buffer.
readu8(b,p))buffer.writeu8(j,m+2,buffer.readu8(b,q))buffer.writeu8(j,m+3,buffer.
readu8(b,r))end local k=g%3 if k==1 then local l=buffer.readu8(f,g-1)local m=
bit32.rshift(l,2)local n=bit32.band(bit32.lshift(l,4),0b111111)buffer.writeu8(j,
i-4,buffer.readu8(b,m))buffer.writeu8(j,i-3,buffer.readu8(b,n))buffer.writeu8(j,
i-2,e)buffer.writeu8(j,i-1,e)elseif k==2 then local l=bit32.bor(bit32.lshift(
buffer.readu8(f,g-2),8),buffer.readu8(f,g-1))local m=bit32.rshift(l,10)local n=
bit32.band(bit32.rshift(l,4),0b111111)local o=bit32.band(bit32.lshift(l,2),
0b111111)buffer.writeu8(j,i-4,buffer.readu8(b,m))buffer.writeu8(j,i-3,buffer.
readu8(b,n))buffer.writeu8(j,i-2,buffer.readu8(b,o))buffer.writeu8(j,i-1,e)
elseif k==0 and g~=0 then local l=bit32.bor(bit32.lshift(buffer.readu8(f,g-3),16
),bit32.lshift(buffer.readu8(f,g-2),8),buffer.readu8(f,g-1))local m=bit32.
rshift(l,18)local n=bit32.band(bit32.rshift(l,12),0b111111)local o=bit32.band(
bit32.rshift(l,6),0b111111)local p=bit32.band(l,0b111111)buffer.writeu8(j,i-4,
buffer.readu8(b,m))buffer.writeu8(j,i-3,buffer.readu8(b,n))buffer.writeu8(j,i-2,
buffer.readu8(b,o))buffer.writeu8(j,i-1,buffer.readu8(b,p))end return j end
local function decode(f:buffer):buffer local g=buffer.len(f)local h=math.ceil(g/
4)local i=0 if g~=0 then if buffer.readu8(f,g-1)==e then i+=1 end if buffer.
readu8(f,g-2)==e then i+=1 end end local j=h*3-i local k=buffer.create(j)for l=1
,h-1 do local m=(l-1)*4 local n=(l-1)*3 local o=buffer.readu8(c,buffer.readu8(f,
m))local p=buffer.readu8(c,buffer.readu8(f,m+1))local q=buffer.readu8(c,buffer.
readu8(f,m+2))local r=buffer.readu8(c,buffer.readu8(f,m+3))local s=bit32.bor(
bit32.lshift(o,18),bit32.lshift(p,12),bit32.lshift(q,6),r)local t=bit32.rshift(s
,16)local u=bit32.band(bit32.rshift(s,8),0b11111111)local v=bit32.band(s,
0b11111111)buffer.writeu8(k,n,t)buffer.writeu8(k,n+1,u)buffer.writeu8(k,n+2,v)
end if g~=0 then local l=(h-1)*4 local m=(h-1)*3 local n=buffer.readu8(c,buffer.
readu8(f,l))local o=buffer.readu8(c,buffer.readu8(f,l+1))local p=buffer.readu8(c
,buffer.readu8(f,l+2))local q=buffer.readu8(c,buffer.readu8(f,l+3))local r=bit32
.bor(bit32.lshift(n,18),bit32.lshift(o,12),bit32.lshift(p,6),q)if i<=2 then
local s=bit32.rshift(r,16)buffer.writeu8(k,m,s)if i<=1 then local t=bit32.band(
bit32.rshift(r,8),0b11111111)buffer.writeu8(k,m+1,t)if i==0 then local u=bit32.
band(r,0b11111111)buffer.writeu8(k,m+2,u)end end end end return k end return{
encode=encode,decode=decode}end function a.b():typeof(__modImpl())local b=a.
cache.b if not b then b={c=__modImpl()}a.cache.b=b end return b.c end end end
local b=require'@lune/roblox'local c=require'@lune/net'local d=require'@lune/fs'
local e=a.a()local f=a.b()local g={'Part','MeshPart','SpawnLocation','WedgePart'
,'UnionPart'}local h local i=0 local function reconstruct(j,k,l,m)local n=b.
Vector3.new(j.x,j.y,j.z)local o=b.Vector3.new(k.x,k.y,k.z)local p=b.Vector3.new(
l.x,l.y,l.z)m=b.Vector3.new(m.x,m.y,m.z)return b.CFrame.fromMatrix(n,o,p,m*-1)
end local function unpack(j:buffer):(number,b.Instance?)local k,l,m if i+4>
buffer.len(j)then print(`buffer overflow: offset: {i}, length: {buffer.len(j)}`)
return i,nil end i=e.u32(j,i)i,k=e.string(j,i)i,l=e.u8(j,i)i=e.u32(j,i)i,m=e.
string(j,i)local n,o=pcall(b.Instance.new,k)if(n)then pcall(function()o.Name=m
end)o.Archivable=(l==1)end if(table.find(g,k))then local p,q,r,s,t local u,v,w
local x,y,z,A i,p=e.u8(j,i)i,q=e.color(j,i)i,r=e.vector(j,i)i,s=e.cframe(j,i)i,t
=e.vector(j,i)i,u=e.u16(j,i)i,v=e.float(j,i)i,w=e.float(j,i)i,x=e.u8(j,i)i,y=e.
u8(j,i)i,z=e.u8(j,i)i,A=e.u8(j,i)for B,C in b.Enum.Material:GetEnumItems()do if(
C.Value==u)then u=C break end end o.CanCollide=(p==1)o.Color=b.Color3.fromRGB(q.
r,q.g,q.b)o.Velocity=b.Vector3.new(r.x,r.y,r.z)o.CFrame=reconstruct(s.Position,s
.RightVector,s.UpVector,s.LookVector)o.Size=b.Vector3.new(t.x,t.y,t.z)if(type(u)
=='userdata')then o.Material=u end o.Reflectance=v o.Transparency=w o.Anchored=(
x==1)o.CastShadow=(y==1)o.Massless=(z==1)o.Locked=(A==1)end if k=='MeshPart'then
local p,q i,p=e.string(j,i)i,q=e.string(j,i)i,init=e.vector(j,i)if string.match(
p,'^http')or string.match(p,'^rbxassetid://')then o.MeshId=p o.InitialSize=init
end if string.match(q,'^http')or string.match(q,'^rbxassetid://')then o.
TextureID=q end end local p i,p=e.u32(j,i)assert(p<=100000,`child count too high: {
p} for {k} '{m}'`)for q=1,p do local r i,r=unpack(j)if(n and o and r)then r.
Parent=o end end return i,if n then o else nil end c.serve(8008,{handleWebSocket
=function(j)local k=buffer.tostring(f.decode(buffer.fromstring(j:next())))print(
`received payload ({#k} bytes)`)_,h=unpack(buffer.fromstring(k))d.writeFile(
'DataModel.rbxl',b.serializePlace(h))print'done'end})print(`serving on ws://localhost:8008`
)
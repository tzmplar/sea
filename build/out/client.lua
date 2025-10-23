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
end end do local function __modImpl()return
[[ewogICJBbmltYXRpb24iOiB7ICJBbmltYXRpb25JZCI6IDIwNCB9LAogICJBdG1vc3BoZXJlIjogewogICAgIkNvbG9yIjogMjA4LAogICAgIkRlY2F5IjogMjIwLAogICAgIkRlbnNpdHkiOiAyMzIsCiAgICAiR2xhcmUiOiAyMzYsCiAgICAiSGF6ZSI6IDI0MCwKICAgICJPZmZzZXQiOiAyNDQKICB9LAogICJCbG9vbSI6IHsgIkludGVuc2l0eSI6IDIwOCwgIlNpemUiOiAyMTIsICJUaHJlc2hvbGQiOiAyMTYgfSwKICAiQmx1ciI6IHsgIlNpemUiOiAyMDggfSwKICAiQm9keUNvbG9ycyI6IHsKICAgICJIZWFkQ29sb3IzIjogMjc2LAogICAgIkxlZnRBcm1Db2xvcjMiOiAyMzYsCiAgICAiTGVmdExlZ0NvbG9yMyI6IDI1MiwKICAgICJSaWdodEFybUNvbG9yMyI6IDIxMiwKICAgICJSaWdodExlZ0NvbG9yMyI6IDMwNCwKICAgICJUb3Jzb0NvbG9yMyI6IDIyNAogIH0sCiAgIkNsaWNrRGV0ZWN0b3IiOiB7ICJDdXJzb3JJY29uIjogMjIwLCAiTWF4QWN0aXZhdGlvbkRpc3RhbmNlIjogMjU2IH0sCiAgIkRlY2FsIjogewogICAgIkNvbG9yMyI6IDUxMiwKICAgICJUZXh0dXJlSWQiOiA0MDQsCiAgICAiVHJhbnNwYXJlbmN5IjogNTUyLAogICAgIlpJbmRleCI6IDU1NgogIH0sCiAgIkZyYW1lIjogewogICAgIkJhY2tncm91bmRDb2xvcjMiOiAxMjcyLAogICAgIkJhY2tncm91bmRUcmFuc3BhcmVuY3kiOiAxMzI0LAogICAgIkJvcmRlckNvbG9yMyI6IDEzMDAsCiAgICAiQm9yZGVyU2l6ZVBpeGVsIjogMTMzMiwKICAgICJMYXlvdXRPcmRlciI6IDEzNDgKICB9LAogICJHcmFwaGljIjogeyAiQ29sb3IzIjogMjU2LCAiR3JhcGhpYyI6IDIyMCB9LAogICJIaWdobGlnaHQiOiB7CiAgICAiQWRvcm5lZSI6IDIwOCwKICAgICJGaWxsQ29sb3IiOiAyMjQsCiAgICAiRmlsbFRyYW5zcGFyZW5jeSI6IDI1MiwKICAgICJPdXRsaW5lQ29sb3IiOiAyMzYsCiAgICAiT3V0bGluZVRyYW5zcGFyZW5jeSI6IDI2MAogIH0sCiAgIkh1bWFub2lkIjogewogICAgIkNhbWVyYU9mZnNldCI6IDMyMCwKICAgICJEaXNwbGF5TmFtZSI6IDIwNCwKICAgICJIZWFsdGgiOiA0MDQsCiAgICAiSGVhbHRoRGlzcGxheURpc3RhbmNlIjogNDA4LAogICAgIkhpcEhlaWdodCI6IDQxNiwKICAgICJKdW1wSGVpZ2h0IjogNDI4LAogICAgIkp1bXBQb3dlciI6IDQzMiwKICAgICJNYXhIZWFsdGgiOiA0MzYsCiAgICAiTWF4U2xvcGVBbmdsZSI6IDQ0MCwKICAgICJOYW1lRGlzcGxheURpc3RhbmNlIjogNDQ0LAogICAgIlRhcmdldFBvaW50IjogMzU2LAogICAgIldhbGtTcGVlZCI6IDQ2OCwKICAgICJXYWxrVG9Qb2ludCI6IDM4MAogIH0sCiAgIkluc3RhbmNlIjogeyAiTmFtZSI6IDEyNCwgIk9uRGVtYW5kIjogNTYsICJQYXJlbnQiOiA4MCB9LAogICJMaWdodGluZyI6IHsKICAgICJBbWJpZW50IjogMjE2LAogICAgIkJyaWdodG5lc3MiOiAyODgsCiAgICAiQ2xvY2tUaW1lIjogNDQwLAogICAgIkNvbG9yU2hpZnRfQm90dG9tIjogMjI4LAogICAgIkNvbG9yU2hpZnRfVG9wIjogMjQwLAogICAgIkVudmlyb25tZW50RGlmZnVzZVNjYWxlIjogMjkyLAogICAgIkVudmlyb25tZW50U3BlY3VsYXJTY2FsZSI6IDI5NiwKICAgICJFeHBvc3VyZUNvbXBlbnNhdGlvbiI6IDMwMCwKICAgICJGb2dDb2xvciI6IDI1MiwKICAgICJGb2dFbmQiOiAzMDgsCiAgICAiRm9nU3RhcnQiOiAzMTIsCiAgICAiR2VvZ3JhcGhpY0xhdGl0dWRlIjogNDAwLAogICAgIk91dGRvb3JBbWJpZW50IjogMjY0LAogICAgIlNoYWRvd1NvZnRuZXNzIjogMzIwCiAgfSwKICAiTW9kZWwiOiB7ICJTY2FsZSI6IDM0MCB9LAogICJQVkluc3RhbmNlIjogeyAiQmluZGluZyI6IDMzNiwgIlByaW1pdGl2ZSI6IDMyOCB9LAogICJQYW50cyI6IHsgIkNvbG9yMyI6IDI5NiwgIlBhbnRzVGVtcGxhdGUiOiAyMjAgfSwKICAiUGFydCI6IHsgIkNvbG9yIjogNDA0LCAiUmVmbGVjdGFuY2UiOiAyMzYsICJUcmFuc3BhcmVuY3kiOiAyNDAgfSwKICAiUG9pbnRMaWdodCI6IHsgIkJyaWdodG5lc3MiOiAyMjgsICJDb2xvciI6IDIxNiwgIlJhbmdlIjogMjQ4IH0sCiAgIlByaW1pdGl2ZSI6IHsgIk1hdGVyaWFsIjogNjA2LCAiU2l6ZSI6IDQ2MCB9LAogICJQcm94aW1pdHlQcm9tcHQiOiB7CiAgICAiQWN0aW9uVGV4dCI6IDIwNCwKICAgICJFeGNsdXNpdml0eSI6IDMxMiwKICAgICJHYW1lcGFkS2V5Q29kZSI6IDMxNiwKICAgICJIb2xkRHVyYXRpb24iOiAzMjAsCiAgICAiS2V5Ym9hcmRLZXlDb2RlIjogMzI0LAogICAgIk1heEFjdGl2YXRpb25EaXN0YW5jZSI6IDMyOCwKICAgICJNYXhJbmRpY2F0b3JEaXN0YW5jZSI6IDMzMiwKICAgICJPYmplY3RUZXh0IjogMjM2CiAgfSwKICAiU2NyZWVuR3VpIjogeyAiRGlzcGxheU9yZGVyIjogMjI0IH0sCiAgIlNoaXJ0IjogeyAiQ29sb3IzIjogMjk2LCAiU2hpcnRUZW1wbGF0ZSI6IDI2MCB9LAogICJTa3kiOiB7CiAgICAiTW9vbkFuZ3VsYXJTaXplIjogNTQwLAogICAgIk1vb25UZXh0dXJlSWQiOiAyMTIsCiAgICAiU2t5Ym94QmsiOiAyNTIsCiAgICAiU2t5Ym94RG4iOiAyOTIsCiAgICAiU2t5Ym94RnQiOiAzMzIsCiAgICAiU2t5Ym94TGYiOiAzNzIsCiAgICAiU2t5Ym94UnQiOiA0MTIsCiAgICAiU2t5Ym94VXAiOiA0NTIsCiAgICAiU3RhckNvdW50IjogNTQ0LAogICAgIlN1bkFuZ3VsYXJTaXplIjogNTQ4CiAgfSwKICAiU3BvdExpZ2h0IjogeyAiQW5nbGUiOiAyNDgsICJCcmlnaHRuZXNzIjogMjI4LCAiQ29sb3IiOiAyMTYsICJSYW5nZSI6IDI1NiB9LAogICJTdW5SYXlzIjogeyAiSW50ZW5zaXR5IjogMjA4LCAiU3ByZWFkIjogMjEyIH0sCiAgIlN1cmZhY2VBcHBlYXJhbmNlIjogewogICAgIkNvbG9yIjogNjQ4LAogICAgIkNvbG9yTWFwIjogMjIwLAogICAgIk1ldGFsbmVzc01hcCI6IDMxNiwKICAgICJOb3JtYWxNYXAiOiAzNjQsCiAgICAiUm91Z2huZXNzTWFwIjogNDEyCiAgfSwKICAiU3VyZmFjZUxpZ2h0IjogewogICAgIkFuZ2xlIjogMjQ4LAogICAgIkJyaWdodG5lc3MiOiAyMjgsCiAgICAiQ29sb3IiOiAyMTYsCiAgICAiUmFuZ2UiOiAyNTYKICB9LAogICJUZXh0TGFiZWwiOiB7CiAgICAiVGV4dCI6IDM1NzIsCiAgICAiVGV4dENvbG9yMyI6IDM3NTIsCiAgICAiVGV4dFNpemUiOiAzNzk2LAogICAgIlRleHRTdHJva2VDb2xvcjMiOiAxMjkyLAogICAgIlRleHRTdHJva2VUcmFuc3BhcmVuY3kiOiAzODAwLAogICAgIlRleHRUcmFuc3BhcmVuY3kiOiAzODA0CiAgfSwKICAiVGV4dHVyZSI6IHsKICAgICJDb2xvcjMiOiA1MTIsCiAgICAiT2Zmc2V0U3R1ZHNVIjogNjM2LAogICAgIk9mZnNldFN0dWRzViI6IDYzMiwKICAgICJTdHVkc1BlclRpbGVVIjogNjI0LAogICAgIlN0dWRzUGVyVGlsZVYiOiA2MjgsCiAgICAiVGV4dHVyZUlkIjogNDA0LAogICAgIlRyYW5zcGFyZW5jeSI6IDU1MiwKICAgICJaSW5kZXgiOiA1NTYKICB9Cn0K
]]
end function a.b():typeof(__modImpl())local b=a.cache.b if not b then b={c=
__modImpl()}a.cache.b=b end return b.c end end end local b=a.a()local c=crypt.
json.decode(crypt.base64.decode(a.b()))local d,e,f=b.u32,b.u16,b.u8 local g,h=b.
string,b.float local i,j=b.color,b.vector local k=b.cframe local l,m=memory.
readu8,memory.readu64 local n,o=memory.readu16,memory.readf32 local p=memory.
readvector local q={'Part','MeshPart','SpawnLocation','WedgePart','UnionPart'}
local r,s=0,buffer.create(1e9)local function pack(t)local u=tonumber(t.Parent
and t.Parent.Data)or 0 local v=l(t,0x58)local w=t.ClassName r=d(s,r,u)r=g(s,r,w)
r=f(s,r,v)r=d(s,r,tonumber(t.Data)::number)r=g(s,r,t.Name)if(table.find(q,w))
then local x=t.Description local y=m(t,c.PVInstance.Primitive)r=f(s,r,if x.
CanCollide then 1 else 0)r=i(s,r,x.Color3)r=j(s,r,x.Velocity)r=k(s,r,{Position=t
.Position,LookVector=t.LookVector,RightVector=t.RightVector,UpVector=t.UpVector}
)r=j(s,r,x.Size)r=e(s,r,n(y,0x246))r=h(s,r,o(t,0xec))r=h(s,r,x.Transparency)r=f(
s,r,l(y,0xba))r=f(s,r,l(t,0xf5))r=f(s,r,l(t,0xf7))r=f(s,r,l(t,0xf6))end if(w==
'MeshPart')then r=g(s,r,t.MeshId)r=g(s,r,t.TextureId)r=j(s,r,p(t,0x248))end
local x=t:GetChildren()do r=b.u32(s,r,#x)for y,z in x do pack(z)end end return s
end pack(game)local t=WebsocketClient.new'ws://localhost:8008'do assert(t,
'failed to connect to server')local u=buffer.tostring(s):sub(1,r)t:Send(crypt.
base64.encode(u),true)print(`sent payload to the server | {#u} bytes`)end
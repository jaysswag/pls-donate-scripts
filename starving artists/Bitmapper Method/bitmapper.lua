              -- use this line to paste the CLIPBOARD.

              -- heres the virus total https://www.virustotal.com/gui/file/86f1d7d95e0b3fc0c9ae679c62875d5627e2341a57f8338ed1bf54db334baa85
              -- you need to Download .NET 6.0 for working https://dotnet.microsoft.com/en-us/download 
local function color_pixel(index,color)
local connection = (getconnections(UI[tostring(index)].MouseButton1Click))[1]
setupvalue(connection.Function,9,color)
connection.Function()
end
local low_quality = 25
lq=low_quality
for i=1,1024 do
    v=imageBytes[i]
    if not v  or not v.R or not v.G or not v.B then continue end
   -- if v.R == 0 and v.G == 0 and v.B == 0 then v = {R=255,G=255,B=255} end
   local r,g,b = v.R or 0,v.G or 0,v.B or 0
   print(i, r-(r%lq),g-(g%lq),b-(b%lq))
   color_pixel(i,Color3.fromRGB(r-(r%lq),g-(g%lq),b-(b%lq)))
end

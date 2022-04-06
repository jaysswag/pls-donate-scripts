--[[
WARNING: use the script only every FIVE MINUTES or else it'll detect it

i love these types of games where you can publicly display images that you made from pixels because of how easily exploitable they are

required pip modules:
- flask
- Pillow
- requests
(easiest way to install of this is to use the command "pip install flask,Pillow,requests" or "py -m pip install flash,Pillow,requests") and run it from command prompt

python file: https://cdn.discordapp.com/attachments/939898979456520246/955527357190516816/bot.py
virus total: https://www.virustotal.com/gui/file/6359ee381aa70b3fc55aa5edb1589a5233dad5585846902223c9c65488825728?nocache=1
--]]

local image = 'https://media.discordapp.net/attachments/948249412835098634/955526363899629658/v3rm-6.png' -- image you want to import
local resolutionX = 32 -- usually it's 32 but it might change depending on the frame?
local resolutionY = 32 -- usually it's 32 but it might change depending on the frame?

-- epic coding stuf --

local grid = nil
local s, e = pcall(function()
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild'MainGui':FindFirstChild'PaintFrame':FindFirstChild'Grid' then
    grid = game.Players.LocalPlayer.PlayerGui.MainGui.PaintFrame.Grid
    elseif game.Players.LocalPlayer.PlayerGui:FindFirstChild'PaintFrame':FindFirstChild'GridHolder':FindFirstChild'Grid' then
        grid = game.Players.LocalPlayer.PlayerGui.MainGui.PaintFrame.GridHolder.Grid
    else
        warn('cannot execute script')
        return
    end
end)
if e then
    local s1, e1 = pcall(function()
        grid = game.Players.LocalPlayer.PlayerGui.MainGui.PaintFrame.GridHolder.Grid
    end)
    if e1 then
        warn('cannot execute script')
        return
    end
end
local h = game:GetService("HttpService")

function getjson(url)
   local begin = game:HttpGet("http://localhost:57554/get?url="..url)
   local json = h:JSONDecode(begin)
   return json
end

function import(url)
   local pixels = getjson(url)
   local cells = {}
   local index = 1
   grid['1'].BackgroundColor3 = Color3.fromRGB(
       pixels[1][1],
       pixels[1][2],
       pixels[1][3]
   )
   for y = 1, resolutionX, 1 do
       for x = 1, resolutionY, 1 do
           pcall(function()
               local pixel = pixels[index]
               index = index + 1 -- index += 1 doesn't work wtf
               local r = pixels[index][1]
               local g = pixels[index][2]
               local b = pixels[index][3]
               grid[tostring(index)].BackgroundColor3 = Color3.fromRGB(r, g, b)
               table.insert(cells, pixel)
           end)
       end
       pcall(function()
           local pixel = pixels[index]
           index = index + 1 -- index += 1 doesn't work wtf
           local r = pixels[index][1]
           local g = pixels[index][2]
           local b = pixels[index][3]
           grid[tostring(index)].BackgroundColor3 = Color3.fromRGB(r, g, b)
           table.insert(cells, pixel)
       end)
   end
game.StarterGui:SetCore(
"SendNotification",
{
Title = "done",
Text = "finished importing, check the drawing grid"
}
   )
end

import(image)

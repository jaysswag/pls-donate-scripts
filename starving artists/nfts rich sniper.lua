local minimum = 1000 -- minimum value and it's also buggy some times. quirky anime boy did this




if game.PlaceId ~= 8916037983 then return end

if not game.IsLoaded then game.Loaded:Wait() end

local highestdono = 0
local highestplr = nil

for i,v in pairs(game:GetService("Players"):GetPlayers()) do
   repeat wait() until v:FindFirstChild("leaderstats")
end

local function getDonated(plr)
   local stats = plr:WaitForChild("leaderstats")
   local donated = stats:FindFirstChild("Bought")
   if donated == nil then
       return 0
   end
   return donated.Value
end

local function shop() -- infinite yield serverhop
   local x = {}
   for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
    if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
    x[#x + 1] = v.id
    end
   end
   if #x > 0 then
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
    game:GetService("GuiService").UiMessageChanged:Wait()
       shop()
   else
    return error("Couldn't find a server.")
   end
end

for i,v in pairs(game:GetService("Players"):GetPlayers()) do
   if i == 1 then continue end
   local dono = getDonated(v)
   if dono > highestdono then
       highestdono = dono
       highestplr = v
   end
end

if highestdono >= minimum then
   local richPlayers = {}
   for i,v in pairs(game:GetService("Players"):GetPlayers()) do
       if i == 1 then continue end
       if getDonated(v) >= minimum then
           table.insert(richPlayers,v)
       end
   end
   game:GetService("StarterGui"):SetCore("SendNotification", {
Title = "Richest player found!",
Text = highestplr.Name .. " has donated " .. highestdono .. "R$",
Duration = 15
})
table.foreach(richPlayers,function(i)
   print(richPlayers[i].Name .. " donated " .. tostring(getDonated(richPlayers[i])) .. "R$")
end)
else
   shop()
end

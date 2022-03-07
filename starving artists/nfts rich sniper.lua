--credits to xyba

--CONFIGURATION (Change to whatever you want)
getgenv().minPlayers = 10
getgenv().minBuyers = 5
getgenv().serverHopAfterMinutes = 15

getgenv().ToggleJoinMSG = false --toggle if message true or false
getgenv().joinMSG = "Hey, make sure to check out my shop! :)" -- join msg

getgenv().AutoClaimBooth = true --claim both true/false

getgenv().LookForSuggarDad = false
getgenv().minSuggardad = 100

repeat wait() until game:IsLoaded()
wait(2)
pcall(function()
   if AutoClaimBooth then
       local lp = game.Players.LocalPlayer
       local waitForPlots = workspace:WaitForChild("Plots")
       
       spawn(function()
           while not waitForPlots:FindFirstChild(lp.Name) do
                   local unclaimed = game:GetService("Workspace").Plots:FindFirstChild("Unclaimed");
                   if unclaimed then
                       if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                           lp.Character.HumanoidRootPart.CFrame = unclaimed.Table:FindFirstChild("Bottom").CFrame + Vector3.new(0, 3, 0)

                           if ToggleJoinMSG then
                               pcall(function()
                                   game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(joinMSG, "All")
                                   ToggleJoinMSG = false;
                               end)
                           end
                       end
                       wait(1.5)
                       for i, v in pairs(unclaimed:GetDescendants()) do
                           if v.Name == "BoothClaimPrompt" then
                               fireproximityprompt(v)
                           end
                       end
                   end
           end
       end)
   end

   function hop()
       pcall(function()
           spawn(function()
               while wait(2) do
local Servers = game.HttpService:JSONDecode(game:HttpGet(
"https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                   for i, v in pairs(Servers.data) do
                       if v.playing ~= v.maxPlayers then
                           wait()
                           game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
                       end
                   end
               end
           end)
       end)
   end

   local players = game.Players:GetChildren()
   local countPlayers = #players

   local buyers = 0
   local suggarAmount = 0
   for i, v in pairs(game:GetService("Players"):GetChildren()) do
       for i, v in pairs(v:GetDescendants()) do
           if v.Name == "Bought" then
               if v.Value > 0 then
                   buyers = buyers + 1
               end

               if LookForSuggarDad then
                   if v.Value > minSuggardad then
                       suggarAmount = suggarAmount + 1
                   end
               end
           end
       end
   end

   if countPlayers >= minPlayers and buyers >= minBuyers then
       if LookForSuggarDad then
           if suggarAmount > 0 then
               local waitTime = serverHopAfterMinutes * 60
               local client = game.GetService(game, "Players").LocalPlayer

               for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
                   v:Disable()
               end
               wait(waitTime)
               hop();
           else
               hop();
           end
       else
           local waitTime = serverHopAfterMinutes * 60
           local client = game.GetService(game, "Players").LocalPlayer

           for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
               v:Disable()
           end
           wait(waitTime)
           hop();
       end
   else
       hop();
   end
end)

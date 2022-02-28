--credits to bukkito the krnl cute cat <3

local Config = {
    Names = {
    "Buy clothes here",
    "BUKI IS AWESOME",
    "donate me",
    },
    Cooldown = 1,--you can chance the cooldown
}
--config name, make sure to add the COMMAS if you did not use it correctly might not work

while wait(Config.Cooldown) do
    game:GetService("ReplicatedStorage").Events.EditBooth:FireServer(Config.Names[math.random(1, #Config.Names)], "booth") 
end

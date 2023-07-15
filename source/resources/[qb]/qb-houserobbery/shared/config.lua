Config = {}

Config.MinZOffset = 45

Config.MinimumHouseRobberyPolice = 0

Config.MinimumTime = 5
Config.MaximumTime = 22

Config.Police = {
    ["police"] = true,
    ["lspd"] = true, 
    ["bcso"] = true
}

Config.Debug = false

Config.Tiers = Config.Tiers or {}

function DebugConsole(string)
    if not string or not Config.Debug then return end
    print(string)
end

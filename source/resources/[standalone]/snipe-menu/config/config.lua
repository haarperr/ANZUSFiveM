Config = {}

Config.CommandName = "admin"                              -- command to open the menu

Config.Core = "QBCore"                                    -- ESX or QBCore
Config.CoreFolderName = "qb-core"                         -- es_extended || qb-core

Config.PlayerLoadedEvent = "QBCore:Client:OnPlayerLoaded" -- esx:playerLoaded || QBCore:Client:OnPlayerLoaded
Config.PlayerUnloadEvent = "QBCore:Client:OnPlayerUnload" -- esx:onPlayerLogout || QBCore:Client:OnPlayerUnload

Config.Target =
"ox_target"                                                                     -- qb-target || ox_target || qtarget (Only these 3 targets are supported. You will have to edit in cl_customise if you want to use any other target other than this. No support is given to other target scripts)

Config.Discord = "https://discord.gg/yourdiscord"                               -- discord link to show when you ban a player in the ban message

Config.ShowInGameNames = true                                                   -- to show the in game names of the players in player list (if your server lags a lot, please set this to false)

Config.ReviveRadiusDistance = 10                                                -- distance within which a player can be revived when using Revive In Radius

Config.SafeCoords = vector3(136.79536437988, -627.42462158203, 262.85092163086) -- coords to teleport after spectate is cancelled and if the last location is not stored properly (happens sometimes but just a precaution so you do not teleport on the spectating player)

Config.EnableReports = true                                                     -- enable reports
--[[
    ['mrpd'] = {label = "Mission Row PD", coords = vector4(428.72, -982.65, 30.71, 77.2)},

    BREAKDOWN OF THE TABLE ABOVE

    ['mrpd'] = should be unique, can be anything but should be unique.
    label = is the name of the location (this will be shown on the UI)
    coords = is the vector4 of the location you want to teleport to
]]
--

Config.SavedLocations = {
  ['mrpd'] = { label = "Mission Row PD", coords = vector4(428.72, -982.65, 30.71, 77.2) },
}

--[[
    DO NOT CHANGE THE NAME PARAMETER. IT IS USED TO IDENTIFY THE WEATHER TYPE. Change the label which will be shown on the UI. Name is used for my reference!!!!
]]
--

Config.Weather = {
  [1] = {
    name = "EXTRASUNNY", -- do not change name
    label = "Sunny"
  },
  [2] = {
    name = "CLEAR", -- do not change name
    label = "Clear",
  },
  [3] = {
    name = "NEUTRAL", -- do not change name
    label = "Neutral",
  },
  [4] = {
    name = "SMOG", -- do not change name
    label = "Smog",
  },
  [5] = {
    name = "FOGGY", -- do not change name
    label = "Foggy",
  },
  [6] = {
    name = "OVERCAST", -- do not change name
    label = "Overcast",
  },
  [7] = {
    name = "CLOUDS", -- do not change name
    label = "Cloudy",
  },
  [8] = {
    name = "CLEARING", -- do not change name
    label = "Clearing",
  },
  [9] = {
    name = "RAIN", -- do not change name
    label = "Rainy",
  },
  [10] = {
    name = "THUNDER", -- do not change name
    label = "Thunder",
  },
  [11] = {
    name = "SNOW", -- do not change name
    label = "Light Snow",
  },
  [12] = {
    name = "BLIZZARD", -- do not change name
    label = "Blizzard",
  },
  [13] = {
    name = "SNOWLIGHT", -- do not change name
    label = "Snow Light",
  },
  [14] = {
    name = "XMAS", -- do not change name
    label = "Heavy Snow",
  },
  [15] = {
    name = "HALLOWEEN", -- do not change name
    label = "Halloween",
  }
}

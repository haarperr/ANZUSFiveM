Config.Debug = true -- set to true if you want to see debug messages in console or f8

-- use qb if you use qb or lj inventory
-- use qs if you use qs inventory
-- use ox if you use ox inventory (should be above version 2.9)
-- use qsv2 is for quasar v2 inventory
Config.Inventory = "ox" -- qb or qs or ox or qsv2

-- use qb-clothing if you use qb-clothing
-- use fivem-appearance if you use fivem-appearance
-- use esx_skin if you use esx_skin
-- use illenium-appearance if you use illenium-appearance
Config.Skin = "illenium-appearance" -- qb-clothing || fivem-appearance || esx_skin || other

-- use none if you dont use any of the mentioned phones (also set to none if you use quasar phone)
-- lb is for lb-phone
-- gks is for gks-phone
-- renewed is for renewed qb phone (only for jobs)
Config.Phone = "none" -- "none", "lb", "gks", "renewed"

-- use none if you dont use any of the mentioned options
-- wasabi is for wasabi-ambulance
Config.Ambulance = "none" -- "wasabi", "none"

-- use none if you dont use any of the mentioned options
-- okok is for okokChat
-- codem is for codem-chat
Config.Chat = "none" -- "none", "okok", "codem"

-- use none if you dont use any of the mentioned options
-- cd_easytime for cd_easytime (if you use esx, it will be cd_easytime  by default)
-- you can add custom weather system in client/open/cl_weather.lua
Config.WeatherScript = "none" -- "none", "cd_easytime"

-- legacy is for legacyfuel
-- ps is for ps-fuel
-- ox is for ox-fuel
-- cdn is for cdn-fuel
-- other is for other fuel scripts (you need to configure in cl_vehicles_customise.lua)
Config.Fuel = "ox" -- "ps" "ox" "other", "cdn", "legacy"

-- garage
-- none is for default ESX or QBCore garage
-- cd is for cd_garage
-- if you use any other paid garage system, the code is open in server/open/sv_vehicles.lua for you to edit queries.
-- Make sure to try with none before making changes in the config or the sv_vehicles.lua file
Config.Garage = "none" -- cd , none

Config.GarageTables = {
  ["QBCore"] = {
    vehicle_table = "character_vehicles",
    trunk_table = "trunkitems",       -- used for qb inventory (if your inventory stores the glove box items and trunk items in different table, change it here)
    glovebox_table = "gloveboxitems", -- used for qb inventory (if your inventory stores the glove box items and trunk items in different table, change it here)
  },
  ["ESX"] = {
    vehicle_table = "owned_vehicles",
  },
}

-- use qb is you use qb-vehiclekeys
-- use cd if you use cd_garage keys system
-- if you choose other, make sure to make changes in client/open/cl_vehicles_customise.lua
Config.Keys = "qb" -- "qb" or "cd" or "other"

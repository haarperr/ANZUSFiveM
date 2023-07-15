Config = {}

-- ██████  ██       █████  ███    ██ ████████ ███████     ██████  ███████ ██       █████  ████████ ███████ ██████
-- ██   ██ ██      ██   ██ ████   ██    ██    ██          ██   ██ ██      ██      ██   ██    ██    ██      ██   ██
-- ██████  ██      ███████ ██ ██  ██    ██    ███████     ██████  █████   ██      ███████    ██    █████   ██   ██
-- ██      ██      ██   ██ ██  ██ ██    ██         ██     ██   ██ ██      ██      ██   ██    ██    ██      ██   ██
-- ██      ███████ ██   ██ ██   ████    ██    ███████     ██   ██ ███████ ███████ ██   ██    ██    ███████ ██████

Config.RequiredRep = 0 -- reputation required to plant this seed

Config.MaxPlantsOut = 10

Config.RepGiven = 1 -- rep added after they harvest the plant

--[[
    * Make sure the seeds you add here are present in shared.lua and are useable items.
    * ["seed_genericplant"] -> seed name (make sure its a useable item in shared.lua)
    * label = label that will be visible as 3d text on top of plant
    * returnItems = table of items that will be given when harvested
    * itemName = item name that will be given when harvested
    * amount = how much item will be given
    * probability - in percentage the chances of getting that item
    * basedOnHealth - based on plant health, the amount will be chosen (say plant health is 50%, you will get half of the amount)
]]
--

Config.Seed = {
  weed_seed = {
    label = "Weed",
    returnItems = {
      [1] = { itemName = "weed_seed", amount = { 1, 10 }, probability = 10, basedOnHealth = false }, -- for random amount, follow this pattern -> {1, 10}, {5, 7}, {4, 9}, {2, 8}, etc
      [2] = { itemName = "weed", amount = 10, probability = 100, basedOnHealth = true },
    }
  },
}


-- ████████  █████  ██████   ██████  ███████ ████████
--    ██    ██   ██ ██   ██ ██       ██         ██
--    ██    ███████ ██████  ██   ███ █████      ██
--    ██    ██   ██ ██   ██ ██    ██ ██         ██
--    ██    ██   ██ ██   ██  ██████  ███████    ██
--[[
    * The script will only work if you are using qb-target
    * Script doesnt support bt-target because bt-target lacks functionality that is needed to check the plants
    * only change this if you have renamed qb-target to something else for the exports to work fine
]]
--
Config.Target = "qb-target"

--[[
    The EnableTargetExports config value is for those who want to add targets from outside the script.
    The event for target is

    --type = "client",
	--event = "qb-farming:client:checkClosestPlant", -- this event will change if you create a new folder so qb-farming will be replaced with Config.Foldername

    You will need to add this in config for qb-target.
]]
--

Config.EnableTargetExports = true


-- ███████  ██████  ██ ██          ██████  ███████ ██       █████  ████████ ███████ ██████
-- ██      ██    ██ ██ ██          ██   ██ ██      ██      ██   ██    ██    ██      ██   ██
-- ███████ ██    ██ ██ ██          ██████  █████   ██      ███████    ██    █████   ██   ██
--      ██ ██    ██ ██ ██          ██   ██ ██      ██      ██   ██    ██    ██      ██   ██
-- ███████  ██████  ██ ███████     ██   ██ ███████ ███████ ██   ██    ██    ███████ ██████

--[[
    * ph decides the acidic and alkaline nature of the soil
    * fertility decides growth rate of the crop (between 0 to 1.0)
    * if Fertility is 0.5, the plant will take double the time to grow
]]
--
Config.Soil = {
  ["1109728704"]  = { ph = "acidic", fertility = 1.0 },
  ["-1942898710"] = { ph = "neutral", fertility = 1.0 },
  ["1288448767"]  = { ph = "basic", fertility = 0.8 },
  ["765206029"]  = { ph = "neutral", fertility = 0.7 },
  ["312396330"]   = { ph = "acidic", fertility = 0.7 },
  ["-1595148316"] = { ph = "basic", fertility = 0.7 },
  ["510490462"]   = { ph = "basic", fertility = 0.7 },
  ["1333033863"]  = { ph = "neutral", fertility = 0.6 },
  ["951832588"]  = { ph = "neutral", fertility = 0.6 },
  ["1187676648"]  = { ph = "neutral", fertility = 0.6 },
  ["-1286696947"] = { ph = "neutral", fertility = 0.5 },
  ["-1885547121"] = { ph = "neutral", fertility = 0.5 },
}

Config.CanBurnPlants = true  --True if you want anyone to burn down and destroy the plants.
Config.DestroyOptions = true --True if you want to display the destroy option on nui.


Config.InfectionProbability = 10 --between 1 to 100
Config.InsecticideEffect = 5     --Health increament of plant / insecticide

Config.ProgressPerCycle = 20     --Progress per cycle (this is only when the fertility of soil is 1.0. If its 0.5, Progress will 5. This value is multiplied by the Fertility of the soil.)
Config.CycleTime = math.floor(math.random(35, 38))              --Cycle time in minutes

Config.WaterProbability = math.floor(math.random(20, 90))    --between 1 to 100 (this is 30% chance of water level dropping)
Config.WaterDepletion = math.floor(math.random(5, 50))      --Decrease in water level of plant / cycle time
Config.WaterEffect = math.floor(math.random(5, 30))         --Health decrement of plant when the water level is 0
Config.WaterIncreaseLevel = math.floor(math.random(5, 35)) --Increase in water level of plant when water is added
Config.StartingWaterLevel = math.floor(math.random(10, 50)) --Starting water level of plant

Config.Items = {
  acidic_soil_item = "alkaline_bottle", --item required if soil is acidic
  alkaline_soil_item = "acid_bottle",   --item required if soil is basic/alkaline
  insecticide = "weed_insecticide",     --insecticide item name
  water = "water",
}

Config.ShowSoilHash = true -- this will print soil hash in F8 if true. You can turn it off on live if you dont want the spam


--  ██       ██████   ██████  █████  ██      ███████
--  ██      ██    ██ ██      ██   ██ ██      ██
--  ██      ██    ██ ██      ███████ ██      █████
--  ██      ██    ██ ██      ██   ██ ██      ██
--  ███████  ██████   ██████ ██   ██ ███████ ███████


--Format of Config.Locale
--[[
    * name = label
    * Do not alter the name (for eg. ["health_label"] -> do not change this)
    * change the label (for eg. "Health" can be changed to whatever you want.)
]]
--
Config.Locale = {
  health_label = "Health",
  collect_weed = "Collecting",
  harvesting_weed_progressbar = "Harvesting Leaves",
  not_suitable_soil = "Soil not Suitable",
  near_another_plant = "Near another Plant, choose another location.",
  plant_weed_progressbar = "Planting plants",
  soil_acidity_notify = "Soil is acidic, need bottle of alkaline to make it neutral",
  soil_alkaline_notify = "Soil is alkaline, need bottle of acid to make it neutral",
  slant_surface_notify = "Surface is slanted",
  no_surface_notify = "No Surface Found",
  no_plant_nearby = "No Plant Nearby!",
  near_another_plant_error = "Near another plant!",
  inventory_full_error = "Not enough space to carry!",
  no_insecticide = "You dont have insecticide",
  plant_not_ready = "Plant is not ready yet!",
  invalid_plant = "Not the right plant!",
  destroying_plant = "Destroying Plant!",
  need_reputation = "Need Rep to Plant",
  need_rep_harvest = "You are not experienced enough to harvest!",
  no_water = "You do not have water",
}


-- ██████  ██       █████  ███    ██ ████████     ███    ███  ██████  ██████  ███████ ██      ███████
-- ██   ██ ██      ██   ██ ████   ██    ██        ████  ████ ██    ██ ██   ██ ██      ██      ██
-- ██████  ██      ███████ ██ ██  ██    ██        ██ ████ ██ ██    ██ ██   ██ █████   ██      ███████
-- ██      ██      ██   ██ ██  ██ ██    ██        ██  ██  ██ ██    ██ ██   ██ ██      ██           ██
-- ██      ███████ ██   ██ ██   ████    ██        ██      ██  ██████  ██████  ███████ ███████ ███████

--[[
    These are the list with offset for some plant models that I tested that spawn. There are several plant models that don't spawn
    There are more plant objects other than this as well.
    You can also create your own props but if the prop size is too large, the server might lag due to spawning of high texture props
]]
--

--[[
    1. p_int_jewel_plant_01 , Zoffset = 0.0
    2. p_int_jewel_plant_02 , Zoffset = 0.0
    3. prop_fbibombplant , Zoffset = -1.0
    4. v_ret_gc_plant1 , Zoffset = 0.0
    5. v_res_rubberplant , Zoffset = 0.0
    6. v_res_tre_plant , Zoffset = 0.0
    7. v_res_fa_plant01 , Zoffset = 0.0
    8. v_res_mplanttongue , Zoffset = 0.0
    9. v_res_m_bananaplant , Zoffset = -2.0
    10. prop_plant_fern_02a , Zoffset = 0.0
    11. prop_plant_palm_01b , Zoffset = -1.0
    12. prop_plant_palm_01a, Zoffset = -1.0
    13. prop_plant_int_01a , Zoffset = 0.0
    14. prop_plant_int_01b , Zoffset = 0.0
    15. prop_plant_int_02b , Zoffset = 0.0
    16. prop_plant_int_03a , Zoffset = 0.0
    17. prop_plant_int_03b , Zoffset = 0.0
    18. prop_plant_int_03c , Zoffset = 0.0
    19. prop_plant_int_04a , Zoffset = 0.0
    20. prop_plant_int_04b , Zoffset = 0.0
    21. prop_plant_int_04c , Zoffset = -1.0
]]
--

-- ███████ ████████  █████   ██████  ███████ ███████
-- ██         ██    ██   ██ ██       ██      ██
-- ███████    ██    ███████ ██   ███ █████   ███████
--      ██    ██    ██   ██ ██    ██ ██           ██
-- ███████    ██    ██   ██  ██████  ███████ ███████

Config.Stages = {
  [1] = {
    min = 0,
    max = 20,
    state = "Seedling",
    model = "bkr_prop_weed_01_small_01c",
    offset = 0.0,
  },
  [2] = {
    min = 21,
    max = 40,
    state = "Small",
    model = "bkr_prop_weed_01_small_01b",
    offset = 0.0,
  },
  [3] = {
    min = 41,
    max = 60,
    state = "Medium",
    model = "bkr_prop_weed_01_small_01a",
    offset = 0.0,
  },
  [4] = {
    min = 61,
    max = 80,
    state = "Big",
    model = "bkr_prop_weed_med_01a",
    offset = -2.5,
  },
  [5] = {
    min = 81,
    max = 100,
    state = "Mature",
    model = "bkr_prop_weed_lrg_01a",
    offset = -2.5,
  },
}

Config.HarvestingState = "Harvestable"

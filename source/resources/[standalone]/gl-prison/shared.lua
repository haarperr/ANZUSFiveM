Config = {}

Config.Debug = false

Config.PrisonZone = {
  vector2(1845.14, 2612.65),
  vector2(1827.97, 2612.36),
  vector2(1823.06, 2617.60),
  vector2(1823.38, 2624.80),
  vector2(1848.17, 2695.85),
  vector2(1846.36, 2702.30),
  vector2(1837.12, 2711.00),
  vector2(1777.56, 2759.03),
  vector2(1775.54, 2759.99),
  vector2(1769.52, 2762.75),
  vector2(1653.20, 2758.43),
  vector2(1647.50, 2755.05),
  vector2(1573.11, 2682.11),
  vector2(1568.74, 2676.73),
  vector2(1536.12, 2588.92),
  vector2(1536.09, 2581.71),
  vector2(1541.08, 2473.36),
  vector2(1543.26, 2466.88),
  vector2(1655.69, 2396.53),
  vector2(1661.97, 2396.61),
  vector2(1757.89, 2410.92),
  vector2(1763.91, 2413.29),
  vector2(1777.72, 2426.92),
  vector2(1821.40, 2472.90),
  vector2(1825.09, 2479.12),
  vector2(1817.01, 2532.49),
  vector2(1819.15, 2568.87),
  vector2(1825.94, 2568.87),
  vector2(1826.25, 2578.80),
  vector2(1845.98, 2578.81)
}

Config.PrisonZoneMinZ = 44.67
Config.PrisonZoneMaxZ = 69.67

Config.EnableTimeReduction = false -- Reduce Time On Prison Tasks
Config.EnableAutoLeave = true      -- Auto Leave Prison When Time Is Up
Config.TimeReductionHigh = 5       -- Reduce By When Higher Then 15 Months
Config.TimeReductionLow = 1        -- Reduce By When Lower Then 15 Months


Config.PrisonReward = 'cigarettee'
Config.RepGains = 10
Config.RepCostForTask = 5           --(SO you gain 5 rep per completed task, can go negative rep)
Config.IllegalCooldown = 30 * 60000 --(30 Minutes)

Config.GiveMoney = true             -- ONLY FOR THE LEGAL JOBS
Config.MoneyReward = 20             -- ONLY FOR THE LEGAL JOBS
Config.GiveItem = false             -- ONLY FOR THE LEGAL JOBS
Config.ItemReward = 'cigarettee'    -- ONLY FOR THE LEGAL JOBS
Config.ItemAmount = 5               -- ONLY FOR THE LEGAL JOBS

Config.MugshotTP = vector3(1844.21, 2594.36, 45.02)
Config.MugshotH = 91.66
Config.CellLocation = vector3(1774.09, 2481.72, 49.69)
Config.CellHeading = 27.36
Config.SetFreeLoc = vector3(1838.51, 2582.58, 46.01)

-- For Drug Making Stuff --
Config.DrugName = 'mud' -- Database name of the drug
Config.ProcessedAmount = 20
Config.UnprocessedName = 'wetmud'
Config.DrugIngredients = { rottenapple = 1, water = 3, steroid = 1, bleech = 1 } -- Database names of Ingredients

Config.RandomTrashReward = { 'rottenapple', 'emptybottle' }                      -- add items to randomly find in trash can job here
Config.RandomTrashChance = 20                                                    -- Out of 100 (% Chance)

Config.SteroidChance = 10                                                        -- Out of 100 (% Chance)

Config.TinfoilChance = 15                                                        -- Out of 100 (% Chance)

Config.DryTime = 2                                                               -- IN HOURS
Config.NPCLocations = {
  Cleaner = {
    coords = vector3(1771.72, 2568.38, 44.73),
    heading = 92.06,
    event = 'gl-prison:beginClean',
    label = 'Begin Cleaning Work',
    model = 's_m_m_janitor',
    icon = 'fas fa-clipboard-list'
  },

  Cook = {
    coords = vector3(1781.16, 2561.0, 44.67),
    heading = 178.71,
    event = 'gl-prison:beginCook',
    label = 'Begin Cooking Work',
    model = 's_m_y_chef_01',
    icon = 'fas fa-clipboard-list'
  },

  Electrical = {
    coords = vector3(1760.12, 2519.22, 44.57),
    heading = 251.62,
    event = 'gl-prison:beginElectrical',
    label = 'Begin Electrical Work',
    model = 's_m_y_construct_02',
    scenario = 'WORLD_HUMAN_WELDING',
    icon = 'fas fa-clipboard-list'
  },

  Trash = {
    coords = vector3(1720.16, 2566.8, 44.57),
    heading = 140.98,
    event = 'gl-prison:beginTrash',
    label = 'Begin Garbage Work',
    model = 's_m_y_garbage',
    scenario = 'WORLD_HUMAN_CLIPBOARD',
    icon = 'fas fa-clipboard-list'
  },

  Toilets = {
    coords = vector3(1774.0, 2492.91, 44.74),
    heading = 120.51,
    event = 'gl-prison:beginToilet',
    label = 'Begin Toilet Cleaning',
    model = 's_m_y_dwservice_01',
    scenario = 'WORLD_HUMAN_JANITOR',
    icon = 'fas fa-clipboard-list'
  },

  Doctor = {
    coords = vector3(1765.23, 2598.29, 44.73),
    heading = 183.49,
    event = 'gl-prison:useDoctor',
    label = 'Get Treated',
    model = 's_m_m_doctor_01',
    scenario = 'WORLD_HUMAN_CLIPBOARD',
    icon = 'fas fa-clipboard-list'
  },

  BallerPed = {
    coords = vector3(1758.12, 2483.82, 44.25),
    heading = 127.03,
    event = 'gl-prison:prisonerTasks',
    label = 'Do Some "Work"',
    model = 's_m_y_prisoner_01',
    scenario = 'PROP_HUMAN_SEAT_CHAIR',
    icon = 'fas fa-clipboard-list',
    event2 = 'gl-prison:openGangShop',
    label2 = 'Trade',
    gang = 'Ballas',
    headVar = 0,
  },

  FamiliesPed = {
    coords = vector3(1747.09, 2534.8, 42.11),
    heading = 31.64,
    event = 'gl-prison:prisonerTasks',
    label = 'Do Some "Work"',
    model = 's_m_y_prisoner_01',
    scenario = 'PROP_HUMAN_SEAT_CHAIR',
    icon = 'fas fa-clipboard-list',
    event2 = 'gl-prison:openGangShop',
    label2 = 'Trade',
    gang = 'Families',
    headVar = 1,
  },

  VagosPed = {
    coords = vector3(1706.49, 2550.89, 44.01),
    heading = 357.17,
    event = 'gl-prison:prisonerTasks',
    label = 'Do Some "Work"',
    model = 's_m_y_prisoner_01',
    scenario = 'PROP_HUMAN_SEAT_CHAIR',
    icon = 'fas fa-clipboard-list',
    event2 = 'gl-prison:openGangShop',
    label2 = 'Trade',
    gang = 'Vagos',
    headVar = 2,
  },

  RecPed1 = {
    coords = vector3(1698.87, 2534.47, 44.56),
    heading = 290.66,
    event = 'gl-prison:teachRec',
    label = 'How To Play',
    model = 'u_m_y_prisoner_01',
    scenario = 'WORLD_HUMAN_LEANING',
    icon = 'fas fa-clipboard-list'
  },

  CommissaryPed = {
    coords = vector3(1780.27, 2548.26, 44.18),
    heading = 354.03,
    event = 'gl-prison:openCommissary',
    label = 'Browse Stock',
    model = 's_m_y_prisoner_01',
    scenario = 'PROP_HUMAN_SEAT_CHAIR',
    icon = 'fas fa-shopping-cart',
  },
}

Config.Commissary = {
  rolling_paper = { databasename = 'rolling_paper', label = 'Rolling Papers', cost = 10, currency = 'money' },
  sandwich = { databasename = 'sandwich', label = 'Premium Sandwich', cost = 20, currency = 'money' },
  lockpick = { databasename = 'lockpick', label = 'Definetly Not a Lockpick', cost = 50, currency = 'money' },
  bleach = { databasename = 'bleech', label = 'Bleach', cost = 100, currency = 'money' },
  drugbag = { databasename = 'drugbag', label = 'A Great Bag for.. Throwing', cost = 30, currency = 'money' },
  bandage = { databasename = 'bandage', label = 'Bandage', cost = 20, currency = 'money' },
}

Config.FoodStuffs = {
  sandwich = { databasename = 'sandwich', label = 'Disgusting Sandwich' },
}

Config.DrinkStuffs = {
  water = { databasename = 'water', label = 'Water' },
  coke = { databasename = 'kurkakola', label = 'Coke' },
  coffee = { databasename = 'coffee', label = 'Coffee' },
}

Config.CookingStuff = { -- You do not get to keep stuff

  sandwich = {
    Label = 'Sandwich',
    IngredientCost = 1,
    Time = 24000,
    Product = 'sandwich'
  },

  tosti = {
    Label = 'Tosti',
    IngredientCost = 1,
    Time = 24000,
    Product = 'tosti'
  },

  prisonmeal = {
    Label = 'Full Prison Meal',
    IngredientCost = 3,
    Time = 32000,
    Product = 'prisonmeal'
  },
}

Config.ElectricalBoxes = {
  [0] = { coords = vector3(1737.28, 2504.12, 45.57), heading = 345, icon = 'fas fa-bolt' },
  [1] = { coords = vector3(1707.47, 2480.61, 45.56), heading = 45, icon = 'fas fa-bolt' },
  [2] = { coords = vector3(1700.58, 2474.36, 45.56), heading = 45, icon = 'fas fa-bolt' },
  [3] = { coords = vector3(1679.32, 2479.88, 45.56), heading = 315, icon = 'fas fa-bolt' },
  [4] = { coords = vector3(1643.95, 2490.21, 45.56), heading = 5, icon = 'fas fa-bolt' },
  [5] = { coords = vector3(1621.76, 2507.63, 45.56), heading = 95, icon = 'fas fa-bolt' },
  [6] = { coords = vector3(1609.42, 2539.23, 45.56), heading = 315, icon = 'fas fa-bolt' },
  [7] = { coords = vector3(1608.5, 2567.46, 45.56), heading = 40, icon = 'fas fa-bolt' },
  [8] = { coords = vector3(1629.76, 2564.96, 45.56), heading = 355, icon = 'fas fa-bolt' },
  [9] = { coords = vector3(1652.51, 2565.2, 45.56), heading = 0, icon = 'fas fa-bolt' },
}

Config.Phones = {
  [0] = { coords = vector3(1828.76, 2579.78, 46.01), heading = 0, icon_leave = 'fas fa-arrow-right-from-bracket', icon_time = 'fas fa-clock' },
  [1] = { coords = vector3(1827.26, 2585.91, 46.01), heading = 0, icon_leave = 'fas fa-arrow-right-from-bracket', icon_time = 'fas fa-clock' },
  [2] = { coords = vector3(1827.21, 2587.72, 46.01), heading = 0, icon_leave = 'fas fa-arrow-right-from-bracket', icon_time = 'fas fa-clock' },
  [3] = { coords = vector3(1827.25, 2589.79, 46.01), heading = 0, icon_leave = 'fas fa-arrow-right-from-bracket', icon_time = 'fas fa-clock' },
}

Config.Toilets = {
  [0] = { coords = vector3(1767.77, 2502.97, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [1] = { coords = vector3(1764.61, 2501.18, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [2] = { coords = vector3(1761.45, 2499.35, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [3] = { coords = vector3(1758.29, 2497.53, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [4] = { coords = vector3(1755.13, 2495.70, 48.69), heading = 30, icon = 'fas fa-toilet' },
  --[5] = {coords = vector3(1751.99, 2493.87, 48.69), heading = 30, icon = 'fas fa-toilet' }, Used for Illegal Stuff
  [6] = { coords = vector3(1748.87, 2492.06, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [7] = { coords = vector3(1767.77, 2502.97, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [8] = { coords = vector3(1764.61, 2501.18, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [9] = { coords = vector3(1761.45, 2499.35, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [10] = { coords = vector3(1755.13, 2495.70, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [11] = { coords = vector3(1751.99, 2493.87, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [12] = { coords = vector3(1748.87, 2492.06, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [13] = { coords = vector3(1776.97, 2481.37, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [14] = { coords = vector3(1773.81, 2479.58, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [15] = { coords = vector3(1770.65, 2477.79, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [16] = { coords = vector3(1767.49, 2476.00, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [17] = { coords = vector3(1764.33, 2474.21, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [18] = { coords = vector3(1761.17, 2472.42, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [19] = { coords = vector3(1758.01, 2470.63, 48.69), heading = 30, icon = 'fas fa-toilet' },
  [20] = { coords = vector3(1776.97, 2481.37, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [21] = { coords = vector3(1773.81, 2479.58, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [22] = { coords = vector3(1770.65, 2477.79, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [23] = { coords = vector3(1767.49, 2476.00, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [24] = { coords = vector3(1764.33, 2474.21, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [25] = { coords = vector3(1761.17, 2472.42, 44.69), heading = 30, icon = 'fas fa-toilet' },
  [26] = { coords = vector3(1758.01, 2470.63, 44.69), heading = 30, icon = 'fas fa-toilet' },
}

Config.BedLocations = {
  [0] = { coords = vector3(1775.21, 2482.43, 44.74), heading = 30, icon = 'fas fa-bed' },
  [1] = { coords = vector3(1762.58, 2475.19, 44.74), heading = 30, icon = 'fas fa-bed' },
  [2] = { coords = vector3(1747.48, 2489.18, 44.74), heading = 30, icon = 'fas fa-bed' },
  [3] = { coords = vector3(1760.12, 2496.52, 44.74), heading = 30, icon = 'fas fa-bed' },
  [4] = { coords = vector3(1765.59, 2476.9, 48.69), heading = 30, icon = 'fas fa-bed' },
  [5] = { coords = vector3(1747.48, 2489.2, 48.69), heading = 30, icon = 'fas fa-bed' },
  [6] = { coords = vector3(1763.44, 2498.3, 48.69), heading = 30, icon = 'fas fa-bed' },
}

Config.IllegalStuff = {
  [1] = {
    message = 'Yo dawg get some ingredients from the kitchen and make me some Sangria in Cell 12.',
    reward = 'cigarette',
    minAmount = 4,
    maxAmount = 10,
    requirement = 'sangria',                       -- Database name if an Item is required
    coords = vector3(1751.98, 2493.79, 48.69),     -- Cell 12 Upper Floor
    boxW = .5,
    boxL = .5,
    heading = 20,
    ingredient = 'ingredients',
    amount = 20,
    icon = 'fas fa-toilet',
    --additionalEvent = nil,
    --killorwound = nil, -- If they need to be killed or wounded (kill, wound)
    --oppModel = nil,
    --spawnCoords = nil,
  },

  [2] = {
    message = 'I hid a shank in some boxes in the yard, get it for me.',
    reward = 'cigarette',
    minAmount = 8,
    maxAmount = 14,
    requirement = 'WEAPON_SWITCHBLADE',            -- Database name if an Item is required
    coords = vector3(1689.82, 2553.16, 45.56),     -- Box in the Yard
    boxW = 1,
    boxL = 1,
    heading = 0,
    ingredient = nil,
    amount = nil,
    icon = 'fas fa-box-open',
    --additionalEvent = nil,
    --killorwound = nil, -- If they need to be killed or wounded (kill, wound)
    --oppModel = nil,
    --spawnCoords = nil,
  },

  [3] = {
    message = 'Take out this loser for me near the basketball court.',
    reward = 'cigarette',
    minAmount = 9,
    maxAmount = 18,
    requirement = nil,     -- Database name if an Item is required
    coords = nil,          -- Box in the Yard
    boxW = nil,
    boxL = nil,
    heading = nil,
    ingredient = nil,
    amount = nil,
    icon = 'fas fa-box-open',
    additionalEvent = 'gl-prison:spawnOpp',
    killorwound = 'kill',     -- If they need to be killed or wounded (kill, wound)
    oppModel = 'u_m_y_prisoner_01',
    spawnCoords = vector3(1662.28, 2517.72, 44.56),
  },

  [4] = {
    message = 'Check out the bunks, someone from the gangs been hiding drugs.',
    reward = 'cigarette',
    minAmount = 8,
    maxAmount = 16,
    requirement = 'weed',     -- Database name if an Item is required
    coords = nil,             -- Box in the Yard
    boxW = nil,
    boxL = nil,
    heading = nil,
    ingredient = nil,
    amount = 10,
    icon = 'fas fa-box-open',
    additionalEvent = 'gl-prison:checkItemBed',
    killorwound = nil,     -- If they need to be killed or wounded (kill, wound)
    oppModel = nil,
    spawnCoords = nil,
  },

  [5] = {
    message = 'Rough up this snitch for us, he has been hanging around the yard equipment.',
    reward = 'cigarette',
    minAmount = 4,
    maxAmount = 13,
    requirement = nil,     -- Database name if an Item is required
    coords = nil,          -- Box in the Yard
    boxW = nil,
    boxL = nil,
    heading = nil,
    ingredient = nil,
    amount = nil,
    icon = 'fas fa-box-open',
    additionalEvent = 'gl-prison:spawnOpp',     -- This event will take care of any kill/wound missions
    killorwound = 'wound',                      -- If they need to be killed or wounded (kill, wound)
    oppModel = 'u_m_y_prisoner_01',
    spawnCoords = vector3(1656.28, 2538.71, 44.56),
  },

}

Config.GangShops = {
  Ballas = {   -- Change up items later
    { Item = 'bandage',            Label = 'Bandage',     Cost = 5,   Currency = 'cigarette', Minrep = 0 },
    { Item = 'medikit',            Label = 'MedKit',      Cost = 15,  Currency = 'cigarette', Minrep = 50 },
    { Item = 'armor',              Label = 'Armor',       Cost = 35,  Currency = 'cigarette', Minrep = 150 },
    { Item = 'WEAPON_SWITCHBLADE', Label = 'Switchblade', Cost = 50,  Currency = 'cigarette', Minrep = 250 },
    { Item = 'WEAPON_PISTOL',      Label = 'Pistol',      Cost = 350, Currency = 'cigarette', Minrep = 500 },

  },

  Families = {   -- Change up items later
    { Item = 'burger',             Label = 'Burger',      Cost = 5,   Currency = 'cigarette', Minrep = 0 },
    { Item = 'medikit',            Label = 'MedKit',      Cost = 15,  Currency = 'cigarette', Minrep = 50 },
    { Item = 'armor',              Label = 'Armor',       Cost = 35,  Currency = 'cigarette', Minrep = 150 },
    { Item = 'WEAPON_SWITCHBLADE', Label = 'Switchblade', Cost = 50,  Currency = 'cigarette', Minrep = 250 },
    { Item = 'WEAPON_PISTOL',      Label = 'Pistol',      Cost = 350, Currency = 'cigarette', Minrep = 500 },

  },

  Vagos = {   -- Change up items later
    { Item = 'taco',               Label = 'Taco',        Cost = 5,   Currency = 'cigarette', Minrep = 0 },
    { Item = 'medikit',            Label = 'MedKit',      Cost = 15,  Currency = 'cigarette', Minrep = 50 },
    { Item = 'armor',              Label = 'Armor',       Cost = 35,  Currency = 'cigarette', Minrep = 150 },
    { Item = 'WEAPON_SWITCHBLADE', Label = 'Switchblade', Cost = 50,  Currency = 'cigarette', Minrep = 250 },
    { Item = 'WEAPON_PISTOL',      Label = 'Pistol',      Cost = 350, Currency = 'cigarette', Minrep = 500 },

  }
}

Config.Stashes = {
  [0] = { coords = vector3(1784.25, 2560.65, 44.67), slots = 10, maxweight = 1000, length = 0.5, width = 0.5, heading = 0, height = 1.0, icon = 'fas fa-hand-paper' },
}

Config.Uniforms = {
  male = {
    outfitData = {
      ["pants"] = { item = 7, texture = 15 },          -- Pants
      ["arms"] = { item = 0, texture = 0 },            -- Arms
      ["t-shirt"] = { item = 15, texture = 0 },        -- T Shirt
      ["torso2"] = { item = 0, texture = 0 },          -- Jacket
      ["shoes"] = { item = 6, texture = 1 },           -- Shoes
      ["accessory"] = { item = 0, texture = 0 },       -- Neck Accessory
      ["bag"] = { item = 0, texture = 0 },             -- Bag
      ["hat"] = { item = -1, texture = -1 },           -- Hat
    },
  },
  female = {
    outfitData = {
      ["pants"] = { item = 0, texture = 12 },          -- Pants
      ["arms"] = { item = 0, texture = 0 },            -- Arms
      ["t-shirt"] = { item = 14, texture = 0 },        -- T Shirt
      ["torso2"] = { item = 370, texture = 0 },        -- Jacket
      ["shoes"] = { item = 1, texture = 0 },           -- Shoes
      ["accessory"] = { item = 0, texture = 0 },       -- Neck Accessory
      ["bag"] = { item = 0, texture = 0 },             -- Bag
      ["hat"] = { item = -1, texture = -1 },           -- Hat
    },
  }
}

-- Prison Break
local isServer = IsDuplicityVersion()
if not isServer then
  Config.SetDoorLock = function(doorid, locked)
    TriggerServerEvent('ox_doorlock:setDoorsState', doorid, locked)
  end

  Config.PrisonGateHackMiniGame = function(id)
    local gateid = id
    LocalPlayer.state:set("inv_busy", true, true)
    TriggerEvent("utk_fingerprint:Start", 1, 6, 2, function(outcome, reason)
      if outcome == true then
        TriggerServerEvent('ox_doorlock:setDoorsState', Config.Gates[gateid].doorid, 0)
        TriggerServerEvent('gl-prison:SetGate', gateid, true)
      end
      LocalPlayer.state:set("inv_busy", false, true)
    end)
  end
end

Config.PowerOutageTimer = 5.0

Config.Gates = {
  [0] = {
    coords = vector3(1846.05, 2604.71, 44.65),
    length = 0.5,
    width = 0.5,
    heading = 0,
    height = 1.2,
    icon = 'fa-solid fa-mobile-screen',
    label = 'Hack Gate',
    item = 'gatecrack',
    doorid = 'prison 13'
  },
  [1] = {
    coords = vector3(1819.52, 2604.69, 44.58),
    length = 0.5,
    width = 0.5,
    heading = 0,
    height = 1.2,
    icon = 'fa-solid fa-mobile-screen',
    label = 'Hack Gate',
    item = 'gatecrack',
    doorid = 'prison 14'
  },
  [2] = {
    coords = vector3(1804.75, 2616.26, 44.61),
    length = 0.5,
    width = 0.5,
    heading = 0,
    height = 1.2,
    icon = 'fa-solid fa-mobile-screen',
    label = 'Hack Gate',
    item = 'gatecrack',
    doorid = 'prison 15'
  },
}

Config.Power = {
  [0] = {
    coords = vector3(1822.98, 2599.64, 44.6),
    anim_coords = vector4(1823.1, 2600.17, 45.69, 180.02),
    ptfx_coords = vector3(1823.18, 2601.02, 45.65),
    explosion_coords = vector3(1822.65, 2599.49, 47.95),
    length = 1.0,
    width = 0.5,
    heading = 0,
    height = 2.2,
    icon = 'fa-solid fa-explosion',
    label = 'Blow Up Generators',
    item = 'thermite'
  }
}

Config.Switches = {
  [0] = {
    coords = vector3(1791.84, 2597.54, 45.57),
    length = 0.2,
    width = 0.4,
    heading = 270,
    height = 0.5,
    state = true,
    doorid = 'prison 53',
  }
}

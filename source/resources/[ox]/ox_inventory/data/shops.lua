---wip types

---@class OxShop
---@field name string
---@field blip? { id: number, colour: number, scale: number }
---@field inventory { name: string, price: number, count?: number, currency?: string }
---@field locations? vector3[]
---@field targets? { loc: vector3, length: number, width: number, heading: number, minZ: number, maxZ: number, distance: number, debug?: boolean, drawSprite?: boolean }[]
---@field groups? string | string[] | { [string]: number }

return {
  General = {
    name = '24/7 Store',
    blip = {
      id = 59, colour = 69, scale = 0.8
    },
    inventory = {
      { name = "water",         price = 2 },
      { name = "ecola",         price = 2 },
      { name = "twerks_candy",  price = 2 },
      { name = "snikkel_candy", price = 2 },
      { name = "sandwich",      price = 2 },
      { name = "beer",          price = 7 },
      { name = "whiskey",       price = 10 },
      { name = "vodka",         price = 12 },
      { name = "bandage",       price = 100 },
      { name = "lighter",       price = 2 },
      { name = "rolling_paper", price = 2 },
      { name = "berkeleypack",  price = 500 },
    },
    targets = {
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(24.616, -1347.156, 29.296),
        heading = 275.905,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(-3039.28, 584.701, 7.908),
        heading = 12.512,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(-3242.327, 1000.284, 12.83),
        heading = 359.155,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(1728.544, 6415.62, 35.037),
        heading = 235.041,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(1697.156, 4923.066, 42.063),
        heading = 321.504,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(1960.199, 3740.69, 32.343),
        heading = 299.182,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(548.844, 2671.048, 42.156),
        heading = 101.188,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(2677.769, 3280.027, 55.241),
        heading = 332.679,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(2556.762, 381.258, 108.622),
        heading = 355.734,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(373.11, 326.901, 103.566),
        heading = 260.35,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(-46.387, -1757.437, 29.421),
        heading = 47.905,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(-706.043, -912.88, 19.215),
        heading = 89.409,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(-1820.747, 794.818, 138.092),
        heading = 136.437,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(1164.516, -321.849, 69.205),
        heading = 100.697,
      },
      {
        ped = `mp_m_shopkeep_01`,
        loc = vec3(161.068, 6641.571, 31.698),
        heading = 222.559,
      },
    }
  },
  Liquor = {
    name = 'Liquor Store',
    blip = {
      id = 93, colour = 69, scale = 0.8
    },
    inventory = { -- Place Holders for now
      { name = "tosti",         price = 2 },
      { name = "water",         price = 2 },
      { name = "cola",          price = 2 },
      { name = "twerks_candy",  price = 2 },
      { name = "snikkel_candy", price = 2 },
      { name = "sandwich",      price = 2 },
      { name = "beer",          price = 7 },
      { name = "whiskey",       price = 10 },
      { name = "vodka",         price = 12 },
      { name = "bandage",       price = 100 },
      { name = "lighter",       price = 2 },
      { name = "rolling_paper", price = 2 },
      { name = "berkeleypack",  price = 500 },
    },
    targets = {
      {
        ped = `S_M_M_CntryBar_01`,
        loc = vec3(1134.123, -981.562, 46.415),
        heading = 271.4,
      },
      {
        ped = `S_M_M_CntryBar_01`,
        loc = vec3(-1221.432, -907.933, 12.326),
        heading = 30.091,
      },
      {
        ped = `S_M_M_CntryBar_01`,
        loc = vec3(-1486.768, -377.557, 40.163),
        heading = 132.665,
      },
      {
        ped = `S_M_M_CntryBar_01`,
        loc = vec3(-2966.504, 390.235, 15.043),
        heading = 77.934,
      },
      {
        ped = `S_M_M_CntryBar_01`,
        loc = vec3(1166.701, 2710.776, 38.157),
        heading = 174.105,
      },
      {
        ped = `S_M_M_CntryBar_01`,
        loc = vec3(1388.406, 3604.652, 34.98),
        heading = 260.059,
      },
    }
  },
  Hardware = {
    name = 'Hardware Store',
    blip = {
      id = 402, colour = 69, scale = 0.8
    },
    inventory = {
      { name = "radio",          price = 100 },
      { name = "binoculars",     price = 100 },
      { name = "profertilizer",  price = 200 },
      { name = "fishingrod",     price = 200 },
      { name = "fishingbait",    price = 10 },
      { name = "lockpick",       price = 500 },
      { name = "weapon_wrench",  price = 600 },
      { name = "weapon_hammer",  price = 500 },
      { name = "repairkit",      price = 350 },
      --{ name = "beehive",        price = 200 },
      { name = "phone",          price = 800 },
      { name = "screwdriverset", price = 2000 },
    },
    targets = {
      {
        ped = `S_M_Y_Construct_01`,
        loc = vec3(2747.136, 3472.657, 55.67),
        heading = 250.388,
      },
      {
        ped = `S_M_Y_Construct_01`,
        loc = vec3(46.648, -1749.515, 29.634),
        heading = 41.765,
      },
    }
  },
  Pharmacy = {
    name = 'Pharmacy',
    blip = {
      id = 51, colour = 69, scale = 0.6
    },
    inventory = {
      { name = "coughsyrup", price = 2500 }
    },
    targets = {
      {
        ped = `A_M_Y_BusiCas_01`,
        loc = vec3(318.658, -1078.423, 29.478),
        heading = 358.35,
      },
      {
        ped = `A_M_Y_BusiCas_01`,
        loc = vec3(91.987, -230.917, 54.663),
        heading = 342.636,
      },
      {
        ped = `A_M_Y_BusiCas_01`,
        loc = vec3(-177.061, 6384.887, 31.495),
        heading = 217.036,
      },
    }
  },
  Computer = {
    name = 'Computer Store',
    blip = {
      id = 521, colour = 27, scale = 0.7
    },
    inventory = {
      { name = "laptop",     price = 2500 },
      { name = "weapon_bat", price = 450 },
      { name = "phone",      price = 50 }
    },
    targets = {
      {
        ped = `A_M_Y_Business_02`,
        loc = vec3(1132.265, -474.343, 66.718),
        heading = 348.976,
      },
      {
        ped = `A_M_Y_Business_02`,
        loc = vec3(-656.393, -858.748, 24.49),
        heading = 5.21,
      },
    }
  },
  -- Casinobar = {
  -- 	name = 'Casino Bar',
  -- 	blip = {
  -- 		id = 402, colour = 69, scale = 0.8
  -- 	}, inventory = {
  -- 		{ name = 'lockpick', price = 10 } -- Placeholder
  -- 	}, locations = {
  -- 		vec3(-1687.03, -1072.18, 13.15)
  -- 	}, targets = {}
  -- },

  Seaword = {
    name = 'Sea Word',
    blip = {
      id = 402, colour = 69, scale = 0.8
    },
    inventory = {
      { name = "diving_gear", price = 2500 },
      { name = "jerry_can",   price = 200 },
      { name = "fishingrod",  price = 200 },
      { name = "fishingbait", price = 10 }
    },
    targets = {
      ped = `A_M_O_Beach_01`,
      loc = vec3(-1687.404, -1072.925, 13.151),
      heading = 10.781,
    }
  },
  -- Illegal = {
  --   name = 'Donny The Dealer',
  --   blip = {
  --     id = 402, colour = 69, scale = 0.8
  --   },
  --   inventory = {
  --     { name = "fishingbait", price = 200 },
  --   },
  --   targets = {
  --     ped = `IG_DrugDealer`,
  --     loc = vec3(-277.211, 2208.62, 129.853),
  --     heading = 62.287,
  --   }
  -- },
  Hunting = {
    name = 'Hunting Store',
    blip = {
      id = 402, colour = 69, scale = 0.8
    },
    inventory = {
      { name = "weapon_huntingrifle", price = 2500 },
      { name = "hunting_bait",        price = 50 },
      { name = "hunting_ammo",        price = 500 },
      { name = "weapon_knife",        price = 250 }
    },
    targets = {
      ped = `IG_Hunter`,
      loc = vec3(562.905, 2741.653, 42.868),
      heading = 172.901,
    }
  },
  FertFarming = {
    name = 'Farming Store',
    blip = {
      id = 677, colour = 69, scale = 0.8
    },
    inventory = {
      { name = "fertilizer", price = 200 }
    },
    targets = {
      ped = `a_m_m_farmer_01`,
      loc = vec3(1678.448, 4881.844, 42.041),
      heading = 45.296,
    }
  },
  -- Weedshop = {
  --   name = 'Smoke On The Water',
  --   blip = {
  --     id = 402, colour = 69, scale = 0.8
  --   },
  --   inventory = {
  --     { name = "joint",          price = 10 },
  --     { name = "weed_nutrition", price = 20 },
  --     { name = "empty_weed_bag", price = 2 },
  --     { name = "rolling_paper",  price = 2 }
  --   },
  --   targets = {
  --     ped = `IG_Hunter`,
  --     loc = vec3(-1170.822, -1570.523, 4.663),
  --     heading = 135.598,
  --   }
  -- },
  Mining = {
    name = 'Mining Shop',
    blip = {
      id = 527, colour = 81, scale = 0.8
    },
    inventory = {
      { name = "goldpan",     price = 2500 },
      { name = "pickaxe",     price = 100 },
      { name = "miningdrill", price = 18000 },
      { name = "mininglaser", price = 60000 },
      { name = "drillbit",    price = 35 },
    },
    targets = {
      {
        ped = `G_M_M_ChemWork_01`,
        loc = vec3(1074.89, -1988.19, 30.89),
        scenario = "WORLD_HUMAN_CLIPBOARD",
        heading = 235.07,
      },
      {
        ped = `G_M_M_ChemWork_01`,
        loc = vec3(2960.9, 2754.14, 43.71),
        scenario = "WORLD_HUMAN_CLIPBOARD",
        heading = 204.58,
      },
      {
        ped = `G_M_M_ChemWork_01`,
        loc = vec3(2908.8, 2643.6, 43.26),
        scenario = "WORLD_HUMAN_CLIPBOARD",
        heading = 328.32,
      },

    }
  },
  Bennys = {
    name = 'Benny\'s Supplies',
    groups = { mechanic = 0 },
    inventory = {
      { name = "Plastic",     price = 50 },
      { name = "hood",        price = 1100 },
      { name = "roof",        price = 1100 },
      { name = "spoiler",     price = 800 },
      { name = "bumper",      price = 500 },
      { name = "skirts",      price = 600 },
      { name = "exhaust",     price = 500 },
      { name = "seat",        price = 800 },
      { name = "livery",      price = 750 },
      { name = "tires",       price = 300 },
      { name = "horn",        price = 300 },
      { name = "internals",   price = 1000 },
      { name = "externals",   price = 1100 },
      { name = "customplate", price = 100 },
      { name = "headlights",  price = 200 },
      { name = "rims",        price = 450 },
      { name = "rollcage",    price = 1200 },
      { name = "noscolour",   price = 750 },
    },
    targets = {
      {
        coords = vec3(-197.95, -1317.2, 31.0),
        size = vec3(1.0, 1.0, 1),
        rotation = 0.0,
      }

    }
  },
  Bennystools = {
    name = 'Benny\'s Tool\'s',
    groups = { mechanic = 0 },
    inventory = {
      { name = "mechanic_tools",       price = 100 },
      { name = "toolbox",              price = 50 },
      { name = "paintcan",             price = 200 },
      { name = "tint_supplies",        price = 100 },
      { name = "underglow_controller", price = 175 },
      { name = "cleaningkit",          price = 120 },
      { name = "newoil",               price = 40 },
      { name = "sparkplugs",           price = 25 },
      { name = "carbattery",           price = 75 },
      { name = "axleparts",            price = 50 },
      { name = "sparetire",            price = 50 },
    },
    targets = {
      {
        coords = vec3(-217.65, -1334.8, 31.0),
        size = vec3(1, 1, 1),
        rotation = 0.0,
      },

    }
  },
  Ammunation = {
    name = 'Ammunation',
    blip = {
      id = 110, colour = 69, scale = 0.8
    },
    inventory = {
      { name = "weapon_knife",      price = 250 },
      { name = "weapon_hatchet",    price = 350 },
      { name = "weapon_bat",        price = 450 },
      { name = "armor",             price = 500 },
      { name = "weapon_pistol",     price = 3500, metadata = { registered = true }, license = 'firearm' },
      { name = "WEAPON_PISTOL_MK2", price = 4200, metadata = { registered = true }, license = 'firearm' },
      { name = "pistol_boxammo",    price = 250,  metadata = { registered = true }, license = 'firearm' }
    },
    targets = {
      {
        ped = `S_M_M_AmmuCountry`,
        loc = vec3(-659.186, -937.317, 21.829),
        heading = 86.047,
      },
      {
        ped = `S_M_Y_AmmuCity_01`,
        loc = vec3(815.383, -2155.225, 29.619),
        heading = 9.983,
      },
      {
        ped = `S_M_M_AmmuCountry`,
        loc = vec3(1696.739, 3758.594, 34.705),
        heading = 151.299,
      },
      {
        ped = `S_M_Y_AmmuCity_01`,
        loc = vec3(-327.143, 6082.292, 31.454),
        heading = 130.554,
      },
      {
        ped = `S_M_Y_AmmuCity_01`,
        loc = vec3(248.293, -51.885, 69.941),
        heading = 338.873,
      },
      {
        ped = `S_M_Y_AmmuCity_01`,
        loc = vec3(16.942, -1107.526, 29.797),
        heading = 154.123,
      },
      {
        ped = `S_M_M_AmmuCountry`,
        loc = vec3(2564.826, 297.531, 108.735),
        heading = 270.026,
      },
      {
        ped = `S_M_M_AmmuCountry`,
        loc = vec3(-1113.533, 2698.345, 18.554),
        heading = 130.898,
      },
      {
        ped = `S_M_Y_AmmuCity_01`,
        loc = vec3(841.179, -1029.958, 28.194),
        heading = 265.484,
      },
      {
        ped = `S_M_Y_AmmuCity_01`,
        loc = vec3(-1309.253, -394.667, 36.695),
        heading = 353.731,
      },

      {
        ped = `S_M_Y_AmmuCity_01`,
        loc = vec3(-3168.326, 1087.512, 20.838),
        heading = 158.486,
      },
    }
  },
  PoliceArmoury = {
    name = 'Police Armoury',
    groups = shared.police,
    inventory = {
      { name = "pistol_boxammo",    price = 45, },
      -- { name = "rifle_boxammo",          price = 150, },
      -- { name = "shotgun_boxammo",        price = 50, },
      -- { name = "smg_boxammo",            price = 100, },
      { name = "taser_boxammo",     price = 10, },
      -- { name = "beanbag_boxammo",        price = 10, },
      { name = "repairkit",         price = 350, },
      { name = "armor",             price = 60, },
      { name = "ifaks",             price = 80, }, -- speak with paul
      { name = "radio",             price = 10, },
      { name = "WEAPON_FLASHLIGHT", price = 150, },
      { name = "handcuffs",         price = 120, },
      { name = "police_stormram",   price = 2000, },
      { name = "spikestrip",        price = 155, },
      { name = "stoppedvehicles",   price = 20, },
      { name = "barricade",         price = 20, },
      { name = "roadblock",         price = 20, },
      { name = "cone",              price = 20, },
      { name = "light",             price = 20, },
      { name = "pdcamera",          price = 200, },
      -- { name = "emp_boxammo",            price = 1000,  grade = 100 },
      { name = "WEAPON_NIGHTSTICK", price = 150,  metadata = { registered = true, pd_issued = true }, },
      { name = "WEAPON_TASER",      price = 300,  metadata = { registered = true, pd_issued = true }, },
      { name = "WEAPON_GLOCK",      price = 450,  metadata = { registered = true, pd_issued = true }, },
      -- { name = "WEAPON_COMBATPDW",       price = 1000,   metadata = { registered = true, pd_issued = true },},
      -- { name = "WEAPON_PUMPSHOTGUN_MK2", price = 800,   metadata = { registered = true, pd_issued = true },},
      -- { name = "WEAPON_LTL",             price = 750,   metadata = { registered = true, pd_issued = true },},
      -- { name = "WEAPON_M4",              price = 1200,   metadata = { registered = true, pd_issued = true },},
      -- { name = "WEAPON_RAILGUN",         price = 10000, metadata = { registered = true, pd_issued = true }, grade = 100 },
      -- { name = "weapon_mp7",             price = 900,    metadata = { registered = true, pd_issued = true }, license = 'lspd_swat', },
      -- { name = "weapon_m14",             price = 1600,    metadata = { registered = true, pd_issued = true }, license = 'lspd_swat', },
      -- { name = "heavyarmor",             price = 150,    metadata = { registered = true, pd_issued = true }, license = 'lspd_swat', },
      -- { name = "weapon_smg",             price = 900,    metadata = { registered = true, pd_issued = true }, license = 'lspd_swat', }
    },
    targets = {
      {
        coords = vec3(481.55, -995.1, 30.65),
        size = vec3(3.25, 0.80000000000001, 1.85),
        rotation = 359.75,
      },
      {
        coords = vec3(485.65, -995.35, 30.7),
        size = vec3(3.6, 0.95000000000001, 2.0),
        rotation = 359.5,
      },
      {
        coords = vec3(487.86, -996.8, 30.7),
        size = vec3(0.6, 3.5, 1.95),
        rotation = 358.25,
      },
      {
        coords = vec3(1834.9, 2570.35, 46.0),
        size = vec3(3.25, 0.40000000000001, 1.95),
        rotation = 0.0,
      },
      {
        coords = vec3(1833.5, 2571.8, 46.05),
        size = vec3(0.80000000000001, 3.2, 1.9),
        rotation = 0.0,
      },
      {
        coords = vec3(1836.75, 3685.7, 34.3),
        size = vec3(4.3, 0.45, 2.1),
        rotation = 299.75,
      },
      {
        coords = vec3(1839.1, 3686.35, 34.0),
        size = vec3(0.65000000000001, 5.35, 4.0),
        rotation = 30.0,
      },
      {
        coords = vec3(-449.3, 6013.1, 37.0),
        size = vec3(3.3, 0.45, 1.85),
        rotation = 314.75,
      },
      {
        coords = vec3(-449.6, 6015.25, 37.0),
        size = vec3(0.70000000000001, 3.05, 1.95),
        rotation = 313.5,
      },
      {
        coords = vec3(-447.65, 6016.95, 37.0),
        size = vec3(1, 2, 2.0),
        rotation = 315.5,
      },
      {
        coords = vec3(-446.05, 6018.95, 37.0),
        size = vec3(0.45000000000001, 2.95, 1.9),
        rotation = 314.75,
      },
      {
        coords = vec3(387.97, 800.07, 187.55),
        size = vec3(1.1, 0.25, 2.1),
        rotation = 0.25,
      },
    }
  },
  EMSArmoury = {
    name = 'Medicine Cabinet',
    groups = { ambulance = 0 },
    inventory = {
      { name = 'ifaks',       price = 60 },
      { name = 'defib',       price = 500 },
      { name = 'painkillers', price = 60 },
      { name = 'bandage',     price = 30 }
    },
    targets = {
      {
        coords = vec3(-254.72, 6326.76, 32.7),
        size = vec3(1.55, 0.6, 2.5),
        rotation = 315.5,
      },
      {
        coords = vec3(306.63, -602.09, 43.5),
        size = vec3(2.05, 0.60000000000001, 2.4),
        rotation = 340.0,
      },
    }
  },
  -- BlackMarketArms = {
  --   name = 'Black Market (Arms)',
  --   inventory = {
  --     { name = 'WEAPON_DAGGER', price = 5000, metadata = { registered = false	}, currency = 'black_money' },
  --     { name = 'WEAPON_CERAMICPISTOL', price = 50000, metadata = { registered = false }, currency = 'black_money' },
  --     { name = 'at_suppressor_light', price = 50000, currency = 'black_money' },
  --     { name = 'ammo-rifle', price = 1000, currency = 'black_money' },
  --     { name = 'ammo-rifle2', price = 1000, currency = 'black_money' }
  --   }, locations = {
  --     vec3(309.09, -913.75, 56.46)
  --   }, targets = {

  --   }
  -- },

  VendingMachineDrinks = {
    name = 'Vending Machine',
    inventory = {
      { name = 'water', price = 10 },
      { name = 'cola',  price = 10 },
    },
    model = {
      `prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
    }
  },

}

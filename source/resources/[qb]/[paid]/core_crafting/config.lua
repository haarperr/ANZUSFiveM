Config = {

  BlipSprite = 44,
  BlipColor = 48,
  BlipText = '!You should not see this',

  UseLimitSystem = false,           -- Enable if your esx uses limit system

  CraftingStopWithDistance = false, -- Crafting will stop when not near workbench

  -- ExperiancePerCraft = 5, -- The amount of experiance added per craft (100 Experiance is 1 level)

  HideWhenCantCraft = true, -- Instead of lowering the opacity it hides the item that is not craftable due to low level or wrong job

  Categories = {
    ['blueprint']   = {
      Label = 'Blueprint',
      Image = 'blank_bp_paper',
      Jobs = {}
    },
    ['items']       = {
      Label = 'Items',
      Image = 'itemsicon',
      Jobs = {}
    },
    ['tools']       = {
      Label = 'Tools',
      Image = 'tools',
      Jobs = {}
    },
    ['weaponparts'] = {
      Label = 'Weapon Parts',
      Image = 'lowerreceiver',
      Jobs = {}
    },
    ['melee']       = {
      Label = 'Melee',
      Image = 'Melee',
      Jobs = {}
    },
    ['pistol']      = {
      Label = 'Pistols',
      Image = 'PISTOLICON',
      Jobs = {}
    },
    ['smg']         = {
      Label = 'SMG',
      Image = 'SMG',
      Jobs = {}
    },
    ['shotgun']     = {
      Label = 'Shotgun',
      Image = 'Shotgun',
      Jobs = {}
    },
    ['rifles']      = {
      Label = 'Rifle',
      Image = 'ASSAULTRILESICON',
      Jobs = {}
    },
    ['sniper']      = {
      Label = 'Sniper',
      Image = 'sniper',
      Jobs = {}
    },
    ['throwable']   = {
      Label = 'Throwable',
      Image = 'throwable',
      Jobs = {}
    },
    ['special']     = {
      Label = 'Special',
      Image = 'Special',
      Jobs = {}
    },
    ['attachment']  = {
      Label = 'Attachment',
      Image = 'attachment',
      Jobs = {}
    },
    ['ammo']        = {
      Label = 'Ammo',
      Image = 'ammo',
      Jobs = {}
    }
  },

  PermanentItems = { -- Items that dont get removed when crafting
    ['wrench'] = true,
    ['blowtorch'] = true,
    ['screwdriver'] = true,
    ['smithingwrench'] = true,
    ['cutter'] = true,
    ['press'] = true,
    ['advancedscrewdriver'] = true,
    ['electronickit'] = true,
    ['screwdriverset'] = true,
    ['isifter'] = true
  },

  Recipes = {


    -- Items

    ['charcoal']            = {
      Level = 0,                -- From what level this item will be craftable
      Category = 'items',       -- The category item will be put in
      isGun = false,            -- Specify if this is a gun so it will be added to the loadout
      Jobs = {},                -- What jobs can craft this item, leaving {} allows any job
      JobGrades = {},           -- What job grades can craft this item, leaving {} allows any grade
      Amount = 6,               -- The amount that will be crafted
      SuccessRate = 100,        -- 100% you will recieve the item
      ExperiancePerCraft = 5,   -- The amount of experiance added per craft (100 Experiance is 1 level)
      requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
      Time = 2,                 -- Time in seconds it takes to craft this item
      Ingredients = {           -- Ingredients needed to craft this item
        ['blowtorch'] = 1,      -- item name and count, adding items that dont exist in database will crash the script
        ['tree_bark'] = 3
      }
    },
    ['bandage']             = {
      Level = 0,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 6,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['cloth'] = 3
      }
    },
    ['gunpowder']           = {
      Level = 1,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 6,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['charcoal'] = 1,
        ['sulfer'] = 3
      }
    },
    ['firstaid']            = {
      Level = 15,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 6,
      SuccessRate = 100,
      ExperiancePerCraft = 4,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['bandage'] = 2
      }
    },
    ['armor']               = {
      Level = 15,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['kevlar'] = 2,
        ['cloth'] = 1
      }
    },
    ['kevlar']              = {
      Level = 15,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 5,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['cloth'] = 3,
        ['plastic'] = 1
      }
    },
    ['lockpick']            = {
      Level = 15,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 5,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['metalscrap'] = 5,
        ['aluminum'] = 10
      }
    },
    ['heavyarmor']          = {
      Level = 30,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 25,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['armor'] = 1,
        ['steelplates'] = 2
      }
    },
    ['refinedgp']           = {
      Level = 30,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 6,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 20,
      Ingredients = {
        ['gunpowder'] = 12,
        ['isifter'] = 1
      }
    },
    ['techcomp']            = {
      Level = 30,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 5,
      SuccessRate = 100,
      ExperiancePerCraft = 3,
      requireBlueprint = false,
      Time = 15,
      Ingredients = {
        ['iphone'] = 1
      }
    },
    ['advancedlockpick']    = {
      Level = 30,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 5,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['aluminum'] = 15,
        ['steelbars'] = 2,
        ['steel'] = 8
      }
    },
    ['rawexplosive']        = {
      Level = 32,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 6,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 15,
      Ingredients = {
        ['refinedgp'] = 12,
        ['plastic'] = 6,
        ['fertilizer'] = 1
      }
    },
    ['thermite']            = {
      Level = 35,
      Category = 'items',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 35,
      Ingredients = {
        ['explosive'] = 2,
        ['techcomp'] = 5,
        ['steel'] = 20,
        ['aluminum'] = 35
      }
    },

    -- Tools

    ['blowtorch']           = {
      Level = 0,
      Category = 'tools',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['lighter'] = 1,
        ['aluminum'] = 10
      }
    },
    ['screwdriver']         = {
      Level = 5,
      Category = 'tools',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['steel'] = 10,
        ['aluminum'] = 10,
        ['metalscrap'] = 5
      }
    },
    ['smithingwrench']      = {
      Level = 10,
      Category = 'tools',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 3,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['steel'] = 5,
        ['aluminum'] = 10,
        ['metalscrap'] = 10
      }
    },
    ['cutter']              = {
      Level = 10,
      Category = 'tools',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['steel'] = 5,
        ['aluminum'] = 15,
        ['metalscrap'] = 5
      }
    },
    ['press']               = {
      Level = 10,
      Category = 'tools',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['steel'] = 10,
        ['aluminum'] = 5,
        ['metalscrap'] = 5
      }
    },
    ['advancedscrewdriver'] = {
      Level = 10,
      Category = 'tools',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['steel'] = 10,
        ['aluminum'] = 20,
        ['metalscrap'] = 15
      }
    },
    ['electronickit']       = {
      Level = 15,
      Category = 'tools',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['screwdriver'] = 1,
        ['copper'] = 5,
        ['cutter'] = 1
      }
    },
    ['screwdriverset']      = {
      Level = 20,
      Category = 'tools',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['screwdriver'] = 1,
        ['advancedscrewdriver'] = 1
      }
    },
    ['isifter']             = {
      Level = 30,
      Category = 'tools',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 10,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['steel'] = 15,
        ['steelbars'] = 5,
        ['aluminum'] = 30,
        ['metalscrap'] = 10
      }
    },

    -- Ammo items

    ['emptypistolcasing']   = {
      Level = 10,
      Category = 'ammo',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 10,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['cutter'] = 1,
        ['copper'] = 5
      }
    },
    ['emptysmgcasing']      = {
      Level = 20,
      Category = 'ammo',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 10,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['cutter'] = 1,
        ['copper'] = 5
      }
    },
    ['emptyshotguncasing']  = {
      Level = 23,
      Category = 'ammo',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 10,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['cutter'] = 1,
        ['copper'] = 5
      }
    },
    ['emptyriflecasing']    = {
      Level = 30,
      Category = 'ammo',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 10,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['cutter'] = 1,
        ['copper'] = 5
      }
    },
    ['emptysnipercasing']   = {
      Level = 50,
      Category = 'ammo',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 10,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['cutter'] = 1,
        ['copper'] = 5
      }
    },


    -- Melee

    ["WEAPON_KNUCKLE"]       = {
      Level = 1,
      Category = 'melee',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['goldbar'] = 3
      }
    },
    ["WEAPON_BAT"]           = {
      Level = 3,
      Category = 'melee',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['plastic'] = 10
      }
    },
    ["WEAPON_DAGGER"]        = {
      Level = 5,
      Category = 'melee',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['wood_plank'] = 2,
        ['steel'] = 3
      }
    },
    ["WEAPON_KATANAS"]       = {
      Level = 9,
      Category = 'melee',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['copper'] = 3,
        ['steelbars'] = 2
      }
    },
    ["WEAPON_KATANA"]        = {
      Level = 25,
      Category = 'melee',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 5,
      Ingredients = {
        ['plastic'] = 5,
        ['steelbars'] = 3,
        ['ruby'] = 1
      }
    },
    -- Pistols

    ["WEAPON_BROWNING"]      = {
      Level = 10,
      Category = 'pistol',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 10,
      Ingredients = {
        ['pistol_fireingpin'] = 1,
        ['pistoltrigger'] = 1,
        ['pistolbarrel'] = 1,
        ['pistolreciever'] = 1,
        ['pistolslide'] = 1,
        ['metalscrap'] = 15,
        ['aluminum'] = 30
      }
    },
    ["WEAPON_DP9"]           = {
      Level = 12,
      Category = 'pistol',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 10,
      Ingredients = {
        ['pistoltrigger'] = 1,
        ['pistolbarrel'] = 1,
        ['pistolreciever'] = 1,
        ['pistolslide'] = 1,
        ['metalscrap'] = 15,
        ['aluminum'] = 30
      }
    },
    ["WEAPON_HEAVYPISTOL"]   = {
      Level = 15,
      Category = 'pistol',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 10,
      Ingredients = {
        ['pistol_fireingpin'] = 1,
        ['pistoltrigger'] = 1,
        ['pistolbarrel'] = 1,
        ['pistolreciever'] = 1,
        ['pistolslide'] = 1,
        ['glass'] = 1,
        ['metalscrap'] = 18,
        ['aluminum'] = 32
      }
    },
    ["WEAPON_PISTOL50"]      = {
      Level = 18,
      Category = 'pistol',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 3,
      requireBlueprint = false,
      Time = 10,
      Ingredients = {
        ['pistol_fireingpin'] = 1,
        ['pistoltrigger'] = 1,
        ['pistolbarrel'] = 1,
        ['pistolreciever'] = 1,
        ['pistolslide'] = 1,
        ['metalscrap'] = 20,
        ['aluminum'] = 35
      }
    },
    ["WEAPON_DOUBLEACTION"]  = {
      Level = 20,
      Category = 'pistol',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 10,
      Ingredients = {
        ['pistol_fireingpin'] = 1,
        ['pistoltrigger'] = 1,
        ['pistolbarrel'] = 1,
        ['pistolreciever'] = 1,
        ['pistolslide'] = 1,
        ['metalscrap'] = 25,
        ['aluminum'] = 40
      }
    },

    -- Pistol Weapon Parts

    ['pistoltrigger']        = {
      Level = 10,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 1,
        ['metalscrap'] = 4,
        ['iron'] = 4
      }
    },
    ['pistolbarrel']         = {
      Level = 10,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 2,
        ['metalscrap'] = 20,
        ['iron'] = 5
      }
    },
    ['pistolreciever']       = {
      Level = 10,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 2,
        ['metalscrap'] = 16,
        ['iron'] = 5
      }
    },
    ['pistolslide']          = {
      Level = 10,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 1,
        ['metalscrap'] = 10,
        ['iron'] = 4
      }
    },

    -- Weapon Parts

    ['guntrigger']           = {
      Level = 20,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 1,
        ['metalscrap'] = 4,
        ['iron'] = 2
      }
    },
    ['gunbolt']              = {
      Level = 20,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 1,
        ['metalscrap'] = 4,
        ['iron'] = 4
      }
    },
    ['gunstock']             = {
      Level = 20,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 2,
        ['metalscrap'] = 8,
        ['iron'] = 4
      }
    },
    ['lowerreceiver']        = {
      Level = 20,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 2,
        ['metalscrap'] = 8,
        ['iron'] = 6
      }
    },
    ['upperreceiver']        = {
      Level = 20,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 3,
        ['metalscrap'] = 10,
        ['iron'] = 8
      }
    },
    ['gunbarrel']            = {
      Level = 20,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 2,
        ['metalscrap'] = 8,
        ['iron'] = 4
      }
    },

    -- Shotgun Parts

    ['shotgunbody']          = {
      Level = 23,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 5,
        ['metalscrap'] = 15,
        ['iron'] = 10
      }
    },
    ['forend']               = {
      Level = 23,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 2,
        ['metalscrap'] = 6,
        ['iron'] = 6
      }
    },

    -- Sniper Parts

    ['reinforcedbarrel']     = {
      Level = 50,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 4,
        ['metalscrap'] = 10,
        ['iron'] = 8
      }
    },
    ['sniperreceiver']       = {
      Level = 50,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 1,
      requireBlueprint = false,
      Time = 2,
      Ingredients = {
        ['steel'] = 2,
        ['metalscrap'] = 9,
        ['iron'] = 6
      }
    },

    -- Special Parts

    ["potatobarrel"]         = {
      Level = 75,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 10,
      Ingredients = {
        ['plastic'] = 15,
        ['blowtorch'] = 1,
      }
    },
    ["potatochamber"]        = {
      Level = 75,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 10,
      Ingredients = {
        ['plastic'] = 20,
        ['blowtorch'] = 1,
      }
    },
    ["paintballhopper"]      = {
      Level = 70,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 10,
      Ingredients = {
        ['plastic'] = 20,
        ['blowtorch'] = 1,
      }
    },
    ["launchertube"]         = {
      Level = 95,
      Category = 'weaponparts',
      isGun = false,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 10,
      Ingredients = {
        ['steelbars'] = 15,
        ['aluminum'] = 20,
      }
    },

    -- Ammo

    ["pistol_boxammo"]       = {
      Level = 10,
      Category = 'ammo',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 20,
      Ingredients = {
        ['press'] = 1,
        ['emptypistolcasing'] = 30,
        ['gunpowder'] = 60
      }
    },
    ["smg_boxammo"]          = {
      Level = 20,
      Category = 'ammo',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 20,
      Ingredients = {
        ['press'] = 1,
        ['emptysmgcasing'] = 30,
        ['gunpowder'] = 60
      }
    },
    ["shotgun_boxammo"]      = {
      Level = 23,
      Category = 'ammo',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 20,
      Ingredients = {
        ['press'] = 1,
        ['emptyshotguncasing'] = 30,
        ['gunpowder'] = 60
      }
    },
    ["rifle_boxammo"]        = {
      Level = 30,
      Category = 'ammo',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = false,
      Time = 20,
      Ingredients = {
        ['press'] = 1,
        ['emptyriflecasing'] = 30,
        ['gunpowder'] = 60
      }
    },
    ["sniper_boxammo"]       = {
      Level = 50,
      Category = 'ammo',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5.2,
      requireBlueprint = false,
      Time = 20,
      Ingredients = {
        ['press'] = 1,
        ['emptysnipercasing'] = 15,
        ['gunpowder'] = 60
      }
    },

    -- SMG

    ['WEAPON_MACHINEPISTOL'] = {
      Level = 20,
      Category = 'smg',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = false,
      Time = 15,
      Ingredients = {
        ['smg_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 15,
        ['aluminum'] = 15,
        ['steelbars'] = 1,
        ['rubber'] = 2
      }
    },
    ['WEAPON_APPISTOL']      = {
      Level = 23,
      Category = 'smg',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 2,
      requireBlueprint = true,
      Time = 15,
      Ingredients = {
        ['smg_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['gunstock'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 15,
        ['aluminum'] = 15,
        ['steelbars'] = 1,
        ['rubber'] = 2
      }
    },
    -- ['WEAPON_GEPARD']={
    --     Level = 25,
    --     Category = 'smg',
    --     isGun = true,
    --     Jobs = {},
    --     JobGrades = {},
    --     Amount = 1,
    --     SuccessRate = 100,
    -- 	ExperiancePerCraft = 3,
    --     requireBlueprint = true,
    --     Time = 15,
    --     Ingredients = {
    --         ['guntrigger'] = 1,
    --         ['gunbolt'] = 1,
    --         ['gunstock'] = 1,
    --         ['lowerreceiver'] = 1,
    --         ['upperreceiver'] = 1,
    --         ['gunbarrel'] = 1,
    --         ['metalscrap'] = 18,
    --         ['aluminum'] = 15,
    --         ['steelbars'] = 1,
    --         ['rubber'] = 2,
    --         ['wood_plank'] = 1
    --     }
    -- },
    ['WEAPON_MICROSMG2']     = {
      Level = 28,
      Category = 'smg',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 4,
      requireBlueprint = true,
      Time = 15,
      Ingredients = {
        ['smg_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['gunstock'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 20,
        ['aluminum'] = 18,
        ['steelbars'] = 2,
        ['rubber'] = 2
      }
    },
    ['WEAPON_MINISMG2']      = {
      Level = 28,
      Category = 'smg',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 6,
      requireBlueprint = true,
      Time = 15,
      Ingredients = {
        ['smg_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['gunstock'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 25,
        ['aluminum'] = 18,
        ['steelbars'] = 2,
        ['rubber'] = 2
      }
    },

    -- Shotguns

    ['WEAPON_PUMPSHOTGUN']   = {
      Level = 23,
      Category = 'shotgun',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 6,
      requireBlueprint = true,
      Time = 15,
      Ingredients = {
        ['shotgun_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['forend'] = 1,
        ['gunstock'] = 1,
        ['shotgunbody'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 18,
        ['aluminum'] = 18,
        ['steelbars'] = 1,
        ['rubber'] = 4,
        ['wood_plank'] = 4
      }
    },
    ['WEAPON_COMBATSHOTGUN'] = {
      Level = 30,
      Category = 'shotgun',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 10,
      requireBlueprint = false,
      Time = 15,
      Ingredients = {
        ['shotgun_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['forend'] = 1,
        ['gunstock'] = 1,
        ['shotgunbody'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 32,
        ['aluminum'] = 25,
        ['steelbars'] = 3,
        ['rubber'] = 10
      }
    },

    -- Rifle

    ['WEAPON_ASSAULTRIFLE']  = {
      Level = 30,
      Category = 'rifles',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 6,
      requireBlueprint = true,
      Time = 20,
      Ingredients = {
        ['rifle_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['gunstock'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 30,
        ['aluminum'] = 20,
        ['steelbars'] = 3,
        ['rubber'] = 4,
        ['wood_plank'] = 4
      }
    },
    ['WEAPON_ASSAULTRIFLE2'] = {
      Level = 33,
      Category = 'rifles',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 6,
      requireBlueprint = true,
      Time = 20,
      Ingredients = {
        ['rifle_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['gunstock'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 30,
        ['aluminum'] = 22,
        ['steelbars'] = 3,
        ['rubber'] = 4,
        ['wood_plank'] = 4
      }
    },
    ['WEAPON_COMPACTRIFLE']  = {
      Level = 35,
      Category = 'rifles',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 6,
      requireBlueprint = true,
      Time = 20,
      Ingredients = {
        ['rifle_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['gunstock'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 32,
        ['aluminum'] = 22,
        ['steelbars'] = 3,
        ['rubber'] = 4,
        ['wood_plank'] = 4
      }
    },
    ['WEAPON_ADVANCEDRIFLE'] = {
      Level = 38,
      Category = 'rifles',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 6,
      requireBlueprint = true,
      Time = 20,
      Ingredients = {
        ['rifle_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['gunstock'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 35,
        ['aluminum'] = 25,
        ['steelbars'] = 4,
        ['rubber'] = 2
      }
    },
    ['WEAPON_MILITARYRIFLE'] = {
      Level = 40,
      Category = 'rifles',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 6,
      requireBlueprint = true,
      Time = 20,
      Ingredients = {
        ['rifle_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['gunstock'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 40,
        ['aluminum'] = 28,
        ['steelbars'] = 4,
        ['rubber'] = 4
      }
    },


    -- Snipers

    ['WEAPON_DRAGUNOV']              = {
      Level = 50,
      Category = 'sniper',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 8,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['guntrigger'] = 1,
        ['specialreceiver'] = 1,
        ['gunstock'] = 1,
        ['reinforcedbarrel'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 25,
        ['aluminum'] = 30,
        ['steelbars'] = 3,
        ['rubber'] = 5
      }
    },
    ['WEAPON_G22']                   = {
      Level = 60,
      Category = 'sniper',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 18,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['guntrigger'] = 1,
        ['specialreceiver'] = 1,
        ['gunstock'] = 1,
        ['reinforcedbarrel'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 30,
        ['aluminum'] = 45,
        ['steelbars'] = 5,
        ['rubber'] = 5
      }
    },

    -- Specials

    ['craft1']                       = {
      Level = 35,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 22,
      requireBlueprint = true,
      Time = 120,
      Ingredients = {
        ['advancedscrewdriver'] = 1,
        ['smithingwrench'] = 1,
        ['screwdriverset'] = 1,
        ['metalscrap'] = 100,
        ['aluminum'] = 75,
        ['steelbars'] = 15,
        ['wood_plank'] = 30,
        ['rubber'] = 30
      }
    },
    ['WEAPON_GUSENBERG']             = {
      Level = 70,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 33,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['special_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['gunstock'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 50,
        ['aluminum'] = 30,
        ['steelbars'] = 5,
        ['wood_plank'] = 5,
        ['rubber'] = 5
      }
    },
    ['WEAPON_MOLOTOV']               = {
      Level = 70,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 10,
      requireBlueprint = true,
      Time = 5,
      Ingredients = {
        ['beer'] = 1,
        ['cloth'] = 1,
        ['lighter'] = 1
      }
    },
    ['WEAPON_MG']                    = {
      Level = 75,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 36,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['special_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['gunbolt'] = 1,
        ['gunstock'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 60,
        ['aluminum'] = 35,
        ['steelbars'] = 5,
        ['wood_plank'] = 5,
        ['rubber'] = 5
      }
    },
    ['WEAPON_GRENADELAUNCHER_SMOKE'] = {
      Level = 75,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 23,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['special_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['potatobarrel'] = 1,
        ['potatochamber'] = 1,
        ['plastic'] = 30,
      }
    },
    ['WEAPON_PROXMINE']              = {
      Level = 80,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['explosive'] = 2,
        ['techcomp'] = 5,
        ['aluminum'] = 30
      }
    },
    ['WEAPON_GRENADE']               = {
      Level = 80,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 23,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['explosive'] = 2,
        ['steel'] = 10,
        ['aluminum'] = 20
      }
    },
    ['WEAPON_PIPEBOMB']              = {
      Level = 90,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 5,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['explosive'] = 2,
        ['techcomp'] = 5,
        ['steel'] = 15,
        ['aluminum'] = 40
      }
    },
    ['WEAPON_GRENADELAUNCHER']       = {
      Level = 90,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 32,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['special_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['grenadechamber'] = 1,
        ['gunstock'] = 1,
        ['gunbarrel'] = 1,
        ['metalscrap'] = 60,
        ['aluminum'] = 45,
        ['steelbars'] = 10,
        ['rubber'] = 20
      }
    },
    ['WEAPON_RPG']                   = {
      Level = 95,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 46,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['guntrigger'] = 1,
        ['launchertube'] = 1,
        ['metalscrap'] = 65,
        ['aluminum'] = 45,
        ['steelbars'] = 15,
        ['rubber'] = 20
      }
    },
    ['WEAPON_HOMINGLAUNCHER']        = {
      Level = 99,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 36,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['special_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['launchertube'] = 1,
        ['techcomp'] = 1,
        ['metalscrap'] = 75,
        ['aluminum'] = 50,
        ['steelbars'] = 15,
        ['rubber'] = 20
      }
    },
    ['WEAPON_MINIGUN']               = {
      Level = 100,
      Category = 'special',
      isGun = true,
      Jobs = {},
      JobGrades = {},
      Amount = 1,
      SuccessRate = 100,
      ExperiancePerCraft = 77,
      requireBlueprint = true,
      Time = 35,
      Ingredients = {
        ['special_fireingpin'] = 1,
        ['guntrigger'] = 1,
        ['lowerreceiver'] = 1,
        ['upperreceiver'] = 1,
        ['reinforcedbarrel'] = 6,
        ['metalscrap'] = 80,
        ['aluminum'] = 60,
        ['steelbars'] = 20,
        ['rubber'] = 30
      }
    },

  },
  Workbenches = { -- Every workbench location, leave {} for jobs if you want everybody to access
    {             -- Trevors House
      coords = vector4(1967.6, 3819, 31.5, -149.0),
      length = 3.0,
      width = 3,
      jobs = {},
      blip = true,
      recipes = {},
    },
    { -- Ace Liquor
      coords = vector4(1399.47, 3602.53, 38.94, 201.23),
      length = 3.0,
      width = 3,
      jobs = {},
      blip = true,
      recipes = {},
    },
    { -- The Island
      coords = vector4(3612.99, 5023.06, 11.35, 111.24),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {},
    },
    { -- Plaleto Barn
      coords = vector4(424.41, 6476.86, 35.87, 49.41),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {},
    },
    { -- Tunnel 1
      coords = vector4(594.86, -430.38, 4.05, 56.07),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {},
    },
    { -- Modshop type Building
      coords = vector4(486.98, -1321.82, 29.2, 305.67),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {},
    },
    { -- Mili Base
      coords = vector4(-1810.97, 3105.13, 32.84, 62.72),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {},
    },
    { -- Airport
      coords = vector4(-1565.13, -3235.97, 26.34, 61.12),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {},
    },
    { -- Island 2
      coords = vector4(-2165.78, 5196.89, 16.88, 282.52),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {},
    },
    { -- Life Invader building
      coords = vector4(-1051.46, -232.04, 44.02, 298.48),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {},
    },





    { -- Mafia
      coords = vector4(-929.25177001953, -3061.7236328125, 12.94437789917, 60),
      length = 10.0,
      width = 10,
      jobs = {},
      blip = false,
      recipes = {
        ['bp_weapon_appistol']      = {
          Level = 0,
          Category = 'blueprint',
          isGun = false,
          Jobs = {},
          JobGrades = {},
          Amount = 1,
          SuccessRate = 100,
          ExperiancePerCraft = 1,
          requireBlueprint = false,
          Time = 35,
          Ingredients = {
            ['blank_bp_paper'] = 1,
            ['ink'] = 1,
          }
        },
        ['bp_weapon_militaryrifle'] = {
          Level = 0,
          Category = 'blueprint',
          isGun = false,
          Jobs = {},
          JobGrades = {},
          Amount = 1,
          SuccessRate = 100,
          ExperiancePerCraft = 1,
          requireBlueprint = false,
          Time = 35,
          Ingredients = {
            ['blank_bp_paper'] = 1,
            ['ink'] = 1,
          }
        },
      },
    },

    { -- Vago
      coords = vector4(-928.11157226563, -3059.6652832031, 12.94437789917, 115.096),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {
        ['bp_weapon_minismg2']      = {
          Level = 0,
          Category = 'blueprint',
          isGun = false,
          Jobs = {},
          JobGrades = {},
          Amount = 1,
          SuccessRate = 100,
          ExperiancePerCraft = 1,
          requireBlueprint = false,
          Time = 35,
          Ingredients = {
            ['blank_bp_paper'] = 1,
            ['ink'] = 1,
          }
        },
        ['bp_weapon_assaultrifle2'] = {
          Level = 0,
          Category = 'blueprint',
          isGun = false,
          Jobs = {},
          JobGrades = {},
          Amount = 1,
          SuccessRate = 100,
          ExperiancePerCraft = 1,
          requireBlueprint = false,
          Time = 35,
          Ingredients = {
            ['blank_bp_paper'] = 1,
            ['ink'] = 1,
          }
        },

      },
    },

    { -- Baller
      coords = vector4(-926.84826660156, -3057.505859375, 12.94437789917, 115.096),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {
        ['bp_weapon_microsmg2']    = {
          Level = 0,
          Category = 'blueprint',
          isGun = true,
          Jobs = {},
          JobGrades = {},
          Amount = 1,
          SuccessRate = 100,
          ExperiancePerCraft = 1,
          requireBlueprint = false,
          Time = 35,
          Ingredients = {
            ['blank_bp_paper'] = 1,
            ['ink'] = 1,
          }
        },
        ['bp_weapon_compactrifle'] = {
          Level = 0,
          Category = 'blueprint',
          isGun = true,
          Jobs = {},
          JobGrades = {},
          Amount = 1,
          SuccessRate = 100,
          ExperiancePerCraft = 1,
          requireBlueprint = false,
          Time = 35,
          Ingredients = {
            ['blank_bp_paper'] = 1,
            ['ink'] = 1,
          }
        },
      },
    },

    { -- Biker
      coords = vector4(-925.62963867188, -3055.357421875, 12.94437789917, 115.096),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {
        ['bp_weapon_pumpshotgun']  = {
          Level = 0,
          Category = 'blueprint',
          isGun = true,
          Jobs = {},
          JobGrades = {},
          Amount = 1,
          SuccessRate = 100,
          ExperiancePerCraft = 1,
          requireBlueprint = false,
          Time = 35,
          Ingredients = {
            ['blank_bp_paper'] = 1,
            ['ink'] = 1,
          }
        },
        ['bp_weapon_assaultrifle'] = {
          Level = 0,
          Category = 'blueprint',
          isGun = true,
          Jobs = {},
          JobGrades = {},
          Amount = 1,
          SuccessRate = 100,
          ExperiancePerCraft = 1,
          requireBlueprint = false,
          Time = 35,
          Ingredients = {
            ['blank_bp_paper'] = 1,
            ['ink'] = 1,
          }
        },

      },
    },






    { -- Biker
      coords = vector4(-923.03967285156, -3061.2595214844, 12.94437789917, 25),
      length = 4.0,
      width = 5,
      jobs = {},
      blip = true,
      recipes = {},
    },









  },

  CraftingObject = {
    "gr_prop_gr_bench_01a",
    "sm_hanger_mod_toolsbench",
    "gr_prop_gr_bench_02a",
    "gr_prop_gr_bench_01b",
    "gr_prop_gr_bench_01a",
  },

  PackableObject = {
    "gr_prop_gr_bench_04a",
  },

  WarehouseWorkbench = {
    recipes = {}
  },
  Text = {

    ['not_enough_ingredients'] = 'You dont have enough ingredients',
    ['you_cant_hold_item'] = 'You cant hold the item',
    ['item_crafted'] = 'Item crafted!',
    ['wrong_job'] = 'You cant open this workbench',
    ['workbench_hologram'] = '[~b~E~w~] Workbench',
    ['wrong_usage'] = 'Wrong usage of command',
    ['inv_limit_exceed'] = 'Inventory limit exceeded! Clean up before you lose more',
    ['crafting_failed'] = 'You failed to craft the item!'

  },
}

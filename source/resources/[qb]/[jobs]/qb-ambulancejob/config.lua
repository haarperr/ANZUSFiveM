Config = {}
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add setr UseTarget true)
Config.MinimalDoctors = 2                                    -- How many players with the ambulance job to prevent the hospital check-in system from being used
Config.DocCooldown = 1                                       -- Cooldown between doctor calls allowed, in minutes
Config.WipeInventoryOnRespawn = true                         -- Enable or disable removing all the players items when they respawn at the hospital
Config.Helicopter = "polmav"                                 -- Helicopter model that players with the ambulance job can use
Config.BillCost = 1000                                       -- Price that players are charged for using the hospital check-in system
Config.DeathTime = 300                                       -- How long the timer is for players to bleed out completely and respawn at the hospital
Config.PainkillerInterval = 60                               -- Set the length of time painkillers last (per one)
Config.HealthDamage = 5                                      -- Minumum damage done to health before checking for injuries
Config.ArmorDamage = 5                                       -- Minumum damage done to armor before checking for injuries
Config.ForceInjury = 35                                      -- Maximum amount of damage a player can take before limb damage & effects are forced to occur
Config.AlwaysBleedChance = 70                                -- Set the chance out of 100 that if a player is hit with a weapon, that also has a random chance, it will cause bleeding
Config.MessageTimer = 12                                     -- How long it will take to display limb/bleed message
Config.AIHealTimer = 20                                      -- How long it will take to be healed after checking in, in seconds
Config.BleedTickRate = 30                                    -- How much time, in seconds, between bleed ticks
Config.BleedMovementTick = 10                                -- How many seconds is taken away from the bleed tick rate if the player is walking, jogging, or sprinting
Config.BleedMovementAdvance = 3                              -- How much time moving while bleeding adds
Config.BleedTickDamage = 8                                   -- The base damage that is multiplied by bleed level everytime a bleed tick occurs
Config.FadeOutTimer = 2                                      -- How many bleed ticks occur before fadeout happens
Config.BlackoutTimer = 10                                    -- How many bleed ticks occur before blacking out
Config.AdvanceBleedTimer = 10                                -- How many bleed ticks occur before bleed level increases
Config.HeadInjuryTimer = 30                                  -- How much time, in seconds, do head injury effects chance occur
Config.ArmInjuryTimer = 30                                   -- How much time, in seconds, do arm injury effects chance occur
Config.HeadInjuryChance = 25                                 -- The chance, in percent, that head injury side-effects get applied
Config.MajorArmoredBleedChance = 45                          -- The chance, in percent, that a player will get a bleed effect when taking heavy damage while wearing armor
Config.MaxInjuryChanceMulti = 3                              -- How many times the HealthDamage value above can divide into damage taken before damage is forced to be applied
Config.DamageMinorToMajor = 35                               -- How much damage would have to be applied for a minor weapon to be considered a major damage event. Put this at 100 if you want to disable it
Config.AlertShowInfo = 2                                     -- How many injuries a player must have before being alerted about them

Config.Locations = {                                         -- Edit the various interaction points for players or create new ones
  checking = {
    [1] = vector3(307.641, -595.28, 43.086),
    [2] = vector3(-254.315, 6330.471, 32.584), -- paleto
  },
  duty = {
    [1] = vector3(311.816, -593.378, 43.086),
    [2] = vector3(-256.745, 6333.238, 32.584),

  },
  roof = {
    [1] = vector4(338.5, -583.85, 74.16, 245.5),
  },
  main = {
    [1] = vector3(332.333, -595.618, 43.284),
  },
  lower = {
    [1] = vector3(345.627, -582.523, 28.796),
  },
  repair = {
    [1] = { -- Paleto
      coords = vec3(-271.42, 6324.88, 33.0),
      size = vec3(6.25, 7.0, 4.0),
      rotation = 315.0,
    },
    [2] = {
      coords = vec3(340.32, -570.8, 29.4),
      size = vec3(9.05, 4.6, 3.2),
      rotation = 250.0,
    },


  },
  stash = {
    [1] = {
      points = {
        vec3(297.66000366211, -599.48999023438, 43.5),
        vec3(298.73999023438, -596.09002685547, 43.5),
        vec3(300.70999145508, -597.15002441406, 43.5),
        vec3(299.70001220703, -600.13000488281, 43.5),
      },
      thickness = 2.3,
    },
    [2] = {
      points = {
        vec3(-258.17999267578, 6333.25, 32.0),
        vec3(-257.19000244141, 6332.2998046875, 32.0),
        vec3(-258.20001220703, 6331.4799804688, 32.0),
        vec3(-259.2200012207, 6332.41015625, 32.0),
      },
      thickness = 4.0,
    },
  },
  repair_zone = {
    [1] = {
      points = {
        vec3(-1841.7399902344, -1255.4300537109, 9.0),
        vec3(-1844.0, -1252.0, 9.0),
        vec3(-1856.0, -1244.0, 9.0),
        vec3(-1856.2700195312, -1246.3399658203, 9.0),
        vec3(-1842.5100097656, -1257.6099853516, 9.0),
      },
      thickness = 4.0,
    },
    [2] = {
      points = {
        vec3(-1841.7399902344, -1255.4300537109, 9.0),
        vec3(-1844.0, -1252.0, 9.0),
        vec3(-1856.0, -1244.0, 9.0),
        vec3(-1856.2700195312, -1246.3399658203, 9.0),
        vec3(-1842.5100097656, -1257.6099853516, 9.0),
      },
      thickness = 4.0,
    },
  },




  ---@class Bed
  ---@field coords vector4
  ---@field taken boolean
  ---@field model number

  ---@type Bed[]
  beds = {
    [1] = { coords = vec4(311.13, -582.89, 43.53, 335.65), taken = false, model = 2117668672 },
    [2] = { coords = vec4(313.96, -579.05, 43.53, 164.5), taken = false, model = 2117668672 },
    [3] = { coords = vec4(314.58, -584.09, 43.53, 335.65), taken = false, model = 2117668672 },
    [4] = { coords = vec4(317.74, -585.29, 43.53, 335.65), taken = false, model = 2117668672 },
    [5] = { coords = vec4(319.47, -581.04, 43.53, 164.5), taken = false, model = 2117668672 },
    --- paleto
    [6] = { coords = vec4(-252.43, 6312.25, 32.34, 313.48), taken = false, model = 2117668672 }, -- ??
    [7] = { coords = vec4(-247.04, 6317.95, 32.34, 134.64), taken = false, model = 2117668672 }, -- ??
    [8] = { coords = vec4(-255.98, 6315.67, 32.34, 313.91), taken = false, model = 2117668672 }, -- ??
  },
  jailbeds = {
    [1] = { coords = vec4(1761.96, 2597.74, 45.66, 270.14), taken = false, model = 2117668672 },
    [2] = { coords = vec4(1761.96, 2591.51, 45.66, 269.8), taken = false, model = 2117668672 },
    [3] = { coords = vec4(1771.8, 2598.02, 45.66, 89.05), taken = false, model = 2117668672 },
    [4] = { coords = vec4(1771.85, 2591.85, 45.66, 91.51), taken = false, model = 2117668672 },
  },
  stations = {
    [1] = { label = Lang:t('info.pb_hospital'), coords = vector4(304.27, -600.33, 43.28, 272.249) },
    [2] = { label = Lang:t('info.paletob_hospital'), coords = vector4(-251.877, 6328.398, 32.427, 19.585) }
  }
}

Config.WeaponClasses = { -- Define gta weapon classe numbers
  ['SMALL_CALIBER'] = 1,
  ['MEDIUM_CALIBER'] = 2,
  ['HIGH_CALIBER'] = 3,
  ['SHOTGUN'] = 4,
  ['CUTTING'] = 5,
  ['LIGHT_IMPACT'] = 6,
  ['HEAVY_IMPACT'] = 7,
  ['EXPLOSIVE'] = 8,
  ['FIRE'] = 9,
  ['SUFFOCATING'] = 10,
  ['OTHER'] = 11,
  ['WILDLIFE'] = 12,
  ['NOTHING'] = 13
}

Config.MinorInjurWeapons = { -- Define which weapons cause small injuries
  [Config.WeaponClasses['SMALL_CALIBER']] = true,
  [Config.WeaponClasses['MEDIUM_CALIBER']] = true,
  [Config.WeaponClasses['CUTTING']] = true,
  [Config.WeaponClasses['WILDLIFE']] = true,
  [Config.WeaponClasses['OTHER']] = true,
  [Config.WeaponClasses['LIGHT_IMPACT']] = true,
}

Config.MajorInjurWeapons = { -- Define which weapons cause large injuries
  [Config.WeaponClasses['HIGH_CALIBER']] = true,
  [Config.WeaponClasses['HEAVY_IMPACT']] = true,
  [Config.WeaponClasses['SHOTGUN']] = true,
  [Config.WeaponClasses['EXPLOSIVE']] = true,
}

Config.AlwaysBleedChanceWeapons = { -- Define which weapons will always cause bleedign
  [Config.WeaponClasses['SMALL_CALIBER']] = true,
  [Config.WeaponClasses['MEDIUM_CALIBER']] = true,
  [Config.WeaponClasses['CUTTING']] = true,
  [Config.WeaponClasses['WILDLIFE']] = false,
}

Config.ForceInjuryWeapons = { -- Define which weapons will always cause injuries
  [Config.WeaponClasses['HIGH_CALIBER']] = true,
  [Config.WeaponClasses['HEAVY_IMPACT']] = true,
  [Config.WeaponClasses['EXPLOSIVE']] = true,
}

Config.CriticalAreas = { -- Define body areas that will always cause bleeding if wearing armor or not
  ['UPPER_BODY'] = { armored = false },
  ['LOWER_BODY'] = { armored = true },
  ['SPINE'] = { armored = true },
}

---@class StaggerArea Defined body areas that will always cause staggering if wearing armor or not
---@field armored boolean
---@field major number
---@field minor number
Config.StaggerAreas = {
  ['SPINE'] = { armored = true, major = 60, minor = 30 },
  ['UPPER_BODY'] = { armored = false, major = 60, minor = 30 },
  ['LLEG'] = { armored = true, major = 100, minor = 85 },
  ['RLEG'] = { armored = true, major = 100, minor = 85 },
  ['LFOOT'] = { armored = true, major = 100, minor = 100 },
  ['RFOOT'] = { armored = true, major = 100, minor = 100 },
}

Config.WoundStates = { -- Translate wound alerts
  Lang:t('states.irritated'),
  Lang:t('states.quite_painful'),
  Lang:t('states.painful'),
  Lang:t('states.really_painful'),
}

Config.BleedingStates = { -- Translate bleeding alerts
  [1] = { label = Lang:t('states.little_bleed') },
  [2] = { label = Lang:t('states.bleed') },
  [3] = { label = Lang:t('states.lot_bleed') },
  [4] = { label = Lang:t('states.big_bleed') },
}

Config.MovementRate = { -- Set the player movement rate based on the level of damage they have
  0.98,
  0.96,
  0.94,
  0.92,
}

Config.Bones = { -- Correspond bone hash numbers to their label
  [0]     = 'NONE',
  [31085] = 'HEAD',
  [31086] = 'HEAD',
  [39317] = 'NECK',
  [57597] = 'SPINE',
  [23553] = 'SPINE',
  [24816] = 'SPINE',
  [24817] = 'SPINE',
  [24818] = 'SPINE',
  [10706] = 'UPPER_BODY',
  [64729] = 'UPPER_BODY',
  [11816] = 'LOWER_BODY',
  [45509] = 'LARM',
  [61163] = 'LARM',
  [18905] = 'LHAND',
  [4089]  = 'LFINGER',
  [4090]  = 'LFINGER',
  [4137]  = 'LFINGER',
  [4138]  = 'LFINGER',
  [4153]  = 'LFINGER',
  [4154]  = 'LFINGER',
  [4169]  = 'LFINGER',
  [4170]  = 'LFINGER',
  [4185]  = 'LFINGER',
  [4186]  = 'LFINGER',
  [26610] = 'LFINGER',
  [26611] = 'LFINGER',
  [26612] = 'LFINGER',
  [26613] = 'LFINGER',
  [26614] = 'LFINGER',
  [58271] = 'LLEG',
  [63931] = 'LLEG',
  [2108]  = 'LFOOT',
  [14201] = 'LFOOT',
  [40269] = 'RARM',
  [28252] = 'RARM',
  [57005] = 'RHAND',
  [58866] = 'RFINGER',
  [58867] = 'RFINGER',
  [58868] = 'RFINGER',
  [58869] = 'RFINGER',
  [58870] = 'RFINGER',
  [64016] = 'RFINGER',
  [64017] = 'RFINGER',
  [64064] = 'RFINGER',
  [64065] = 'RFINGER',
  [64080] = 'RFINGER',
  [64081] = 'RFINGER',
  [64096] = 'RFINGER',
  [64097] = 'RFINGER',
  [64112] = 'RFINGER',
  [64113] = 'RFINGER',
  [36864] = 'RLEG',
  [51826] = 'RLEG',
  [20781] = 'RFOOT',
  [52301] = 'RFOOT',
}

---@alias Bone 'NONE'|'HEAD'|'NECK'|'SPINE'|'UPPER_BODY'|'LOWER_BODY'|'LARM'|'LHAND'|'LFINGER'|'LLEG'|'LFOOT'|'RARM'|'RHAND'|'RFINGER'|'RLEG'|'RFOOT'
Config.BoneIndexes = { -- Correspond bone labels to their hash number
  ['NONE'] = 0,
  -- ['HEAD'] = 31085,
  ['HEAD'] = 31086,
  ['NECK'] = 39317,
  -- ['SPINE'] = 57597,
  -- ['SPINE'] = 23553,
  -- ['SPINE'] = 24816,
  -- ['SPINE'] = 24817,
  ['SPINE'] = 24818,
  -- ['UPPER_BODY'] = 10706,
  ['UPPER_BODY'] = 64729,
  ['LOWER_BODY'] = 11816,
  -- ['LARM'] = 45509,
  ['LARM'] = 61163,
  ['LHAND'] = 18905,
  -- ['LFINGER'] = 4089,
  -- ['LFINGER'] = 4090,
  -- ['LFINGER'] = 4137,
  -- ['LFINGER'] = 4138,
  -- ['LFINGER'] = 4153,
  -- ['LFINGER'] = 4154,
  -- ['LFINGER'] = 4169,
  -- ['LFINGER'] = 4170,
  -- ['LFINGER'] = 4185,
  -- ['LFINGER'] = 4186,
  -- ['LFINGER'] = 26610,
  -- ['LFINGER'] = 26611,
  -- ['LFINGER'] = 26612,
  -- ['LFINGER'] = 26613,
  ['LFINGER'] = 26614,
  -- ['LLEG'] = 58271,
  ['LLEG'] = 63931,
  -- ['LFOOT'] = 2108,
  ['LFOOT'] = 14201,
  -- ['RARM'] = 40269,
  ['RARM'] = 28252,
  ['RHAND'] = 57005,
  -- ['RFINGER'] = 58866,
  -- ['RFINGER'] = 58867,
  -- ['RFINGER'] = 58868,
  -- ['RFINGER'] = 58869,
  -- ['RFINGER'] = 58870,
  -- ['RFINGER'] = 64016,
  -- ['RFINGER'] = 64017,
  -- ['RFINGER'] = 64064,
  -- ['RFINGER'] = 64065,
  -- ['RFINGER'] = 64080,
  -- ['RFINGER'] = 64081,
  -- ['RFINGER'] = 64096,
  -- ['RFINGER'] = 64097,
  -- ['RFINGER'] = 64112,
  ['RFINGER'] = 64113,
  -- ['RLEG'] = 36864,
  ['RLEG'] = 51826,
  -- ['RFOOT'] = 20781,
  ['RFOOT'] = 52301,
}

Config.Weapons = { -- Correspond weapon names to their class number
  [`WEAPON_STUNGUN`] = Config.WeaponClasses['NONE'],
  [`WEAPON_STUNGUN_MP`] = Config.WeaponClasses['NONE'],
  --[[ Small Caliber ]] --
  [`WEAPON_PISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
  [`WEAPON_COMBATPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
  [`WEAPON_APPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
  [`WEAPON_COMBATPDW`] = Config.WeaponClasses['SMALL_CALIBER'],
  [`WEAPON_MACHINEPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
  [`WEAPON_MICROSMG`] = Config.WeaponClasses['SMALL_CALIBER'],
  [`WEAPON_MINISMG`] = Config.WeaponClasses['SMALL_CALIBER'],
  [`WEAPON_PISTOL_MK2`] = Config.WeaponClasses['SMALL_CALIBER'],
  [`WEAPON_SNSPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],
  [`WEAPON_SNSPISTOL_MK2`] = Config.WeaponClasses['SMALL_CALIBER'],
  [`WEAPON_VINTAGEPISTOL`] = Config.WeaponClasses['SMALL_CALIBER'],

  --[[ Medium Caliber ]] --
  [`WEAPON_ADVANCEDRIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_ASSAULTSMG`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_BULLPUPRIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_BULLPUPRIFLE_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_CARBINERIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_CARBINERIFLE_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_COMPACTRIFLE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_DOUBLEACTION`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_GUSENBERG`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_HEAVYPISTOL`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_MARKSMANPISTOL`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_PISTOL50`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_REVOLVER`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_REVOLVER_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_SMG`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_SMG_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_SPECIALCARBINE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
  [`WEAPON_SPECIALCARBINE_MK2`] = Config.WeaponClasses['MEDIUM_CALIBER'],

  --[[ High Caliber ]] --
  [`WEAPON_ASSAULTRIFLE`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_ASSAULTRIFLE_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_COMBATMG`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_COMBATMG_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_HEAVYSNIPER`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_HEAVYSNIPER_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_MARKSMANRIFLE`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_MARKSMANRIFLE_MK2`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_MG`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_MINIGUN`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_MUSKET`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_RAILGUN`] = Config.WeaponClasses['HIGH_CALIBER'],
  [`WEAPON_HEAVYRIFLE`] = Config.WeaponClasses['HIGH_CALIBER'],

  --[[ Shotguns ]] --
  [`WEAPON_ASSAULTSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
  [`WEAPON_BULLUPSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
  [`WEAPON_DBSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
  [`WEAPON_HEAVYSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
  [`WEAPON_PUMPSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
  [`WEAPON_PUMPSHOTGUN_MK2`] = Config.WeaponClasses['SHOTGUN'],
  [`WEAPON_SAWNOFFSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],
  [`WEAPON_SWEEPERSHOTGUN`] = Config.WeaponClasses['SHOTGUN'],

  --[[ Animals ]]                                            --
  [`WEAPON_ANIMAL`] = Config.WeaponClasses['WILDLIFE'],      -- Animal
  [`WEAPON_COUGAR`] = Config.WeaponClasses['WILDLIFE'],      -- Cougar
  [`WEAPON_BARBED_WIRE`] = Config.WeaponClasses['WILDLIFE'], -- Barbed Wire

  --[[ Cutting Weapons ]]                                    --
  [`WEAPON_BATTLEAXE`] = Config.WeaponClasses['CUTTING'],
  [`WEAPON_BOTTLE`] = Config.WeaponClasses['CUTTING'],
  [`WEAPON_DAGGER`] = Config.WeaponClasses['CUTTING'],
  [`WEAPON_HATCHET`] = Config.WeaponClasses['CUTTING'],
  [`WEAPON_KNIFE`] = Config.WeaponClasses['CUTTING'],
  [`WEAPON_MACHETE`] = Config.WeaponClasses['CUTTING'],
  [`WEAPON_SWITCHBLADE`] = Config.WeaponClasses['CUTTING'],

  --[[ Light Impact ]] --
  [`WEAPON_KNUCKLE`] = Config.WeaponClasses['LIGHT_IMPACT'],

  --[[ Heavy Impact ]] --
  [`WEAPON_BAT`] = Config.WeaponClasses['HEAVY_IMPACT'],
  [`WEAPON_CROWBAR`] = Config.WeaponClasses['HEAVY_IMPACT'],
  [`WEAPON_FIREEXTINGUISHER`] = Config.WeaponClasses['HEAVY_IMPACT'],
  [`WEAPON_FIRWORK`] = Config.WeaponClasses['HEAVY_IMPACT'],
  [`WEAPON_GOLFLCUB`] = Config.WeaponClasses['HEAVY_IMPACT'],
  [`WEAPON_HAMMER`] = Config.WeaponClasses['HEAVY_IMPACT'],
  [`WEAPON_PETROLCAN`] = Config.WeaponClasses['HEAVY_IMPACT'],
  [`WEAPON_POOLCUE`] = Config.WeaponClasses['HEAVY_IMPACT'],
  [`WEAPON_WRENCH`] = Config.WeaponClasses['HEAVY_IMPACT'],
  [`WEAPON_RAMMED_BY_CAR`] = Config.WeaponClasses['HEAVY_IMPACT'],
  [`WEAPON_RUN_OVER_BY_CAR`] = Config.WeaponClasses['HEAVY_IMPACT'],

  --[[ Explosives ]] --
  [`WEAPON_EXPLOSION`] = Config.WeaponClasses['EXPLOSIVE'],
  [`WEAPON_GRENADE`] = Config.WeaponClasses['EXPLOSIVE'],
  [`WEAPON_COMPACTLAUNCHER`] = Config.WeaponClasses['EXPLOSIVE'],
  [`WEAPON_HOMINGLAUNCHER`] = Config.WeaponClasses['EXPLOSIVE'],
  [`WEAPON_PIPEBOMB`] = Config.WeaponClasses['EXPLOSIVE'],
  [`WEAPON_PROXMINE`] = Config.WeaponClasses['EXPLOSIVE'],
  [`WEAPON_RPG`] = Config.WeaponClasses['EXPLOSIVE'],
  [`WEAPON_STICKYBOMB`] = Config.WeaponClasses['EXPLOSIVE'],
  [`WEAPON_HELI_CRASH`] = Config.WeaponClasses['EXPLOSIVE'],
  [`WEAPON_EMPLAUNCHER`] = Config.WeaponClasses['EXPLOSIVE'],

  --[[ Other ]]                                                   --
  [`WEAPON_FALL`] = Config.WeaponClasses['OTHER'],                -- Fall
  [`WEAPON_HIT_BY_WATER_CANNON`] = Config.WeaponClasses['OTHER'], -- Water Cannon

  --[[ Fire ]]                                                    --
  [`WEAPON_ELECTRIC_FENCE`] = Config.WeaponClasses['FIRE'],
  [`WEAPON_FIRE`] = Config.WeaponClasses['FIRE'],
  [`WEAPON_MOLOTOV`] = Config.WeaponClasses['FIRE'],
  [`WEAPON_FLARE`] = Config.WeaponClasses['FIRE'],
  [`WEAPON_FLAREGUN`] = Config.WeaponClasses['FIRE'],

  --[[ Suffocate ]]                                                     --
  [`WEAPON_DROWNING`] = Config.WeaponClasses['SUFFOCATING'],            -- Drowning
  [`WEAPON_DROWNING_IN_VEHICLE`] = Config.WeaponClasses['SUFFOCATING'], -- Drowning Veh
  [`WEAPON_EXHAUSTION`] = Config.WeaponClasses['SUFFOCATING'],          -- Exhaust
  [`WEAPON_BZGAS`] = Config.WeaponClasses['SUFFOCATING'],
  [`WEAPON_SMOKEGRENADE`] = Config.WeaponClasses['SUFFOCATING'],
}

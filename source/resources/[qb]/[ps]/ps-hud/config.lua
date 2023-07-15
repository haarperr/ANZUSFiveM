Config = {}

Config.OpenMenu = 'I'              -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.StressChance = 0.5          -- Default: 10% -- Percentage Stress Chance When Shooting (0-1)
Config.UseMPH = true               -- If true speed math will be done as MPH, if false KPH will be used (YOU HAVE TO CHANGE CONTENT IN STYLES.CSS TO DISPLAY THE CORRECT TEXT)
Config.MinimumStress = 30          -- Minimum Stress Level For Screen Shaking
Config.MinimumSpeedUnbuckled = 35  -- Going Over This Speed Will Cause Stress
Config.MinimumSpeed = 120           -- Going Over This Speed Will Cause Stress

Config.DisablePoliceStress = false -- Default: false, If true will disable stress for people with the police job

-- Admin only to change hud icons/shapes
Config.AdminOnly = false


Config.AddStress = {
    on_shoot = {
        min = 1,
        max = 3,
        enable = true,
    },
    on_fastdrive = {
        min = 1,
        max = 2,
        enable = true,
    },
}

-- Stress
Config.WhitelistedWeaponArmed = { -- weapons specifically whitelisted to not show armed mode
    -- miscellaneous
    `weapon_petrolcan`,
    `weapon_hazardcan`,
    `weapon_fireextinguisher`,
    -- melee
    `weapon_dagger`,
    `weapon_bat`,
    `weapon_bottle`,
    `weapon_crowbar`,
    `weapon_flashlight`,
    `weapon_golfclub`,
    `weapon_hammer`,
    `weapon_hatchet`,
    `weapon_knuckle`,
    `weapon_knife`,
    `weapon_machete`,
    `weapon_switchblade`,
    `weapon_nightstick`,
    `weapon_wrench`,
    `weapon_battleaxe`,
    `weapon_poolcue`,
    `weapon_briefcase`,
    `weapon_briefcase_02`,
    `weapon_garbagebag`,
    `weapon_handcuffs`,
    `weapon_bread`,
    `weapon_stone_hatchet`,
    -- throwables
    `weapon_grenade`,
    `weapon_bzgas`,
    `weapon_molotov`,
    `weapon_stickybomb`,
    `weapon_proxmine`,
    `weapon_snowball`,
    `weapon_pipebomb`,
    `weapon_ball`,
    `weapon_smokegrenade`,
    `weapon_flare`
}

Config.WhitelistedWeaponStress = {
    `weapon_petrolcan`,
    `weapon_hazardcan`,
    `weapon_fireextinguisher`
}

Config.Intensity = {
    blur = {
        [1] = {
            min = 20,
            max = 30,
            intensity = 2000,
        },
        [2] = {
            min = 30,
            max = 40,
            intensity = 3500,
        },
        [3] = {
            min = 40,
            max = 50,
            intensity = 4000,
        },
        [4] = {
            min = 50,
            max = 60,
            intensity = 4500,
        },
        [5] = {
            min = 60,
            max = 70,
            intensity = 5000,
        },
        [6] = {
            min = 70,
            max = 80,
            intensity = 5500,
        },
        [7] = {
            min = 80,
            max = 90,
            intensity = 6500,
        },
        [8] = {
            min = 90,
            max = 100,
            intensity = 7000,
        },
    }
}

Config.EffectInterval = {
    [1] = {
        min = 20,
        max = 30,
        timeout = math.random(102000, 132000)
    },
    [2] = {
        min = 40,
        max = 50,
        timeout = math.random(77000, 102000)
    },
    [3] = {
        min = 50,
        max = 60,
        timeout = math.random(57000, 77000)
    },
    [4] = {
        min = 60,
        max = 70,
        timeout = math.random(42000, 57000)
    },
    [5] = {
        min = 70,
        max = 80,
        timeout = math.random(30000, 42000)
    },
    [6] = {
        min = 80,
        max = 90,
        timeout = math.random(20000, 30000)
    },
    [7] = {
        min = 90,
        max = 100,
        timeout = math.random(15000, 20000)
    }
}

Config.FuelBlacklist = {
    "surge",
    "iwagen",
    "voltic",
    "voltic2",
    "raiden",
    "cyclone",
    "tezeract",
    "neon",
    "omnisegt",
    "iwagen",
    "caddy",
    "caddy2",
    "caddy3",
    "airtug",
    "rcbandito",
    "imorgon",
    "dilettante",
    "khamelion",
    "wheelchair",
}

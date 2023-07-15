Config = Config or {}

Config.PoliceRequired = 1

local keys = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y",
  "z" }

local function getRandomKeys()
  local result = {}
  for i = 1, 4 do
    local rand = math.random(1, #keys)
    result[#result + 1] = keys[rand]
    table.remove(keys, rand)
  end

  return result
end

Config.Weapons = {
  [`WEAPON_COMBATPDW`] = 0.4,
  [`WEAPON_COMBATPISTOL`] = 0.25,
  [`WEAPON_COMBATSHOTGUN`] = 0.4,
  [`WEAPON_COMPACTLAUNCHER`] = 0.4,
  [`WEAPON_COMPACTRIFLE`] = 0.4,
  [`WEAPON_CROWBAR`] = 0,
  [`WEAPON_DAGGER`] = 0,
  [`WEAPON_DBSHOTGUN`] = 0.4,
  [`WEAPON_DOUBLEACTION`] = 0.25,
  [`WEAPON_FIREEXTINGUISHER`] = 0.25,
  [`WEAPON_FIREWORK`] = 0.25,
  [`WEAPON_FLARE`] = 0.1,
  [`WEAPON_FLAREGUN`] = 0.25,
  [`WEAPON_FLASHLIGHT`] = 0,
  [`WEAPON_GOLFCLUB`] = 0,
  [`WEAPON_GRENADE`] = 0,
  [`WEAPON_GRENADELAUNCHER`] = 0.4,
  [`WEAPON_GUSENBERG`] = 0.4,
  [`WEAPON_HAMMER`] = 0,
  [`WEAPON_HATCHET`] = 0,
  [`WEAPON_HAZARDCAN`] = 0,
  [`WEAPON_HEAVYPISTOL`] = 0.25,
  [`WEAPON_HEAVYSHOTGUN`] = 0.4,
  [`WEAPON_HEAVYSNIPER_MK2`] = 0.4,
  [`WEAPON_HEAVYSNIPER`] = 0.4,
  [`WEAPON_HOMINGLAUNCHER`] = 0.4,
  [`WEAPON_KNIFE`] = 0,
  [`WEAPON_KNUCKLE`] = 0,
  [`WEAPON_MACHETE`] = 0,
  [`WEAPON_MACHINEPISTOL`] = 0.25,
  [`WEAPON_MARKSMANPISTOL`] = 0.25,
  [`WEAPON_MARKSMANRIFLE_MK2`] = 0.4,
  [`WEAPON_MARKSMANRIFLE`] = 0.4,
  [`WEAPON_MG`] = 0.6,
  [`WEAPON_MICROSMG`] = 0.3,
  [`WEAPON_MILITARYRIFLE`] = 0.4,
  [`WEAPON_MINIGUN`] = 0.7,
  [`WEAPON_MINISMG`] = 0.3,
  [`WEAPON_MOLOTOV`] = 0,
  [`WEAPON_MUSKET`] = 0.3,
  [`WEAPON_NAVYREVOLVER`] = 0.25,
  [`WEAPON_NIGHTSTICK`] = 0,
  [`WEAPON_PETROLCAN`] = 0,
  [`WEAPON_PIPEBOMB`] = 0,
  [`WEAPON_PISTOL_MK2`] = 0.25,
  [`WEAPON_PISTOL`] = 0.25,
  [`WEAPON_PISTOL50`] = 0.25,
  [`WEAPON_POOLCUE`] = 0,
  [`WEAPON_PROXMINE`] = 0,
  [`WEAPON_PUMPSHOTGUN_MK2`] = 0.4,
  [`WEAPON_PUMPSHOTGUN`] = 0.4,
  [`WEAPON_RAILGUN`] = 0.7,
  [`WEAPON_RAYCARBINE`] = 0,
  [`WEAPON_RAYMINIGUN`] = 0,
  [`WEAPON_RAYPISTOL`] = 0,
  [`WEAPON_REVOLVER_MK2`] = 0.25,
  [`WEAPON_REVOLVER`] = 0.25,
  [`WEAPON_RPG`] = 0.8,
  [`WEAPON_SAWNOFFSHOTGUN`] = 0.3,
  [`WEAPON_SMG_MK2`] = 0.3,
  [`WEAPON_SMG`] = 0.3,
  [`WEAPON_SMOKEGRENADE`] = 0.2,
  [`WEAPON_SNIPERRIFLE`] = 0.6,
  [`WEAPON_SNOWBALL`] = 0,
  [`WEAPON_SNSPISTOL_MK2`] = 0.25,
  [`WEAPON_SNSPISTOL`] = 0.25,
  [`WEAPON_SPECIALCARBINE_MK2`] = 0.4,
  [`WEAPON_SPECIALCARBINE`] = 0.4,
  [`WEAPON_STICKYBOMB`] = 0.4,
  [`WEAPON_STONE_HATCHET`] = 0,
  [`WEAPON_STUNGUN`] = 0,
  [`WEAPON_SWITCHBLADE`] = 0,
  [`WEAPON_VINTAGEPISTOL`] = 0.25,
  [`WEAPON_WRENCH`] = 0,
}

Config.SkillCheck = {
  difficulty = { 'medium', 'easy', 'easy' },
  keys = getRandomKeys()
}

Config.Jewellery = {
  centre = vec3(-623.96, -231.95, 38.056),
  panel = {
    [1] = {
      coords = vec3(-604.77, -274.33, 50.85),
      size = vec3(0.3, 0.7, 1.05),
      rotation = 300.25,
      icon = '',
      robbed = false,
      busy = false,
    }
  },
  inside = {
    points = {
      vec3(-633.15997314453, -233.39999389648, 38.75),
      vec3(-628.19000244141, -240.25999450684, 38.75),
      vec3(-622.09002685547, -235.86999511719, 38.75),
      vec3(-620.45001220703, -237.30000305176, 38.75),
      vec3(-619.26000976562, -237.88000488281, 38.75),
      vec3(-617.67999267578, -237.7799987793, 38.75),
      vec3(-616.36999511719, -236.63000488281, 38.75),
      vec3(-616.15997314453, -234.88999938965, 38.75),
      vec3(-616.51000976562, -234.05000305176, 38.75),
      vec3(-617.03002929688, -233.86000061035, 38.75),
      vec3(-616.91998291016, -232.41999816895, 38.75),
      vec3(-614.40997314453, -230.63999938965, 38.75),
      vec3(-619.65002441406, -223.58999633789, 38.75),
      vec3(-622.22998046875, -225.32000732422, 38.75),
      vec3(-623.40997314453, -224.41999816895, 38.75),
      vec3(-624.78002929688, -223.53999328613, 38.75),
      vec3(-626.55999755859, -223.71000671387, 38.75),
      vec3(-627.63000488281, -224.64999389648, 38.75),
      vec3(-628.08001708984, -226.02000427246, 38.75),
      vec3(-627.65997314453, -227.63000488281, 38.75),
      vec3(-627.15002441406, -227.71000671387, 38.75),
      vec3(-627.21002197266, -229.05000305176, 38.75),
      vec3(-628.0, -229.0, 38.75),
      vec3(-629.55999755859, -226.63999938965, 38.75),
      vec3(-633.21002197266, -229.32000732422, 38.75),
      vec3(-631.47998046875, -231.63000488281, 38.75),
      vec3(-629.34997558594, -229.96000671387, 38.75),
      vec3(-629.09997558594, -230.33999633789, 38.75),
    },
    thickness = 3.35,
  },
  case = {
    [1] = {
      coords = vec3(-626.55, -233.56, 38.0),
      size = vec3(0.65, 1.25, 0.45),
      rotation = 306.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab_start',
      newModel = 'des_jewel_cab_end'
    },
    [2] = {
      coords = vec3(-626.32, -239.03, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 306.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab2_start',
      newModel = 'des_jewel_cab2_end'
    },
    [3] = {
      coords = vec3(-625.28, -238.26, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 306.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab3_start',
      newModel = 'des_jewel_cab3_end'
    },
    [4] = {
      coords = vec3(-627.21, -234.92, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 306.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab3_start',
      newModel = 'des_jewel_cab3_end'
    },
    [5] = {
      coords = vec3(-626.16, -234.18, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 306.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab4_start',
      newModel = 'des_jewel_cab4_end'
    },
    [6] = {
      coords = vec3(-627.61, -234.36, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 306.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab_start',
      newModel = 'des_jewel_cab_end'
    },
    [7] = {
      coords = vec3(-619.88, -234.86, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 306.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab_start',
      newModel = 'des_jewel_cab_end'
    },
    [8] = {
      coords = vec3(-618.81, -234.14, 38.05),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 306.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab3_start',
      newModel = 'des_jewel_cab3_end'
    },
    [9] = {
      coords = vec3(-617.9, -229.14, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 216.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab3_start',
      newModel = 'des_jewel_cab3_end'
    },
    [10] = {
      coords = vec3(-617.07, -230.21, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 216.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab2_start',
      newModel = 'des_jewel_cab2_end'
    },
    [11] = {
      coords = vec3(-619.26, -227.26, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 216.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab2_start',
      newModel = 'des_jewel_cab2_end'
    },
    [12] = {
      coords = vec3(-619.99, -226.24, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 216.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab_start',
      newModel = 'des_jewel_cab_end'
    },
    [13] = {
      coords = vec3(-625.32, -227.38, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 125.75,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab3_start',
      newModel = 'des_jewel_cab3_end'
    },
    [14] = {
      coords = vec3(-624.24, -226.65, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 126.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab4_start',
      newModel = 'des_jewel_cab4_end'
    },
    [15] = {
      coords = vec3(-623.97, -230.75, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 36.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab4_start',
      newModel = 'des_jewel_cab4_end'
    },
    [16] = {
      coords = vec3(-623.64, -228.59, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 306.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab2_start',
      newModel = 'des_jewel_cab2_end'
    },
    [17] = {
      coords = vec3(-621.46, -228.97, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 216.25,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab3_start',
      newModel = 'des_jewel_cab3_end'
    },
    [18] = {
      coords = vec3(-620.15, -230.78, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 216.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab_start',
      newModel = 'des_jewel_cab_end'
    },
    [19] = {
      coords = vec3(-620.55, -232.94, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 126.25,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab4_start',
      newModel = 'des_jewel_cab4_end'
    },
    [20] = {
      coords = vec3(-622.68, -232.54, 38.0),
      size = vec3(0.6, 1.3, 0.6),
      rotation = 36.25,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
      oldModel = 'des_jewel_cab_start',
      newModel = 'des_jewel_cab_end'
    },
    [21] = {
      coords = vec3(-624.52, -229.98, 38.0),
      size = vec3(0.6, 0.65, 0.6),
      rotation = 36.25,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [22] = {
      coords = vec3(-624.38, -229.16, 38.0),
      size = vec3(0.6, 0.65, 0.6),
      rotation = 36.25,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [23] = {
      coords = vec3(-622.87, -228.07, 38.0),
      size = vec3(0.6, 0.65, 0.6),
      rotation = 36.75,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [24] = {
      coords = vec3(-622.01, -228.15, 38.0),
      size = vec3(0.6, 0.65, 0.6),
      rotation = 36.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [25] = {
      coords = vec3(-619.62, -231.53, 38.0),
      size = vec3(0.6, 0.65, 0.6),
      rotation = 35.75,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [26] = {
      coords = vec3(-619.74, -232.35, 38.0),
      size = vec3(0.6, 0.65, 0.6),
      rotation = 35.75,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [27] = {
      coords = vec3(-621.25, -233.48, 38.0),
      size = vec3(0.6, 0.65, 0.6),
      rotation = 35.75,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [28] = {
      coords = vec3(-622.11, -233.35, 38.0),
      size = vec3(0.6, 0.65, 0.6),
      rotation = 35.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [29] = {
      coords = vec3(-628.2, -226.67, 38.35),
      size = vec3(0.3, 0.55, 0.45),
      rotation = 12.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [30] = {
      coords = vec3(-628.05, -225.06, 38.35),
      size = vec3(0.3, 0.55, 0.45),
      rotation = 338.5,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [31] = {
      coords = vec3(-627.09, -223.87, 38.4),
      size = vec3(0.3, 0.55, 0.45),
      rotation = 306.5,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [32] = {
      coords = vec3(-625.6, -223.31, 38.35),
      size = vec3(0.3, 0.55, 0.45),
      rotation = 275.0,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [33] = {
      coords = vec3(-624.09, -223.67, 38.35),
      size = vec3(0.3, 0.55, 0.45),
      rotation = 240.25,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [34] = {
      coords = vec3(-615.95, -234.86, 38.35),
      size = vec3(0.3, 0.55, 0.45),
      rotation = 191.75,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [35] = {
      coords = vec3(-616.07, -236.45, 38.35),
      size = vec3(0.3, 0.55, 0.45),
      rotation = 158.75,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [36] = {
      coords = vec3(-617.06, -237.69, 38.35),
      size = vec3(0.3, 0.55, 0.45),
      rotation = 126.5,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [37] = {
      coords = vec3(-618.55, -238.23, 38.35),
      size = vec3(0.3, 0.55, 0.45),
      rotation = 93.5,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
    [38] = {
      coords = vec3(-620.08, -237.9, 38.35),
      size = vec3(0.3, 0.55, 0.45),
      rotation = 60.25,
      icon = 'fa-solid fa-hammer',
      robbed = false,
      busy = false,
    },
  },
  vent = {
    [1] = {
      coords = vec3(-629.48, -226.68, 55.55),
      size = vec3(0.85, 0.45, 1.25),
      rotation = 26.25,
      scene = {
        heading = 116.68,
        px = -0.53,
        py = 0.01,
        loc = vector3(-628.63, -226.62, 55.9)
      },
      icon = 'fa-solid fa-mask-ventilator',
      busy = false,
    },
    [2] = {
      coords = vec3(-623.59, -242.77, 55.55),
      size = vec3(0.65, 0.55, 1.3),
      rotation = 27.5,
      scene = {
        heading = 21.44,
        px = -0.10,
        py = 0.25,
        loc = vector3(-623.39, -243.21, 55.82)
      },
      icon = 'fa-solid fa-mask-ventilator',
      busy = false,
    },
  }
}

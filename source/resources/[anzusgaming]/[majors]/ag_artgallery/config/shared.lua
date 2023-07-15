Config = Config or {}

Config.PoliceRequired = 1

Config.MaxCodeAttempts = 3

--- Seconds
Config.SmashBaseTime = 20

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

Config.Artgallery = {
  computer = {
    [1] = {
      coords = vec3(14.68, 145.37, 93.85),
      size = vec3(0.55, 0.55, 0.65),
      rotation = 28.75,
      doorlock = 'artgallery main',
      busy = false,
      robbed = false,
    }
  },
  painting = {
    [1] = {
      name = "painting1",
      hash = -600979221,
      coords = vec3(23.71, 149.72, 94.7),
      size = vec3(1.65, 0.2, 1.45),
      rotation = 340.0,
      heading = 341.658,
      busy = false,
      needed = {
        computer = 1
      }
    },
    [2] = {
      name = "painting2",
      hash = -1033071255,
      coords = vec3(23.92, 150.29, 94.7),
      size = vec3(1.65, 0.2, 1.45),
      rotation = 340.0,
      heading = 164.588,
      busy = false,
      needed = {
        computer = 1
      }
    },
    [3] = {
      name = "painting3",
      hash = -1822247070,
      coords = vec3(21.92, 150.99, 94.7),
      size = vec3(1.65, 0.2, 1.45),
      rotation = 339.75,
      heading = 161.2,
      busy = false,
      needed = {
        computer = 1
      }
    },
    [4] = {
      name = "painting4",
      hash = -1381897248,
      coords = vec3(20.03, 139.8, 94.7),
      size = vec3(1.65, 0.2, 1.45),
      rotation = 340.25,
      heading = 347.011,
      busy = false,
      needed = {
        computer = 1
      }
    },
    [5] = {
      name = "painting5",
      hash = 1996881577,
      coords = vec3(37.5, 133.98, 94.7),
      size = vec3(1.65, 0.2, 1.45),
      rotation = 340.25,
      heading = 155.784,
      busy = false,
      needed = {
        computer = 1
      }
    },
    [6] = {
      name = "painting6",
      hash = -2142236355,
      coords = vec3(41.12, 143.92, 94.7),
      size = vec3(1.65, 0.2, 1.45),
      rotation = 339.75,
      heading = 164.562,
      busy = false,
      needed = {
        computer = 1
      }
    },
    [7] = {
      name = "painting7",
      hash = -630930071,
      coords = vec3(18.3, 141.06, 94.7),
      size = vec3(1.65, 0.2, 1.45),
      rotation = 339.5,
      heading = 161.674,
      busy = false,
      needed = {
        computer = 1
      }
    },
    [8] = {
      name = "painting8",
      hash = -184812905,
      coords = vec3(39.43, 133.25, 94.7),
      size = vec3(1.65, 0.2, 1.45),
      rotation = 339.75,
      heading = 162.256,
      busy = false,
      needed = {
        computer = 1
      }
    },
    [9] = {
      name = "painting9",
      hash = -1095168494,
      coords = vec3(39.28, 132.75, 94.7),
      size = vec3(1.65, 0.2, 1.45),
      rotation = 339.75,
      heading = 336.532,
      busy = false,
      needed = {
        computer = 1
      }
    },
  },
  case = {
    [1] = {
      coords = vec3(36.03, 130.19, 93.45),
      size = vec3(1.35, 0.7, 1.2),
      rotation = 339.25,
      busy = false,
      needed = {
        door = 2,
        computer = 1
      },
    },
    [2] = {
      coords = vec3(34.76, 130.67, 93.45),
      size = vec3(1.35, 0.7, 1.2),
      rotation = 339.25,
      busy = false,
      needed = {
        door = 2,
        computer = 1
      },
    },
    [3] = {
      coords = vec3(34.48, 130.03, 93.45),
      size = vec3(1.35, 0.7, 1.2),
      rotation = 339.25,
      busy = false,
      needed = {
        door = 2,
        computer = 1
      },
    },
    [4] = {
      coords = vec3(35.76, 129.54, 93.45),
      size = vec3(1.35, 0.7, 1.2),
      rotation = 339.25,
      busy = false,
      needed = {
        door = 2,
        computer = 1
      },
    },
    [5] = {
      coords = vec3(41.35, 148.33, 93.45),
      size = vec3(1.35, 0.7, 1.2),
      rotation = 339.25,
      busy = false,
      needed = {
        door = 1,
        computer = 1
      },
    },
    [6] = {
      coords = vec3(42.62, 147.87, 93.45),
      size = vec3(1.35, 0.7, 1.2),
      rotation = 339.25,
      busy = false,
      needed = {
        door = 1,
        computer = 1
      },
    },
    [7] = {
      coords = vec3(42.37, 147.18, 93.45),
      size = vec3(1.35, 0.7, 1.2),
      rotation = 339.25,
      busy = false,
      needed = {
        door = 1,
        computer = 1
      },
    },
    [8] = {
      coords = vec3(41.13, 147.66, 93.45),
      size = vec3(1.35, 0.7, 1.2),
      rotation = 339.25,
      busy = false,
      needed = {
        door = 1,
        computer = 1
      },
    },
  },
  door = {
    [1] = {
      zone = {
        coords = vec3(36.81, 145.15, 94.0),
        size = vec3(1.3, 0.15, 2.15),
        rotation = 340.25,
      },
      model = `hei_v_ilev_bk_safegate_pris`,
      doorlock = 'artgallery thermite01',
      scene = {
        ptfx = vec3(36.223773, 146.24411, 93.992846),
        animation = vec4(36.223773, 145.34411, 93.992846, 343.00),
      },
      busy = false,
      opened = false
    },
    [2] = {
      zone = {
        coords = vec3(32.74, 135.46, 93.9),
        size = vec3(0.4, 0.15, 0.4),
        rotation = 340.0,
      },
      model = -1508355822,
      doorlock = 'artgallery thermite02',
      scene = {
        ptfx = vec3(32.721370697021, 135.49913024902, 256.044),
        animation = vec4(32.721370697021, 135.49913024902, 93.89826965332, 256.044),
      },
      busy = false,
      opened = false
    }
  },
  keypad = {
    [1] = {
      zone = {
        coords = vec3(20.41, 153.04, 94.25),
        size = vec3(0.15, 0.25, 0.25),
        rotation = 340.0,
      },
      model = -1721227941,
      swipe = `ch_prop_swipe_card_01a`,
      doorlock = 'artgallery security',
      busy = false
    },
  },
  server = {
    [1] = {
      zone = {
        coords = vec3(17.33, 152.56, 93.35),
        size = vec3(0.8, 0.5, 1.05),
        rotation = 340.5,
      },
      busy = false
    }
  },
  code = {
    [1] = {
      zone = {
        coords = vec3(15.72, 140.13, 94.3),
        size = vec3(0.35, 0.5, 0.55),
        rotation = 340.5,
      },
      door = {
        model = -660779536,
        coords = vec3(15.74549, 140.19191, 93.992701),
        closed = 70.0,
        open = 210.0,
        opened = false
      },
      busy = false
    }
  },
  egg = {
    [1] = {
      zone = {
        coords = vec3(11.31, 139.23, 94.4),
        size = vec3(0.45, 0.5, 0.7),
        rotation = 340.5,
      },
      busy = false,
      needed = {
        computer = 1,
        keypad = 1
      }
    }
  }
}

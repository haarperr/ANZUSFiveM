Config = Config or {}

Config.PoliceRequired = 1
Config.MaxCodeAttempts = 3

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

Config.SkillCheck = {
  difficulty = { 'medium', 'easy', 'easy' },
  keys = getRandomKeys()
}

Config.Paleto = {
  centre = vec3(-103.46, 6468.965, 31.636),
  door = {
    [1] = {
      doorlock = 'paleto_bank_sidedoor',
      hack = 'keypad',
      label = 'Hack Keypad',
      icon = 'fa-solid fa-microchip',
      zone = {
        coords = vec3(-115.49, 6480.14, 31.95),
        size = vec3(0.25, 0.2, 0.25),
        rotation = 313.25,
      },
      busy = false,
    },
    [2] = {
      doorlock = 'paleto_bank_backdoor',
      hack = 'keypad',
      label = 'Hack Keypad',
      icon = 'fa-solid fa-microchip',
      zone = {
        coords = vec3(-95.53, 6473.06, 31.95),
        size = vec3(0.15, 0.05, 0.2),
        rotation = 314.0,
      },
      busy = false,
    }
  },
  vault = {
    [1] = {
      open = 100,
      closed = 225,
      coords = vec3(-100.89818572998, 6463.7817382813, 32.173557281494),
      model = `ch_prop_ch_vault_d_door_01a`,
      zone = {
        coords = vec3(-101.92, 6462.87, 32.15),
        size = vec3(0.2, 0.45, 0.5),
        rotation = 317.0,
      },
      busy = false,
    }
  },
  cabinet = {
    [1] = {
      coords = vec3(-95.09, 6467.15, 31.25),
      size = vec3(0.3, 2.1, 0.85),
      rotation = 315.0,
      busy = false
    },
    [2] = {
      coords = vec3(-103.94, 6458.11, 31.2),
      size = vec3(0.3, 2.1, 0.85),
      rotation = 315.0,
      busy = false
    },
    [3] = {
      coords = vec3(-108.18, 6478.5, 31.25),
      size = vec3(0.3, 2.1, 0.85),
      rotation = 315.0,
      busy = false
    },
    [4] = {
      coords = vec3(-97.78, 6470.04, 31.2),
      size = vec3(0.3, 1.65, 0.85),
      rotation = 315.0,
      busy = false
    },
    [5] = {
      coords = vec3(-102.86, 6476.68, 31.2),
      size = vec3(0.3, 2.15, 0.85),
      rotation = 315.0,
      busy = false
    }
  },
  offices = {
    [1] = {
      doorlock = 'paleto_bank_loans2',
      title = 'Office 1',
      busy = false,
      opened = false,
      computer = {
        coords = vec3(-103.85, 6460.43, 31.7),
        size = vec3(0.5, 0.55, 0.55),
        rotation = 329.5,
      }
    },
    [2] = {
      doorlock = 'paleto_bank_loans',
      title = 'Office 2',
      busy = false,
      opened = false,
      computer = {
        coords = vec3(-98.24, 6466.2, 31.7),
        size = vec3(0.5, 0.55, 0.55),
        rotation = 329.5,
      }
    },
    [3] = {
      doorlock = 'paleto_bank_admin',
      title = 'Office 3',
      busy = false,
      opened = false
    },
  },
  atm = {
    [1] = {
      zone = {
        coords = vec3(-97.52, 6455.7, 31.7),
        size = vec3(0.45, 1, 1.1),
        rotation = 315.0,
      },
      hacked = false,
      busy = false
    },
    [2] = {
      zone = {
        coords = vec3(-95.76, 6457.41, 31.75),
        size = vec3(0.45, 1, 1.1),
        rotation = 315.0,
      },
      hacked = false,
      busy = false
    }
  },
  safe = {
    [1] = {
      coords = vec3(-105.27, 6480.66, 32.05),
      size = vec3(0.55, 0.1, 0.6),
      rotation = 315.0,
      busy = false,
      robbed = false
    }
  },
  camera = {
    [1] = {
      coords = vec3(-91.79, 6464.91, 31.5),
      size = vec3(0.35, 0.7, 0.25),
      rotation = 324.5,
    }
  },
  control_door = {
    [1] = {
      doorlock = 'paleto_bank_unauthorized',
      name = 'Front Desk',
      opened = false,
    },
    [2] = {
      doorlock = 'paleto_bank_backhallway',
      name = 'Side Hallway',
      opened = false,
    }
  },
  trolly = {
    [1] = {
      coords = vec4(-97.0527801513672, 6459.517578125, 31.10668563842773, 44.65915),
      type = 'diamond',
      model = `ch_prop_diamond_trolly_01c`,
      busy = false,
      needed = {
        vault = 1
      }
    },
    -- [2] = {
    --     coords = vec4(-96.06124114990236, 6460.51318359375, 31.10668563842773, 44.65915),
    --     type = 'diamond',
    --     model = `ch_prop_diamond_trolly_01c`,
    --     busy = false,
    --     robbed = false
    -- }
  },
  lockbox = {
    [1] = {
      coords = vec3(-96.89, 6463.51, 32.05),
      size = vec3(4.2, 0.1, 2.05),
      rotation = 314.75,
      busy = false,
      needed = {
        vault = 1
      }
    },
    [2] = {
      coords = vec3(-100.29, 6459.89, 32.0),
      size = vec3(4.45, 0.1, 2.25),
      rotation = 314.75,
      busy = false,
      needed = {
        vault = 1
      }
    },
    [3] = {
      coords = vec3(-96.51, 6459.62, 32.0),
      size = vec3(3.7, 0.1, 2.25),
      rotation = 225.0,
      busy = false,
      needed = {
        vault = 1
      }
    },
  },
}

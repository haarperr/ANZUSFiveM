Config = Config or {}

Config.KeycardStolen = false

Config.DrillTime = 1

Config.PoliceRequired = 1

Config.Bank = {
  centre = vec3(250.636, 219.991, 106.352),
  door = {
    [1] = {
      zone = {
        coords = vec3(256.93, 220.38, 106.25),
        size = vec3(1.25, 0.1, 1.7),
        rotation = 340.0,
      },
      scene = {
        pos = vec3(257.40, 220.20, 106.35),
        rot = vec3(0.0, 0.0, 336.48),
        ptfx = vec3(257.39, 221.20, 106.29)
      },
      hash = `hei_v_ilev_bk_gate_pris`,
      doorlock = 'pacific_teller',
      busy = false
    },
    [2] = {
      zone = {
        coords = vec3(261.97, 221.91, 106.4),
        size = vec3(0.15, 1.3, 1.95),
        rotation = 339.75,
      },
      scene = {
        pos = vec3(261.75, 221.420, 106.35),
        rot = vec3(0.0, 0.0, 255.48),
        ptfx = vec3(261.80, 222.470, 106.283)
      },
      hash = `hei_v_ilev_bk_gate2_pris`,
      doorlock = 'pacific_stairs',
      busy = false
    },
    [3] = {
      zone = {
        coords = vec3(252.48, 220.85, 101.9),
        size = vec3(0.15, 1.3, 1.95),
        rotation = 249.75,
      },
      scene = {
        pos = vec3(252.95, 220.70, 101.76),
        rot = vec3(0.0, 0.0, 160.0),
        ptfx = vec3(252.985, 221.70, 101.72)
      },
      hash = `hei_v_ilev_bk_safegate_pris`,
      doorlock = 'pacific_vault_door1',
      busy = false
    },
    [4] = {
      zone = {
        coords = vec3(261.5, 215.11, 102.0),
        size = vec3(0.15, 1.3, 1.95),
        rotation = 159.75,
      },
      scene = {
        pos = vec3(261.65, 215.60, 101.76),
        rot = vec3(0.0, 0.0, 252.0),
        ptfx = vec3(261.68, 216.63, 101.75)
      },
      hash = `hei_v_ilev_bk_safegate_pris`,
      doorlock = 'pacific_vault_door2',
      busy = false
    }
  },
  computer = {
    [1] = {
      coords = vec3(261.83, 205.67, 110.4),
      size = vec3(0.65, 1, 0.55),
      rotation = 310.5,
      busy = false
    }
  },
  keypad = {
    [1] = {
      zone = {
        coords = vec3(257.61, 228.24, 102.15),
        size = vec3(0.3, 0.3, 0.25),
        rotation = 340.5
      },
      doorlock = 'pacific_right_vault',
      model = `ch_prop_fingerprint_scanner_01e`
    }
  },
  vault = {
    [1] = {
      zone = {
        coords = vec3(252.86, 228.55, 102.1),
        size = vec3(0.2, 0.45, 0.65),
        rotation = 340.0,
      },
      model = `v_ilev_bk_vaultdoor`,
      coords = vec3(253.87, 224.77, 102.3),
      closed = 160.0,
      open = 75.0,
      busy = false,
      opened = false,
      type = 'hack'
    },
    [2] = {
      zone = {
        coords = vec3(256.52, 240.61, 102.05),
        size = vec3(0.4, 1.0, 1.1),
        rotation = 250.0,
      },
      drill = {
        coords = vec3(255.91209411621, 240.46913146973, 102.02689361572),
        heading = 164.250,
      },
      model = `ch_prop_ch_vaultdoor01x`,
      coords = vec3(256.33, 240.29, 101.4),
      closed = 160.0,
      open = 340.32513,
      busy = false,
      opened = false,
      type = 'drill'
    },
    [3] = {
      zone = {
        coords = vec3(261.56, 258.35, 102.1),
        size = vec3(0.25, 0.1, 0.25000000000001),
        rotation = 340.5,
      },
      model = 1008631277,
      coords = vec3(263.74087524414, 257.7770690918, 101.87050628662),
      closed = 341,
      open = 240,
      busy = false,
      opened = false,
      type = 'hack2'
    }
  },
  gate = {
    [1] = {
      zone = {
        coords = vec3(255.24, 244.87, 102.0),
        size = vec3(0.1, 0.35, 0.35),
        rotation = 340.0,
      },
      scene = {
        coords = vec3(255.24, 244.87, 102.0),
        ptfx = vec3(255.24, 244.87, 102.0)
      },
      busy = false
    },
    [2] = {
      zone = {
        coords = vec3(257.22, 250.3, 102.0),
        size = vec3(0.1, 0.35, 0.35),
        rotation = 340.0,
      },
      scene = {
        coords = vec3(257.22, 250.3, 102.0),
        ptfx = vec3(257.22, 250.3, 102.0)
      },
      busy = false
    },
    [3] = {
      zone = {
        coords = vec3(259.23, 255.86, 102.0),
        size = vec3(0.1, 0.35, 0.35),
        rotation = 340.0,
      },
      scene = {
        coords = vec3(259.23, 255.86, 102.0),
        ptfx = vec3(259.23, 255.86, 102.0)
      },
      busy = false
    },
    [4] = {
      zone = {
        coords = vec3(260.35, 242.89, 102.0),
        size = vec3(0.1, 0.35, 0.35),
        rotation = 340.0,
      },
      scene = {
        coords = vec3(260.35, 242.89, 102.0),
        ptfx = vec3(260.35, 242.89, 102.0)
      },
      busy = false
    },
    [5] = {
      zone = {
        coords = vec3(262.36, 248.43, 102.0),
        size = vec3(0.1, 0.35, 0.35),
        rotation = 340.0,
      },
      scene = {
        coords = vec3(262.36, 248.43, 102.0),
        ptfx = vec3(262.36, 248.43, 102.0)
      },
      busy = false
    },
    [6] = {
      zone = {
        coords = vec3(264.39, 253.97, 102.0),
        size = vec3(0.1, 0.35, 0.35),
        rotation = 340.0,
      },
      scene = {
        coords = vec3(264.39, 253.97, 102.0),
        ptfx = vec3(264.39, 253.97, 102.0)
      },
      busy = false
    }
  },
  stack = {
    [1] = {
      coords = vec4(264.265, 213.735, 101.531, 250.0),
      type = 'cash',
      icon = 'fa-solid fa-sack-dollar',
      hash = `h4_prop_h4_cash_stack_01a`,
      busy = false,
      needed = {
        vault = 1,
        door = { 3, 4 }
      }
    },
    [2] = {
      coords = vec4(265.812, 241.233, 101.581, 250.0),
      type = 'cash',
      icon = 'fa-solid fa-sack-dollar',
      hash = `h4_prop_h4_cash_stack_01a`,
      busy = false,
      needed = {
        vault = { 2, 3 },
        door = { 1, 2 },
        gate = 4
      }
    },
    [3] = {
      coords = vec4(268.112, 247.533, 101.581, 250.0),
      type = 'cash',
      icon = 'fa-solid fa-sack-dollar',
      hash = `h4_prop_h4_cash_stack_01a`,
      busy = false,
      needed = {
        vault = { 2, 3 },
        door = { 1, 2 },
        gate = 5
      }
    },
    [4] = {
      coords = vec4(254.062, 258.454, 101.581, 70.0),
      type = 'cash',
      icon = 'fa-solid fa-sack-dollar',
      hash = `h4_prop_h4_cash_stack_01a`,
      busy = false,
      needed = {
        vault = { 2, 3 },
        door = { 1, 2 },
        gate = 3
      }
    },
    [5] = {
      coords = vec4(250.019, 247.602, 101.581, 70.0),
      type = 'gold',
      icon = 'fa-solid fa-sack-dollar',
      hash = `h4_prop_h4_gold_stack_01a`,
      busy = false,
      needed = {
        vault = { 2, 3 },
        door = { 1, 2 },
        gate = 1
      }
    },
    [6] = {
      coords = vec4(251.988, 252.979, 101.581, 70.0),
      type = 'gold',
      icon = 'fa-solid fa-sack-dollar',
      hash = `h4_prop_h4_gold_stack_01a`,
      busy = false,
      needed = {
        vault = { 2, 3 },
        door = { 1, 2 },
        gate = 2
      }
    }
  },
  trolly = {
    [1] = {
      coords = vec4(266.41, 256.41, 101.25, 342.0),
      type = 'diamond',
      create = false,
      hash = `ch_prop_diamond_trolly_01c`,
      busy = false,
      needed = {
        vault = { 2, 3 },
        door = { 1, 2 },
        gate = 6
      }
    },
    [2] = {
      coords = vec4(269.31, 255.29, 101.25, 342.0),
      type = 'diamond',
      create = false,
      hash = `ch_prop_diamond_trolly_01c`,
      busy = false,
      needed = {
        vault = { 2, 3 },
        door = { 1, 2 },
        gate = 6
      }
    },
    [3] = {
      coords = vec4(267.87, 250.76, 101.25, 342.0),
      type = 'diamond',
      create = false,
      hash = `ch_prop_diamond_trolly_01c`,
      busy = false,
      needed = {
        vault = { 2, 3 },
        door = { 1, 2 },
        gate = 6
      }
    },
    [4] = {
      coords = vec4(266.04, 251.48, 101.35, 342.0),
      type = 'diamond',
      create = false,
      hash = `ch_prop_diamond_trolly_01c`,
      busy = false,
      needed = {
        vault = { 2, 3 },
        door = { 1, 2 },
        gate = 6
      }
    },
    [5] = {
      coords = vec4(266.351, 215.192, 101.15, 115.0),
      type = 'cash',
      create = true,
      hash = `ch_prop_ch_cash_trolly_01c`,
      needed = {
        vault = 1,
        door = { 3, 4 }
      },
      busy = false
    },
    [6] = {
      coords = vec4(265.107, 211.960, 101.15, 35.0),
      type = 'cash',
      create = true,
      hash = `ch_prop_ch_cash_trolly_01c`,
      needed = {
        vault = 1,
        door = { 3, 4 }
      },
      busy = false
    },
    [7] = {
      coords = vec4(260.77230834961, 260.06423950195, 101.15630340576, 293.1621),
      type = 'diamond',
      create = true,
      hash = `ch_prop_diamond_trolly_01c`,
      busy = false
    },
  }
}

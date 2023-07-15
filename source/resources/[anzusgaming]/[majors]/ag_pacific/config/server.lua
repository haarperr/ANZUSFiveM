Config = Config or {}

Config.Manager = {
  [1] = {
    hint = 'Where did he vanish, leaving nothing but a faint scent in the air?',
    manager = {
      model = `ig_bankman`,
      coords = vec4(306.649, 269.2, 105.623, 63.267)
    },
    guards = {
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(306.162, 267.685, 105.47, 7.689)
      },
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(304.76, 268.14, 105.556, 314.062)
      },
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(304.385, 268.845, 105.593, 301.13)
      },
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(305.213, 270.953, 105.647, 213.301)
      }
    }
  },
  [2] = {
    hint = 'A restful place for travelers to dwell, nearby attractions that cast a spell',
    manager = {
      model = `ig_bankman`,
      coords = vec4(462.501, 214.741, 103.1, 69.726)
    },
    guards = {
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(460.739, 213.811, 103.1, 327.878),
        sos = false
      },
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(460.042, 215.224, 103.1, 260.38),
        sos = false
      },
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(461.172, 216.578, 103.1, 200.555),
        sos = false
      },
    }
  },
  [3] = {
    hint = 'I\'m not a hit, but often missed, hiding behind a building, you\'ll insist',
    manager = {
      model = `ig_bankman`,
      coords = vec4(224.261, 121.226, 102.599, 261.024)
    },
    guards = {
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(224.174, 120.215, 102.605, 343.142),
        sos = false
      },
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(224.926, 122.511, 102.599, 149.583),
        sos = false
      },
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(226.347, 120.658, 102.599, 64.916),
        sos = false
      },
    }
  },
  [4] = {
    hint = 'A tranquil abode of flickering light, wax illuminates the night',
    manager = {
      model = `ig_bankman`,
      coords = vec4(134.864, 269.617, 109.974, 343.347)
    },
    guards = {
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(137.032, 269.508, 109.974, 83.132),
        sos = false
      },
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(133.54, 270.621, 109.974, 244.723),
        sos = false
      },
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(134.697, 272.333, 109.974, 154.781),
        sos = false
      },
      {
        model = `MP_M_SecuroGuard_01`,
        weapon = `WEAPON_COMBATPISTOL`,
        armour = 100,
        coords = vec4(136.607, 271.784, 109.974, 117.307),
        sos = false
      },
    }
  }
}

Config.MaxRewards = 2

Config.Rewards = {
  stack = {
    cash = {
      item = 'markedbills',
      min = 2500,
      max = 3300
    },
    gold = {
      item = 'gold',
      min = 20,
      max = 25
    },
    diamond = {
      item = 'majordiamond',
      min = 5,
      max = 5
    },
  },
  trolly = {
    cash = {
      item = 'markedbills',
      min = 2500,
      max = 3300
    },
    diamond = {
      item = 'majordiamond',
      min = 5,
      max = 5
    },
  },
  painting = {
    [1] = {
      item = 'artg_painting3',
      min = 1,
      max = 1
    },
    [2] = {
      item = 'artg_painting10',
      min = 1,
      max = 1
    }
  },
  display = {
    [1] = {
      item = 'monkeystatue',
      min = 1,
      max = 1
    },
    [2] = {
      item = 'displayitem2',
      min = 1,
      max = 1
    },
    [3] = {
      item = 'faberge_egg',
      min = 1,
      max = 1
    },
    [4] = {
      item = 'hopediamond',
      min = 1,
      max = 1
    },
  },
}

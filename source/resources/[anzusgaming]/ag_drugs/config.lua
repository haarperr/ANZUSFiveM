Config = {}

Config.Keys = {
  "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
}

Config.CornerSelling = {
  minimum_police = 0,
  chances = {
    success = 50,
    scam = 25,
    robbery = 25,
    police_notify = 7
  },
  prices = {
    weed = {
      min = 180,
      max = 220
    },
    weed_brick = {
      min = 245,
      max = 295
    },
    bottle_methylamine = {
      min = 480,
      max = 720
    }
  },
  items = {
    "weed",
    "weed_brick",
    "bottle_methylamine"
  }
}

Config.weed = {
  packing = {
    [1] = {
      enter = vec3(-1287.23, -1328.37, 4.35),
      exit = vec4(-1287.334, -1327.726, 4.191, 23.468),
      tables = {
        vec3(-6.1697, -3.8959, -2.8285),
        vec3(2.0852, 4.083, -2.8205)
      }
    }
  },
  corner = {
    [1] = {
      points = {
        vec3(-109.0, -1552.0, 34.0),
        vec3(-109.0, -1552.0, 34.0),
        vec3(-103.0, -1547.0, 34.0),
        vec3(-99.0, -1551.0, 34.0),
        vec3(-103.0, -1557.0, 34.0),
      }
    }
  }
}

Config.meth = {
  barrel_ped = {
    model = `a_m_m_hillbilly_01`,
    coords = vec4(583.45, 2782.06, 43.48, 339.36)
  },
  objects = {
    methtable = { model = `bkr_prop_meth_table01a`, freeze = false },
  },
  labs = {
    [1] = {
      [1] = {
        name = 'bottle_methylamine',
        localName = 'Add Methylamine',
        polyzone = 'circle',
        coords = vec3(-1959.99, -238.44, 35.0),
        circleRadius = 0.9,
        distance = 2,
        ingredientAdded = false,
      },
      [2] = {
        name = 'ephedrine',
        localName = 'Add Ephedrine',
        polyzone = 'box',
        coords = vec3(-1968.62, -241.53, 35.0),
        length = 2.2,
        width = 1,
        heading = 324,
        minZ = 31.8,
        maxZ = 35.8,
        distance = 2,
        ingredientAdded = false,
      },
      [3] = {
        name = 'acetone',
        localName = 'Add Acetone',
        polyzone = 'box',
        coords = vec3(-1959.34, -244.66, 35.0),
        length = 2.2,
        width = 1,
        heading = 325,
        minZ = 32.2,
        maxZ = 36.2,
        distance = 2,
        ingredientAdded = false,
      },
      [4] = {
        name = 'batteryacid',
        localName = 'Add Battery Acid',
        polyzone = 'box',
        coords = vec3(-1957.78, -241.55, 35.0),
        length = 2.4,
        width = 1,
        heading = 0,
        minZ = 32.0,
        maxZ = 36.0,
        distance = 2,
        ingredientAdded = false,
      },
      [5] = {
        name = 'finish',
        localName = 'Start mixer',
        polyzone = 'box',
        coords = vec3(-1961.44, -236.89, 35.0),
        length = 1.4,
        width = 1,
        heading = 55,
        minZ = 32.4,
        maxZ = 36.4,
        distance = 2,
        ingredientAdded = false,
      },
      labName = 'lab1',
      blownUp = false,
      cooldown = false,
      runsThisRestart = 0,
      smokeLocations = {
        vec3(-1963.15, -240.68, 40.48),
        vec3(-1973.26, -232.58, 40.48),
        vec3(-1976.44, -237.72, 40.48),
      },
    },
    [2] = {
      [1] = {
        name = 'bottle_methylamine',
        localName = 'Add Methylamine',
        polyzone = 'circle',
        coords = vec3(3072.76, 2264.32, 5.61),
        circleRadius = 0.95,
        distance = 2,
        ingredientAdded = false,
      },
      [2] = {
        name = 'ephedrine',
        localName = 'Add Ephedrine',
        polyzone = 'box',
        coords = vec3(3076.41, 2263.16, 5.14),
        length = 2.4,
        width = 1,
        heading = 215,
        minZ = 2.34,
        maxZ = 6.34,
        distance = 2,
        ingredientAdded = false,
      },
      [3] = {
        name = 'acetone',
        localName = 'Add Acetone',
        polyzone = 'box',
        coords = vec3(3068.61, 2257.09, 5.14),
        length = 2.2,
        width = 1,
        heading = 270,
        minZ = 2.14,
        maxZ = 6.14,
        distance = 2,
        ingredientAdded = false,
      },
      [4] = {
        name = 'batteryacid',
        localName = 'Add Battery Acid',
        polyzone = 'box',
        coords = vec3(3067.54, 2260.72, 5.14),
        length = 2.0,
        width = 1,
        heading = 270,
        minZ = 2.54,
        maxZ = 6.54,
        distance = 2,
        ingredientAdded = false,
      },
      [5] = {
        name = 'finish',
        localName = 'Start mixer',
        polyzone = 'box',
        coords = vec3(3070.72, 2265.01, 5.14),
        length = 1.2,
        width = 1,
        heading = 270,
        minZ = 2.54,
        maxZ = 6.54,
        distance = 2,
        ingredientAdded = false,
      },
      labName = 'lab2',
      blownUp = false,
      cooldown = false,
      runsThisRestart = 0,
      smokeLocations = {
        vec3(3088.62, 2246.84, 74.14)
      },
    },
  },
  factories = {
    [1] = {
      barrels = {
        vec3(-72.69889831543, 6241.2661132813, 30.509887695313),
        vec3(-104.20219421387, 6198.0395507813, 30.459350585938),
        vec3(-81.99560546875, 6214.4833984375, 30.532489776611),
        vec3(-92.887908935547, 6235.2133789063, 30.526733398438),
        vec3(-117.48132324219, 6180.9624023438, 30.46263885498),
        vec3(-146.37362670898, 6164.6767578125, 30.648683547974),
      },
      hash = 'prop_barrel_01a'
    },
    [2] = {
      barrels = {
        vec3(493.0813293457, -1351.8857421875, 28.758125305176),
        vec3(490.23297119141, -1321.0549316406, 28.588989257813),
        vec3(480.26373291016, -1301.3934326172, 28.757568359375),
        vec3(481.64834594727, -1326.0791015625, 28.639526367188),
        vec3(502.21978759766, -1330.0219726563, 28.7744140625),
      },
      hash = 'prop_barrel_01a'
    },
    [3] = {
      barrels = {
        vec3(608.04022216797, -436.06350708008, 24.187419891357),
        vec3(610.54992675781, -461.59002685547, 24.187419891357),
        vec3(591.85998535156, -469.62002563477, 24.186601638794),
        vec3(609.78002929688, -489.86999511719, 24.182165145874),
        vec3(619.58441162109, -431.80282592773, 24.2080078125),
        vec3(612.63995361328, -409.33001708984, 25.4798412323),

      },
      hash = 'prop_barrel_01a'
    },
    [4] = {
      barrels = {
        vec3(2908.0998535156, 4354.0151367188, 49.744411468506),
        vec3(2888.9399414063, 4394.3701171875, 49.758434295654),
        vec3(2886.830078125, 4422.330078125, 48.331035614014),
        vec3(2923.1799316406, 4339.83984375, 49.795024871826),
        vec3(2929.3701171875, 4286.4799804688, 49.761322021484),
      },
      hash = 'prop_barrel_01a'
    },
    [5] = {
      barrels = {
        vec3(-21.980007171631, -1296.5600585938, 28.802335739136),
        vec3(39.82999420166, -1314.6899414063, 28.765991210938),
        vec3(-55.22004699707, -1331.0300292969, 28.703477859497),
        vec3(-45.020008087158, -1267.1199951172, 28.613901138306),
      },
      hash = 'prop_barrel_01a'
    },
    [6] = { -- random locations
      barrels = {
        vec3(1444.3905029297, 6333.2221679688, 23.305810928345),
        vec3(432.14318847656, 6477.251953125, 28.230201721191),
        vec3(2445.6904296875, 4982.4682617188, 51.007354736328),
        vec3(1530.6236572266, 3590.9440917969, 38.214023590088),
        vec3(-811.32080078125, -586.66564941406, 29.718774795532),

      },
      hash = 'prop_barrel_01a'
    },
  }
}

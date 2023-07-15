Config = {}

Config.BreakoutCuffKeys = {
  "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y",
  "z"
}


PD_Zones = {
  {
    name = "MRPD",
    blip = vec3(428.23, -984.28, 29.76),
    building = {
      points = {
        vec3(425.0, -971.0, 30.0),
        vec3(426.0, -1032.5, 30.0),
        vec3(489.5, -1023.0, 30.0),
        vec3(489.0, -967.0, 30.0),
      },
      thickness = 26.5,
    },
    duty = {
      coords = vec3(441.8, -982.1, 30.9),
      size = vec3(0.35000000000001, 0.45000000000001, 0.25000000000001),
      rotation = 0.0,
    },
    trash = {
      coords = vec3(450.1, -981.9, 30.1),
      size = vec3(0.5, 0.3, 0.7),
      rotation = 320.25,
    },
    evidence = {
      points = {
        vec3(476.14999389648, -992.15002441406, 26.55),
        vec3(471.70001220703, -992.04998779297, 26.55),
        vec3(471.5, -997.70001220703, 26.55),
        vec3(476.20001220703, -997.65002441406, 26.55),
      },
      thickness = 2.5,
    },
    lockers = {
      points = {
        vec3(464.23001098633, -995.58001708984, 31.0),
        vec3(459.75, -995.61999511719, 31.0),
        vec3(459.75, -995.16998291016, 31.0),
        vec3(458.61999511719, -995.21997070312, 31.0),
        vec3(456.85000610352, -997.0, 31.0),
        vec3(456.85998535156, -1000.3900146484, 31.0),
        vec3(459.70001220703, -1000.3699951172, 31.0),
        vec3(459.70001220703, -999.96997070312, 31.0),
        vec3(464.20001220703, -999.97998046875, 31.0),
      },
      thickness = 2.6,
    },
    repair_station = {
      coords = vec3(450.1, -975.9, 26.0),
      size = vec3(8.4, 4.15, 2.15),
      rotation = 0.0,
    }
  },
  -- {
  --     name = "DavisPD",
  --     blip = vec3(382.18, -1590.9, 29.28),
  --     building = {
  --         points = {
  --             vec3(387.0, -1640.0, 29.0),
  --             vec3(388.0, -1641.0, 29.0),
  --             vec3(409.0, -1614.0, 29.0),
  --             vec3(360.0, -1575.0, 29.0),
  --             vec3(338.0, -1598.0, 29.0),
  --         },
  --         thickness = 4.0
  --     }
  -- },
  -- {
  --   name = "Rangers Station",
  --   blip = vec3(387.26, 789.7, 187.69),
  --   building = {
  --     points = {
  --       vec3(377.0, 802.0, 188.0),
  --       vec3(390.0, 803.0, 188.0),
  --       vec3(390.0, 787.0, 188.0),
  --       vec3(377.0, 787.0, 188.0),
  --     },
  --     thickness = 10.0
  --   },
  --   duty = {
  --     coords = vec3(385.82, 795.15, 187.55),
  --     size = vec3(0.35000000000001, 0.55000000000001, 0.25000000000001),
  --     rotation = 0.0,
  --   },
  --   lockers = {
  --     points = {
  --       vec3(387.33999633789, 800.59002685547, 187.0),
  --       vec3(387.23999023438, 798.26000976562, 187.0),
  --       vec3(384.01000976562, 798.39001464844, 187.0),
  --       vec3(383.60000610352, 800.41998291016, 187.0),
  --     },
  --     thickness = 4.0
  --   },
  -- },
  {
    name = "Sandy PD",
    blip = vec3(1839.81, 3668.07, 33.88),
    building = {
      points = {
        vec3(1817.0, 3648.0, 34.0),
        vec3(1795.0, 3684.0, 34.0),
        vec3(1856.0, 3720.0, 34.0),
        vec3(1880.0, 3684.0, 34.0),
      },
      thickness = 29.0
    },
    duty = {
      coords = vec3(1833.84, 3678.26, 34.3),
      size = vec3(0.8, 0.2, 0.20000000000001),
      rotation = 29.75,
    },
    lockers = {
      points = {
        vec3(1841.3100585938, 3683.2399902344, 34.0),
        vec3(1839.3299560547, 3682.1298828125, 34.0),
        vec3(1841.5899658203, 3678.2299804688, 34.0),
        vec3(1843.5999755859, 3679.3000488281, 34.0),
      },
      thickness = 3.35
    },
  },
  {
    name = "Paleto PD",
    blip = vec3(-451.55, 6014.25, 31.716),
    building = {
      points = {
        vec3(-448.0, 6028.0, 31.0),
        vec3(-417.0, 5996.0, 31.0),
        vec3(-463.0, 5954.0, 31.0),
        vec3(-502.0, 5991.0, 31.0),
        vec3(-477.0, 6017.0, 31.0),
        vec3(-460.0, 6031.0, 31.0),
      },
      thickness = 83.0
    },
    duty = {
      coords = vec3(-447.31, 6013.08, 32.5),
      size = vec3(0.45000000000001, 0.6, 0.20000000000001),
      rotation = 315.25,
    },
    lockers = {
      points = {
        vec3(-438.39999389648, 6013.3701171875, 37.45),
        vec3(-435.35000610352, 6010.3100585938, 37.45),
        vec3(-438.70001220703, 6006.7202148438, 37.45),
        vec3(-441.79998779297, 6009.7797851562, 37.45),
        thickness = 3,
      },
    },
    repair_station = {
      coords = vec3(-487.86, 6000.52, 31.7),
      size = vec3(6.7, 5.1, 3.2),
      rotation = 315.0,
    }
  }
  -- {
  --     name = "LaMesaPD",
  --     blip = vec3(824.88, -1290.2, 28.23),
  --     building = {
  --         points = {
  --             vec3(817.0, -1267.0, 26.0),
  --             vec3(861.0, -1275.0, 26.0),
  --             vec3(861.0, -1334.0, 26.0),
  --             vec3(816.0, -1325.0, 26.0),
  --         },
  --         thickness = 30.0
  --     }
  -- }
}

TrunkClasses = {
  [0] = { allowed = true, x = 0.0, y = -1.5, z = 0.0 },     -- Coupes
  [1] = { allowed = true, x = 0.0, y = -2.0, z = 0.0 },     -- Sedans
  [2] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },    -- SUVs
  [3] = { allowed = true, x = 0.0, y = -1.5, z = 0.0 },     -- Coupes
  [4] = { allowed = true, x = 0.0, y = -2.0, z = 0.0 },     -- Muscle
  [5] = { allowed = true, x = 0.0, y = -2.0, z = 0.0 },     -- Sports Classics
  [6] = { allowed = true, x = 0.0, y = -2.0, z = 0.0 },     -- Sports
  [7] = { allowed = true, x = 0.0, y = -2.0, z = 0.0 },     -- Super
  [8] = { allowed = false, x = 0.0, y = -1.0, z = 0.25 },   -- Motorcycles
  [9] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },    -- Off-road
  [10] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Industrial
  [11] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Utility
  [12] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Vans
  [13] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Cycles
  [14] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Boats
  [15] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Helicopters
  [16] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Planes
  [17] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Service
  [18] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Emergency
  [19] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Military
  [20] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 },   -- Commercial
  [21] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }    -- Trains
}

Config.Impound = {
  reasons = {
    scuff = {
      flipped = 'Vehicle is flipped',
      exploded = 'Vehicle is exploded',
      middle_road = 'Vehicle is blocking road'
    },
    normal = {
      felony = 'Involved in a felony offense'
    }
  }
}

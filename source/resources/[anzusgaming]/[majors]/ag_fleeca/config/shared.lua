Config = Config or {}

--- Minutes
Config.DrillTime = 1

--- Seconds
Config.LockboxTime = {
  min = 20,
  max = 40
}

Config.PoliceRequired = 1

Config.Banks = {
  [1] = { -- harwick
    centre = vec3(313.326, -281.029, 54.164),
    cameracontrol = {
      model = `ch_prop_ch_fuse_box_01a`,
      coords = vec4(276.055, -308.707, 49.864, 340.00),
      disabled = false
    },
    cameras = {
      {
        coords = vec3(290.500, -317.200, 50.500),
        size = vec3(6, 30, 4),
        rotation = 70,
      },
      {
        coords = vec3(308.449, -279.66, 54.164),
        size = vec3(2, 3, 3),
        rotation = 157.843,
      }
    },
    manager = {
      model = `a_f_y_business_01`,
      anim = 'WORLD_HUMAN_DRINKING_FACILITY',
      coords = {
        [1] = vec4(316.241, -282.126, 54.164, 64.575),
        [2] = vec4(289.563, -318.885, 49.864, 158.638),
        [3] = vec4(303.659, -276.756, 54.166, 45.574)
      }
    },
    vault_door = {
      model = 839234948,
      --- Target box zone
      coords = vec3(312.858, -283.730, 54.303), -- Also used to get vault door
      size = vec3(2, 1.9, 2.5),
      rotation = 249.865,

      closed = 250.27,
      open = 142.22,
      opened = false,
      drill = {
        coords = vec3(311.810, -283.530, 54.303),
        heading = 70
      },
    },
    door = {
      model = -1591004109,
      doorlock = 'fleeca_inner_door_harwick',
      coords = vec3(313.32, -285.47, 54.45),
      size = vec3(0.15, 0.4, 0.6),
      rotation = 250.25,
      busy = false,
      opened = false
    },
    cash = {
      model = `h4_prop_h4_cash_stack_01a`,
      coords = vec4(313.156, -287.61, 53.99, 160)
    },
    trolly = {
      model = `ch_prop_gold_trolly_01a`,
      grab = `ch_prop_gold_bar_01a`,
      coords = vec4(314.211, -283.37, 53.6030, 160)
    },
    lockbox = {
      [1] = {
        coords = vec3(315.1, -288.4, 54.0),
        size = vec3(0.15, 2.0, 0.85),
        rotation = 160.0,
      },
      [2] = {
        coords = vec3(315.66, -285.07, 54.0),
        size = vec3(0.25, 2.0, 1),
        rotation = 340.0,
      },
      [3] = {
        coords = vec3(313.33, -289.61, 54.0),
        size = vec3(0.2, 2.0, 0.8),
        rotation = 69.5,
      },
      [4] = {
        coords = vec3(311.46, -288.91, 54.0),
        size = vec3(0.2, 2.0, 0.8),
        rotation = 69.5,
      }
    }
  },
  [2] = { -- legionsquare
    centre = vec3(147.338, -1045.371, 29.372),
    cameracontrol = {
      model = `ch_prop_ch_fuse_box_01a`,
      coords = vec4(141.544921875, -1056.6458740234375, 29.17235565185547, 339.455),
      disabled = false
    },
    cameras = {
      {
        coords = vec3(144.18, -1041.27, 29.6),
        size = vec3(2.1, 4.6, 2.6),
        rotation = 339.0,
      },
      {
        coords = vec3(152.76, -1035.27, 29.6),
        size = vec3(4.1, 4.6, 2.6),
        rotation = 339.0,
      }
    },
    manager = {
      model = `a_f_y_business_01`,
      anim = 'WORLD_HUMAN_DRINKING_FACILITY',
      coords = {
        [1] = vec4(151.113, -1043.439, 29.368, 41.708),
        [2] = vec4(144.74, -1036.958, 29.368, 237.861),
        [3] = vec4(179.746, -1004.363, 29.33, 145.386)
      }
    },
    vault_door = {
      model = 839234948,
      --- Target box zone
      coords = vec3(147.57, -1045.29, 29.5),
      size = vec3(0.4, 1, 1.2),
      rotation = 339.75,

      closed = 249.84,
      open = 142.47,
      opened = false,
      drill = {
        coords = vec3(147.57983398438, -1044.9951171875, 29.57074546814),
        heading = 69.35
      },
    },
    door = {
      model = -1591004109,
      doorlock = 'fleeca_inner_door_legion',
      coords = vec3(149.03, -1047.19, 29.65),
      size = vec3(0.2, 0.5, 1.2),
      rotation = 69.75,
      busy = false,
      opened = false
    },
    cash = {
      model = `h4_prop_h4_cash_stack_01a`,
      coords = vec4(148.99050903320312, -1049.34423828125, 29.19168853759765, 339.0646)
    },
    trolly = {
      model = `ch_prop_gold_trolly_01a`,
      grab = `ch_prop_gold_bar_01a`,
      coords = vec4(149.88282775879, -1044.9873046875, 28.805297851563, 160.32)
    },
    lockbox = {
      [1] = {
        coords = vec3(150.85, -1050.07, 29.15),
        size = vec3(0.3, 2.05, 0.8),
        rotation = 339.5,
      },
      [2] = {
        coords = vec3(151.46, -1046.72, 29.2),
        size = vec3(0.3, 2.05, 0.8),
        rotation = 339.5,
      },
      [3] = {
        coords = vec3(149.02, -1051.32, 29.2),
        size = vec3(0.3, 2.05, 0.8),
        rotation = 69.75,
      },
      [4] = {
        coords = vec3(147.1, -1050.61, 29.2),
        size = vec3(0.3, 2.05, 0.8),
        rotation = 69.75,
      },
      [5] = {
        coords = vec3(146.53, -1048.51, 29.2),
        size = vec3(0.3, 2.05, 0.8),
        rotation = 339.5,
      },
    }
  },
  [3] = { -- hawick2
    centre = vec3(-353.19, -53.262, 49.036),
    cameracontrol = {
      model = `ch_prop_ch_fuse_box_01a`,
      coords = vec4(-366.02529907227, -71.220718383789, 46.157306671143, 340.2343),
      disabled = false
    },
    cameras = {
      {
        coords = vec3(-349.48, -44.54, 50.0),
        size = vec3(10.0, 4.0, 4.0),
        rotation = 341.5,
      },
      {
        coords = vec3(-356.67, -50.5, 49.3),
        size = vec3(2.25, 4.0, 3.0),
        rotation = 341.0,
      },
      {
        coords = vec3(-384.33, -43.23, 49.0),
        size = vec3(6.25, 13, 3),
        rotation = 341.0,
      }
    },
    manager = {
      model = `a_f_y_business_01`,
      anim = 'WORLD_HUMAN_DRINKING_FACILITY',
      coords = {
        [1] = vec4(-349.843, -52.564, 49.036, 88.834),
        [2] = vec4(-347.914, -42.706, 49.036, 336.604),
        [3] = vec4(-387.831, -44.919, 49.024, 71.818)
      }
    },
    vault_door = {
      model = 839234948,
      --- Target box zone
      coords = vec3(-353.14, -54.48, 49.2),
      size = vec3(0.35, 0.75, 1.25),
      rotation = 341.5,

      closed = 250.85,
      open = 144.57,
      opened = false,
      drill = {
        coords = vec3(-353.15008544922, -54.212783813477, 49.230274200439),
        heading = 73.072
      },
    },
    door = {
      model = `v_ilev_gb_vaubar`,
      doorlock = 'fleeca_inner_door_harwick2',
      coords = vec3(-351.72, -56.33, 49.35),
      size = vec3(0.15, 0.4, 0.6),
      rotation = 250.75,
      busy = false,
      opened = false
    },
    cash = {
      model = `h4_prop_h4_cash_stack_01a`,
      coords = vec4(-351.86761474609375, -58.40796661376953, 48.8661003112793, 160.858)
    },
    trolly = {
      model = `ch_prop_gold_trolly_01a`,
      grab = `ch_prop_gold_bar_01a`,
      coords = vec4(-350.86499023438, -54.167419433594, 48.4873046875, 161.46)
    },
    lockbox = {
      [1] = {
        coords = vec3(-349.91, -59.17, 48.85), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 340.75,
      },
      [2] = {
        coords = vec3(-349.43, -55.82, 48.9), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 340.75,
      },
      [3] = {
        coords = vec3(-351.58, -60.44, 48.85), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 250.5,
      },
      [4] = {
        coords = vec3(-353.54, -59.82, 48.85), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 251.0,
      },
      [5] = {
        coords = vec3(-354.17, -57.72, 48.85), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 160.75,
      },
    }
  },
  [4] = { -- southb
    centre = vec3(-1211.775, -334.62, 37.78),
    cameracontrol = {
      model = `ch_prop_ch_fuse_box_01a`,
      coords = vec4(-1210.9721679688, -347.97219848633, 37.615184783936, 297.5054),
      disabled = false
    },
    cameras = {
      {
        coords = vec3(-1214.96, -326.18, 37.8),
        size = vec3(6.95, 3.45, 2.7),
        rotation = 26.0,
      },
      {
        coords = vec3(-1216.12, -335.37, 38.1),
        size = vec3(2.5, 3.95, 2.7),
        rotation = 26.0,
      }
    },
    manager = {
      model = `a_f_y_business_01`,
      anim = 'WORLD_HUMAN_DRINKING_FACILITY',
      coords = {
        [1] = vec4(-1210.201, -331.705, 37.780, 119.629),
        [2] = vec4(-1201.303, -338.571, 38.084, 298.426),
        [3] = vec4(-1218.859, -331.905, 37.780, 295.92)
      }
    },
    vault_door = {
      model = 839234948,
      --- Target box zone
      coords = vec3(-1210.87, -335.53, 38.2),
      size = vec3(0.6, 0.75, 2.7),
      rotation = 27.0,

      closed = 297.02459,
      open = 184.93,
      opened = false,
      drill = {
        coords = vec3(-1211.0902099609, -335.31405639648, 37.904525756836),
        heading = 118.8238
      },
    },
    door = {
      model = `v_ilev_gb_vaubar`,
      doorlock = 'fleeca_inner_door_southb',
      coords = vec3(-1208.65, -335.74, 38.1), -- done
      size = vec3(0.15, 0.4, 0.6),
      rotation = 296.75,
      busy = false,
      opened = false
    },
    cash = {
      model = `h4_prop_h4_cash_stack_01a`,
      coords = vec4(-1207.13720703125, -337.3191223144531, 37.58595657348633, 203.016)
    },
    trolly = {
      model = `ch_prop_gold_trolly_01a`,
      grab = `ch_prop_gold_bar_01a`,
      coords = vec4(-1209.7108154297, -333.73529052734, 37.231811523438, 207.881)
    },
    lockbox = {
      [1] = {
        coords = vec3(-1205.23, -336.41, 37.6), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 206.5,
      },
      [2] = {
        coords = vec3(-1207.16, -333.67, 37.6), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 206.5,
      },
      [3] = {
        coords = vec3(-1205.51, -338.54, 37.6), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 116.75,
      },
      [4] = {
        coords = vec3(-1207.32, -339.51, 37.6), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 117.0,
      },
      [5] = {
        coords = vec3(-1209.26, -338.47, 37.55), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 27.0,
      },
    }
  },
  [5] = { -- sandy
    centre = vec3(1176.122, 2710.801, 38.088),
    cameracontrol = {
      model = `ch_prop_ch_fuse_box_01a`,
      coords = vec4(1174.9134521484, 2721.7526855469, 38.153438568115, 180.576),
      disabled = false
    },
    cameras = {
      {
        coords = vec3(1175.04, 2701.33, 38.45),
        size = vec3(7.7, 4.0, 2.65),
        rotation = 0.0,
      },
      {
        coords = vec3(1180.26, 2709.16, 38.2),
        size = vec3(2.35, 4.0, 2.1),
        rotation = 0.0,
      }
    },
    manager = {
      model = `a_f_y_business_01`,
      anim = 'WORLD_HUMAN_DRINKING_FACILITY',
      coords = {
        [1] = vec4(1172.593, 2708.923, 38.087, 273.477),
        [2] = vec4(1172.456, 2700.311, 38.174, 181.503)
      }
    },
    vault_door = {
      model = 839234948,
      --- Target box zone
      coords = vec3(1175.66, 2711.92, 38.3),
      size = vec3(0.6, 0.85, 1.4),
      rotation = 0.0,

      closed = 90.41,
      open = 342.07,
      opened = false,
      drill = {
        coords = vec3(1175.7445068359, 2711.4885253906, 38.269577026367),
        heading = 269.831
      },
    },
    door = {
      model = `v_ilev_gb_vaubar`,
      doorlock = 'fleeca_inner_door_sandy',
      coords = vec3(1173.67, 2713.13, 38.4), -- done
      size = vec3(0.15, 0.4, 0.6),
      rotation = 270.0,
      busy = false,
      opened = false
    },
    cash = {
      model = `h4_prop_h4_cash_stack_01a`,
      coords = vec4(1173.2286376953125, 2715.205322265625, 37.90750503540039, 0.0)
    },
    trolly = {
      model = `ch_prop_gold_trolly_01a`,
      grab = `ch_prop_gold_bar_01a`,
      coords = vec4(1173.7230224609, 2710.8034667969, 37.538696289063, 0.69)
    },
    lockbox = {
      [1] = {
        coords = vec3(1170.95, 2715.24, 37.9), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 0.0,
      },
      [2] = {
        coords = vec3(1171.53, 2711.89, 37.9), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 359.75,
      },
      [3] = {
        coords = vec3(1172.21, 2717.02, 37.9), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 269.5,
      },
      [4] = {
        coords = vec3(1174.26, 2717.01, 38.0), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 270.0,
      },
      [5] = {
        coords = vec3(1175.52, 2715.23, 37.9), -- done
        size = vec3(0.3, 2.05, 0.8),
        rotation = 180.0,
      },
    }
  }
}

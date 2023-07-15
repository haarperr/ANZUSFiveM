--==========| CREATE CONFIG |==========--
Config = {}


--==========| DEFAULTS |==========--
Config.dealerships = {
  Main = {
    label = 'Premium Deluxe Motorsport',
    requiredJobs = {},
    requiredJobGrade = 0,
    job = 'killmore',
    society = 'killmore',
    societyCut = 15,
    onlineRequirement = 2,
    testDriveTime = 60,
    range = 40,
    salesCommission = 5,
    testDriveLoc = vec4(-50.1789, -1074.5433, 27.0676, 69.1599),
    purchaseLoc = vec4(-23.2054, -1113.3008, 26.9247, 163.5603),
    dealerShipLocation = vec3(-37.46, -1100.58, 26.42),
    blipOptions = {
      sprite = 225,
      color = 26
    },
    showRoomCars = {
      {
        id = 'sports',
        label = 'Sports',
        class = 6,
        location = vec4(-49.5124, -1083.3047, 27.3023, 102.7500),
        defaultCar = 'coquette4',
        zone = {
          coords = vec3(-51.07, -1086.9, 27.35),
          size = vec3(1.0, 0.5, 0.75),
          rotation = 156.75,
        }
      },
      {
        id = 'sportsclassic',
        label = 'Sports Classic',
        class = 5,
        location = vec4(-46.8235, -1092.1780, 26.6285, 92.8565),
        defaultCar = 'elegy',
        zone = {
          coords = vec3(-46.93, -1095.32, 27.35),
          size = vec3(1.0, 0.5, 0.75),
          rotation = 190.25,
        }
      },
      {
        id = 'super',
        label = 'Super',
        class = 7,
        location = vec4(-55.1756, -1096.9342, 27.3023, 219.6980),
        defaultCar = 'krieger',
        zone = {
          coords = vec3(-51.89, -1095.15, 27.4),
          size = vec3(1.0, 0.5, 0.75),
          rotation = 120.0,
        }
      },
      {
        id = 'sedans',
        label = 'Sedans',
        class = 1,
        location = vec4(-36.4723, -1093.4319, 26.8081, 17.5694),
        defaultCar = 'stafford',
        zone = {
          coords = vec3(-40.21, -1094.46, 27.4),
          size = vec3(1.0, 0.5, 0.75),
          rotation = 294.25,
        }
      },
      {
        id = 'coupes',
        label = 'Coupes',
        class = 3,
        location = vec4(-42.6840, -1100.8674, 26.7585, 223.7747),
        defaultCar = 'cogcabrio',
        zone = {
          coords = vec3(-39.01, -1100.3, 27.35),
          size = vec3(1.0, 0.5, 0.75),
          rotation = 294.25,
        }

      },
      -- {
      --     id = 'tuner',
      --     label = 'Tuner',
      --     location = vec4(-42.34, -1094.37, 25.81, 191.98),
      --     defaultCar = 'sentinel'
      -- },
      -- {
      --     id = 'muscle',
      --     label = 'Muscle',
      --     location = vec4(-42.1579, -1101.1268, 26.7307, 22.0608),
      --     defaultCar = 'dominator3'
      -- },
      -- {
      --     id = 'suvs',
      --     label = 'Suvs',
      --     location = vec4(-39.0695, -1096.3229, 25.9354, 189.6493),
      --     defaultCar = 'baller4'
      -- },
      -- {
      --   id = 'cycles',
      --   label = 'Cycles',
      --   class = 13,
      --   location = vec4(-55.5523, -1091.1818, 27.2744, 162.9642),
      --   defaultCar = 'bmx'
      -- },
      -- {
      --     id = 'compacts',
      --     label = 'Compacts',
      --     location = vec4(-42.4922, -1101.0961, 27.3023, 199.6825),
      --     defaultCar = 'penumbra2'
      -- },
    }
  },
  -- Second = {
  --   label = "Otto's Dealership & Repairs",
  --   requiredJobs = {},
  --   requiredJobGrade = 0,
  --   job = 'ottos',
  --   society = 'ottos',
  --   societyCut = 50,
  --   onlineRequirement = 2,
  --   testDriveTime = 120,
  --   range = 80,
  --   salesCommission = 50,
  --   testDriveLoc = vec4(828.6572, -793.7021, 26.2313, 87.4629),
  --   purchaseLoc = vec4(829.5039, -796.5229, 26.2361, 94.4169),
  --   dealerShipLocation = vec3(803.1262, -812.5244, 26.1810),
  --   blipOptions = {
  --     sprite = 226,
  --     color = 1
  --   },
  --   showRoomCars = {
  --     {
  --       id = 'motorcycles',
  --       label = 'Motorcycles',
  --       class = 8,
  --       location = vec4(808.5418, -816.1200, 25.6979, 123.7197),
  --       defaultCar = 'nightblade'
  --     },
  --     {
  --       id = 'offroad',
  --       label = 'Off Road',
  --       class = 9,
  --       location = vec4(807.5916, -811.7163, 25.8983, 123.1314),
  --       defaultCar = 'caracara2'
  --     },
  --     {
  --       id = 'vans',
  --       label = 'Vans',
  --       class = 12,
  --       location = vec4(802.6996, -805.6206, 27.0853, 90.4711),
  --       defaultCar = 'rumpo'
  --     },
  --   }
  -- },
  -- boat = {
  --   label = "Boat Dealership",
  --   requiredJobs = {},
  --   requiredJobGrade = 0,
  --   jobs = {},
  --   society = 'boat',
  --   societyCut = 50,
  --   onlineRequirement = 0,
  --   testDriveTime = 120,
  --   range = 80,
  --   salesCommission = 50,
  --   testDriveLoc = vec4(-807.0574, -1419.1572, 0.4425, 230.1974),
  --   purchaseLoc = vec4(-783.3260, -1432.9374, 0.4082, 141.5308),
  --   dealerShipLocation = vec3(-738.5267, -1327.4004, 1.5952),
  --   blipOptions = {
  --     sprite = 427,
  --     color = 67
  --   },
  --   showRoomCars = {
  --     {
  --       id = 'speed',
  --       label = 'Speed Boat',
  --       location = vec4(-723.6711, -1329.3824, -1.4470, 228.2772),
  --       defaultCar = 'yacht2'
  --     },
  --     {
  --       id = 'civilian',
  --       label = 'Civ Boat',
  --       location = vec4(-732.9649, -1333.1893, -1.3292, 230.0599),
  --       defaultCar = 'reefer'
  --     },
  --     {
  --       id = 'jetski',
  --       label = 'Jetski',
  --       location = vec4(-741.0280, -1338.4698, -0.1109, 228.5422),
  --       defaultCar = 'seashark3'
  --     },
  --     {
  --       id = 'sail',
  --       label = 'Sail Boat',
  --       location = vec4(-742.2685, -1349.4749, -1.4094, 228.5241),
  --       defaultCar = 'marquis'
  --     },
  --     {
  --       id = 'tug',
  --       label = 'Tug Boat',
  --       location = vec4(-752.1338, -1352.5890, -0.3006, 226.7262),
  --       defaultCar = 'avisa'
  --     },
  --   }
  -- },
  -- heli = {
  --   label = "Helicopter Dealership",
  --   requiredJobs = {},
  --   requiredJobGrade = 0,
  --   jobs = {},
  --   society = 'heli',
  --   societyCut = 50,
  --   onlineRequirement = 0,
  --   testDriveTime = 120,
  --   range = 80,
  --   salesCommission = 50,
  --   testDriveLoc = vec4(-1201.7134, -3221.1650, 13.9444, 61.6408),
  --   purchaseLoc = vec4(-1248.8677, -3341.9500, 13.9450, 318.7808),
  --   dealerShipLocation = vec3(-1239.8270, -3346.9841, 13.9450),
  --   blipOptions = {
  --     sprite = 602,
  --     color = 22
  --   },
  --   showRoomCars = {
  --     {
  --       id = 'cargo',
  --       label = 'Cargo Helicopters',
  --       location = vec4(-1202.4805, -3363.6904, 14.2693, 149.9415),
  --       defaultCar = 'pavelow'
  --     },
  --     {
  --       id = 'hcivilian',
  --       label = 'Civ Helicopters',
  --       location = vec4(-1224.2997, -3359.5166, 14.3058, 149.9848),
  --       defaultCar = 'ecr135'
  --     },
  --     {
  --       id = 'luxury',
  --       label = 'Luxury Helicopters',
  --       location = vec4(-1202.2891, -3342.0706, 13.8425, 145.8590),
  --       defaultCar = 'supervolito6'
  --     },
  --   }
  -- },
  -- business = {
  --   label = "Business Dealership",
  --   requiredJobs = {},
  --   requiredJobGrade = 0,
  --   job = 'businessdealer',
  --   society = 'state',
  --   societyCut = 50,
  --   onlineRequirement = 0,
  --   testDriveTime = 120,
  --   range = 80,
  --   salesCommission = 0,
  --   testDriveLoc = vec4(-1234.6990, -344.0006, 37.3328, 23.7679),
  --   purchaseLoc = vec4(-1234.6990, -344.0006, 37.3328, 23.7679),
  --   dealerShipLocation = vec3(-1246.9280, -355.3624, 37.0562),
  --   blipOptions = {
  --     sprite = 225,
  --     color = 26
  --   },
  --   showRoomCars = {}
  -- }

}


--==========| POLICE DEALERSHIP |==========--
-- Config.dealerships.businessPolice = {
--    label = "Police Dealership",
--    requiredJobs = { 'police', 'state' },
--    requiredJobGrade = 17,
--    jobs = {},
--    society = 'state',
--    societyCut = 50,
--    onlineRequirement = 0,
--    testDriveTime = 120,
--    moneyCostLocation = 'bank',
--    defaultGarage = 'policeGarage',
--    plateFormat = 'NNLLNNLL',
--    defaultTaxRate = 0,
--    maxTaxRate = 0,
--    range = 80,
--    salesCommission = 0,
--    testDriveLoc = vec4(-1234.6990, -344.0006, 37.3328, 23.7679),
--    purchaseLoc = vec4(-1234.6990, -344.0006, 37.3328, 23.7679),
--    dealerShipLocation = vec3(-1246.9280, -355.3624, 37.0562),
--    showRoomCars = {
--        {
--            id = 'Police',
--            label = 'Police Vehicles',
--            location = vec4(-1269.3643, -358.8499, 36.5975, 249.6467),
--            defaultCar = 'code318charg'
--        },
--    }
-- }

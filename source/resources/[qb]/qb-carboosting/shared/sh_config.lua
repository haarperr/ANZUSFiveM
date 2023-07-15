Shared = Shared or {}

Shared.Framework = 'qb-core'         -- In case you've renamed your Framework
Shared.NewCore = true                -- Set to false if NOT using local QBCore = exports['qb-core']:GetCoreObject()
Shared.CoreObject = 'QBCore'         -- In case you've renamed your Framework

Shared.FuelScript = 'LegacyFuel'     -- This is used for exports[Shared.FuelScript]:SetFuel(veh, 23.00), use ps-fuel if using Project Sloth version
Shared.Debug = true                  -- Server sided console prints
Shared.LaptopItem = 'boostinglaptop' -- Boostinglaptop item name

Shared.BoostInterval = 15            -- Amount of minutes between new boost contracts
Shared.BoostContractAmount = 5       -- Amount of contract created every Shared.BoostInterval minutes
Shared.MinSpeed = 40                 -- Minimum speed in MPH required to perform a hack
Shared.LaptopAnimation = true        -- Set to false if you don't want a tablet animation

Shared.Permission = 'god'            -- The permission needed to use the createboost command, admin or god
Shared.MoneyType =
'cash'                               -- The moneytype used to start a contract, make sure to edit the strings in the UI too in the app.js to fit your moneytype. i.e Change QBit to Cash
Shared.DownTrade = false             -- Setting this to false stops players from sending contracts to players that don't have the boosting class for it.
Shared.DisablePolice = false         -- Setting this to true stops players with a police job to open the laptop and receive contracts
Shared.MinCops = 0                   -- Minimum cops required for the server to send contracts if CopsRequired option enabled
Shared.CopsRequired = false          -- Settings this to true stops players from getting contracts when insufficient (Shared.MinCops) cops are online.

Shared.Contracts = {
  ['D'] = {
    vehicles = { 'youga3','manana2','peyote3','asea','emperor','regina','romero','minivan','paradise','pony','rumpo','speedo','camper','burrito3','kalahari','gburrito','gburrito2','dilettante','blazer','blazer2','bodhi2','sadler','sandking2','sandking','dynasty','surfer','hermes','hustler','virgo2','virgo3','voodoo2','voodoo','manana','peyote','tornado','tornado5','pigalle','journey','youga2','flatbed','mixer','mixer2','rubble','tiptruck','tiptruck2','bus','bus','pbus2','tourbus','tourbus','airtug','caddy','docktug','forklift','mower','ripley','scrap','tractor2','benson','biff','hauler','mule','packer','phantom','pounder','stockade','tampa2' },     -- You can always add more vehicles here
    locations = {
      -- You can always add more locations here, vehicle takes a vector4 and peds takes a table of vector3's to spawn the peds
      [1] = {
        vehicle = vector4(-1579.07, -374.6, 44.1, 269.02),
        peds = {}
      },
      [2] = {
        vehicle = vector4(1708.48, -1483.51, 112.47, 248.69),
        peds = {}
      },
      [3] = {
        vehicle = vector4(1450.73, -2599.01, 47.96, 343.22),
        peds = {}
      },
      [4] = {
        vehicle = vector4(851.07, -1951.8, 28.69, 85.25),
        peds = {}
      },
      [5] = {
        vehicle = vector4(873.73, -2197.5, 30.1, 174.43),
        peds = {}
      },
      [6] = {
        vehicle = vector4(174.68, -1709.45, 28.87, 231.21),
        peds = {}
      },
      [7] = {
        vehicle = vector4(407.1, -1313.25, 39.02, 320.67),
        peds = {}
      },
      [8] = {
        vehicle = vector4(485.54, -1105.71, 28.78, 267.75),
        peds = {}
      },
      [9] = {
        vehicle = vector4(353.67, -1116.26, 28.99, 178.94),
        peds = {}
      },
      [10] = {
        vehicle = vector4(497.55, -1522.76, 28.87, 139.62),
        peds = {}
      },
      [11] = {
        vehicle = vector4(244.74, -1766.56, 28.59, 140.16),
        peds = {}
      },
      [12] = {
        vehicle = vector4(2742.17, 2788.68, 34.85, 303.0),
        peds = {}
      },
      [13] = {
        vehicle = vector4(2985.31, 3503.0, 70.78, 122.61),
        peds = {}
      },
      [14] = {
        vehicle = vector4(3333.2, 5160.43, 17.69, 333.88),
        peds = {}
      },
      [15] = {
        vehicle = vector4(2113.11, 4767.5, 40.76, 295.7),
        peds = {}
      },
      [16] = {
        vehicle = vector4(1931.98, 4639.51, 40.01, 69.41),
        peds = {}
      },
      [17] = {
        vehicle = vector4(1718.61, 4669.77, 42.76, 270.09),
        peds = {}
      },
      [18] = {
        vehicle = vector4(2484.0, 4112.86, 37.65, 156.92),
        peds = {}
      },
      [19] = {
        vehicle = vector4(1983.0, 3783.3, 31.76, 118.17),
        peds = {}
      },
      [20] = {
        vehicle = vector4(1626.35, 3734.26, 34.12, 123.91),
        peds = {}
      },
      [21] = {
        vehicle = vector4(243.24, 3112.95, 42.07, 273.87),
        peds = {}
      },
      [22] = {
        vehicle = vector4(342.11, 2622.36, 44.09, 209.3),
        peds = {}
      },
      [23] = {
        vehicle = vector4(-53.71, 1949.68, 189.77, 210.4),
        peds = {}
      },
      [24] = {
        vehicle = vector4(-71.38, 903.18, 235.2, 290.81),
        peds = {}
      }
    },
    minRep = 0,                           -- Here you can change the min and max reputation thresholds for the different ranks
    maxRep = 120,                         -- Here you can change the min and max reputation thresholds for the different ranks
    price = { min = 20, max = 30 },       -- Buy-in price in crypto
    reward = { min = 44, max = 55 },      -- Crypto rewarded after successful boost
    exp = { buyin = 0, payout = 12 },     -- Boosting rep buyin and reward after successful boost
    hacks = 2,                            -- Amount of hacks required
    dropCops = 0,                         -- Minimum amount of cops required for a drop-off
    vinCops = 0,                          -- Minimum amount of cops required for a VIN-scratch
    expireTime = 6,                       -- Time in hours for the contract of this tier to expire
    vinPrice = 251                        -- Additional price to start a VIN scratch
  },
  ['C'] = {
    vehicles = { 'yosemite3','seminole2','glendale2','blista2','asterope','ingot','primo','primo2','stanier','taxi','stretch','warrener','washington','issi2','panto','rhapsody','baller','bjxl','fq2','granger','habanero','landstalker','patriot','patriot2','radi','seminole','youga','rallytruck','caracara2','contender','rumpo3','streiter','mesa','mesa3','comet4','bifta','blazer4','brawler','dubsta3','dune','freecrawler','bfinjection','kamacho','rebel','rebel2','guardian','bison','bobcatxl','riata','glendale','fagaloa','issi3','faction3','chino','chino2','hotknife','btype','btype3','ztype','moonbeam','ratloader' },
    locations = {
      [1] = {
        vehicle = vector4(184.55, -1894.43, 23.28, 246.51),
        peds = {}
      },
      [2] = {
        vehicle = vector4(232.35, 1158.39, 225.04, 102.12),
        peds = {}
      },
      [3] = {
        vehicle = vector4(-1531.13, -429.47, 35.02, 48.64),
        peds = {}
      },
      [4] = {
        vehicle = vector4(-1774.65, -516.6, 38.38, 119.17),
        peds = {}
      },
      [5] = {
        vehicle = vector4(-1663.09, -298.42, 51.28, 53.14),
        peds = {}
      },
      [6] = {
        vehicle = vector4(-1547.26, -424.75, 41.58, 229.91),
        peds = {}
      },
      [7] = {
        vehicle = vector4(-1309.72, -935.81, 9.31, 198.63),
        peds = {}
      },
      [8] = {
        vehicle = vector4(-1282.47, -804.76, 17.12, 308.21),
        peds = {}
      },
      [9] = {
        vehicle = vector4(-1171.36, -917.65, 2.23, 31.75),
        peds = {}
      },
      [10] = {
        vehicle = vector4(-1318.8, -1148.35, 4.08, 270.3),
        peds = {}
      },
      [11] = {
        vehicle = vector4(-1300.31, -1318.15, 4.4, 178.3),
        peds = {}
      },
      [12] = {
        vehicle = vector4(-1227.25, -1220.26, 6.55, 279.1),
        peds = {}
      },
      [13] = {
        vehicle = vector4(-1160.26, -1563.02, 3.98, 124.75),
        peds = {}
      },
      [14] = {
        vehicle = vector4(-1091.02, -1633.45, 4.25, 304.2),
        peds = {}
      },
      [15] = {
        vehicle = vector4(-1409.07, -636.59, 28.25, 33.05),
        peds = {}
      },
      [16] = {
        vehicle = vector4(-1230.81, -696.31, 22.91, 127.89),
        peds = {}
      },
      [17] = {
        vehicle = vector4(-1228.21, -667.74, 35.12, 130.14),
        peds = {}
      },
      [18] = {
        vehicle = vector4(324.01, 343.66, 104.78, 345.9),
        peds = {}
      },
      [19] = {
        vehicle = vector4(1741.02, 3784.58, 33.88, 33.66),
        peds = {}
      },
      [20] = {
        vehicle = vector4(1831.4, 3846.38, 32.7, 282.99),
        peds = {}
      },
      [21] = {
        vehicle = vector4(1861.89, 3868.57, 32.61, 201.97),
        peds = {}
      },
      [22] = {
        vehicle = vector4(2795.51, 3485.95, 54.65, 246.73),
        peds = {}
      },
      [23] = {
        vehicle = vector4(2904.03, 4397.0, 49.84, 21.8),
        peds = {}
      }
    },
    minRep = 121,
    maxRep = 250,
    price = { min = 30, max = 45 },
    reward = { min = 60, max = 80 },
    exp = { buyin = 12, payout = 21 },
    hacks = 5,
    dropCops = 0,
    vinCops = 0,
    expireTime = 6,
    vinPrice = 252
  },
  ['B'] = {
    vehicles = { 'club','komoda','vstr','blista','sugoi','prairie','savestra','sentinel','zion3','buffalo','buffalo2','windsor2','fusilade','futo','kuruma','sultan','sultan2','revolter','schafter2','schafter3','schafter4','sentinel3','cognoscenti','cog55','fugitive','intruder','premier','stratum','superd','tailgater','exemplar','jackal','oracle','oracle2','felon','raiden','surge','rebla','novak','baller3','dubsta2','dubsta','gresley','huntley','rocoto','serrano','xls','minivan2','issi7','flashgt','omnis','tropos','gb200','michelli','retinue','retinue2','outlaw','vagrant','everon','trophytruck','trophytruck2','slamvan2','cheburek','buccaneer','buccaneer2','clique','faction','faction2','impaler','nightshade','phoenix','picador','ratloader2','sabregt2','tulip','vigero','virgo','feltzer3','casco','coquette2','coquette3','gt500','mamba','stinger','stingergt','swinger','viseris','rapidgt3' },
    locations = {
      [1] = {
        vehicle = vector4(-815.58, -1098.29, 10.47, 119.79),
        peds = { vector3(-815.61, -1120.23, 10.55), vector3(-819.82, -1122.39, 10.43) }
      },
      [2] = {
        vehicle = vector4(-685.11, -882.85, 24.08, 226.07),
        peds = { vector3(-676.03, -885.1, 24.46), vector3(-676.46, -868.38, 28.66), vector3(-689.63, -866.3, 28.66) }
      },
      [3] = {
        vehicle = vector4(426.66, -1826.02, 27.56, 42.94),
        peds = { vector3(434.02, -1818.06, 27.98), vector3(429.48, -1819.98, 28.36), vector3(440.54, -1829.63, 28.36) }
      },
      [4] = {
        vehicle = vector4(311.56, -1939.35, 24.23, 52.21),
        peds = { vector3(312.38, -1928.92, 25.0), vector3(327.28, -1933.16, 24.67), vector3(324.13, -1937.19, 25.02) }
      },
      [5] = {
        vehicle = vector4(497.11, -1968.94, 24.47, 301.37),
        peds = { vector3(474.18, -1951.6, 24.64), vector3(497.7, -1993.45, 24.99) }
      },
      [6] = {
        vehicle = vector4(237.55, 3164.6, 42.21, 281.88),
        peds = { vector3(247.51, 3169.19, 42.78), vector3(248.68, 3180.64, 42.92) }
      },
      [7] = {
        vehicle = vector4(-1152.39, 2679.78, 17.67, 38.77),
        peds = { vector3(-1123.59, 2682.42, 18.76), vector3(-1125.79, 2694.67, 18.8) }
      },
      [8] = {
        vehicle = vector4(-223.64, -1707.14, 33.49, 37.79),
        peds = { vector3(-231.2, -1683.11, 34.85), vector3(-212.53, -1683.11, 34.85) }
      },
      [9] = {
        vehicle = vector4(-1143.89, -1155.15, 2.38, 300.61),
        peds = { vector3(-1135.59, -1153.36, 2.74), vector3(-1129.34, -1143.62, 2.84) }
      },
      [10] = {
        vehicle = vector4(-1189.71, -1065.99, 1.73, 301.34),
        peds = { vector3(-1181.05, -1056.41, 2.15), vector3(-1175.65, -1062.42, 2.15) }
      },
      [11] = {
        vehicle = vector4(-1035.14, -900.22, 3.79, 210.67),
        peds = { vector3(-1020.82, -917.16, 3.25), vector3(-1028.33, -920.0, 2.33) }
      },
      [12] = {
        vehicle = vector4(-703.33, -1138.85, 10.19, 39.65),
        peds = { vector3(-703.74, -1156.14, 10.81), vector3(-717.38, -1159.52, 10.74) }
      }
    },
    minRep = 251,
    maxRep = 450,
    price = { min = 55, max = 70 },
    reward = { min = 90, max = 110 },
    exp = { buyin = 20, payout = 30 },
    hacks = 9,
    dropCops = 0,
    vinCops = 0,
    expireTime = 6,
    vinPrice = 253
  },
  ['A'] = {
    vehicles = { 'toros','zentorno','adder','turismor','penumbra2','banshee','coquette','ninef','ninef2','drafter','alpha','bestiagts','carbonizzare','comet2','comet3','comet5','jester3','kanjo','elegy2','feltzer2','furoregt','jester','jugular','lynx','locust','massacro','pariah','penumbra','rapidgt','rapidgt2','ruston','schwarzer','seven70','specter','specter2','surano','z190','cogcabrio','f620','felon2','zion','zion2','paragon','windsor','brioso','voltic','dominator','dominator3','gauntlet','stafford','blade','dukes','vamos','ellie','ruiner','sabregt','slamvan','slamvan3','tampa','yosemite','tornado6' },
    locations = {
      [1] = {
        vehicle = vector4(1056.01, -386.45, 67.43, 221.97),
        peds = { vector3(1050.27, -368.16, 67.85), vector3(1049.07, -369.39, 67.85), vector3(1060.64, -378.33, 68.23) }
      },
      [2] = {
        vehicle = vector4(1359.8, -616.23, 73.92, 359.08),
        peds = { vector3(1367.75, -606.55, 74.71), vector3(1366.88, -606.22, 74.71), vector3(1367.14, -623.4, 74.71) }
      },
      [3] = {
        vehicle = vector4(1291.49, -580.75, 71.32, 342.43),
        peds = { vector3(1301.44, -574.18, 71.73), vector3(1300.86, -573.91, 71.73), vector3(1306.49, -578.17, 71.94) }
      },
      [4] = {
        vehicle = vector4(1047.46, -486.76, 63.5, 257.7),
        peds = { vector3(1046.24, -497.99, 64.08), vector3(1041.95, -504.57, 63.9), vector3(1031.42, -488.76, 63.92) }
      },
      [5] = {
        vehicle = vector4(957.49, -603.97, 58.96, 27.65),
        peds = { vector3(964.38, -595.66, 59.9), vector3(964.04, -596.45, 59.9), vector3(969.87, -591.55, 59.49), vector3(965.68, -608.23, 59.9) }
      },
      [6] = {
        vehicle = vector4(1003.44, -514.44, 60.27, 205.64),
        peds = { vector3(1006.45, -511.0, 60.99), vector3(1019.03, -513.38, 60.69), vector3(1016.95, -514.55, 60.69) }
      },
      [7] = {
        vehicle = vector4(-1855.13, -624.14, 10.76, 229.29),
        peds = { vector3(-1879.1, -611.17, 11.89), vector3(-1849.03, -631.89, 11.16), vector3(-1848.11, -632.65, 11.16) }
      },
      [8] = {
        vehicle = vector4(-1900.74, -561.17, 11.38, 141.15),
        peds = { vector3(-1898.58, -572.53, 11.85), vector3(-1914.73, -573.75, 11.44), vector3(-1915.58, -572.98, 11.67) }
      },
      [9] = {
        vehicle = vector4(-734.59, -282.27, 36.53, 262.11),
        peds = { vector3(-740.55, -279.13, 36.95), vector3(-723.72, -280.9, 37.14), vector3(-735.71, -292.33, 37.04) }
      },
      [10] = {
        vehicle = vector4(-458.29, 225.76, 82.74, 325.19),
        peds = { vector3(-476.0, 217.56, 83.7), vector3(-477.16, 217.81, 83.7), vector3(-478.9, 218.08, 83.7) }
      },
      [11] = {
        vehicle = vector4(-16.71, 6646.43, 30.7, 207.3),
        peds = { vector3(-9.63, 6654.2, 31.71), vector3(-4.93, 6658.62, 31.14), vector3(-25.75, 6660.0, 31.04) }
      },
      [12] = {
        vehicle = vector4(-393.8, 6308.84, 28.81, 39.9),
        peds = { vector3(-407.5, 6314.06, 28.94), vector3(-413.59, 6309.83, 28.64) }
      },
      [13] = {
        vehicle = vector4(-3181.68, 1276.1, 12.24, 253.57),
        peds = { vector3(-3194.77, 1280.5, 12.66), vector3(-3196.65, 1280.76, 12.66) }
      },
      [14] = {
        vehicle = vector4(-1026.8, -493.05, 36.53, 108.9),
        peds = { vector3(-1007.12, -486.68, 39.97), vector3(-1011.11, -479.9, 39.97), vector3(-1049.03, -523.03, 36.59) }
      }
    },
    minRep = 451,
    maxRep = 800,
    price = { min = 75, max = 90 },
    reward = { min = 120, max = 150 },
    exp = { buyin = 34, payout = 51 },
    hacks = 12,
    dropCops = 0,
    vinCops = 0,
    expireTime = 6,
    vinPrice = 254
  },
  ['S'] = {
    vehicles = { 'tigon','coquette4','dukes3','gauntlet5','elegy','banshee2','gauntlet3','gauntlet4','hotring','cheetah2','furia','turismo2','infernus2','monroe','torero','deviant','sultanrs','peyote2','nebula' },
    locations = {
      [1] = {
        vehicle = vector4(-586.65, 528.55, 107.38, 218.91),
        peds = { vector3(-587.18, 541.54, 110.5), vector3(-585.75, 542.09, 109.62), vector3(-613.65, 535.55, 110.52), vector3(-615.76, 535.13, 110.52) }
      },
      [2] = {
        vehicle = vector4(-88.83, 365.7, 112.04, 64.01),
        peds = { vector3(-61.4, 359.45, 113.06), vector3(-60.75, 360.75, 113.06), vector3(-70.66, 359.42, 112.55), vector3(-77.46, 364.6, 112.44) }
      },
      [3] = {
        vehicle = vector4(-868.73, 318.19, 83.56, 194.32),
        peds = { vector3(-877.83, 305.93, 84.15), vector3(-877.1, 306.89, 84.15), vector3(-881.29, 297.67, 84.13), vector3(-884.57, 316.79, 84.13) }
      },
      [4] = {
        vehicle = vector4(-889.73, 364.64, 84.61, 355.48),
        peds = { vector3(-881.51, 364.0, 85.36), vector3(-887.9, 350.44, 85.29), vector3(-872.04, 378.03, 87.27), vector3(-870.8, 377.79, 87.22) }
      },
      [5] = {
        vehicle = vector4(-811.59, 808.39, 201.71, 197.73),
        peds = { vector3(-824.18, 806.11, 202.78), vector3(-834.96, 801.17, 202.59), vector3(-802.42, 792.52, 202.19), vector3(-804.03, 791.68, 202.19) }
      },
      [6] = {
        vehicle = vector4(-661.26, 807.58, 198.95, 181.17),
        peds = { vector3(-655.11, 802.95, 198.99), vector3(-638.87, 802.45, 196.61), vector3(-667.74, 790.93, 197.34), vector3(-668.93, 791.01, 197.7) }
      },
      [7] = {
        vehicle = vector4(-593.33, 753.53, 183.3, 257.82),
        peds = { vector3(-597.82, 763.55, 189.12), vector3(-596.71, 764.15, 189.12), vector3(-584.05, 771.22, 188.51), vector3(-608.92, 771.54, 188.51) }
      },
      [8] = {
        vehicle = vector4(-1022.1, 693.53, 160.82, 181.79),
        peds = { vector3(-1032.94, 686.1, 161.3), vector3(-1037.65, 681.99, 158.31), vector3(-1002.11, 683.92, 160.9) }
      },
      [9] = {
        vehicle = vector4(-615.63, 678.56, 149.36, 165.17),
        peds = { vector3(-605.59, 672.11, 151.6), vector3(-606.43, 672.34, 151.6), vector3(-594.73, 667.38, 151.04) }
      },
      [10] = {
        vehicle = vector4(-317.05, 480.7, 112.36, 118.37),
        peds = { vector3(-312.21, 475.38, 111.82), vector3(-311.7, 474.09, 111.82) }
      },
      [11] = {
        vehicle = vector4(-448.03, 372.05, 104.35, 270.17),
        peds = { vector3(-428.13, 364.2, 106.75), vector3(-450.87, 395.55, 104.78), vector3(-451.91, 395.42, 104.77), vector3(-448.05, 380.43, 108.87) }
      },
      [12] = {
        vehicle = vector4(-628.82, 528.38, 109.27, 188.58),
        peds = { vector3(-640.81, 520.57, 109.88), vector3(-641.65, 519.4, 109.69), vector3(-618.45, 514.02, 107.6) }
      },
      [13] = {
        vehicle = vector4(-1287.0, 290.38, 64.39, 58.07),
        peds = { vector3(-1274.39, 316.3, 65.51), vector3(-1273.42, 315.61, 65.51), vector3(-1268.17, 306.08, 65.5), vector3(-1303.98, 313.14, 65.49) }
      },
      [14] = {
        vehicle = vector4(-913.04, 587.01, 100.47, 150.25),
        peds = { vector3(-904.36, 588.12, 101.19), vector3(-905.42, 576.71, 100.99), vector3(-908.13, 603.51, 101.0), vector3(-908.9, 602.22, 101.0) }
      },
      [15] = {
        vehicle = vector4(-1102.49, 554.63, 102.26, 81.77),
        peds = { vector3(-1089.91, 548.28, 103.63), vector3(-1091.09, 548.79, 103.63), vector3(-1093.68, 567.43, 102.73), vector3(-1094.41, 567.97, 102.73) }
      },
      [16] = {
        vehicle = vector4(-1270.4, 505.64, 96.81, 178.69),
        peds = { vector3(-1277.94, 497.06, 97.89), vector3(-1263.28, 525.0, 96.78), vector3(-1278.89, 480.77, 97.56) }
      },
      [17] = {
        vehicle = vector4(-2994.22, 705.32, 28.07, 112.78),
        peds = { vector3(-2976.58, 710.99, 28.24), vector3(-2977.32, 708.69, 28.21), vector3(-2997.65, 722.99, 28.5), vector3(-3004.08, 728.59, 28.25),
          vector3(-2987.12, 720.44, 28.5) }
      }
    },
    minRep = 801,
    maxRep = 1500,
    price = { min = 30, max = 45 },
    reward = { min = 44, max = 55 },
    exp = { buyin = 55, payout = 80 },
    hacks = 15,
    dropCops = 0,
    vinCops = 0,
    expireTime = 6,
    vinPrice = 255
  },
  ['S+'] = {
    vehicles = { 'formula','formula2','openwheel1','s80' },
    locations = {
      [1] = {
        vehicle = vector4(-908.99, 189.18, 69.03, 152.77),
        peds = { vector3(-890.35, 178.46, 69.45), vector3(-914.86, 203.77, 69.44), vector3(-912.11, 203.71, 69.61), vector3(-895.33, 175.91, 69.45) }
      },
      [2] = {
        vehicle = vector4(-1461.54, -29.01, 54.22, 52.92),
        peds = { vector3(-1486.65, -22.08, 54.65), vector3(-1488.22, -21.91, 54.65), vector3(-1480.44, -41.33, 56.84), vector3(-1481.88, -40.68, 56.84),
          vector3(-1478.87, -7.77, 55.0), vector3(-1445.16, -41.58, 52.63) }
      },
      [3] = {
        vehicle = vector4(-1585.99, -86.23, 53.91, 90.35),
        peds = { vector3(-1530.9, -95.34, 54.53), vector3(-1531.31, -93.93, 54.53), vector3(-1564.84, -116.14, 54.52), vector3(-1564.78, -116.18, 54.52),
          vector3(-1548.54, -90.81, 54.93), vector3(-1550.18, -90.68, 54.93) }
      },
      [4] = {
        vehicle = vector4(-1590.51, -59.04, 56.06, 91.45),
        peds = { vector3(-1580.55, -34.81, 57.57), vector3(-1580.46, -33.35, 57.57), vector3(-1579.25, -17.35, 56.85), vector3(-1602.48, -45.33, 57.57),
          vector3(-1598.5, -35.93, 58.19), vector3(-1598.69, -33.66, 58.19) }
      },
      [5] = {
        vehicle = vector4(-1504.54, 22.22, 55.89, 1.27),
        peds = { vector3(-1514.9, 23.89, 56.82), vector3(-1516.49, 24.22, 56.82), vector3(-1538.82, 25.41, 56.77), vector3(-1540.03, 24.25, 56.71),
          vector3(-1504.21, 6.29, 56.07), vector3(-1504.76, 4.81, 56.07) }
      },
      [6] = {
        vehicle = vector4(-928.79, 15.74, 47.35, 309.49),
        peds = { vector3(-934.81, 36.95, 53.3), vector3(-933.51, 36.59, 52.37), vector3(-935.17, 4.7, 47.77), vector3(-934.41, 3.31, 47.75), vector3(-930.29, 19.51, 48.53) }
      },
      [7] = {
        vehicle = vector4(-835.58, 116.01, 54.94, 174.01),
        peds = { vector3(-830.39, 115.07, 56.03), vector3(-844.17, 122.79, 55.57), vector3(-819.51, 107.93, 56.65), vector3(-813.18, 110.97, 60.78),
          vector3(-849.63, 112.91, 54.88) }
      },
      [8] = {       -- michaels
        vehicle = vector4(-820.04, 184.05, 71.69, 122.04),
        peds = { vector3(-815.35, 178.45, 72.15), vector3(-815.58, 179.66, 72.15), vector3(-806.58, 184.34, 72.35), vector3(-805.69, 182.98, 72.35),
          vector3(-806.89, 191.26, 72.84), vector3(-801.7, 167.42, 71.66) }
      },
      [9] = {
        vehicle = vector4(-104.49, 824.07, 235.3, 190.43),
        peds = { vector3(-85.61, 834.7, 235.92), vector3(-60.24, 850.75, 235.72), vector3(-59.17, 849.76, 235.72), vector3(-58.34, 863.3, 232.42),
          vector3(-115.43, 831.13, 231.85), vector3(-114.01, 829.26, 231.34) }
      },
      [10] = {
        vehicle = vector4(-123.7, 1007.61, 235.31, 20.15),
        peds = { vector3(-103.21, 1011.7, 235.76), vector3(-102.71, 1010.36, 235.76), vector3(-111.18, 999.51, 235.76), vector3(-113.12, 985.89, 235.75),
          vector3(-104.42, 975.96, 235.76), vector3(-97.52, 988.55, 235.76), vector3(-96.12, 1016.9, 235.75) }
      },
      [11] = {
        vehicle = vector4(-167.52, 919.21, 235.24, 133.56),
        peds = { vector3(-151.52, 910.87, 235.66), vector3(-152.29, 910.33, 235.66), vector3(-136.26, 894.79, 235.65), vector3(-123.56, 905.2, 235.82),
          vector3(-122.66, 895.47, 235.83), vector3(-183.39, 915.3, 233.44) }
      },
      [12] = {
        vehicle = vector4(-1118.18, 297.9, 65.57, 78.92),
        peds = { vector3(-1117.51, 304.52, 66.52), vector3(-1116.33, 304.35, 66.52), vector3(-1127.95, 315.43, 66.18), vector3(-1105.42, 313.02, 66.98),
          vector3(-1104.67, 305.19, 66.21) }
      },
      [13] = {
        vehicle = vector4(-1205.88, 271.7, 69.13, 244.89),
        peds = { vector3(-1202.31, 283.56, 69.93), vector3(-1201.99, 282.14, 69.93), vector3(-1190.77, 292.13, 69.89), vector3(-1189.47, 292.44, 69.89),
          vector3(-1173.22, 300.22, 69.67), vector3(-1207.83, 298.61, 69.68) }
      },
      [14] = {
        vehicle = vector4(-1061.6, 303.38, 65.54, 351.39),
        peds = { vector3(-1047.66, 312.99, 67.01), vector3(-1048.72, 312.72, 67.01), vector3(-1039.16, 311.82, 67.27), vector3(-1037.66, 312.41, 67.27),
          vector3(-1047.2, 295.08, 66.78), vector3(-1052.36, 304.75, 67.01) }
      }
    },
    minRep = 1500,
    maxRep = 9999,
    price = { min = 30, max = 45 },
    reward = { min = 44, max = 55 },
    exp = { buyin = 80, payout = 120 },
    hacks = 20,
    dropCops = 0,
    vinCops = 0,
    expireTime = 6,
    vinPrice = 256
  }
}

Shared.DropOffLocations = { -- You can always add more here :>
  vector3(-424.71, -1686.2, 18.33),
  vector3(-1114.67, -1233.93, 2.05),
  vector3(-1047.61, -1152.34, 1.74),
  vector3(260.32, -1794.73, 26.69),
  vector3(1131.32, -793.54, 57.18),
  vector3(850.92, -951.04, 25.86),
  vector3(730.76, -1323.34, 25.86),
  vector3(-24.54, -1225.57, 28.91),
  vector3(117.57, -1213.16, 28.87),
  vector3(-218.92, -1379.34, 30.84),
  vector3(194.84, -1496.71, 28.72),
  vector3(507.24, -1496.27, 28.87),
  vector3(-441.38, 6341.58, 12.3),
  vector3(2.7, 6469.76, 31.01),
  vector3(-81.2, 6493.89, 31.07),
  vector3(-20.5, 6417.08, 31.01),
  vector3(-198.79, 6273.54, 31.06),
  vector3(92.68, 6358.52, 30.96),
  vector3(1541.08, 6335.67, 23.65),
  vector3(1977.91, 5171.16, 47.22),
  vector3(1669.54, 4973.25, 41.87),
  vector3(1642.96, 4839.38, 41.61),
  vector3(1908.72, 3731.19, 32.07),
  vector3(1833.38, 3919.69, 32.88),
  vector3(1358.52, 3618.34, 34.47),
  vector3(346.16, 3391.64, 35.98),
  vector3(18.47, 3716.92, 39.18),
  vector3(1343.6, 4318.44, 37.58),
  vector3(184.59, 2793.72, 45.22),
  vector3(221.99, 2580.18, 45.4),
  vector3(166.01, 2283.64, 93.01),
  vector3(-114.41, -56.9, 55.95),
  vector3(-368.99, -98.6, 45.24),
  vector3(-461.68, -62.0, 44.09),
  vector3(-357.32, 78.49, 62.88),
  vector3(-487.21, 171.65, 70.51),
  vector3(-446.19, 291.44, 82.81),
  vector3(-560.48, 301.88, 82.75),
  vector3(-753.77, 356.53, 87.44),
  vector3(-1662.42, -384.56, 44.42),
  vector3(253.19, -3059.2, 5.36),
  vector3(344.13, -2684.3, 5.64),
  vector3(1204.27, -3116.46, 5.12),
  vector3(757.04, -3195.09, 5.65),
  vector3(1015.08, -2524.98, 27.88),
  vector3(855.68, -2496.68, 27.9),
  vector3(819.73, -2403.3, 23.24),
  vector3(845.48, -2360.9, 29.92),
  vector3(1090.75, -2404.22, 30.13),
  vector3(1075.73, -2323.9, 29.87),
  vector3(1000.73, -1559.97, 30.34),
  vector3(942.02, -1496.56, 29.66),
  vector3(952.82, -1513.12, 30.68),
  vector3(999.95, -1487.29, 30.92),
  vector3(728.65, -1291.49, 25.86),
  vector3(842.26, -1154.16, 24.81),
  vector3(1263.29, -2564.59, 42.32)
}

Shared.ScratchLocations = {
  -- You can always add more here but make sure to stick to the format :>
  [1] = {   -- Hayes
    coords = vector3(480.78, -1317.12, 28.78),
    laptop = vector4(471.48, -1310.92, 29.26, 119.53)
  },
  [2] = {   -- Paleto
    coords = vector3(111.38, 6625.73, 31.37),
    laptop = vector4(100.69, 6620.21, 32.29, 254.96)
  },
  [3] = {   -- Sandy
    coords = vector3(1174.95, 2640.19, 37.34),
    laptop = vector4(1186.5, 2637.92, 38.26, 21.71)
  }
}

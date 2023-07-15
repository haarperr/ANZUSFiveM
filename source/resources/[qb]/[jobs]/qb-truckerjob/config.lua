Config = {}

Config.UseTarget = true

Config.BailPrice = 250
Config.MaxDrops = 10 -- amount of locations before being forced to return to station to reload

Config.Locations = {
  ['main'] = {
    label = 'Get Paycheck',
    coords = vector3(153.68, -3211.88, 5.91),
    size = vector3(3.0, 3.0, 5.0),
    rotation = 274.5,
    icon = 'fa-solid fa-eye',
    debug = false
  },
  ['vehicle'] = {
    label = 'Truck Storage',
    coords = vector3(141.12, -3204.31, 5.85),
    size = vector3(5.0, 5.0, 5.0),
    rotation = 267.5,
    debug = false
  },
  ['stores'] = {
    [1] = {
      label = 'ltdgasoline',
      coords = vector3(-41.07, -1747.91, 29.4),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 137.5,
      debug = false
    },
    [2] = {
      label = '247supermarket',
      coords = vector3(31.62, -1315.87, 29.52),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 179.5,
      debug = false
    },
    [3] = {
      label = 'robsliquor',
      coords = vector3(-1226.48, -907.58, 12.32),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 119.5,
      debug = false
    },
    [4] = {
      label = 'ltdgasoline2',
      coords = vector3(-714.13, -909.13, 19.21),
      size = vector3(40.0, 40.0, 5.0),
      roation = 0.5,
      debug = false
    },
    [5] = {
      label = 'robsliquor2',
      coords = vector3(-1469.78, -366.72, 40.2),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 138.5,
      debug = false
    },
    [6] = {
      label = 'ltdgasoline3',
      coords = vector3(-1829.15, 791.99, 138.26),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 46.5,
      debug = false
    },
    [7] = {
      label = 'robsliquor3',
      coords = vector3(-2959.92, 396.77, 15.02),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 178.5,
      debug = false
    },
    [8] = {
      label = '247supermarket2',
      coords = vector3(-3047.58, 589.89, 7.78),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 199.5,
      debug = false
    },
    [9] = {
      label = '247supermarket3',
      coords = vector3(-3245.85, 1008.25, 12.83),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 90.5,
      debug = false
    },
    [10] = {
      label = '247supermarket4',
      coords = vector3(1735.54, 6416.28, 35.03),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 332.5,
      debug = false
    },
    [11] = {
      label = '247supermarket5',
      coords = vector3(1702.84, 4917.28, 42.22),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 323.5,
      debug = false
    },
    [12] = {
      label = '247supermarket6',
      coords = vector3(1960.47, 3753.59, 32.26),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 127.5,
      debug = false
    },
    [13] = {
      label = 'robsliquor4',
      coords = vector3(1169.27, 2707.7, 38.15),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 267.5,
      debug = false
    },
    [14] = {
      label = '247supermarket7',
      coords = vector3(543.47, 2658.81, 42.17),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 277.5,
      debug = false
    },
    [15] = {
      label = '247supermarket8',
      coords = vector3(2678.09, 3288.43, 55.24),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 61.5,
      debug = false
    },
    [16] = {
      label = '247supermarket9',
      coords = vector3(2553.0, 399.32, 108.61),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 179.5,
      debug = false
    },
    [17] = {
      label = 'ltdgasoline4',
      coords = vector3(1155.97, -319.76, 69.2),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 17.5,
      debug = false
    },
    [18] = {
      label = 'robsliquor5',
      coords = vector3(1119.78, -983.99, 46.29),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 287.5,
      debug = false
    },
    [19] = {
      label = '247supermarket10',
      coords = vector3(382.13, 326.2, 103.56),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 253.5,
      debug = false
    },
    [20] = {
      label = 'hardware',
      coords = vector3(89.33, -1745.44, 30.08),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 143.5,
      debug = false
    },
    [21] = {
      label = 'hardware2',
      coords = vector3(2704.09, 3457.55, 55.53),
      size = vector3(40.0, 40.0, 5.0),
      rotation = 339.5,
      debug = false
    },
  },
}

Config.Vehicles = {
  rumpo = 'Dumbo Delivery',
}

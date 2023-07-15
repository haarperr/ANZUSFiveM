Config = {}

Config.TreeModels = {
  1380551480,
  80813867,
  -2114297789,
  1827343468,
  1958725070,
  1768206104,
  -1605097644
}

-- 4 seconds
Config.ChopDuration = 4 * 1000

Config.ProcessDuration = 5 * 60 * 1000

Config.Reset = 1 * 60 * 1000

Config.Processer = {
  ped = 0xD7DA9E99,
  coords = vec4(-513.944, 5332.31, 80.262, 282.5),
  items = {
    tree_lumber = {
      required = 1,
      to = {
        item = 'wood_plank',
        amount = 5
      }
    },
    tree_bark = {
      required = 5,
      to = {
        item = 'wood_plank',
        amount = 1
      }
    }
  }
}

Config.Seller = {
  ped = 0xD7DA9E99,
  coords = vec4(259.44, -3059.57, 4.86, 131.34),
  items = {
    wood_plank = {
      min = 3,
      max = 5
    },
    tree_bark = {
      min = 2,
      max = 3
    }
  }
}

-- Items to receive when chopping down a tree
Config.ChopItems = {
  tree_lumber = {
    min = 1,
    max = 2
  },
  tree_bark = {
    min = 1,
    max = 8
  }
}

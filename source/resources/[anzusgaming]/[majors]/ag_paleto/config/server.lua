Config = Config or {}

Config.Inventories = {
  maxItems = 2,
  cabinet = {
    items = {
      rolex = {
        chance = 100,
        min = 1,
        max = 5
      },
      water = {
        chance = 100,
        min = 1,
        max = 5
      },
    },
    id = {}
  }
}

Config.Rewards = {
  maxItems = 2,
  trolly = {
    diamond = {
      item = 'diamond',
      chance = 100,
      min = 35,
      max = 40
    },
  },
  atm = {
    cash = {
      item = 'money',
      chance = 100,
      min = 800,
      max = 1500
    }
  },
  lockbox = {
    watch_3 = {
      item = 'watch_3',
      chance = 30,
      min = 1,
      max = 5
    },
    ring_3 = {
      item = 'ring_3',
      chance = 20,
      min = 1,
      max = 5
    },
    necklace_4 = {
      item = 'necklace_4',
      chance = 15,
      min = 1,
      max = 5
    },
    necklace_5 = {
      item = 'necklace_5',
      chance = 10,
      min = 1,
      max = 5
    },
  }
}

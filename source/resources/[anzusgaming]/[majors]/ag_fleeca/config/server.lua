Config = Config or {}

Config.Rewards = {
  max = 2,
  cashstack = {
    cash = {
      chance = 100,
      min = 6000,
      max = 8000
    },
  },
  lockbox = {
    cash = {
      chance = 100,
      min = 400,
      max = 800
    },
    artgallery_keycard = {
      chance = 25,
      min = 1,
      max = 1
    },
    raspberry_pi = {
      chance = 10,
      min = 1,
      max = 1
    },
    vpn = {
      chance = 15,
      min = 1,
      max = 1,
    }
  },
  trolly = {
    gold = {
      chance = 100,
      min = 4,
      max = 7
    },
  },
}

--- Minutes
Config.Cooldown = 60 * 60 * 1000

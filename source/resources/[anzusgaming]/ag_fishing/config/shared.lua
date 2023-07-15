Config = Config or {}

Config.Keys = {
  "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o"
}

Config.CastTimeMin = 5                           -- Minimum Time in seconds between fishing and minigame
Config.CastTimeMax = 25                           -- Maximum Time in seconds between fishing and minigame

Config.MinigameDifficulties = { 'easy', 'easy' } -- Minigame: Minimum amount of circles

Config.SellLocation = vec4(1348.36, 4317.34, 37.04, 83.71)
Config.SellPed = `s_m_m_migrant_01`

Config.SellPrices = {
  stripedbass = {
    min = 1,
    max = 4
  },
  bluefish = {
    min = 1,
    max = 4
  },
  redfish = {
    min = 1,
    max = 4
  },
  goldfish = {
    min = 45,
    max = 65
  },
  largemouthbass = {
    min = 2,
    max = 5
  },
  salmon = {
    min = 4,
    max = 8
  },
  catfish = {
    min = 2,
    max = 5
  },
  tigershark = {
    min = 5,
    max = 10
  },
  stingray = {
    min = 2,
    max = 4
  },
  killerwhale = {
    min = 50,
    max = 75
  },
  unopenedchest = {
   min = 0,
   max = 10
  },
}

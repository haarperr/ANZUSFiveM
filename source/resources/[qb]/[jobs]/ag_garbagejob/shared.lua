Config = {}
Config.RequireJob = false
Config.UseClothing = false
Config.VehicleSpawn = vector4(-316.34, -1527.81, 26.56, 0)

Config.Bins = {
  -1096777189,
  666561306,
  218085040,
  -1426008804,
  -468629664,
  -206690185,
  1437508529,
}

Config.Zones = {
  { Coords = vector3(-1110.1, -1615.2, 4.36),   Radius = 450.0 },
  { Coords = vector3(-1010.42, -1122.98, 2.11), Radius = 450.0 },
  { Coords = vector3(55.69, -1898.98, 21.67),   Radius = 450.0 },
  { Coords = vector3(287.37, -2007.61, 20.12),  Radius = 450.0 },
  { Coords = vector3(1286.84, -1730.96, 53.03), Radius = 450.0 },
  { Coords = vector3(1105.51, -543.5, 57.47),   Radius = 450.0 },
  { Coords = vector3(-1942.11, 233.89, 84.51),  Radius = 450.0 },
  { Coords = vector3(-359.71, 363.21, 109.68),  Radius = 450.0 },
  { Coords = vector3(402.9, -957.9, 29.45),     Radius = 450.0 },
  { Coords = vector3(-1613.4, -985.66, 13.02),  Radius = 450.0 },
  { Coords = vector3(-863.16, 706.22, 149.19),  Radius = 450.0 },
  { Coords = vector3(364.37, 296.42, 103.48),   Radius = 450.0 },
  { Coords = vector3(-690.19, -962.13, 19.84),  Radius = 450.0 },
}


Config.TrashAmt = math.floor(math.random(10, 20))

Config.Payout = 20

Config.VoucherList = {
  [0] = {
    databasename = 'scrapmetal',
    label = 'Scrap metal',
    amount = 20,
  },
  [1] = {
    databasename = 'plastic',
    label = 'Plastic',
    amount = 20,
  },
  [2] = {
    databasename = 'electronics',
    label = 'Electronics',
    amount = 20,
  },
  [3] = {
    databasename = 'rubber',
    label = 'Rubber',
    amount = 20,
  },
  [4] = {
    databasename = 'steel',
    label = 'Steel',
    amount = 20,
  },
}

Config.Outfits = {
  ["male"] = {
    outfitData = {
      ["pants"] = { item = 43, texture = 2 },        -- Pants
      ["arms"] = { item = 18, texture = 0 },         -- Arms
      ["t-shirt"] = { item = 59, texture = 0 },      -- T Shirt
      ["torso2"] = { item = 75, texture = 2 },       -- Jacket
      ["shoes"] = { item = 32, texture = 0 },        -- Shoes
      ["accessory"] = { item = 0, texture = 0 },     -- Neck Accessory
      ["bag"] = { item = 0, texture = 0 },           -- Bag
      ["hat"] = { item = 142, texture = -1 },        -- Hat
    },
  },
  ["female"] = {
    outfitData = {
      ["pants"] = { item = 43, texture = 2 },        -- Pants
      ["arms"] = { item = 18, texture = 0 },         -- Arms
      ["t-shirt"] = { item = 59, texture = 0 },      -- T Shirt
      ["torso2"] = { item = 75, texture = 2 },       -- Jacket
      ["shoes"] = { item = 32, texture = 0 },        -- Shoes
      ["accessory"] = { item = 0, texture = 0 },     -- Neck Accessory
      ["bag"] = { item = 0, texture = 0 },           -- Bag
      ["hat"] = { item = 142, texture = -1 },        -- Hat
    },
  }
}

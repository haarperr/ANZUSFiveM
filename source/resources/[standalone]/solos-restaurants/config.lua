config = {} --dont touch


---------------------------ESX only-------------------------------------

RegisterNetEvent('solos-openclothingmenu', function() --dont touch this
  OpenESXShopMenu()                                   -- change this to the event that opens your Saved Outfits if using one different than default ESX
end)

-- i.e for illenium-appearance: TriggerEvent("illenium-appearance:client:openClothingShopMenu")
------------------------------------------------------------------------

config.preptime = 10000 -- time in ms to prepare food

config.storages = {
  ['Burger Shot Fridge'] = {
    id = "burgershot_fridge",
    coords = vec3(-1192.25, -898.27, 14.0),
    size = vec3(0.85000000000001, 2.0, 2.4),
    rotation = 213.75,
    debug = false,
    job = 'burgershot',
  },
  ['Burger Shot Hot'] = {
    id = "burgershot_hot",
    coords = vec3(-1187.72, -896.87, 14.55),
    size = vec3(0.85000000000001, 1.55, 1.2),
    rotation = 304.0,
    debug = false,
    job = 'burgershot',
  },
  ['Burger Shot Hot Drive-Thru'] = {
    id = "burgershot_drivethru",
    coords = vec3(-1191.13, -903.75, 14.5),
    size = vec3(0.85000000000001, 1.55, 1.2),
    rotation = 214.0,
    debug = false,
    job = 'burgershot',
  },
  --UWU
  ['UWU Drink Storage'] = {
    id = "uwu_drink",
    coords = vec3(-584.23, -1060.42, 22.25),
    size = vec3(0.5, 1.3, 0.5),
    rotation = 180.0,
    debug = false,
    job = 'uwu',
  },
  ['UWU Food Storage'] = {
    id = "uwu_food",
    coords = vec3(-585.47, -1062.74, 22.35),
    size = vec3(0.5, 1.3, 0.5),
    rotation = 90.0,
    debug = false,
    job = 'uwu',
  },
  ['Uwu Fridge'] = {
    id = "uwu_fridge",
    coords = vector3(-588.1, -1067.99, 22.5),
    size = vector3(2.0, 0.55, 2.45), -- ox_target only
    heading = 35.0,
    debug = false,
    job = 'uwu',
  },
  --atom
  -- ['Atom'] = {
  --     coords = vector3(89.57, 294.14, 110.21),
  --     length = 2.0,
  --     width = 0.5,
  --     size = vector3(2.0, 0.5, 2.0), -- ox_target only
  --     heading = 70.0,
  --     debug = false,
  --     minZ = 108.0,
  --     maxZ = 112.0,
  --     job = 'atom',
  -- },
  -- ['Atom Ready'] = {
  --     coords = vector3(91.63, 288.77, 110.21),
  --     length = 1.5,
  --     width = 0.7,
  --     size = vector3(1.5, 0.7, 2.0), -- ox_target only
  --     heading = 25.0,
  --     debug = false,
  --     minZ = 108.0,
  --     maxZ = 112.0,
  --     job = 'atom',
  -- },
  -- --hornys
  -- ['Hornys'] = {
  --     coords = vector3(1248.87, -351.95, 69.08),
  --     length = 3.0,
  --     width = 0.5,
  --     size = vector3(3.0, 0.5, 2.0), -- ox_target only
  --     heading = 75.0,
  --     debug = false,
  --     minZ = 67.0,
  --     maxZ = 71.0,
  --     job = 'hornys',
  -- },
  -- ['Hornys Ready'] = {
  --     coords = vector3(1251.86, -356.87, 69.08),
  --     length = 1.5,
  --     width = 0.7,
  --     size = vector3(1.5, 0.7, 2.0), -- ox_target only
  --     heading = 75.0,
  --     debug = false,
  --     minZ = 67.0,
  --     maxZ = 71.0,
  --     job = 'hornys',
  -- },
  -- --pearls
  -- ['Pearls'] = {
  --     coords = vector3(-1843.81, -1198.96, 14.31),
  --     length = 3.0,
  --     width = 0.5,
  --     size = vector3(3.0, 0.5, 2.0), -- ox_target only
  --     heading = 330.0,
  --     debug = false,
  --     minZ = 12.0,
  --     maxZ = 17.0,
  --     job = 'pearls',
  -- },
  -- ['Pearls Ready'] = {
  --     coords = vector3(-1838.81, -1192.67, 14.31),
  --     length = 1.5,
  --     width = 0.7,
  --     size = vector3(1.5, 0.7, 2.0), -- ox_target only
  --     heading = 330.0,
  --     debug = false,
  --     minZ = 12.0,
  --     maxZ = 17.0,
  --     job = 'pearls',
  -- },
  --burger shot
  --koi
  -- ['koi'] = {
  --     coords = vector3(-1076.15, -1441.21, -1.42),
  --     length = 2.0,
  --     width = 1.5,
  --     size = vector3(2.0, 1.5, 2.0), -- ox_target only
  --     heading = 35.0,
  --     debug = false,
  --     minZ = -3.0,
  --     maxZ = 2.0,
  --     job = 'koi',
  -- },
}

config.cashregisters = { --cash register prop models

  --------------------------------------------------------------------------------------------------------------------------------
  -- OPTIONS:
  --      name: name for cash register must be unique (players dont see this)
  --      coords: vector3 coords of cash register prop you want to make targetable
  --      job: only players with specified job can use charge/invoice options, set to false if you want everyone to be able to use
  --      receipt: set to true if you want cashier to receive a receipt after each successful transaction, false to disable receipts for this register
  --
  --                  (players can deposit receipts for money at configured locations)
  --                  (players must have a job from config.receiptpayouts [see below] to get paid for receipts)
  --------------------------------------------------------------------------------------------------------------------------------

  --burger shot
  {
    name = "bs1",
    coords = vec3(-1187.6, -893.6, 14.2),
    size = vec3(0.65, 0.55, 0.55),
    rotation = 304.5,
    job = 'burgershot',
    receipt = true
  },
  {
    name = "bs2",
    coords = vec3(-1189.12, -894.59, 14.2),
    size = vec3(0.65, 0.55, 0.55),
    rotation = 304.5,
    job = 'burgershot',
    receipt = true
  },
  {
    name = "bs3",
    coords = vec3(-1190.62, -895.64, 14.2),
    size = vec3(0.65, 0.55, 0.55),
    rotation = 304.5,
    job = 'burgershot',
    receipt = true
  },
  {
    name = "bs4",
    coords = vec3(-1194.91, -905.97, 14.2),
    size = vec3(0.65, 0.55, 0.55),
    rotation = 259,
    job = 'burgershot',
    receipt = true
  },
  -- UWU
  {
    name = "uwu1",
    coords = vec3(-584.06, -1058.69, 22.6),
    size = vec3(0.6, 0.45, 0.5),
    rotation = 180.0,
    job = 'uwu',
    receipt = true
  },
  {
    name = "uwu2",
    coords = vec3(-584.05, -1061.4, 22.55),
    size = vec3(0.4, 0.75, 0.4),
    rotation = 270.5,
    job = 'uwu',
    receipt = true
  },


  --bahamas
  -- {name = "bahamas1", coords = vector3(-1402.86, -602.57, 30.37), job = false, receipt = true}, -- name must be unique!
  -- {name = "bahamas2", coords = vector3(-1376.277, -627.88, 30.81958), job = 'atom', receipt = false},
  --vector4(-1375.843, -628.128, 30.81958, 70.92693)
  --weed shop
  -- {name = "weed1", coords = vector3(-1209.82, -1465.64, 4.35), job = false, receipt = true},
  -- --atom
  -- {name = "atom1", coords = vector3(89.16, 288.83, 110.13), job = 'atom', receipt = true},
  -- {name = "atom2", coords = vector3(89.7, 287.67, 110.13), job = 'atom', receipt = true},
  -- {name = "atom3", coords = vector3(90.42, 286.55, 110.18), job = 'atom', receipt = true},
  -- {name = "atom4", coords = vector3(94.44, 284.62, 110.31), job = 'atom', receipt = true},
  -- --hornys
  -- {name = "hornys1", coords = vector3(1248.12, -358.73, 68.99), job = 'hornys', receipt = true},
  -- {name = "hornys2", coords = vector3(1249.39, -359.08, 68.99), job = 'hornys', receipt = true},
  -- {name = "hornys3", coords = vector3(1250.75, -359.44, 68.99), job = 'hornys', receipt = true},
  -- {name = "hornys4", coords = vector3(1252.9, -357.55, 68.99), job = 'hornys', receipt = true},
  -- --pearls
  -- {name = "pearls1", coords = vector3(-1835.16, -1191.81, 14.33), job = 'pearls', receipt = true},
  -- {name = "pearls2", coords = vector3(-1834.16, -1190.07, 14.33), job = 'pearls', receipt = true},
  -- --pizzeria
  -- {name = "pizza1", coords = vector3(811.27, -750.6, 26.74), job = 'pizzathis', receipt = true},
  -- {name = "pizza2", coords = vector3(811.27, -751.92, 26.74), job = 'pizzathis', receipt = true},
}

config.trays = { -- where customers pick up their food

  --burgershot
  { id = "burgershot_tray_1", name = "BurgerShot1", coords = vec3(-1194.1, -906.25, 14.2),  size = vec3(2.25, 1.05, 0.55), rotation = 259.75 },
  { id = "burgershot_tray_2", name = "BurgerShot2", coords = vec3(-1188.32, -894.07, 14.2), size = vec3(0.55, 1.05, 0.55), rotation = 305.0 },
  { id = "burgershot_tray_3", name = "BurgerShot3", coords = vec3(-1189.78, -895.21, 14.2), size = vec3(0.55, 1.05, 0.55), rotation = 304.5 },
  { id = "burgershot_tray_4", name = "BurgerShot4", coords = vec3(-1191.47, -896.24, 14.2), size = vec3(0.55, 1.05, 0.55), rotation = 304.5 },
  { id = "uwu_tray_1",        name = "Uwu1",        coords = vec3(-583.98, -1062.09, 22.6), size = vec3(0.6, 0.75, 0.5),   rotation = 180.0 },
  { id = "uwu_tray_2",        name = "Uwu2",        coords = vec3(-584.02, -1059.27, 22.6), size = vec3(0.6, 0.75, 0.5),   rotation = 180.0 },


  --UWU


  -- --atom
  --     {name = "atom1", coords = vector3(89.17, 288.15, 110.13)}, -- name must be unique!
  --     {name = "atom2", coords = vector3(89.74, 286.95, 110.13)},
  --     {name = "atom3", coords = vector3(90.27, 285.77, 110.13)},
  -- --hornys
  --     {name = "hornys1", coords = vector3(1248.77, -358.96, 68.99)},
  --     {name = "hornys2", coords = vector3(1250.06, -359.39, 68.99)},
  --     {name = "hornys3", coords = vector3(1251.42, -359.72, 68.99)},
}

config.blips = {
  burgershot = {
    sprite = 106,
    name = 'BurgerShot',
    colour = 1,
    coords = vec3(-1177.71, -904.211, 13.773)
  },
  uwu = {
    sprite = 89,
    name = 'Uwu Cafe',
    colour = 34,
    coords = vec3(-584.699, -1062.139, 22.344)
  },

}

config.locations = {
  --add as many locations as you'd like :) follow the format below

  ['burgershot'] = {          -- name of location
    -- add as many targets as you want for each location, customize the target options, actions, items as you'd like
    ['Prepare Station 1'] = { -- target name (also menu header)
      --target & options:
      coords = vec3(-1188.18, -900.93, 13.95),
      size = vec3(0.70000000000001, 1.45, 0.35000000000001),
      rotation = 214.0,
      debug = false,

      recipes = { 'hearts_burger', 'german_burger', 'chozzo_burger', 'vegan_burger', 'bleeder_burger', 'chicken_burger' }, --recipe must be in config.recipes (see below)

      animdict = "anim@amb@business@coc@coc_unpack_cut@",
      animation = "fullcut_cycle_v5_cokecutter",
      flags = 16,

      job = 'burgershot', --which jobs while be able to see the target option
    },

    ['Prepare Station 2'] = { -- target name (also menu header)
      --target & options:
      coords = vec3(-1186.1, -899.37, 13.95),
      size = vec3(0.70000000000001, 1.45, 0.35000000000001),
      rotation = 214.0,
      debug = false,

      recipes = { 'hearts_burger', 'german_burger', 'chozzo_burger', 'vegan_burger', 'bleeder_burger', 'chicken_burger' }, --recipe must be in config.recipes (see below)

      animdict = "anim@amb@business@coc@coc_unpack_cut@",
      animation = "fullcut_cycle_v5_cokecutter",
      flags = 16,

      job = 'burgershot', --which jobs while be able to see the target option
    },
    ['Stovetop'] = { --cook target
      coords = vec3(-1186.87, -900.56, 13.95),
      size = vec3(0.70000000000001, 1.45, 0.35000000000001),
      rotation = 124.0,
      debug = false,

      recipes = { 'cooked_patty', 'cooked_chicken' },

      scenario = "PROP_HUMAN_BBQ",
      prop = 'prop_fish_slice_01', --spatula prop from scenario above

      job = 'burgershot',
    },
    ['fryer'] = { --cook target
      coords = vec3(-1187.6, -899.64, 14.0),
      size = vec3(0.70000000000001, 1.35, 0.25000000000001),
      rotation = 305.0,
      debug = false,

      recipes = { 'small_fries', 'medium_fries', 'large_fries' },

      animdict = "amb@prop_human_bbq@male@idle_a",
      animation = "idle_b",
      flags = 16,

      job = 'burgershot',
    },
    ['slushie'] = { --cook target
      coords = vec3(-1191.23, -905.46, 14.35),
      size = vec3(0.6, 0.4, 0.85000000000001),
      rotation = 33.0,
      debug = false,

      recipes = { 'blueberry_slushie', 'strawberry_slushie', 'vanilla_milkshake', 'cocaine_milkshake', 'banana_milkshake', 'chocolate_milkshake', 'lingon_milkshake' },

      job = 'burgershot',
    },
  },


  ['uwu'] = {       -- name of location
    -- add as many targets as you want for each location, customize the target options, actions, items as you'd like
    ['prepare'] = { -- target name (also menu header)
      --target & options:
      coords = vec3(-591.05, -1063.05, 22.5),
      size = vec3(0.5, 0.65, 0.5),
      rotation = 0.0,
      debug = false,

      recipes = { 'pink_bubble_tea', 'green_bubble_tea', 'blue_bubble_tea', 'matcha_tea', 'chicken_cucumber_sandwich', 'green_mochi_ice_cream', 'yellow_mochi_ice_cream', 'pink_mochi_ice_cream', 'bento_box', 'strawberry_shortcake', 'blueberry_shortcake' }, 

      animdict = "anim@amb@business@coc@coc_unpack_cut@",
      animation = "fullcut_cycle_v5_cokecutter",
      flags = 16,

      job = 'uwu', --which jobs while be able to see the target option
    },
    ['stove'] = {  --cook target
      coords = vec3(-590.99, -1056.56, 22.55),
      size = vec3(0.5, 1.1, 0.55),
      rotation = 0.0,
      debug = false,

      recipes = { 'vindaloo_curry', 'vegetable_curry' },

      scenario = "PROP_HUMAN_BBQ",
      prop = 'prop_fish_slice_01', --spatula prop from scenario above

      job = 'uwu',
    },
    ['oven'] = { --cook target
      coords = vec3(-590.56, -1059.67, 22.8),
      size = vec3(0.25, 1.15, 1.35),
      rotation = 359.75,
      debug = false,

      recipes = { 'breaded_chicken',  },

      animdict = "amb@prop_human_bbq@male@idle_a",
      animation = "idle_b",
      flags = 16,

      job = 'uwu',
    },
  },

  -- ['hornys'] = { -- name of location
  --     -- add as many targets as you want for each location, customize the target options, actions, items as you'd like
  --     ['prepare'] = { -- target name (also menu header)
  --         --target & options:
  --         coords = vector3(1249.64, -355.7, 69.08),
  --         length = 1.75,
  --         width = 1.20,
  --         size = vector3(1.75, 1.0, 2.0), -- ox_target only
  --         heading = 75.0,
  --         debug = false,
  --         minZ = 67.0,
  --         maxZ = 71.0,

  --         recipes = {'burger', 'double_burger', 'triple_burger'}, --recipe must be in config.recipes (see below)

  --         animdict = "anim@amb@business@coc@coc_unpack_cut@",
  --         animation = "fullcut_cycle_v5_cokecutter",
  --         flags = 16,

  --         job = 'hornys', --which jobs while be able to see the target option
  --     },

  --     ['stove'] = { --cook target
  --         coords = vector3(1253.63, -355.53, 69.08),
  --         length = 1.2,
  --         width = 2.5,
  --         size = vector3(1.2, 2.5, 2.0), -- ox_target only
  --         heading = 75.0,
  --         debug = false,

  --         minZ = 67.0,
  --         maxZ = 71.0,

  --         recipes = {'cooked_patty'},

  --         scenario = "PROP_HUMAN_BBQ",
  --         prop = 'prop_fish_slice_01', --spatula prop from scenario above

  --         job = 'hornys',
  --     },

  --     ['fryer'] = { --cook target
  --         coords = vector3(1254.3, -352.88, 69.08),
  --         length = 1.0,
  --         width = 2.0,
  --         size = vector3(1.0, 2.0, 2.0), -- ox_target only
  --         heading = 75.0,
  --         debug = false,

  --         minZ = 67.0,
  --         maxZ = 71.0,

  --         recipes = {'fries'},

  --         animdict = "amb@prop_human_bbq@male@idle_a",
  --         animation = "idle_b",
  --         flags = 16,

  --         job = 'hornys',
  --     },
  -- },
  -- ['atom'] = { -- name of location
  --     -- add as many targets as you want for each location, customize the target options, actions, items as you'd like
  --     ['prepare'] = { -- target name (also menu header)
  --         --target & options:
  --         coords = vector3(96.95, 293.19, 110.21),
  --         length = 1,
  --         width = 1.5,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 70.0,
  --         debug = false,
  --         minZ = 108.0,
  --         maxZ = 112.0,

  --         recipes = {'burger', 'double_burger', 'triple_burger'}, --recipe must be in config.recipes (see below)

  --         animdict = "anim@amb@business@coc@coc_unpack_cut@",
  --         animation = "fullcut_cycle_v5_cokecutter",
  --         flags = 16,

  --         job = 'atom', --which jobs while be able to see the target option
  --     },

  --     ['stove'] = { --cook target
  --         coords = vector3(93.9, 291.83, 110.21),
  --         length = 1,
  --         width = 1.5,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 70.0,
  --         debug = false,

  --         minZ = 108.0,
  --         maxZ = 112.0,

  --         recipes = {'cooked_patty'},

  --         scenario = "PROP_HUMAN_BBQ",
  --         prop = 'prop_fish_slice_01', --spatula prop from scenario above

  --         job = 'atom',
  --     },

  --     ['fryer'] = { --cook target
  --         coords = vector3(93.09, 292.17, 110.21),
  --         length = 1,
  --         width = 1.5,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 70.0,
  --         debug = false,

  --         minZ = 108.0,
  --         maxZ = 112.0,

  --         recipes = {'fries'},

  --         animdict = "amb@prop_human_bbq@male@idle_a",
  --         animation = "idle_b",
  --         flags = 16,

  --         job = 'atom',
  --     },
  -- },
  -- ['pearls'] = { -- name of location
  --     -- add as many targets as you want for each location, customize the target options, actions, items as you'd like
  --     ['prepare'] = { -- target name (also menu header)
  --         --target & options:
  --         coords = vector3(-1848.13, -1199.26, 14.31),
  --         length = 1,
  --         width = 2.5,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 330.0,
  --         debug = false,
  --         minZ = 12.0,
  --         maxZ = 16.0,

  --         recipes = {'fish_taco', 'sushi'}, --recipe must be in config.recipes (see below)

  --         animdict = "anim@amb@business@coc@coc_unpack_cut@",
  --         animation = "fullcut_cycle_v5_cokecutter",
  --         flags = 16,

  --         job = 'pearls', --which jobs while be able to see the target option
  --     },

  --     ['stove'] = { --cook target
  --         coords = vector3(-1847.22, -1194.03, 14.31),
  --         length = 2.0,
  --         width = 0.75,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 330.0,
  --         debug = false,

  --         minZ = 12.0,
  --         maxZ = 16.0,

  --         recipes = {'cooked_fish'},

  --         scenario = "PROP_HUMAN_BBQ",
  --         prop = 'prop_fish_slice_01', --spatula prop from scenario above

  --         job = 'pearls',
  --     },

  --     ['fryer'] = { --cook target
  --         coords = vector3(-1848.11, -1195.51, 14.31),
  --         length = 1,
  --         width = 1.5,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 60.0,
  --         debug = false,

  --         minZ = 12.0,
  --         maxZ = 16.0,

  --         recipes = {'fish_taco', 'fries'},

  --         animdict = "amb@prop_human_bbq@male@idle_a",
  --         animation = "idle_b",
  --         flags = 16,

  --         job = 'pearls',
  --     },
  -- },
  -- ['koi'] = { -- name of location
  --     -- add as many targets as you want for each location, customize the target options, actions, items as you'd like
  --     ['prepare'] = { -- target name (also menu header)
  --         --target & options:
  --         coords = vector3(-1074.92, -1446.22, -1.42),
  --         length = 1,
  --         width = 1.5,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 35.0,
  --         debug = false,
  --         minZ = -3.0,
  --         maxZ = 2.0,

  --         recipes = {'orange_chicken', 'sushi'}, --recipe must be in config.recipes (see below)

  --         animdict = "anim@amb@business@coc@coc_unpack_cut@",
  --         animation = "fullcut_cycle_v5_cokecutter",
  --         flags = 16,

  --         job = 'koi', --which jobs while be able to see the target option
  --     },

  --     ['stove'] = { --cook target
  --         coords = vector3(-1072.22, -1443.77, -1.42),
  --         length = 1.5,
  --         width = 1.5,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 305.0,
  --         debug = false,

  --         minZ = -3.0,
  --         maxZ = 2.0,

  --         recipes = {'cooked_chicken', 'cooked_fish', 'fried_rice'},

  --         scenario = "PROP_HUMAN_BBQ",
  --         prop = 'prop_fish_slice_01', --spatula prop from scenario above

  --         job = 'koi',
  --     },

  --     ['stove2'] = { --cook target
  --         coords = vector3(-1074.2, -1445.12, -1.42),
  --         length = 1.5,
  --         width = 1.5,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 305.0,
  --         debug = false,

  --         minZ = -3.0,
  --         maxZ = 2.0,

  --         recipes = {'cooked_chicken', 'cooked_fish', 'fried_rice'},

  --         scenario = "PROP_HUMAN_BBQ",
  --         prop = 'prop_fish_slice_01', --spatula prop from scenario above

  --         job = 'koi',
  --     },

  --     ['fryer'] = { --cook target
  --         coords = vector3(-1071.7, -1444.51, -1.42),
  --         length = 1.5,
  --         width = 1.5,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 305.0,
  --         debug = false,

  --         minZ = -3.0,
  --         maxZ = 2.0,

  --         recipes = {'fries'},

  --         animdict = "amb@prop_human_bbq@male@idle_a",
  --         animation = "idle_b",
  --         flags = 16,

  --         job = 'koi',
  --     },
  --     ['fryer2'] = { --cook target
  --         coords = vector3(-1073.56, -1446.11, -1.42),
  --         length = 1.5,
  --         width = 1.5,
  --         size = vector3(1.0, 1.0, 2.0), -- ox_target only
  --         heading = 305.0,
  --         debug = false,

  --         minZ = -3.0,
  --         maxZ = 2.0,

  --         recipes = {'custom_recipe'},

  --         animdict = "amb@prop_human_bbq@male@idle_a",
  --         animation = "idle_b",
  --         flags = 16,

  --         job = 'koi',
  --     },
  -- },
}

config.redeemlocations = {
  -- where players can cash in their receipts
  ['pacific'] = {               --gabz pacific bank
    ped = 's_m_m_fiboffice_02', --set to false if you do not want to spawn a ped at this location (uses boxzone instead)
    coords = vector3(238.721, 221.06, 106.286),
    length = 2.0,
    width = 0.5,
    size = vector3(2.0, 0.5, 2.0), -- ox_target only
    heading = 295.775,             --this will set the direction the ped is facing if ped is set to true above
    debug = false,
    minZ = 108.0,
    maxZ = 112.0,
  },
  -- ['pacific2'] = { --default pacific bank
  --     ped = 's_m_m_fiboffice_02', --set to false if you do not want to spawn a ped at this location (uses boxzone instead)
  --     coords = vector3(241.8873, 226.8703, 106.2871),
  --     length = 2.0,
  --     width = 0.5,
  --     size = vector3(2.0, 0.5, 2.0), -- ox_target only
  --     heading = 160.97,--this will set the direction the ped is facing if ped is set to true above
  --     debug = false,
  --     minZ = 108.0,
  --     maxZ = 112.0,
  -- },
}

config.receiptpayouts = { -- payouts for receipts, money is taken out of job's society account *society accounts can go negative!*
  -- {job = 'atom', payout = 10}, -- (for this example, any 'atom' employee will recieve $10 per receipt when they cash it in)

  { job = 'atom',       payout = 10 },
  { job = 'hornys',     payout = 10 },
  { job = 'burgershot', payout = 10 },
  { job = 'pearls',     payout = 10 },
  { job = 'pizzathis',  payout = 10 },
  { job = 'koi',        payout = 15 },
  { job = 'uwu',        payout = 15 },

  { job = 'bahamas',    payout = 20 },
  { job = 'unicorn',    payout = 20 },

  { job = 'mechanic',   payout = 25 },
}

config.bossmenus = {
  ['BurgerShot'] = {
    coords = vec3(-1199.04, -897.85, 14.0),
    size = vec3(1.05, 0.75, 0.8),
    rotation = 214.0,
    debug = false,

    job = { burgershot = 30 },
  },

  ['Uwu'] = {
    coords = vec3(-577.44, -1066.78, 26.75),
    size = vec3(0.8, 1.15, 0.55),
    rotation = 270.0,
    debug = false,

    job = { uwu = 20 },
  },

  -- ['Hornys'] = {
  --     coords = vector3(1239.29, -348.76, 69.08),
  --     length = 2.5,
  --     width = 1.5,
  --     heading = 345.0,
  --     size = vector3(2.5, 1.5, 2.0), --ox_target only
  --     rotation = 345.0, --ox_target only
  --     debug = false,
  --     minZ = 67.0,
  --     maxZ = 71.0,
  --     job = 'hornys',
  -- },
  -- ['Atom'] = {
  --     coords = vector3(81.31, 297.3, 110.25),
  --     length = 1.5,
  --     width = 2.5,
  --     heading = 340.0,
  --     size = vector3(1.5, 2.5, 2.0), --ox_target only
  --     rotation = 340.0, --ox_target only
  --     debug = false,
  --     minZ = 108.0,
  --     maxZ = 112.0,
  --     job = 'atom',
  -- },
  -- ['Pearls'] = {
  --     coords = vector3(-1840.2, -1183.9, 14.31),
  --     length = 2.5,
  --     width = 1.5,
  --     heading = 60.0,
  --     size = vector3(2.5, 1.5, 2.0), --ox_target only
  --     rotation = 60.0, --ox_target only
  --     debug = false,
  --     minZ = 11.0,
  --     maxZ = 16.0,
  --     job = 'pearls',
  -- },
  -- ['Koi'] = {
  --     coords = vector3(-1054.44, -1440.93, -1.38),
  --     length = 2.0,
  --     width = 1.5,
  --     heading = 0.0,
  --     size = vector3(2.0, 1.5, 2.0), --ox_target only
  --     rotation = 0.0, --ox_target only
  --     debug = false,
  --     minZ = -3.0,
  --     maxZ = 2.0,
  --     job = 'koi',
  -- },
}

config.jobzones = {
  ['Burger Shot'] = {
    ped = 'false', --set to false if you do not want to spawn a ped at this location
    coords = vec3(-1180.59, -892.94, 13.85),
    size = vec3(0.80, 3.3, 2.05),
    rotation = 303.5,
    debug = false,

    job = 'burgershot', --which jobs can access, false means anyone can access
  },

  ['Uwu'] = {
    ped = 'false', --set to false if you do not want to spawn a ped at this location
    coords = vec3(-586.35, -1049.88, 22.0),
    size = vec3(0.4, 2.3, 3.1),
    rotation = 0.0,
    debug = false,

    job = 'burgershot', --which jobs can access, false means anyone can access
  },


  --where employees can clock in/out, change clothes, access lockers
  -- ['atom'] = {
  --     ped = 's_m_m_fiboffice_02', --set to false if you do not want to spawn a ped at this location
  --     coords = vector3(84.33, 295.2, 110.21),
  --     length = 2.0,
  --     width = 0.5,
  --     size = vector3(2.0, 0.5, 3.0), -- ox_target only
  --     heading = 222.85,              --this will set the direction the ped is facing if ped is set to true above
  --     debug = false,
  --     minZ = 108.0,
  --     maxZ = 112.0,
  --     job = true, --which jobs can access, false means anyone can access
  -- },
}

config.recipes = {
  -------------------------------  RECIPE TEMPLATE  ---------------------------------
  -- ['item_name'] = { -- THIS IS THE ITEM THAT WILL BE RECIEVED - must match the item_name in your inventory,
  --     {ingredient = 'item_name', amount = #}, --required item and required amount
  --     {ingredient = 'item_name', amount = #}, --required item and required amount
  --     {ingredient = 'item_name', amount = #}, --required item and required amount
  -- },
  -----------------------------------------------------------------------------------

  -- Burger Shot
  ['hearts_burger'] = { -- must match the item_name in your inventory
    ['label'] = 'Hear Stopper Burger',
    ['ingredients'] = {
      { ingredient = 'lettuce',      amount = 1 },
      { ingredient = 'tomato',       amount = 3 },
      { ingredient = 'cheese',       amount = 3 },
      { ingredient = 'burger_bun',   amount = 1 },
      { ingredient = 'onions',       amount = 2 },
      { ingredient = 'cooked_patty', amount = 3 },
    },
  },
  ['german_burger'] = {
    ['label'] = 'The German Burger',
    ['ingredients'] = {
      { ingredient = 'lettuce',      amount = 3 },
      { ingredient = 'tomato',       amount = 3 },
      { ingredient = 'cheese',       amount = 3 },
      { ingredient = 'burger_bun',   amount = 2 },
      { ingredient = 'onions',       amount = 2 },
      { ingredient = 'cooked_patty', amount = 3 },
    },
  },
  ['chozzo_burger'] = {
    ['label'] = 'The Chozzo Burger',
    ['ingredients'] = {
      { ingredient = 'lettuce',      amount = 1 },
      { ingredient = 'tomato',       amount = 1 },
      { ingredient = 'cheese',       amount = 4 },
      { ingredient = 'burger_bun',   amount = 1 },
      { ingredient = 'cooked_patty', amount = 1 },
    },
  },
  ['vegan_burger'] = {
    ['label'] = 'The Vegan Burger',
    ['ingredients'] = {
      { ingredient = 'lettuce',     amount = 2 },
      { ingredient = 'tomato',      amount = 2 },
      { ingredient = 'burger_bun',  amount = 1 },
      { ingredient = 'vegan_patty', amount = 1 },
    },
  },
  ['bleeder_burger'] = {
    ['label'] = 'Bleeder Burger',
    ['ingredients'] = {
      { ingredient = 'lettuce',      amount = 1 },
      { ingredient = 'tomato',       amount = 1 },
      { ingredient = 'cheese',       amount = 2 },
      { ingredient = 'burger_bun',   amount = 1 },
      { ingredient = 'onions',       amount = 1 },
      { ingredient = 'cooked_patty', amount = 2 },
    },
  },
  ['chicken_burger'] = {
    ['label'] = 'Chicken Burger',
    ['ingredients'] = {
      { ingredient = 'cheese',         amount = 2 },
      { ingredient = 'burger_bun',     amount = 1 },
      { ingredient = 'onions',         amount = 1 },
      { ingredient = 'cooked_chicken', amount = 1 },
    },
  },
  ['vanilla_milkshake'] = {
    ['label'] = 'Vanilla Milkshake',
    ['ingredients'] = {
      { ingredient = 'vanilla_ice_cream', amount = 1 },
      { ingredient = 'milk',              amount = 1 },
    },
  },
  ['cocaine_milkshake'] = {
    ['label'] = 'Cocaine Milkshake',
    ['ingredients'] = {
      { ingredient = 'vanilla_ice_cream', amount = 1 },
      { ingredient = 'milk',              amount = 1 },
      { ingredient = 'flour',             amount = 1 },
    },
  },
  ['banana_milkshake'] = {
    ['label'] = 'Banana Milkshake',
    ['ingredients'] = {
      { ingredient = 'vanilla_ice_cream', amount = 1 },
      { ingredient = 'milk',              amount = 1 },
      { ingredient = 'banana',            amount = 2 },
    },
  },
  ['chocolate_milkshake'] = {
    ['label'] = 'Chocolate Milkshake',
    ['ingredients'] = {
      { ingredient = 'vanilla_ice_cream', amount = 1 },
      { ingredient = 'milk',              amount = 1 },
      { ingredient = 'chocolate_powder',  amount = 2 },
    },
  },
  ['lingon_milkshake'] = {
    ['label'] = 'Lingon Milkshake',
    ['ingredients'] = {
      { ingredient = 'vanilla_ice_cream', amount = 1 },
      { ingredient = 'milk',              amount = 1 },
      { ingredient = 'lingon',            amount = 2 },
    },
  },
  ['blueberry_slushie'] = {
    ['label'] = 'Blueberry Slushie',
    ['ingredients'] = {
      { ingredient = 'slushie_mix_blueberry', amount = 1 },
    },
  },
  ['strawberry_slushie'] = {
    ['label'] = 'Strawberry Slushie',
    ['ingredients'] = {
      { ingredient = 'slushie_mix_strawberry', amount = 1 },
    },
  },
  ['small_fries'] = {
    ['label'] = 'Small Fries',
    ['ingredients'] = {
      { ingredient = 'potato', amount = 1 },
    },
  },
  ['medium_fries'] = {
    ['label'] = 'Medium Fries',
    ['ingredients'] = {
      { ingredient = 'potato', amount = 3 },
    },
  },
  ['large_fries'] = {
    ['label'] = 'Large Fries',
    ['ingredients'] = {
      { ingredient = 'potato', amount = 5 },
    },
  },
  ['cooked_patty'] = {
    ['label'] = 'Cooked Patty',
    ['ingredients'] = {
      { ingredient = 'raw_patty', amount = 1 },
    },
  },
  ['cooked_chicken'] = {
    ['label'] = 'Cooked Chicken Breast',
    ['ingredients'] = {
      { ingredient = 'raw_chicken', amount = 1 },
    },
  },


  -- UWU


  ['pink_bubble_tea'] = {
    ['label'] = 'Pink Bubble Tea',
    ['ingredients'] = {
      { ingredient = 'tapioca_pearls', amount = 1 },
      { ingredient = 'strawberry',     amount = 2 },
      { ingredient = 'milk',           amount = 2 },
    },
  },
  ['green_bubble_tea'] = {
    ['label'] = 'Green Bubble Tea',
    ['ingredients'] = {
      { ingredient = 'tapioca_pearls', amount = 1 },
      { ingredient = 'matcha_powder',  amount = 1 },
      { ingredient = 'milk',           amount = 2 },
    },
  },
  ['blue_bubble_tea'] = {
    ['label'] = 'Blue Bubble Tea',
    ['ingredients'] = {
      { ingredient = 'tapioca_pearls', amount = 1 },
      { ingredient = 'blueberry',      amount = 1 },
      { ingredient = 'milk',           amount = 2 },
    },
  },
  ['matcha_tea'] = {
    ['label'] = 'Matcha Tea Latte',
    ['ingredients'] = {
      { ingredient = 'matcha_powder', amount = 1 },
      { ingredient = 'milk',          amount = 1 },
    },
  },
  ['chicken_cucumber_sandwich'] = {
    ['label'] = 'Chicken & Cucumber Sandwich',
    ['ingredients'] = {
      { ingredient = 'breaded_chicken', amount = 2 },
      { ingredient = 'bread',           amount = 1 },
      { ingredient = 'cucumber',        amount = 1 },
    },
  },
  ['breaded_chicken'] = {
    ['label'] = 'Cooked Breaded Chicken Cutlet',
    ['ingredients'] = {
      { ingredient = 'raw_breaded_chicken', amount = 1 },
    },
  },
  ['green_mochi_ice_cream'] = {
    ['label'] = 'Green Mochi Ice Cream',
    ['ingredients'] = {
      { ingredient = 'vanilla_ice_cream', amount = 1 },
      { ingredient = 'green_mochi',       amount = 2 },
    },
  },
  ['yellow_mochi_ice_cream'] = {
    ['label'] = 'Yellow Mochi Ice Cream',
    ['ingredients'] = {
      { ingredient = 'vanilla_ice_cream', amount = 1 },
      { ingredient = 'yellow_mochi',      amount = 2 },
    },
  },
  ['pink_mochi_ice_cream'] = {
    ['label'] = 'Pink Mochi Ice Cream',
    ['ingredients'] = {
      { ingredient = 'vanilla_ice_cream', amount = 1 },
      { ingredient = 'pink_mochi',        amount = 1 },
    },
  },
  ['bento_box'] = {
    ['label'] = 'Bento Box',
    ['ingredients'] = {
      { ingredient = 'pickled_vegetables', amount = 2 },
      { ingredient = 'rice_ball',          amount = 2 },
      { ingredient = 'boiled_egg',         amount = 1 },
    },
  },
  ['strawberry_shortcake'] = {
    ['label'] = 'Strawberry Shortcake',
    ['ingredients'] = {
      { ingredient = 'strawberry',    amount = 5 },
      { ingredient = 'shortcake_mix', amount = 1 },
    },
  },
  ['blueberry_shortcake'] = {
    ['label'] = 'Blueberry Shortcake',
    ['ingredients'] = {
      { ingredient = 'blueberry',     amount = 5 },
      { ingredient = 'shortcake_mix', amount = 1 },
    },
  },
  ['vindaloo_curry'] = {
    ['label'] = 'Vindaloo Curry',
    ['ingredients'] = {
      { ingredient = 'assort_vegetables', amount = 2 },
      { ingredient = 'curry_powder',      amount = 1 },
      { ingredient = 'herbs_spices',      amount = 1 },
    },
  },
  ['vegetable_curry'] = {
    ['label'] = 'Vegetable Curry',
    ['ingredients'] = {
      { ingredient = 'assort_vegetables', amount = 5 },
      { ingredient = 'curry_powder',      amount = 1 },
    },
  },
  -- seafood
  -- ['fish_taco'] = {
  --   ['label'] = 'Fish Taco',
  --   ['ingredients'] = {
  --     { ingredient = 'tortilla',    amount = 1 },
  --     { ingredient = 'cooked_fish', amount = 1 },
  --     { ingredient = 'lettuce',     amount = 1 },
  --     { ingredient = 'tomato',      amount = 1 },
  --   },
  -- },
  -- ['cooked_fish'] = {
  --   ['label'] = 'Cooked Fish',
  --   ['ingredients'] = {
  --     { ingredient = 'raw_fish', amount = 1 },
  --   },
  -- },

  -- -- asian cuisine
  -- ['orange_chicken'] = {
  --   ['label'] = 'Orange Chicken',
  --   ['ingredients'] = {
  --     { ingredient = 'cooked_chicken', amount = 1 },
  --     { ingredient = 'orange',         amount = 1 },
  --   },
  -- },
  -- ['chicken_fried_rice'] = {
  --   ['label'] = 'Chicken Fried Rice',
  --   ['ingredients'] = {
  --     { ingredient = 'cooked_chicken', amount = 1 },
  --     { ingredient = 'fried_rice',     amount = 1 },
  --   },
  -- },
  -- ['cooked_chicken'] = {
  --   ['label'] = 'Cooked Chicken',
  --   ['ingredients'] = {
  --     { ingredient = 'raw_chicken', amount = 1 },
  --   },
  -- },
  -- ['fried_rice'] = {
  --   ['label'] = 'Fried Rice',
  --   ['ingredients'] = {
  --     { ingredient = 'rice', amount = 1 },
  --     { ingredient = 'egg',  amount = 1 },
  --   },
  -- },
  -- ['sushi'] = {
  --   ['label'] = 'Sushi',
  --   ['ingredients'] = {
  --     { ingredient = 'rice',     amount = 1 },
  --     { ingredient = 'raw_fish', amount = 1 },
  --   },
  -- },


}

config.EatItems = {
  --this is only needed for qb-inventory, makes each of the items below usable and able to be eaten
  --['item_name'] = #, --> # is the amount of hunger it will restore when eaten
  ['burger'] = 15,
  ['double_burger'] = 20,
  ['triple_burger'] = 25,
  ['fries'] = 10,
  ['fried_rice'] = 10,
  ['fish_taco'] = 15,
  ['orange_chicken'] = 15,
  ['sushi'] = 10,
}

config.delivery = {
  burgershot = {
    zone = {
      coords = vec3(-1198.43, -898.49, 14.0),
      size = vec3(0.75, 1.35, 0.8),
      rotation = 35.5,
    },
    pickup = {
      model = `prop_cs_cardbox_01`,
      coords = vec3(999.1873168945312, -1784.2379150390625, 31.47191619873047)
    },
    items = {
      cheese = { price = 3, total = 100, title = 'Cheese' },
      burger_bun = { price = 5, total = 100, title = 'Burger Buns' },
      onions = { price = 3, total = 100, title = 'Onions' },
      raw_chicken = { price = 4, total = 100, title = 'Raw Chicken' },
      raw_patty = { price = 3, total = 100, title = 'Raw Beef Patty' },
      lettuce = { price = 4, total = 100, title = 'Lettuce' },
      tomato = { price = 3, total = 100, title = 'Sliced Tomato' },
      vanilla_ice_cream = { price = 8, total = 100, title = 'Vanilla Ice Cream' },
      milk = { price = 3, total = 100, title = 'Milk' },
      flour = { price = 4, total = 100, title = 'Flour' },
      banana = { price = 3, total = 100, title = 'Bananas' },
      chocolate_powder = { price = 2, total = 100, title = 'Chocolate Powder' },
      lingon = { price = 6, total = 100, title = 'Lingon Berries' },
      slushie_mix_blueberry = { price = 4, total = 100, title = 'Blueberry Slushie Mix' },
      slushie_mix_strawberry = { price = 4, total = 100, title = 'Strawberry Slushie Mix' },
      potato = { price = 3, total = 100, title = 'Sack of Potatos' },
      original_glazed_donut = { price = 15, total = 100, title = 'Original Glazed Donut' },
      pink_glazed_donut = { price = 10, total = 100, title = 'Pink Glazed' },
      plain_donut = { price = 10, total = 100, title = 'Plain Donut' },
      rainbow_donut = { price = 25, total = 100, title = 'Rainbow Donut' },
      ecola_light = { price = 1, total = 100, title = 'ECola Light' },
      sprunk_light = { price = 1, total = 100, title = 'Sprunk Light' },
    }
  },
  uwu = {
    zone = {
      coords = vec3(-575.5, -1065.86, 26.75),
      size = vec3(0.6, 1.1, 0.6),
      rotation = 0.0,
    },
    pickup = {
      model = `prop_cs_cardbox_01`,
      coords = vec3(999.1873168945312, -1784.2379150390625, 31.47191619873047) -- change location
    },
    items = {
      tapioca_pearls = { price = 5, total = 100, title = 'Tapioca Pearls' },
      strawberry = { price = 6, total = 100, title = 'Strawberry' },
      milk = { price = 3, total = 100, title = 'Milk' },
      matcha_powder = { price = 4, total = 100, title = 'Matcha Powder' },
      blueberry = { price = 7, total = 100, title = 'Blueberry' },
      bread = { price = 3, total = 100, title = 'Bread' },
      cucumber = { price = 3, total = 100, title = 'Cucumber' },
      raw_breaded_chicken = { price = 4, total = 100, title = 'Raw Breaded Chicken' },
      vanilla_ice_cream = { price = 8, total = 100, title = 'Vanilla Ice Cream' },
      green_mochi = { price = 5, total = 100, title = 'Green Mochi' },
      yellow_mochi = { price = 5, total = 100, title = 'Yellow Mochi' },
      pink_mochi = { price = 5, total = 100, title = 'Pink Light' },
      pickled_vegetables = { price = 4, total = 100, title = 'Pickled Vegetables' },
      rice_ball = { price = 2, total = 100, title = 'Rice Ball' },
      boiled_egg = { price = 2, total = 100, title = 'Boiled Egg' },
      shortcake_mix = { price = 6, total = 100, title = 'Shortcake Mix' },
      assort_vegetables = { price = 4, total = 100, title = 'Assorted Vegetables' },
      curry_powder = { price = 4, total = 100, title = 'Curry Powder' },
      herbs_spices = { price = 6, total = 100, title = 'Herbs & Spices' },
    }
  },

}

Crafting = {
  Tools = {
    { mechanic_tools = { iron = 1, } },
    { toolbox = { iron = 1, } },
    -- { ducttape = { plastic = 1, } },
    { paintcan = { aluminum = 1, } },
    { tint_supplies = { iron = 1, } },
    { underglow_controller = { iron = 1, } },
    { cleaningkit = { rubber = 1, } },
    { newoil = { plastic = 1, } },
    { sparkplugs = { metalscrap = 1, } },
    { carbattery = { metalscrap = 1, plastic = 1 } },
    { axleparts = { steel = 1, } },
    { sparetire = { rubber = 1, } },

    -- Example : Delete me --
    -- Support for multiple items in recipes --
    -- Support for multiple resulting items --
    -- Support to limit items to certain job roles --
    -- {
    --   cleaningkit = { rubber = 5, engine2 = 1, plastic = 2 },
    --   amount = 2,
    --   job = { mechanic = 4, tuner = 4, }
    -- },
    -- -- Example : Delete me --

  },
  Perform = {
    { enginepart = { iron = 2, aluminum = 2, steel = 3, } },
    { engine1 = { enginepart = 1, } },
    { engine2 = { enginepart = 3, } },
    { engine3 = { enginepart = 5, } },
    { engine4 = { enginepart = 7, } },
    { engine5 = { enginepart = 9, } },
    { transmissionblock = { iron = 2, aluminum = 2, metalscrap =8, } },
    { transmission1 = { transmissionblock = 1, } },
    { transmission2 = { transmissionblock = 3, } },
    { transmission3 = { transmissionblock = 5, } },
    { transmission4 = { transmissionblock = 7, } },
    { brakedisk = { iron = 1, aluminum = 1, metalscrap = 3, } },
    { brakecaliper = { iron = 3, carbon = 2, } },
    { brakes1 = { brakedisk= 2, brakecaliper = 2,} },
    { brakes2 = { brakedisk= 3, brakecaliper = 3,} },
    { brakes3 = { brakedisk= 4, brakecaliper = 4,} },
    { suspensionkit = { iron = 2, aluminum = 2, metalscrap =8, } },
    { suspension1 = { suspensionkit = 1} },
    { suspension2 = { suspensionkit = 3} },
    { suspension3 = { suspensionkit = 5} },
    { suspension4 = { suspensionkit = 7} },
    { suspension5 = { suspensionkit = 9} },
    { drifttires = { rubber = 10} },
    { nos = { noscan = 1, } },
    { noscan = { iron = 10, aluminum = 10, steel =12, copper = 8, rubber = 2 } },
    -- { bprooftires = { rubber = 1, } }, -- Removed as they are OP
  },
  Cosmetic = {
    { hood = { plastic = 1, } },
    { roof = { plastic = 1, } },
    { spoiler = { plastic = 1, } },
    { bumper = { plastic = 1, } },
    { skirts = { plastic = 1, } },
    { exhaust = { iron = 1, } },
    { seat = { plastic = 1, } },
    { livery = { plastic = 1 }, },
    { tires = { rubber = 1, } },
    { horn = { plastic = 1, } },
    { internals = { plastic = 1, } },
    { externals = { plastic = 1, } },
    { customplate = { steel = 1, } },
    { headlights = { plastic = 1, } },
    { rims = { iron = 1, } },
    { rollcage = { steel = 1, } },
    { noscolour = { plastic = 1, } },
  },
}

Stores = {
  ToolItems = {
    label = Loc[Config.Lan].stores.tools,
    items = {
      { name = "mechanic_tools",       price = 0, amount = 10,   info = {}, type = "item", },
      { name = "toolbox",              price = 0, amount = 10,   info = {}, type = "item", },
      { name = "ducttape",             price = 0, amount = 100,  info = {}, type = "item", },
      { name = "paintcan",             price = 0, amount = 50,   info = {}, type = "item", },
      { name = "tint_supplies",        price = 0, amount = 50,   info = {}, type = "item", },
      { name = "underglow_controller", price = 0, amount = 50,   info = {}, type = "item", },
      { name = "cleaningkit",          price = 0, amount = 100,  info = {}, type = "item", },
      { name = "sparetire",            price = 0, amount = 100,  info = {}, type = "item", },
      { name = "axleparts",            price = 0, amount = 1000, info = {}, type = "item", },
      { name = "carbattery",           price = 0, amount = 1000, info = {}, type = "item", },
      { name = "sparkplugs",           price = 0, amount = 1000, info = {}, type = "item", },
      { name = "newoil",               price = 0, amount = 1000, info = {}, type = "item", },
    },
  },
  PerformItems = {
    label = Loc[Config.Lan].stores.perform,
    items = {
      { name = "turbo",         price = 0, amount = 50, info = {}, type = "item", },
      { name = "engine1",       price = 0, amount = 50, info = {}, type = "item", },
      { name = "engine2",       price = 0, amount = 50, info = {}, type = "item", },
      { name = "engine3",       price = 0, amount = 50, info = {}, type = "item", },
      { name = "engine4",       price = 0, amount = 50, info = {}, type = "item", },
      { name = "engine5",       price = 0, amount = 50, info = {}, type = "item", },
      { name = "transmission1", price = 0, amount = 50, info = {}, type = "item", },
      { name = "transmission2", price = 0, amount = 50, info = {}, type = "item", },
      { name = "transmission3", price = 0, amount = 50, info = {}, type = "item", },
      { name = "transmission4", price = 0, amount = 50, info = {}, type = "item", },
      { name = "brakes1",       price = 0, amount = 50, info = {}, type = "item", },
      { name = "brakes2",       price = 0, amount = 50, info = {}, type = "item", },
      { name = "brakes3",       price = 0, amount = 50, info = {}, type = "item", },
      { name = "car_armor",     price = 0, amount = 50, info = {}, type = "item", },
      { name = "suspension1",   price = 0, amount = 50, info = {}, type = "item", },
      { name = "suspension2",   price = 0, amount = 50, info = {}, type = "item", },
      { name = "suspension3",   price = 0, amount = 50, info = {}, type = "item", },
      { name = "suspension4",   price = 0, amount = 50, info = {}, type = "item", },
      { name = "suspension5",   price = 0, amount = 50, info = {}, type = "item", },
      { name = "bprooftires",   price = 0, amount = 50, info = {}, type = "item", },
      { name = "drifttires",    price = 0, amount = 50, info = {}, type = "item", },
      { name = "nos",           price = 0, amount = 50, info = {}, type = "item", },
    },
  },
  StoreItems = {
    label = Loc[Config.Lan].stores.cosmetic,
    items = {
      { name = "hood",        price = 0, amount = 50,  info = {}, type = "item", },
      { name = "roof",        price = 0, amount = 50,  info = {}, type = "item", },
      { name = "spoiler",     price = 0, amount = 50,  info = {}, type = "item", },
      { name = "bumper",      price = 0, amount = 50,  info = {}, type = "item", },
      { name = "skirts",      price = 0, amount = 50,  info = {}, type = "item", },
      { name = "exhaust",     price = 0, amount = 50,  info = {}, type = "item", },
      { name = "seat",        price = 0, amount = 50,  info = {}, type = "item", },
      { name = "livery",      price = 0, amount = 50,  info = {}, type = "item", },
      { name = "tires",       price = 0, amount = 50,  info = {}, type = "item", },
      { name = "horn",        price = 0, amount = 50,  info = {}, type = "item", },
      { name = "internals",   price = 0, amount = 50,  info = {}, type = "item", },
      { name = "externals",   price = 0, amount = 50,  info = {}, type = "item", },
      { name = "customplate", price = 0, amount = 50,  info = {}, type = "item", },
      { name = "headlights",  price = 0, amount = 50,  info = {}, type = "item", },
      { name = "rims",        price = 0, amount = 100, info = {}, type = "item", },
      { name = "rollcage",    price = 0, amount = 50,  info = {}, type = "item", },
      { name = "noscolour",   price = 0, amount = 50,  info = {}, type = "item", },
    },
  },
}

-- No Touch
-- This is corrective code to help simplify the stores for people removing the slot info
-- Jim shops doesn"t use it but other inventories do
-- Most people don"t even edit the slots, these lines generate the slot info autoamtically
Stores.StoreItems.slots = #Stores.StoreItems.items
for k in pairs(Stores.StoreItems.items) do Stores.StoreItems.items[k].slot = k end
Stores.PerformItems.slots = #Stores.PerformItems.items
for k in pairs(Stores.PerformItems.items) do Stores.PerformItems.items[k].slot = k end
Stores.ToolItems.slots = #Stores.ToolItems.items
for k in pairs(Stores.ToolItems.items) do Stores.ToolItems.items[k].slot = k end

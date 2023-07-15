Config = {
  Debug = false,   -- Simple debug mode

  language = 'en', -- The language of the script, currently only english and dutch are supported

  RealEstateJobs = {
    -- job name = minimum grade to access real estate menu,
    realestate = 0,
  },

  PoliceRaid = {
    Enabled = true,
    Jobs = {
      -- job name = minimum grade to breach door,
      lspd = 0,
    },
  },

  PoliceLockdown = {
    DisableEnter = true,              -- Disable entering properties during lockdown
    DisableInventory = true,          -- Disable inventory during lockdown
    DisableGarage = true,             -- Disable garage during lockdown
    DisableKeyManagement = true,      -- Disable key management during lockdown
    DisableInteractablePoints = true, -- Disable interactable points during lockdown
    DisableDoorManagement = true,     -- Disable door management during lockdown
    DisableSellProperty = true,       -- Disable selling properties during lockdown
    DisableFurniture = true,          -- Disable furniture during lockdown
    DisableIplManagement = true,      -- Disable ipl management during lockdown
  },

  --[[ Framework ]]
  InteractOption = "lib.zones", -- The option to use for interacting with the properties, "ox_target" or "lib.zones"
  Garage = "ag_garage",         -- The garage script to use, "qb-garages"
  Inventory = "ox_inventory",   -- The inventory script to use, "qb-inventory" or "esx_inventoryhud"
  Clothes = "qb-clothing",      -- The clothing script to use, "qb-clothing" or "esx_clotheshop"
  Weather = "qb-weathersync",   -- The weather script to use, "qb-weathersync" or "cd_easytime"
  Logs = "ox_lib",              -- The logs script to use, "ox_lib"
  Framework = {
    -- 1 = ESX,
    -- 2 = QBcore,
    -- 3 = Custom Framework
    ---@type 1|2|3
    Active = 2,
  },

  --[[ Properties ]]
  ChoosePropertyName = true,                   -- Allow the player to choose the property name on creation if set to false it will use the default name
  ExitEnterWhileLocked = true,                 -- Allow entering and exiting while locked (if you have a key)
  OpenForPreview = true,                       -- Allow the property to be enter for preview (if you the property is for sale)
  PropertyPrice = { 1, 1000000 },              -- The price of the property, first number is the minimum, second is the maximum.
  SecurityCamFilter = "CAMERA_secuirity_FUZZ", -- The filter for the security cameras (default: "CAMERA_secuirity_FUZZ") https://wiki.rage.mp/index.php?title=Timecycle_Modifiers
  SecurityCamFilterStrength = 0.4,             -- The strength of the filter (default: 0.4)
  SellPercentage = 70,                         -- The percentage of the property price you get back when selling it (default: 70 %)

  -- [[ Ipls ]]
  IplPrice = { 1, 1000000 }, -- The price of the ipl, first number is the minimum, second is the maximum.
  PayedIplChanges = true,    -- Does the player have to pay for IPL changes?


  --[[ Shells ]]
  ShellZLevel = 2000.0,        -- The z level of the shell spawn (default: 5000)
  ShellPrice = { 1, 1000000 }, -- The price of the shell, first number is the minimum, second is the maximum.


  --[[ Mlos ]]
  MloPriceBasedOnArea = true,    -- Should the price be based on the area of the mlo?
  MloInventoryOnCreation = true, -- Allow the player to choose the inventory weight and slots on creation.
  MloInventoryData = {
    Slots = { 1, 100 },          -- The amount of slots the inventory has, first number is the minimum, second is the maximum
    Weight = { 1, 1000000 },     -- The weight of the inventory, first number is the minimum, second is the maximum
  },
  PricePerSquare = { 1, 200 },   -- The price per square meter, first number is the minimum, second is the maximum
  MloPrice = { 1, 1000000 },     -- The price of the mlo, first number is the minimum, second is the maximum (if MloPriceBasedOnArea is false)

  limitFreeCam = true,           -- Limit the freecam to the property area
  limitFreeCamDistance = 100.0,  -- The distance from the property to the freecam limit

  DefaultSlots = 50,             -- The default amount of slots for the inventory
  DefaultWeight = 10000,         -- The default weight for the inventory

  Keybinds = {
    PropertyMenu = "F5", -- The keybind to open the property menu
  },

  InteractDistance = 1.5, -- The distance to interact with the property (ox_target - default: 1.5)
  --[[ Blips ]]
  --[[
        Display Types:
            0 = Doesn't show up, ever, anywhere.
            1 = Doesn't show up, ever, anywhere.
            2 = Shows on both main map and minimap. (Selectable on map)
            3 = Shows on main map only. (Selectable on map)
            4 = Shows on main map only. (Selectable on map)
            5 = Shows on minimap only.
            6 = Shows on both main map and minimap. (Selectable on map)
            7 = Doesn't show up, ever, anywhere.
            8 = Shows on both main map and minimap. (Not selectable on map)
            9 = Shows on minimap only.
            10 = Shows on both main map and minimap. (Not selectable on map)
            Anything higher than 10 seems to be exactly the same as 10.
    ]]
  Blips = {
    -- Properties
    ["IPL"] = {
      Color = 3,
      Sprite = 475,
      Scale = 0.8,
      Category = 11,
      Display = 2,
      ShortRange = false,
      Disabled = false,
    },
    ["Shell"] = {
      Color = 3,
      Sprite = 40,
      Scale = 0.8,
      Category = 11,
      Display = 2,
      ShortRange = false,
      Disabled = false,
    },
    ["MLO"] = {
      Color = 3,
      Sprite = 492,
      Scale = 0.8,
      Category = 11,
      Display = 2,
      ShortRange = false,
      Disabled = false,
    },
    ["Sale"] = {
      Color = 69,
      Sprite = 374,
      Scale = 0.8,
      Category = 10,
      Display = 5,
      ShortRange = true,
      Disabled = true,
    },
    -- Buildings
    ["BuildingOwnedProperty"] = {
      Color = 3,
      Sprite = 475,
      Scale = 0.8,
      Category = 11,
      Display = 2,
      ShortRange = false,
      Disabled = false,
    },
    ["BuildingNoProperties"] = {
      Color = 3,
      Sprite = 475,
      Scale = 0.8,
      Category = 10,
      Display = 5,
      ShortRange = true,
      Disabled = true,
    },
    ["BuildingPorpertiesForSale"] = {
      Color = 69,
      Sprite = 374,
      Scale = 0.8,
      Category = 10,
      Display = 5,
      ShortRange = true,
      Disabled = true,
    }
  },


  -- [[ Custom Functions ]]
  Functions = {
    -- ["OpenRealEstateMenu"] = {
    --     type = "inside", -- inside or outside
    --     maxPerProperty = 1, -- The maximum amount of real estate menu's per property
    --     label = "RealEstate Menu",
    --     icon = "fas fa-house-chimney-user",
    --     onSelect = function(property)
    --         DebugPrint("Open Real Estate Menu for property #" .. property.id)
    --     end
    -- },
  },

  Bell = {
    Event = "InteractSound_CL:PlayOnOne",
    Sound = "doorbell",
    Volume = 0.1,
    Cooldown = 5000
  },

  RaidProperty = function()
    local result = false

    lib.requestAnimDict("missheistfbi3b_ig7")

    local success = lib.skillCheck({ 'easy', 'easy' }, { 'w', 'a', 's', 'd' })
    if success then
      success = lib.progressCircle({
        duration = math.random(10000, 20000),
        label = 'Breaching the door..',
        disable = {
          car = true,
          combat = true,
          move = true
        },
        anim = {
          dict = "missheistfbi3b_ig7",
          clip = 'lift_fibagent_loop'
        }
      })
      if success then
        result = true
      end
    end

    return result
  end,
}

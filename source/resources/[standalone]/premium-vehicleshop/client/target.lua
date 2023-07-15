local ids = {}

--- Setup target zones for the premium vehicle shop
--- @ param none
--- @ return none
local function SetupTargets()
  for i = 1, #Config.Locations do
    local location = Config.Locations[i]

    -- Create a new target
    local id = exports.ox_target:addSphereZone({
      name = name,
      coords = location,
      radius = 1,
      debug = Config.Debug,
      options = {
        {
          name = 'open_premium_vehicleshop_menu',
          icon = 'fa-solid fa-cash-register',
          label = 'Premium Vehicle Shop',
          onSelect = function()
            OpenMenu()
          end
        }
      }
    })

    -- Add the target id to the ids table
    ids[#ids + 1] = id
  end
end

--- Delete the target zones for the premium vehicle shop
--- @ param none
--- @ return none
local function DeleteTargets()
  for i = 1, #ids do exports.ox_target:removeZone(ids[i]) end
  ids = {}
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  SetupTargets()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  DeleteTargets()
end)

-- If debug is enabled, setup targets on resource start
if Config.Debug then
  SetupTargets()
end

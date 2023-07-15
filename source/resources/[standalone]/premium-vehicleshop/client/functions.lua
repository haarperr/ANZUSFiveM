-- Check if the player is close enough to a vehicle shop
local function CheckDistance()
  local playerCoords = GetEntityCoords(PlayerPedId())
  for i = 1, #Config.Locations do
    if #(playerCoords - Config.Locations[i]) <= 5.0 then
      return true
    end
  end
  return false
end


--- Open the premium vehicle shop menu for the player
--- @ param none
--- @ return none
function OpenMenu()
  if not CheckDistance() then return end

  -- Get the user's premium vehicles from the server
  local vehicles = lib.callback.await('premium-vehicleshop:server:getPremiumVehicles', false)
  if not vehicles then return end

  local options = {}

  -- Loop through the vehicles and add them to the context menu
  for i = 1, #vehicles do
    local vehicle = vehicles[i]
    local vehicleData = vehicle.data

    -- Check if the vehicle exists in the server's vehicle list
    if not vehicleData then
      options[#options + 1] = {
        title = "Vehicle Unavaliable",
        description = string.format("This vehicle has not been added to the server yet.\nOnce it is available, you will be able to purchase it.\nVehicle Id: %s.", vehicle.id),
        icon = "times",
        disabled = true
      }
    else
      local vehicleName = vehicleData["name"]

      -- Check if the vehicle has been purchased
      if vehicle.purchased ~= 0 then
        options[#options + 1] = {
          title = vehicleName,
          description = "You've already purchased this vehicle.",
          icon = "times",
          disabled = true
        }
      else
        options[#options + 1] = {
          title = vehicleName,
          description = "Purchase Price: $" .. Config.FormatNumber(vehicleData["price"]),
          icon = "car",
          serverEvent = "premium-vehicleshop:server:purchaseVehicle",
          args = { vehicle = vehicle.id },
          disabled = false
        }
      end
    end
  end

  -- Check if there are no vehicles
  if #options == 0 then
    options[#options + 1] = {
      title = "No Vehicles Avaliable",
      description = "You have not purchased any premium vehicles yet.\nClick to open '" .. Config.TebexLink .. "' in your default browser.",
      onSelect = function()
        SendNUIMessage({ action = "openUrl", url = Config.TebexLink })
      end,
    }
  end

  -- Register the context menu
  lib.registerContext({
    id = 'premium_vehicleshop_menu_vehicles',
    title = 'Avaliable Vehicles',
    menu = 'premium_vehicleshop_menu_vehicles',
    options = options
  })

  -- Show the context menu
  lib.showContext('premium_vehicleshop_menu')
end

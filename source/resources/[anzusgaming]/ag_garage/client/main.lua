lib.locale()

InVehicle = false
Garage = nil
Inside = nil
GarageTypes = nil

local utils = require 'client.utils'

local function setup()
  SetupPublicZones()
  SetupJobZones()
  SetupImpoundZones()
end

AddEventHandler('onClientResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end
  setup()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  setup()
end)

AddStateBagChangeHandler('inVehicle', nil, function(bagName, key, value, _unused, replicated)
  InVehicle = value

  if value and Inside then
    lib.addRadialItem({
      id = 'park_vehicle',
      icon = 'square-parking',
      label = locale('park_vehicle'),
      onSelect = function()
        utils.ParkVehicle(Inside, Garage)
      end
    })
  else
    lib.removeRadialItem('park_vehicle')
  end
end)

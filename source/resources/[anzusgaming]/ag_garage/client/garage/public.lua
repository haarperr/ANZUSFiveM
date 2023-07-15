local utils = require 'client.utils'

---Add open menu on radial
local function OpenGarage()
  local config = Config.Public[Garage]
  local res = lib.callback.await('ag_garage:GetVehiclesAtGarage', 500, { garage = Garage, pool = 'public', type = config.type })

  if not res then return lib.notify({ type = 'error', description = locale('no_vehicles_stored') }) end

  local options = utils.FormatOptions(res, config.parking)

  lib.registerContext({
    id = 'garage_menu',
    title = config.name,
    options = options
  })

  lib.hideRadial()
  lib.showContext('garage_menu')
end

local function onEnter()
  lib.showTextUI('Parking', { position = 'left-center' })

  lib.addRadialItem({
    id = 'garage_access',
    icon = 'warehouse',
    label = locale('garage'),
    onSelect = function()
      OpenGarage()
    end
  })
end

function SetupPublicZones()
  for k, value in pairs(Config.Public) do
    if #value.zone.points == 0 then goto skip end
    lib.zones.poly({
      points = value.zone.points,
      thickness = value.zone.thickness,
      debug = false,
      onEnter = function()
        Inside = 'public'
        Garage = k
        GarageTypes = value.type
        onEnter()

        if cache.vehicle then
          lib.addRadialItem({
            id = 'park_vehicle',
            icon = 'square-parking',
            label = locale('park_vehicle'),
            onSelect = function()
              utils.ParkVehicle(Inside, Garage)
            end
          })
        end
      end,
      onExit = function()
        Inside = nil
        Garage = nil
        GarageTypes = nil
        lib.removeRadialItem('garage_access')
        lib.removeRadialItem('park_vehicle')
        lib.hideTextUI()
      end,
    })
    ::skip::

    if not value.blip then goto skip_blip end
    utils.CreateBlip(value.blip, locale('public_parking'))
    ::skip_blip::
  end
end

local utils = require 'client.utils'

local function ViewImpound()
  local res = lib.callback.await('ag_garage:GetVehiclesAtGarage', 200, { pool = 'impound', garage = 'impound', type = { 'automobile', 'bike' } })

  if not res then return lib.notify({ type = 'info', title = 'Impound Lot', description = locale('no_impounded_vehicles') }) end

  local options = {}
  for i = 1, #res, 1 do
    local vehicle = res[i]
    local data = vehicle.data
    local vClass = GetVehicleClassFromName(vehicle.model)
    local pulloutCost = (Config.PulloutMultiplier[vClass] or 1) * 50
    local storageCost = math.ceil((data.impound.time / 60 / 60 / 24) * 10)
    options[#options + 1] = {
      title = string.format('🚗 %s | %s', data.name, vehicle.plate),
      description = string.format([[Pullout Cost - $%s
Storage Cost - $%s
Total - $%s]], pulloutCost, storageCost, (pulloutCost + storageCost)),
      onSelect = function()
        local rd = lib.callback.await('ag_garage:RetrieveFromImpound', 500, { cost = (pulloutCost + storageCost), id = vehicle.id, lot = Garage })
        if not rd then return end
        lib.notify({ type = 'success', title = 'Impound Lot', description = locale('impound_available') })
      end
    }
  end

  lib.registerContext({
    id = 'impound_menu',
    title = locale('impound_lot'),
    options = options
  })

  lib.hideRadial()
  lib.showContext('impound_menu')
end

local function onEnter()
  lib.showTextUI('Impound', { position = 'left-center' })

  lib.addRadialItem({
    id = 'impound_menu',
    icon = 'garage',
    label = 'Impound Lot',
    onSelect = function()
      ViewImpound()
    end
  })
end

function SetupImpoundZones()
  for k, value in pairs(Config.Impound) do
    lib.zones.poly({
      points = value.zone.points,
      thickness = value.zone.thickness,
      debug = false,
      onEnter = function()
        Garage = k
        onEnter()
      end,
      onExit = function()
        Garage = nil
        lib.removeRadialItem('impound_menu')
        lib.hideTextUI()
      end,
    })

    utils.CreateBlip(value.blip, 'Impound Lot')
  end
end

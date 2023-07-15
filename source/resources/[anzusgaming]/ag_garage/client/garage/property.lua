local utils = require 'client.utils'

---@param id string Property ID
---@param name string Property Name
local function openPropertyGarage(id, name)
  local res = lib.callback.await('ag_garage:GetVehiclesAtGarage', 500, { garage = name .. id, pool = 'property', type = { 'automobile', 'bike' } })
  if not res then return lib.notify({ type = 'warning', description = locale('no_vehicles_stored') }) end

  local coords = GetEntityCoords(cache.ped)
  local heading = GetEntityHeading(cache.ped)

  local options = utils.FormatOptions(res, { vec4(coords.x, coords.y, coords.z, heading) })

  lib.registerContext({
    id = 'garage_menu',
    title = name,
    options = options
  })

  lib.hideRadial()
  lib.showContext('garage_menu')
end

exports('openPropertyGarage', openPropertyGarage)

---@param id string Property ID
---@param name string Property Name
local function parkProperty(id, name)
  local properties = lib.getVehicleProperties(cache.vehicle)
  local class = GetVehicleClass(cache.vehicle)
  if class == 18 then
    return lib.notify({ type = 'error', description = locale('cannot_be_stored_here_class') })
  end

  local res = lib.callback.await('ag_garage:ParkVehicle', 200, { garage = name .. id, properties = properties, type = type })
  if not res then return lib.notify({ type = 'error', description = locale('you_cannot_store') }) end
end

exports('parkProperty', parkProperty)

local utils = require 'client.utils'

utils.entityStateHandler('initVehicle', function(entity, _, value)
  if not value then return end

  -- workaround for server-vehicles that exist in traffic randomly creating peds
  -- https://forum.cfx.re/t/sometimes-an-npc-spawns-inside-an-vehicle-spawned-with-createvehicleserversetter-or-create-automobile/4947251
  for i = -1, 0 do
    local ped = GetPedInVehicleSeat(entity, i)

    if ped ~= cache.ped and ped > 0 and NetworkGetEntityOwner(ped) == cache.playerId then
      DeleteEntity(ped)
    end
  end

  if NetworkGetEntityOwner(entity) ~= cache.playerId then return end

  SetVehicleOnGroundProperly(entity)
  SetVehicleCanLeakPetrol(entity, false)
  SetVehicleCanLeakOil(entity, false)
  Entity(entity).state:set('initVehicle', nil, true)
end)

utils.entityStateHandler('vehicleProperties', function(entity, _, value)
  if not value or NetworkGetEntityOwner(entity) ~= cache.playerId then return end

  lib.setVehicleProperties(entity, value)

  Entity(entity).state:set('vehicleProperties', nil, true)
end)

utils.entityStateHandler('lockStatus', function(entity, _, value)
  if not value or NetworkGetEntityOwner(entity) ~= cache.playerId then return end

  SetVehicleDoorsLocked(entity, value)
  Entity(entity).state:set('lockStatus', nil, true)
end)

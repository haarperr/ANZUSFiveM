AddEventHandler("gameEventTriggered", function(name, args)
  if name == "CEventNetworkVehicleUndrivable" then
    local entity, destoyer, weapon = table.unpack(args)
    local lastVehicle = GetVehiclePedIsIn(cache.ped, true)

    if destoyer == -1 then return end
    if destoyer ~= cache.ped and weapon ~= 0 then return end
    if weapon == 0 and (lastVehicle == 0 and lastVehicle ~= entity) then return end

    local plate = GetVehicleNumberPlateText(entity)

    TriggerServerEvent('ag_misc:server:VehicleDestroyed', { destroyer = destroyer, plate = plate, weapon = weapon, entity = entity })
  elseif name == 'CEventNetworkEntityDamage' then
    local attacker = args[2]
    if cache.ped ~= attacker then return end

    local isfatal = args[6]
    if not isfatal then return end

    local victim = args[1]

    if not IsPedInAnyVehicle(victim, false) then return end
    local vehicle = GetVehiclePedIsIn(victim, false)

    SetVehicleDoorsLocked(vehicle, 1)
  end
end)

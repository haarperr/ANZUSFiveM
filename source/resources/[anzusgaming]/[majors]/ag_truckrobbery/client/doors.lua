local utils = require 'client.utils'

function MakeGuardsAngry(vehicle)
  SetVehicleBrake(vehicle, true)
  local numPeds = GetVehicleNumberOfPassengers(vehicle) -- Get the number of passengers in the vehicle

  for seat = -1, numPeds do
    local ped = GetPedInVehicleSeat(vehicle, seat) -- Get the ped at the specified seat
    if DoesEntityExist(ped) then
      TaskLeaveVehicle(ped, vehicle, 256)
      Wait(140)
      GiveWeaponToPed(ped, `WEAPON_PISTOL`, 420, false, true)
      SetCurrentPedWeapon(ped, `WEAPON_PISTOL`, true)
      SetPedDropsWeaponsWhenDead(ped, false)
      SetPedCombatAttributes(ped, 46, true)
      SetPedAsEnemy(ped, true)
      SetPedAlertness(ped, 3)
      SetPedCombatRange(ped, 1)
      SetPedRelationshipGroupDefaultHash(ped, `SECURITY_GUARD`)
      SetPedRelationshipGroupHash(ped, `SECURITY_GUARD`)
      SetCanAttackFriendly(ped, false, true)
      TaskCombatPed(ped, cache.ped, 0, 16)
    end
  end
end

function BlowDoor(data)
  if utils.isBusy(data.entity) then return end
  utils.setBusy(data.entity, true)

  exports['ps-ui']:Scrambler(function(success)
    if not success then return utils.setBusy(data.entity, false) end
    TriggerEvent('ox_inventory:disarm')
    success = lib.progressCircle({
      label = locale('planting'),
      duration = Config.PlantingTime,
      canCancel = true,
      useWhileDead = false,
      disable = {
        move = true,
        combat = true,
        car = true
      },
      -- anim = {
      --   dict = "anim@heists@ornate_bank@thermal_charge",
      --   clip = "thermal_charge",
      --   flag = 63
      -- }
    })
    if not success then return utils.setBusy(data.entity, false) end
    TriggerServerEvent('ag_truckrobbery:server:removeItem', 'thermite')
    SetVehicleBrake(data.entity, true)

    SetEntityHeading(cache.ped, GetEntityHeading(data.entity))
    lib.requestModel(`prop_c4_final_green`)
    lib.requestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')

    local x, y, z = table.unpack(GetEntityCoords(cache.ped))
    local prop = CreateObject(`prop_c4_final_green`, x, y, z + 0.2, true, true, true)
    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 60309), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
    SetCurrentPedWeapon(cache.ped, `WEAPON_UNARMED`, true)
    FreezeEntityPosition(cache.ped, true)

    TaskPlayAnim(cache.ped, 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8, -1, 63, 0, false, false, false)
    Wait(5500)

    ClearPedTasks(cache.ped)
    DetachEntity(prop, true, false)
    AttachEntityToEntity(prop, data.entity, GetEntityBoneIndexByName(data.entity, 'door_pside_r'), -0.7, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    FreezeEntityPosition(cache.ped, false)
    LocalPlayer.state:set("invBusy", false, true)

    SetVehicleAlarm(data.entity, true)
    local detonateTime = Config.DetonateTime
    SetVehicleAlarmTimeLeft(data.entity, detonateTime)

    exports['ps-dispatch']:VanRobbery()
    local start_time = GetGameTimer()
    local end_time = start_time + detonateTime
    local e = math.floor((end_time - GetGameTimer()) / 1000)
    local guardWakeupTime = (e / 2)

    local remaining = true
    local notified = false
    while remaining do
      local coords = GetEntityCoords(cache.ped)
      if #(GetEntityCoords(data.entity) - coords) > 200 then
        utils.setBusy(data.entity, false)
        return lib.notify({ type = 'error', description = 'Too far away to continue' })
      end

      local remaining_time = math.floor((end_time - GetGameTimer()) / 1000)
      if remaining_time <= 0 then remaining = false end

      if remaining_time == guardWakeupTime + 10 then
        if not notified then
          notified = true
          lib.notify({ type = 'warning', description = locale('guards_ready'), duration = 2500 })
        end
      end
      if remaining_time == guardWakeupTime then MakeGuardsAngry(data.entity) end
      utils.drawTimerBar("Detonation", utils.s2m(remaining_time))
      Wait(0)
    end

    if DoesEntityExist(plantObject) then
      DeleteEntity(plantObject)
      ClearAreaOfObjects(pedCoords.x, pedCoords.y, pedCoords.z, 3, 0)
    end

    local vehicleCoords = GetEntityCoords(data.entity)
    SetVehicleDoorBroken(data.entity, 2, false)
    SetVehicleDoorBroken(data.entity, 3, false)

    AddExplosion(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
    NetworkExplodeVehicle(data.entity, true, false, 0)
    utils.setBusy(data.entity, false)
    utils.setCanTruckBeRobbed(data.entity, true)
  end, Config.Scrambler.type, Config.Scrambler.time, 1)
end

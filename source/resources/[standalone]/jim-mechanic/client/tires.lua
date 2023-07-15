--========================================================== Drift
RegisterNetEvent('jim-mechanic:client:applyDrift', function()
  if GetGameBuildNumber() < 2372 then return end
  if not jobChecks() then return end
  if not locationChecks() then return end
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    local found = false
    for _, v in pairs({ "wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr" }) do
      if #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 1.2 then
        lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
        found = true
        break
      end
    end
    if not found then
      triggerNotify(nil, Loc[Config.Lan]["common"].nearwheel, "error")
      return
    end
    if GetNumVehicleMods(vehicle, 11) == 0 then
      triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
      return
    end
    if GetDriftTyresEnabled(vehicle) ~= false then
      triggerNotify(nil, Loc[Config.Lan]["common"].already, "error")
    else
      SetVehicleEngineOn(vehicle, false, false, true)
      QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["tires"].install, math.random(7000, 10000), false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
        { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
          SetVehicleModKit(vehicle, 0)
          qblog("`drifttires - " .. QBCore.Shared.Items["drifttires"].label .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
          SetVehicleTyreFixed(vehicle, 0)
          SetVehicleTyreFixed(vehicle, 1)
          SetVehicleTyreFixed(vehicle, 2)
          SetVehicleTyreFixed(vehicle, 3)
          SetVehicleTyreFixed(vehicle, 4)
          SetDriftTyresEnabled(vehicle, true)
          emptyHands(PlayerPedId())

          toggleItem(false, "drifttires")
          if GetVehicleTyresCanBurst(vehicle) ~= 1 then
            toggleItem(true, "bprooftires")
            SetVehicleTyresCanBurst(vehicle, true)
            triggerNotify(nil, Loc[Config.Lan]["tires"].swap, "success")
          end
          triggerNotify(nil, Loc[Config.Lan]["tires"].installed, "success")
        end, function() -- Cancel
          triggerNotify(nil, Loc[Config.Lan]["tires"].failed, "error")
          emptyHands(PlayerPedId())
        end, "drifttires")
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:giveDrift', function()
  if GetGameBuildNumber() < 2372 then return end
  if not jobChecks() then return end
  if not locationChecks() then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    local found = false
    for _, v in pairs({ "wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr" }) do
      if #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 1.2 then
        lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
        found = true
        break
      end
    end
    if not found then
      triggerNotify(nil, Loc[Config.Lan]["common"].nearwheel, "error")
      return
    end
    QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["tires"].removing, math.random(7000, 10000), false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        if GetDriftTyresEnabled(vehicle) == false then
          TriggerServerEvent("jim-mechanic:server:DupeWarn", "drifttires")
          emptyHands(playerPed)
          return
        end
        qblog("`drifttires - " .. QBCore.Shared.Items["drifttires"].label .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleTyreFixed(vehicle, 0)
        SetVehicleTyreFixed(vehicle, 1)
        SetVehicleTyreFixed(vehicle, 2)
        SetVehicleTyreFixed(vehicle, 3)
        SetVehicleTyreFixed(vehicle, 4)
        SetDriftTyresEnabled(vehicle, false)
        emptyHands(PlayerPedId())

        toggleItem(true, "drifttires")
        triggerNotify(nil, Loc[Config.Lan]["tires"].remove, "success")
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["tires"].remfail, "error")
        emptyHands(PlayerPedId())
      end, "drifttires")
  end
end)

--========================================================== Bullet Proof
RegisterNetEvent('jim-mechanic:client:applyBulletProof', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    local found = false
    for _, v in pairs({ "wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr" }) do
      if #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 1.2 then
        lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
        found = true
        break
      end
    end
    if not found then
      triggerNotify(nil, Loc[Config.Lan]["common"].nearwheel, "error")
      return
    end
    if GetNumVehicleMods(vehicle, 11) == 0 then
      triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
      return
    end
    if GetVehicleTyresCanBurst(vehicle) == false then
      triggerNotify(nil, Loc[Config.Lan]["common"].already2, "error")
    else
      SetVehicleEngineOn(vehicle, false, false, true)
      time = math.random(7000, 10000)
      QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["tires"].install2, time, false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
        { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
          SetVehicleModKit(vehicle, 0)
          if GetVehicleTyresCanBurst(vehicle) == false then
            TriggerServerEvent("jim-mechanic:server:DupeWarn", "bprooftires")
            emptyHands(playerPed)
            return
          end
          qblog("`bprooftires - " .. QBCore.Shared.Items["bprooftires"].label .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
          SetVehicleTyreFixed(vehicle, 0)
          SetVehicleTyreFixed(vehicle, 1)
          SetVehicleTyreFixed(vehicle, 2)
          SetVehicleTyreFixed(vehicle, 3)
          SetVehicleTyreFixed(vehicle, 4)
          SetVehicleTyresCanBurst(vehicle, false)

          toggleItem(false, "bprooftires")
          if GetDriftTyresEnabled(vehicle) ~= false then
            toggleItem(true, "drifttires")
            SetDriftTyresEnabled(vehicle, false)
            triggerNotify(nil, Loc[Config.Lan]["tires"].swap2, "success")
          end
          triggerNotify(nil, Loc[Config.Lan]["tires"].installed2, "success")
          emptyHands(PlayerPedId())
        end, function() -- Cancel
          triggerNotify(nil, Loc[Config.Lan]["tires"].failed2, "error")
          emptyHands(PlayerPedId())
        end, "bprooftires")
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:giveBulletProof', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    local found = false
    for _, v in pairs({ "wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr" }) do
      if #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 1.2 then
        lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
        found = true
        break
      end
    end
    if not found then
      triggerNotify(nil, Loc[Config.Lan]["common"].nearwheel, "error")
      return
    end
    QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["tires"].removing2, math.random(7000, 9000), false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
      { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        if GetVehicleTyresCanBurst(vehicle) ~= false then
          TriggerServerEvent("jim-mechanic:server:DupeWarn", "bprooftires")
          emptyHands(playerPed)
          return
        end
        qblog("`bprooftires - " .. QBCore.Shared.Items["bprooftires"].label .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleTyreFixed(vehicle, 0)
        SetVehicleTyreFixed(vehicle, 1)
        SetVehicleTyreFixed(vehicle, 2)
        SetVehicleTyreFixed(vehicle, 3)
        SetVehicleTyreFixed(vehicle, 4)
        SetVehicleTyresCanBurst(vehicle, true)

        toggleItem(true, "bprooftires")
        triggerNotify(nil, Loc[Config.Lan]["tires"].remove2, "success")
        emptyHands(PlayerPedId())
      end, function()
        triggerNotify(nil, Loc[Config.Lan]["tires"].remfail, "error")
        emptyHands(PlayerPedId())
      end, "bprooftires")
  end
end)

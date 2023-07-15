--=== AMROUR ===--
RegisterNetEvent('jim-mechanic:client:applyArmour', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
    lookVeh(vehicle)
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    if GetNumVehicleMods(vehicle, 16) == 0 then
      triggerNotify(nil, Loc[Config.Lan]["armour"].cant, "error")
      return
    end
    if GetVehicleMod(vehicle, 16) + 1 == GetNumVehicleMods(vehicle, 16) then
      triggerNotify(nil, Loc[Config.Lan]["common"].already, "error")
    else
      SetVehicleEngineOn(vehicle, false, false, true)
      SetVehicleDoorOpen(vehicle, 4, false, false)
      QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["armour"].install, math.random(7000, 10000), false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
        { animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
          SetVehicleModKit(vehicle, 0)
          if (GetVehicleMod(vehicle, 16) == GetNumVehicleMods(vehicle, 16) - 1) or (not HasItem("car_armor")) then
            TriggerServerEvent("jim-mechanic:server:DupeWarn", "car_armor")
            emptyHands(playerPed)
            return
          end
          qblog("`" .. QBCore.Shared.Items["car_armor"].label .. " - car_armor` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
          SetVehicleMod(vehicle, 16, GetNumVehicleMods(vehicle, 16) - 1)
          SetVehicleDoorShut(vehicle, 4, false)
          emptyHands(PlayerPedId())

          toggleItem(false, "car_armor")
          triggerNotify(nil, Loc[Config.Lan]["armour"].installed, "success")
        end, function() -- Cancel
          triggerNotify(nil, Loc[Config.Lan]["armour"].failed, "success")
          SetVehicleDoorShut(vehicle, 4, false)
          emptyHands(PlayerPedId())
        end, "car_armor")
    end
  end
end)
RegisterNetEvent('jim-mechanic:client:giveArmor', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  SetVehicleDoorOpen(vehicle, 4, false, false)
  QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["armour"].removing, math.random(7000, 10000), false, true,
    { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
    { animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
      SetVehicleModKit(vehicle, 0)
      if (GetVehicleMod(vehicle, 16) == -1) then
        TriggerServerEvent("jim-mechanic:server:DupeWarn", "car armor")
        emptyHands(playerPed)
        return
      end
      qblog("`" .. QBCore.Shared.Items["car_armor"].label .. " - car_armor` removed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
      SetVehicleMod(vehicle, 16, -1)
      SetVehicleDoorShut(vehicle, 4, false)

      toggleItem(true, "car_armor")
      triggerNotify(nil, Loc[Config.Lan]["armour"].removed, "success")
      emptyHands(PlayerPedId())
    end, function()
      triggerNotify(nil, Loc[Config.Lan]["armour"].remfail, "error")
      emptyHands(PlayerPedId())
    end, "car_armor")
end)

--=== BRAKES ===--
RegisterNetEvent('jim-mechanic:client:applyBrakes', function(level)
  if not jobChecks() then return end
  if not locationChecks() then return end
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
  end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if lockedCar(vehicle) then return end
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
    local currentBrakes = GetVehicleMod(vehicle, 12)
    if GetNumVehicleMods(vehicle, 12) == 0 or level > GetNumVehicleMods(vehicle, 12) then
      triggerNotify(nil, Loc[Config.Lan]["brakes"].cant, "error")
      return
    end
    if GetVehicleMod(vehicle, 12) == level then
      triggerNotify(nil, QBCore.Shared.Items["brakes" .. level].label .. " " .. Loc[Config.Lan]["common"].already, "error")
    else
      SetVehicleEngineOn(vehicle, false, false, true)
      QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["common"].installing .. "LVL: " .. level + 1, math.random(7000, 10000), false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
        { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
          SetVehicleModKit(vehicle, 0)
          if (GetVehicleMod(vehicle, 12) ~= currentBrakes) or (not HasItem("brakes" .. (level + 1))) then
            TriggerServerEvent("jim-mechanic:server:DupeWarn", "brakes" .. (currentBrakes + 1))
            emptyHands(playerPed)
            return
          end
          qblog("`" .. QBCore.Shared.Items["brakes" .. level + 1].label .. " - brakes" .. level + 1 .. "` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
          SetVehicleMod(vehicle, 12, level)

          TriggerServerEvent('jim-mechanic:server:swapItem', level, currentBrakes, "brakes")
          triggerNotify(nil, Loc[Config.Lan]["brakes"].installed, "success")
          emptyHands(PlayerPedId())
        end, function() -- Cancel
          triggerNotify(nil, Loc[Config.Lan]["brakes"].failed, "error")
          emptyHands(PlayerPedId())
        end, "brakes" .. level + 1)
    end
  end
end)
RegisterNetEvent('jim-mechanic:client:giveBrakes', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
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
  local currentBrakes = GetVehicleMod(vehicle, 12)
  QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["brakes"].removing, math.random(7000, 10000), false, true,
    { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
    { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
      if (GetVehicleMod(vehicle, 12) ~= currentBrakes) then
        TriggerServerEvent("jim-mechanic:server:DupeWarn", "brakes" .. (currentBrakes + 1))
        emptyHands(playerPed)
        return
      end
      qblog("`" .. QBCore.Shared.Items["brakes" .. currentBrakes + 1].label .. " - brakes" .. currentBrakes + 1 .. "` removed [**" .. trim(GetVehicleNumberPlateText(vehicle)) ..
        "**]")
      SetVehicleMod(vehicle, 12, -1)

      TriggerServerEvent('jim-mechanic:server:swapItem', nil, currentBrakes, "brakes")
      triggerNotify(nil, Loc[Config.Lan]["brakes"].remove, "success")
      emptyHands(PlayerPedId())
    end, function() -- Cancel
      emptyHands(PlayerPedId())
      triggerNotify(nil, Loc[Config.Lan]["brakes"].remfail, "error")
    end, "brakes" .. currentBrakes + 1)
end)

--=== SUSPENSION ===--
RegisterNetEvent('jim-mechanic:client:applySuspension', function(level)
  if not jobChecks() then return end
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
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
      if #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 1.5 then
        lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
        found = true
        break
      end
    end
    if not found then
      triggerNotify(nil, Loc[Config.Lan]["common"].nearwheel, "error")
      return
    end
    local currentSuspension = GetVehicleMod(vehicle, 15)
    if (GetNumVehicleMods(vehicle, 15) == 0 and (level + 1) > GetNumVehicleMods(vehicle, 15)) then
      triggerNotify(nil, Loc[Config.Lan]["suspension"].cant, "error")
      return
    end
    if currentSuspension == level then
      triggerNotify(nil, QBCore.Shared.Items["suspension" .. level + 1].label .. " " .. Loc[Config.Lan]["common"].already, "error")
    else
      SetVehicleEngineOn(vehicle, false, false, true)
      QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. "LVL: " .. level + 1, math.random(7000, 10000), false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
        { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
          SetVehicleModKit(vehicle, 0)
          if (GetVehicleMod(vehicle, 15) ~= currentSuspension) or (not HasItem("suspension" .. level + 1)) then
            TriggerServerEvent("jim-mechanic:server:DupeWarn", "suspension" .. (currentSuspension + 1))
            emptyHands(playerPed)
            return
          end
          qblog("`" .. QBCore.Shared.Items["suspension" .. (level + 1)].label .. " - suspension" .. (level + 1) .. "` installed [**" ..
            trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
          SetVehicleMod(vehicle, 15, level)
          SetVehicleDoorShut(vehicle, 4, false)
          emptyHands(PlayerPedId())

          TriggerServerEvent('jim-mechanic:server:swapItem', level, currentSuspension, "suspension")
          triggerNotify(nil, Loc[Config.Lan]["suspension"].installed, "success")
        end, function()
          triggerNotify(nil, Loc[Config.Lan]["suspension"].failed, "error")
          emptyHands(PlayerPedId())
        end, "suspension" .. level + 1)
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:giveSuspension', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
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
  local currentSuspension = GetVehicleMod(vehicle, 15)
  QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["suspension"].removing, math.random(7000, 10000), false, true,
    { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
    { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
      SetVehicleModKit(vehicle, 0)
      if (GetVehicleMod(vehicle, 15) ~= currentSuspension) then
        TriggerServerEvent("jim-mechanic:server:DupeWarn", "suspension" .. (currentSuspension + 1))
        emptyHands(playerPed)
        return
      end
      qblog("`" ..
        QBCore.Shared.Items["suspension" .. (currentSuspension + 1)].label ..
        " - suspension" .. (currentSuspension + 1) .. "` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
      SetVehicleMod(vehicle, 15, -1)

      TriggerServerEvent('jim-mechanic:server:swapItem', nil, currentSuspension, "suspension")
      triggerNotify(nil, Loc[Config.Lan]["suspension"].removed, "success")
      emptyHands(PlayerPedId())
    end, function() -- Cancel
      triggerNotify(nil, Loc[Config.Lan]["suspension"].remfail, "error")
      emptyHands(PlayerPedId())
    end, "suspension" .. currentSuspension + 1)
end)
--=== TRANSMISSION ===--
RegisterNetEvent('jim-mechanic:client:applyTransmission', function(level)
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
    for _, v in pairs({ "engine" }) do
      if (#(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 2.0) and (GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)) ~= vec3(0, 0, 0)) then
        lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
        found = true
        break
      else
        found = true
      end
    end
    if not found then
      triggerNotify(nil, Loc[Config.Lan]["common"].nearengine, "error")
      return
    end
    local currentTrans = GetVehicleMod(vehicle, 13)
    if (GetNumVehicleMods(vehicle, 13) == 0 or (level + 1) > GetNumVehicleMods(vehicle, 13)) then
      triggerNotify(nil, Loc[Config.Lan]["transmission"].cant, "error")
      return
    end
    if currentTrans == level then
      triggerNotify(nil, QBCore.Shared.Items["transmission" .. level + 1].label .. " " .. Loc[Config.Lan]["common"].already, "error")
    else
      SetVehicleEngineOn(vehicle, false, false, true)
      SetVehicleDoorOpen(vehicle, 4, false, false)
      QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. "LVL: " .. level + 1, math.random(7000, 10000), false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
        { animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
          SetVehicleModKit(vehicle, 0)
          if (GetVehicleMod(vehicle, 13) ~= currentTrans) or (not HasItem("transmission" .. (level + 1))) then
            TriggerServerEvent("jim-mechanic:server:DupeWarn", "transmission" .. (currentTrans + 1))
            emptyHands(playerPed)
            return
          end
          qblog("`" .. QBCore.Shared.Items["transmission" .. (level + 1)].label .. " - transmission" .. (level + 1) ..
            "` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
          SetVehicleMod(vehicle, 13, level)
          SetVehicleDoorShut(vehicle, 4, false)

          TriggerServerEvent('jim-mechanic:server:swapItem', level, currentTrans, "transmission")
          TriggerServerEvent('jim-mechanic:server:removeTransmission', level, currentTrans)
          triggerNotify(nil, Loc[Config.Lan]["transmission"].installed, "success")
          emptyHands(PlayerPedId())
        end, function() -- Cancel
          triggerNotify(nil, Loc[Config.Lan]["transmission"].failed, "error")
          SetVehicleDoorShut(vehicle, 4, false)
          emptyHands(PlayerPedId())
        end, "transmission" .. level + 1)
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:giveTransmission', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  local found = false
  for _, v in pairs({ "engine" }) do
    if (#(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 2.0) and (GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)) ~= vec3(0, 0, 0)) then
      lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
      found = true
      break
    else
      found = true
    end
  end
  if not found then
    triggerNotify(nil, Loc[Config.Lan]["common"].nearengine, "error")
    return
  end
  local currentTrans = GetVehicleMod(vehicle, 13)
  SetVehicleDoorOpen(vehicle, 4, false, false)
  QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["transmission"].removing, math.random(7000, 10000), false, true,
    { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
    { animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
      SetVehicleModKit(vehicle, 0)
      if (GetVehicleMod(vehicle, 13) ~= currentTrans) then
        TriggerServerEvent("jim-mechanic:server:DupeWarn", "transmission" .. (currentTrans + 1))
        emptyHands(playerPed)
        return
      end
      qblog("`" ..
        QBCore.Shared.Items["transmission" .. (currentTrans + 1)].label .. " - transmission" .. (currentTrans + 1) ..
        "` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
      SetVehicleMod(vehicle, 13, -1)
      SetVehicleDoorShut(vehicle, 4, false)

      TriggerServerEvent('jim-mechanic:server:swapItem', nil, currentTrans, "transmission")
      triggerNotify(nil, Loc[Config.Lan]["transmission"].remove, "success")
      emptyHands(PlayerPedId())
    end, function() -- Cancel
      triggerNotify(nil, Loc[Config.Lan]["transmission"].remfail, "error")
      emptyHands(PlayerPedId())
    end, "transmission" .. currentTrans + 1)
end)

--=== TURBO ===--
RegisterNetEvent('jim-mechanic:client:applyTurbo', function()
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
    for _, v in pairs({ "engine" }) do
      if (#(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 2.0) and (GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)) ~= vec3(0, 0, 0)) then
        lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
        found = true
        break
      else
        found = true
      end
    end
    if not found then
      triggerNotify(nil, Loc[Config.Lan]["common"].nearengine, "error")
      return
    end
    if GetNumVehicleMods(vehicle, 11) == 0 then
      triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
      return
    end
    if IsToggleModOn(vehicle, 18) then
      triggerNotify(nil, Loc[Config.Lan]["common"].already, "error")
    else
      SetVehicleEngineOn(vehicle, false, false, true)
      SetVehicleDoorOpen(vehicle, 4, false, false)
      QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["turbo"].install, math.random(7000, 10000), false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
        { animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
          SetVehicleModKit(vehicle, 0)
          if (IsToggleModOn(vehicle, 18)) or (not HasItem("turbo")) then
            TriggerServerEvent("jim-mechanic:server:DupeWarn", "turbo")
            emptyHands(playerPed)
            return
          end
          qblog("`" .. QBCore.Shared.Items["turbo"].label .. " - turbo` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
          ToggleVehicleMod(vehicle, 18, true)
          SetVehicleDoorShut(vehicle, 4, false)
          FreezeEntityPosition(PlayerPedId(), false)

          toggleItem(false, "turbo")
          triggerNotify(nil, Loc[Config.Lan]["turbo"].installed, "success")
          emptyHands(PlayerPedId())
        end, function() -- Cancel
          triggerNotify(nil, Loc[Config.Lan]["turbo"].failed, "error")
          SetVehicleDoorShut(vehicle, 4, false)
          emptyHands(PlayerPedId())
        end, "turbo")
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:giveTurbo', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  local found = false
  for _, v in pairs({ "engine" }) do
    if (#(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 2.0) and (GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)) ~= vec3(0, 0, 0)) then
      lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
      found = true
      break
    else
      found = true
    end
  end
  if not found then
    triggerNotify(nil, Loc[Config.Lan]["common"].nearengine, "error")
    return
  end
  SetVehicleDoorOpen(vehicle, 4, false, false)
  QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["turbo"].removing, math.random(7000, 10000), false, true,
    { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
    { animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
      SetVehicleModKit(vehicle, 0)
      SetVehicleModKit(vehicle, 0)
      if (not IsToggleModOn(vehicle, 18)) then
        TriggerServerEvent("jim-mechanic:server:DupeWarn", "turbo")
        emptyHands(playerPed)
        return
      end
      qblog("`" .. QBCore.Shared.Items["turbo"].label .. " - turbo` removed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
      ToggleVehicleMod(vehicle, 18, false)
      SetVehicleDoorShut(vehicle, 4, false)

      toggleItem(true, "turbo")
      triggerNotify(nil, Loc[Config.Lan]["turbo"].remove, "success")
      emptyHands(PlayerPedId())
    end, function() -- Cancel
      triggerNotify(nil, Loc[Config.Lan]["turbo"].remfail, "error")
      emptyHands(PlayerPedId())
    end, "turbo")
end)

--=== ENGINES ===--
RegisterNetEvent('jim-mechanic:client:applyEngine', function(level)
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
    for _, v in pairs({ "engine" }) do
      if (#(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 2.0) and (GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)) ~= vec3(0, 0, 0)) then
        lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
        found = true
        break
      else
        found = true
      end
    end
    if not found then
      triggerNotify(nil, Loc[Config.Lan]["common"].nearengine, "error")
      return
    end
    local currentEngine = GetVehicleMod(vehicle, 11)
    if (GetNumVehicleMods(vehicle, 11) == 0 or (level + 1) > GetNumVehicleMods(vehicle, 11)) then
      triggerNotify(nil, Loc[Config.Lan]["engines"].cant, "error")
      return
    end
    if GetVehicleMod(vehicle, 11) == level then
      triggerNotify(nil, "LVL: " .. (level + 1) .. Loc[Config.Lan]["common"].already, "error")
    else
      SetVehicleEngineOn(vehicle, false, false, true)
      SetVehicleDoorOpen(vehicle, 4, false, false)
      QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. " LVL: " .. level + 1, math.random(7000, 10000), false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
        { animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
          SetVehicleModKit(vehicle, 0)
          if (GetVehicleMod(vehicle, 11) ~= currentEngine) or (not HasItem("engine" .. (level + 1), 1)) then
            TriggerServerEvent("jim-mechanic:server:DupeWarn", "engine" .. (currentEngine + 1))
            emptyHands(playerPed)
            return
          end
          qblog("`" .. QBCore.Shared.Items["engine" .. (level + 1)].label .. " - engine" .. (level + 1) .. "` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
          SetVehicleMod(vehicle, 11, level)
          SetVehicleDoorShut(vehicle, 4, false)
          emptyHands(PlayerPedId())

          TriggerServerEvent('jim-mechanic:server:swapItem', level, currentEngine, "engine")
          triggerNotify(nil, Loc[Config.Lan]["engines"].installed, "success")
        end, function()
          triggerNotify(nil, Loc[Config.Lan]["engines"].failed, "error")
          SetVehicleDoorShut(vehicle, 4, false)
          emptyHands(PlayerPedId())
        end, "engine" .. level + 1)
    end
  end
end)
RegisterNetEvent('jim-mechanic:client:giveEngine', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  local found = false
  for _, v in pairs({ "engine" }) do
    if (#(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 2.0) and (GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)) ~= vec3(0, 0, 0)) then
      lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
      found = true
      break
    else
      found = true
    end
  end
  if not found then
    triggerNotify(nil, Loc[Config.Lan]["common"].nearengine, "error")
    return
  end
  local currentEngine = GetVehicleMod(vehicle, 11)
  SetVehicleDoorOpen(vehicle, 4, false, false)
  QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["engines"].removing, math.random(7000, 10000), false, true,
    { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
    { animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
      SetVehicleModKit(vehicle, 0)
      if (GetVehicleMod(vehicle, 11) ~= currentEngine) then
        TriggerServerEvent("jim-mechanic:server:DupeWarn", "engine" .. (currentEngine + 1))
        emptyHands(playerPed)
        return
      end
      qblog("`" .. QBCore.Shared.Items["engine" .. (currentEngine + 1)].label .. " - engine" .. (currentEngine + 1) ..
        "` removed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
      SetVehicleMod(vehicle, 11, -1)
      SetVehicleDoorShut(vehicle, 4, false)

      TriggerServerEvent('jim-mechanic:server:swapItem', nil, currentEngine, "engine")
      triggerNotify(nil, Loc[Config.Lan]["engines"].remove, "success")
      emptyHands(PlayerPedId())
    end, function() -- Cancel
      triggerNotify(nil, Loc[Config.Lan]["engines"].remfail, "error")
      emptyHands(PlayerPedId())
    end, "engine" .. currentEngine + 1)
end)

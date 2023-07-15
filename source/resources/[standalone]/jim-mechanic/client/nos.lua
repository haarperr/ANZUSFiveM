--========================================================== NOS
--Leave alone--
local NitrousActivated = false
--local VehicleNitrous = {}
local nosColour = {}
local manualPurgeLoc = {}
local soundId = GetSoundId()
manualPurgeLoc = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  GetNos()
  GetNosColour()
end)

AddEventHandler('onResourceStart', function(resource)
  if GetCurrentResourceName() == resource then
    GetNos()
    GetNosColour()
  end
end)

function GetNos()
  local p = promise.new()
  QBCore.Functions.TriggerCallback('jim-mechanic:GetNosLoaded', function(vehs) p:resolve(vehs) end)
  VehicleNitrous = Citizen.Await(p)
  for plate in pairs(VehicleNitrous) do
    if Config.Debug then
      print("^5Debug^7: ^3VehicleNitrous^7[^6" ..
        tostring(plate) .. "^7] = { ^2level^7: ^4" .. tonumber(VehicleNitrous[plate].level) .. "^7, ^2hasnitro^7: ^4" .. tostring(VehicleNitrous[plate].hasnitro) .. "^7 }")
    end
  end
end

function GetNosColour()
  local p = promise.new()
  QBCore.Functions.TriggerCallback('jim-mechanic:GetNosColour', function(vehs) p:resolve(vehs) end)
  nosColour = Citizen.Await(p)
  for plate in pairs(nosColour) do
    if Config.Debug then
      print("^5Debug^7: ^3nosColour^7[^6" ..
        tostring(plate) .. "^7] = { ^2RBG^7: ^4" .. nosColour[plate][1] .. "^7, ^4" .. nosColour[plate][2] .. "^7, ^4" .. nosColour[plate][3] .. " ^7}")
    end
  end
end

RegisterNetEvent('jim-mechanic:client:applyNOS', function()
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  --if not jobChecks() then return end --uncomment this line to make nos mechanic only
  --if not locationChecks() then return end
  if not inCar() then return end
  if not nearPoint(coords) then return end
  if not IsPedInAnyVehicle(playerPed, false) then
    vehicle = getClosest(coords)
    pushVehicle(vehicle)
  end
  if lockedCar(vehicle) then return end
  if DoesEntityExist(vehicle) then
    if not IsToggleModOn(vehicle, 18) then
      triggerNotify(nil, Loc[Config.Lan]["nos"].notinstalled, "error")
      return
    end
    for _, v in pairs({ "engine" }) do
      if #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 2.5 then
        lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
        found = true
        break
      end
    end
    SetVehicleEngineOn(vehicle, false, false, true)
    TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
    Wait(1000)
    playAnim("mini@repair", "fixing_a_ped", 35000, 16)
    SetVehicleDoorOpen(vehicle, 4, false, false)
    if Config.skillcheck == "qb-lock" then
      local time = math.random(7000, 10000)
      playAnim("mini@repair", "fixing_a_ped", time, 16)
      local success = exports['qb-lock']:StartLockPickCircle(math.random(2, 4), math.random(7, 10), success)
      if success then
        QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. "NOS..", time, false, true,
          { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
          { animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
            SetVehicleModKit(vehicle, 0)
            ClearPedTasks(playerPed)
            if VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))] then toggleItem(true, "noscan") end
            TriggerServerEvent('jim-mechanic:server:LoadNitrous', trim(GetVehicleNumberPlateText(vehicle)))
            SetVehicleDoorShut(vehicle, 4, false)

            toggleItem(false, "nos")
            triggerNotify(nil, Loc[Config.Lan]["nos"].installed, "success")
          end, function() -- Cancel
            triggerNotify(nil, Loc[Config.Lan]["nos"].failed, "error")
            SetVehicleDoorShut(vehicle, 4, false)
            emptyHands(playerPed)
          end, "nos")
      else
        triggerNotify(nil, Loc[Config.Lan]["nos"].failed, "error")
        SetVehicleDoorShut(vehicle, 4, false)
        emptyHands(playerPed)
        if Config.explosiveFail then
          local chance = math.random(1, 10)
          if not Config.explosiveFailJob then
            if not jobChecks() then
              if chance == 10 then
                SetVehicleDoorBroken(vehicle, 4, 0) -- Rip Hood off
                Wait(100)
                AddExplosion(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.6, 1.0), 2, 0.8, 1, 0, 1.0, true)
              end
            end
          elseif Config.explosiveFailJob then
            if chance == 10 then
              SetVehicleDoorBroken(vehicle, 4, 0) -- Rip Hood off
              Wait(100)
              AddExplosion(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.6, 1.0), 2, 0.8, 1, 0, 1.0, true)
            end
          end
        end
      end
    elseif Config.skillcheck == "ps-ui" then
      exports['ps-ui']:Circle(function(success)
        local time = math.random(7000, 10000)
        if success then
          QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. "NOS..", time, false, true,
            { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
            { animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
              SetVehicleModKit(vehicle, 0)
              ClearPedTasks(playerPed)
              if VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))] then toggleItem(true, "noscan") end
              TriggerServerEvent('jim-mechanic:server:LoadNitrous', trim(GetVehicleNumberPlateText(vehicle)))
              SetVehicleDoorShut(vehicle, 4, false)

              toggleItem(false, "nos")
              triggerNotify(nil, Loc[Config.Lan]["nos"].installed, "success")
            end, function() -- Cancel
              triggerNotify(nil, Loc[Config.Lan]["nos"].failed, "error")
              SetVehicleDoorShut(vehicle, 4, false)
              emptyHands(playerPed)
            end, "nos")
        else
          triggerNotify(nil, Loc[Config.Lan]["nos"].failed, "error")
          SetVehicleDoorShut(vehicle, 4, false)
          emptyHands(playerPed)
          if Config.explosiveFail then
            local chance = math.random(1, 10)
            if not Config.explosiveFailJob then
              if not jobChecks() then
                if chance == 10 then
                  SetVehicleDoorBroken(vehicle, 4, 0) -- Rip Hood off
                  Wait(100)
                  AddExplosion(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.6, 1.0), 2, 0.8, 1, 0, 1.0, true)
                end
              end
            elseif Config.explosiveFailJob then
              if chance == 10 then
                SetVehicleDoorBroken(vehicle, 4, 0) -- Rip Hood off
                Wait(100)
                AddExplosion(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.6, 1.0), 2, 0.8, 1, 0, 1.0, true)
              end
            end
          end
        end
      end, 2, 20)
    elseif Config.skillcheck == "qb-skillbar" then
      local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
      Skillbar.Start({ duration = math.random(2500, 5000), pos = math.random(10, 30), width = math.random(10, 20), },
        function() -- On success
          triggerNotify(nil, Loc[Config.Lan]["nos"].installing, "success")
          playAnim("mini@repair", "fixing_a_ped", time, 16)
          QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. "NOS..", math.random(7000, 10000), false, true,
            { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
            { animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
              SetVehicleModKit(vehicle, 0)
              ClearPedTasks(playerPed)
              qblog("`nos - " .. QBCore.Shared.Items["nos"].label .. "` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
              if VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))] then toggleItem(true, "noscan") end
              TriggerServerEvent('jim-mechanic:server:LoadNitrous', trim(GetVehicleNumberPlateText(vehicle)))
              SetVehicleDoorShut(vehicle, 4, false)
              toggleItem(false, "nos")
              triggerNotify(nil, Loc[Config.Lan]["nos"].installed, "success")
            end, function() -- Cancel
              triggerNotify(nil, Loc[Config.Lan]["nos"].failed, "error")
              SetVehicleDoorShut(vehicle, 4, false)
              ClearPedTasks(playerPed)
            end, "nos")
        end, function() -- On fail
          triggerNotify(nil, Loc[Config.Lan]["nos"].failed, "error")
          SetVehicleDoorShut(vehicle, 4, false)
          ClearPedTasks(playerPed)
          if Config.explosiveFail then
            local chance = math.random(1, 10)
            if not Config.explosiveFailJob then
              if not jobChecks() then
                if chance == 10 then
                  SetVehicleDoorBroken(vehicle, 4, 0) -- Rip Hood off
                  Wait(100)
                  AddExplosion(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.6, 1.0), 2, 0.8, 1, 0, 1.0, true)
                end
              end
            elseif Config.explosiveFailJob then
              if chance == 10 then
                SetVehicleDoorBroken(vehicle, 4, 0) -- Rip Hood off
                Wait(100)
                AddExplosion(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.6, 1.0), 2, 0.8, 1, 0, 1.0, true)
              end
            end
          end
        end)
    else
      triggerNotify(nil, Loc[Config.Lan]["nos"].installing, "success")
      playAnim("mini@repair", "fixing_a_ped", time, 16)
      QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. "NOS..", math.random(7000, 10000), false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
        { animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
          SetVehicleModKit(vehicle, 0)
          ClearPedTasks(playerPed)
          qblog("`nos - " .. QBCore.Shared.Items["nos"].label .. "` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
          if VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))] then toggleItem(true, "noscan") end
          TriggerServerEvent('jim-mechanic:server:LoadNitrous', trim(GetVehicleNumberPlateText(vehicle)))
          SetVehicleDoorShut(vehicle, 4, false)
          toggleItem(false, "nos")
          triggerNotify(nil, Loc[Config.Lan]["nos"].installed, "success")
        end, function() -- Cancel
          triggerNotify(nil, Loc[Config.Lan]["nos"].failed, "error")
          SetVehicleDoorShut(vehicle, 4, false)
          ClearPedTasks(playerPed)
        end, "nos")
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:UpdateNitroLevel', function(Plate, level) VehicleNitrous[Plate] = { hasnitro = true, level = level } end)

RegisterNetEvent('jim-mechanic:client:LoadNitrous', function(Plate)
  if not LocalPlayer.state.isLoggedIn then return end
  VehicleNitrous[Plate] = { hasnitro = true, level = 100, }
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  local CurrentVehicle = getClosest(coords)
  pushVehicle(vehicle)
  local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
  if CPlate == Plate then TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false) end
end)

RegisterNetEvent('jim-mechanic:client:UnloadNitrous', function(Plate)
  if not LocalPlayer.state.isLoggedIn then return end
  VehicleNitrous[Plate] = nil
  local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
  local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
  if CPlate == Plate then
    NitrousActivated = false
    TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
  end
end)

local boosting = false
local forceStop = false
local damageTimer = 0
local CurrentVehicle
local Plate

RegisterKeyMapping('levelUP', 'Boost/Purge lvl Up', 'keyboard', 'PRIOR')
RegisterCommand('levelUP', function()
  local Plate = trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())))
  if VehicleNitrous[Plate] and VehicleNitrous[Plate].hasnitro and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
    if purgemode and purgeSize < 1.0 then
      purgeSize = purgeSize + 0.1
      if purgeSize >= 1.0 then purgeSize = 1.0 end
      if purgeSize > 0.1 then
        if not ShowOdo then triggerNotify(nil, Loc[Config.Lan]["nos"].spray .. math.floor(purgeSize * 10)) end
      end
    end
    if not purgemode and boostLevel < 3 and not NitrousActivated then
      boostLevel = boostLevel + 1
      if boostLevel > 3 then boostLevel = 3 end
      if boostLevel <= 3 then
        if not ShowOdo then triggerNotify(nil, Loc[Config.Lan]["nos"].boost .. boostLevel) end
      end
    end
  end
end)
RegisterKeyMapping('levelDown', 'Boost/Purge lvl Down', 'keyboard', 'NEXT')
RegisterCommand('levelDown', function()
  local Plate = trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())))
  if VehicleNitrous[Plate] and VehicleNitrous[Plate].hasnitro and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
    if purgemode and purgeSize > 0.1 then
      purgeSize = purgeSize - 0.1
      if purgeSize < 0.1 then purgeSize = 0.1 end
      if purgeSize > 0.1 then
        if not ShowOdo then triggerNotify(nil, Loc[Config.Lan]["nos"].spray .. math.floor(purgeSize * 10)) end
      end
    end
    if not purgemode and boostLevel > 1 and not NitrousActivated then
      boostLevel = boostLevel - 1
      if boostLevel < 1 then boostLevel = 1 end
      if not ShowOdo then triggerNotify(nil, Loc[Config.Lan]["nos"].boost .. boostLevel) end
    end
  end
end)
RegisterKeyMapping('nosSwitch', 'Boost/Purge Switch', 'keyboard', 'LCONTROL')
RegisterCommand('nosSwitch', function()
  local Plate = trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())))
  if VehicleNitrous[Plate] and VehicleNitrous[Plate].hasnitro and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
    if purgemode then
      purgemode = false
      if not ShowOdo then triggerNotify(nil, Loc[Config.Lan]["nos"].boostmode, "success") end
    else
      purgemode = true
      if not ShowOdo then triggerNotify(nil, Loc[Config.Lan]["nos"].purgemode, "success") end
    end
  end
end)


RegisterKeyMapping('+nosBoost', 'Boost', 'keyboard', 'LSHIFT')
RegisterCommand('+nosBoost', function()
  CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
  if IsPedInAnyVehicle(PlayerPedId()) then
    Plate = trim(GetVehicleNumberPlateText(CurrentVehicle))
    if VehicleNitrous[Plate] and VehicleNitrous[Plate].hasnitro and (GetVehicleWheelieState(CurrentVehicle) ~= 129 and GetVehicleWheelieState(CurrentVehicle) ~= 65 and not IsEntityInAir(CurrentVehicle)) and GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPedId() then
      TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
      forceStop = true
      if purgemode then
        TriggerServerEvent('jim-mechanic:server:SyncPurge', VehToNet(CurrentVehicle), true, purgeSize)
        CreateThread(function()
          while boosting do
            purgeCool = purgeCool + 1
            Wait(500)
          end
        end)
      end
      if not purgemode then
        if (GetEntitySpeed(CurrentVehicle) * 3.6) > 25.0 and not boosting then
          boosting = true
          ModifyVehicleTopSpeed(CurrentVehicle, (Config.NosTopSpeed or -1.0))
          ApplyForceToEntity(CurrentVehicle, 3, 0, Config.NosBoostPower[boostLevel], 0, 0.0, -1.2, 0.0, 0, true, true, true, false, true)
          NitrousActivated = true
          if Config.EnableScreen then SetNitroBoostScreenEffectsEnabled(true) end
          if Config.EnableTrails then TriggerServerEvent('jim-mechanic:server:SyncTrail', VehToNet(CurrentVehicle), true) end
          SetVehicleBoostActive(CurrentVehicle, 1)
          -- Boosting Effects
          CreateThread(function()
            while NitrousActivated do
              if VehicleNitrous[Plate].level - 1 >= 0 then
                local nitrousUseRate = Config.NitrousUseRate
                if boostLevel == 1 then nitrousUseRate = nitrousUseRate - (Config.NitrousUseRate / 2) end
                if boostLevel == 3 then nitrousUseRate = nitrousUseRate + (Config.NitrousUseRate / 2) end
                if Config.EnableFlame then TriggerServerEvent('jim-mechanic:server:SyncFlame', VehToNet(CurrentVehicle), true) end
                TriggerServerEvent('jim-mechanic:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - nitrousUseRate))
                TriggerEvent("jim-mechanic:client:NosUpdateDelay", Plate, (VehicleNitrous[Plate].level - nitrousUseRate))
                TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, true)
              elseif VehicleNitrous[Plate].level - 1 <= 0 then
                TriggerServerEvent('jim-mechanic:server:UnloadNitrous', Plate)
                toggleItem(true, "noscan")
                if Config.EnableScreen then SetNitroBoostScreenEffectsEnabled(false) end
                if Config.EnableTrails then TriggerServerEvent('jim-mechanic:server:SyncTrail', VehToNet(CurrentVehicle), false) end
                NitrousActivated = false
                boosting = not boosting
                SetVehicleBoostActive(CurrentVehicle, 0)
                if Config.EnableFlame then TriggerServerEvent('jim-mechanic:server:SyncFlame', VehToNet(CurrentVehicle), false) end
                ModifyVehicleTopSpeed(CurrentVehicle, -1.0)
              end
              Wait(100)
            end
          end)
          CreateThread(function()
            while NitrousActivated do
              damageTimer = damageTimer + 1
              local engDamage = math.random(14, 19)
              local dmgFctr = (math.random(20, 50) / 10)
              if damageTimer > 7 then
                CreateThread(function()
                  RequestAmbientAudioBank("DLC_sum20_Open_Wheel_Racing_Sounds", 0)
                  PlaySoundFromEntity(soundId, "tyre_health_warning", CurrentVehicle, "DLC_sum20_Open_Wheel_Racing_Sounds", 1, 0)
                  Wait(1000)
                  StopSound(soundId)
                end)
                if boostLevel == 1 then
                  engDamage = math.random(0, 13)
                  dmgFctr = (math.random(10, 20) / 10)
                elseif boostLevel == 3 then
                  engDamage = math.random(19, 25)
                  dmgFctr = (math.random(40, 70) / 10)
                end
                SetVehicleEngineHealth(CurrentVehicle, (GetVehicleEngineHealth(CurrentVehicle) - engDamage))
                if useMechJob() then
                  local DamageComponents = { "radiator", "fuel", }
                  local randomComponent = DamageComponents[math.random(1, #DamageComponents)]
                  local randomDamage = (math.random() + math.random(0, 1)) * dmgFctr
                  exports['qb-mechanicjob']:SetVehicleStatus(QBCore.Functions.GetPlate(CurrentVehicle), randomComponent,
                    exports['qb-mechanicjob']:GetVehicleStatus(QBCore.Functions.GetPlate(CurrentVehicle), randomComponent) - randomDamage)
                end
              end
              if damageTimer >= 14 and boostLevel == 3 and Config.boostExplode then
                forceStop = true
                AddExplosion(GetOffsetFromEntityInWorldCoords(CurrentVehicle, 0.0, 1.6, 1.0), 23, 0.8, 1, 0, 1.0, true)
                TriggerServerEvent('jim-mechanic:server:UnloadNitrous', Plate)
                if Config.EnableScreen then SetNitroBoostScreenEffectsEnabled(false) end
                if Config.EnableTrails then TriggerServerEvent('jim-mechanic:server:SyncTrail', VehToNet(CurrentVehicle), false) end
                NitrousActivated = false
                boosting = not boosting
                SetVehicleBoostActive(CurrentVehicle, 0)
                if Config.EnableFlame then TriggerServerEvent('jim-mechanic:server:SyncFlame', VehToNet(CurrentVehicle), false) end
                ModifyVehicleTopSpeed(CurrentVehicle, -1.0)
                damageTimer = 14
              end
              Wait(1000)
            end
          end)
        end
      end
    end
  else
    if forceStop then -- This will make sure it doesn't break boosting in any car the person leaves. Clears the effects once and waits till you boost in another car
      forceStop = false
      if nosupdated then nosupdated = false end
      SetVehicleBoostActive(GetVehiclePedIsIn(PlayerPedId(), true), 0)
      TriggerServerEvent('jim-mechanic:server:SyncPurge', VehToNet(GetVehiclePedIsIn(PlayerPedId(), true)), false)
      if Config.EnableFlame then TriggerServerEvent('jim-mechanic:server:SyncFlame', VehToNet(GetVehiclePedIsIn(PlayerPedId(), true)), false) end
      if Config.EnableTrails then TriggerServerEvent('jim-mechanic:server:SyncTrail', VehToNet(GetVehiclePedIsIn(PlayerPedId(), true)), false) end
      if Config.EnableScreen then SetNitroBoostScreenEffectsEnabled(false) end

      ModifyVehicleTopSpeed(GetVehiclePedIsIn(PlayerPedId(), true), -1.0)

      if VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)))] then
        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)))].hasnitro,
          VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)))].level, false)
      else
        TriggerEvent('hud:client:UpdateNitrous', false, 0, false)
      end
      NitrousActivated = false
      boostLevel = 1
      damageTimer = 0
      purgeCool = 0
      boosting = false
      CurrentVehicle = nil
      Plate = nil
      Wait(1500)
      StopSound(soundId)
    end
  end
end)
RegisterCommand('-nosBoost', function()
  if not IsPedInAnyVehicle(PlayerPedId()) then return end
  if tonumber(CurrentVehicle) == 0 or DoesEntityExist(CurrentVehicle) == false then return end
  TriggerServerEvent('jim-mechanic:server:SyncPurge', VehToNet(CurrentVehicle), false)
  if NitrousActivated then
    StopSound(soundId)
    SetVehicleBoostActive(CurrentVehicle, 0)
    if Config.EnableFlame then TriggerServerEvent('jim-mechanic:server:SyncFlame', VehToNet(CurrentVehicle), false) end
    ModifyVehicleTopSpeed(CurrentVehicle, -1.0)
    TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro, VehicleNitrous[Plate].level, false)
    NitrousActivated = not NitrousActivated
    if Config.EnableTrails then TriggerServerEvent('jim-mechanic:server:SyncTrail', VehToNet(CurrentVehicle), false) end
    if Config.EnableScreen then SetNitroBoostScreenEffectsEnabled(false) end
    if VehicleNitrous[Plate] then
      CreateThread(function()
        while boosting do
          Wait(1000)
          purgeCool = purgeCool + 1
          if purgeCool >= Config.NitrousCoolDown then
            if Config.CooldownConfirm and boosting then
              RequestAmbientAudioBank("dlc_xm_heists_fm_uc_sounds", 0)
              PlaySoundFromEntity(soundId, "download_complete", GetVehiclePedIsIn(PlayerPedId()), "dlc_xm_heists_fm_uc_sounds", 1, 0)
              Wait(200)
            end
            purgeCool = 0
            damageTimer = 0
            boosting = false
          end
        end
      end)
    end
    CurrentVehicle = nil
    Plate = nil
  end
end)

--For testing Purge locations
--[[CreateThread(function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	--while true do
		if DoesEntityExist(vehicle) then
		--SetVehicleNitroPurgeEnabled(vehicle, true)
		--Wait(1000)
		--SetVehicleNitroPurgeEnabled(vehicle, false)
		--Wait(1000)
	--end
end)]]
--Purge Effects
local vehiclePurge = {}
local vehicleTrails = {}

RegisterNetEvent('jim-mechanic:client:SyncPurge', function(netid, enabled, size)
  if not LocalPlayer.state.isLoggedIn then return end
  if not NetworkDoesEntityExistWithNetworkId(netid) then return end
  if #(GetEntityCoords(NetToVeh(netid)) - GetEntityCoords(PlayerPedId())) >= 200 then return end
  if DoesEntityExist(NetToVeh(netid)) then SetVehicleNitroPurgeEnabled(NetToVeh(netid), enabled, size) end
end)

function SetVehicleNitroPurgeEnabled(vehicle, enabled, size)
  local bonnet = nil
  if enabled and DoesEntityExist(vehicle) then
    RequestAmbientAudioBank("CARWASH_SOUNDS", 0)
    PlaySoundFromEntity(soundId, "SPRAY", vehicle, "CARWASH_SOUNDS", 1, 0)
    local off = GetOffsetFromEntityGivenWorldCoords(vehicle, GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'engine')))
    local ptfxs = {}
    local manFound = false
    for i = 0, 3 do
      if IsThisModelABike(GetEntityModel(vehicle)) then
        ptfxs[#ptfxs + 1] = CreateVehiclePurgeSpray(vehicle, off.x - 0.1, off.y - 0.2, off.z, 40.0, -90.0, 70.0, size) -- Left
        ptfxs[#ptfxs + 1] = CreateVehiclePurgeSpray(vehicle, off.x + 0.1, off.y - 0.2, off.z, 40.0, 90.0, -70.0, size) --Right
      else
        for k in pairs(manualPurgeLoc) do
          if GetEntityModel(vehicle) == k then
            manFound = true
            for _, v in pairs(manualPurgeLoc[k]) do
              ptfxs[#ptfxs + 1] = CreateVehiclePurgeSpray(vehicle, off.x + v[1], off.y + v[2], off.z + v[3], v[4], v[5], v[6], size)
            end
          end
        end
        if not manFound then
          off = GetOffsetFromEntityGivenWorldCoords(vehicle, GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'bonnet')))
          ptfxs[#ptfxs + 1] = CreateVehiclePurgeSpray(vehicle, off.x - 0.2, off.y + 0.5, off.z, 40.0, -20.0, 0.0, size)
          ptfxs[#ptfxs + 1] = CreateVehiclePurgeSpray(vehicle, off.x + 0.2, off.y + 0.5, off.z, 40.0, 20.0, 0.0, size)
        end
      end
      if nosColour[trim(GetVehicleNumberPlateText(vehicle))] then
        for i = 1, #ptfxs do
          SetParticleFxLoopedColour(ptfxs[i],
            nosColour[trim(GetVehicleNumberPlateText(vehicle))][1] / 255,
            nosColour[trim(GetVehicleNumberPlateText(vehicle))][2] / 255,
            nosColour[trim(GetVehicleNumberPlateText(vehicle))][3] / 255)
        end
      else
        for i = 1, #ptfxs do
          SetParticleFxLoopedColour(ptfxs[i],
            255 / 255,
            255 / 255,
            255 / 255)
        end
      end
    end
    vehiclePurge[vehicle] = ptfxs
  else
    StopSound(soundId)
    if vehiclePurge[vehicle] and #vehiclePurge[vehicle] > 0 then
      for _, v in ipairs(vehiclePurge[vehicle]) do
        StopParticleFxLooped(v)
      end
    end
    vehiclePurge[vehicle] = nil
  end
end

function CreateVehiclePurgeSpray(vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
  if not LocalPlayer.state.isLoggedIn then return end
  if DoesEntityExist(vehicle) then
    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('ent_sht_steam', vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, 0, 0, 0)
  end
end

-- Trails
RegisterNetEvent('jim-mechanic:client:SyncTrail', function(netid, enabled)
  if not LocalPlayer.state.isLoggedIn then return end
  if not NetworkDoesEntityExistWithNetworkId(netid) then return end
  if DoesEntityExist(NetToVeh(netid)) then
    if #(GetEntityCoords(NetToVeh(netid)) - GetEntityCoords(PlayerPedId())) >= 200 then return end
    SetVehicleLightTrailEnabled(NetToVeh(netid), enabled)
  end
end)

function SetVehicleLightTrailEnabled(vehicle, enabled)
  if enabled then
    vehicleTrails[vehicle] = {
      CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_l"), 1.0),
      CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_r"), 1.0), }
  else
    if vehicleTrails[vehicle] and #vehicleTrails[vehicle] > 0 then
      for _, particleId in ipairs(vehicleTrails[vehicle]) do StopVehicleLightTrail(particleId, 500) end
    end
    vehicleTrails[vehicle] = nil
  end
end

function CreateVehicleLightTrail(vehicle, bone, scale)
  if DoesEntityExist(vehicle) then
    UseParticleFxAssetNextCall('core')
    local ptfx = StartParticleFxLoopedOnEntityBone('veh_light_red_trail', vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone, scale, false, false, false)
    SetParticleFxLoopedEvolution(ptfx, "speed", 1.0, false)
    return ptfx
  end
end

function StopVehicleLightTrail(ptfx, duration)
  Citizen.CreateThread(function()
    local startTime = GetGameTimer()
    local endTime = GetGameTimer() + duration
    while GetGameTimer() < endTime do
      Wait(0)
      local now = GetGameTimer()
      local scale = (endTime - now) / duration
      SetParticleFxLoopedScale(ptfx, scale)
      SetParticleFxLoopedAlpha(ptfx, scale)
    end
    StopParticleFxLooped(ptfx)
  end)
end

RegisterNetEvent('jim-mechanic:client:SyncFlame', function(netid, enable)
  if not LocalPlayer.state.isLoggedIn then return end
  if not NetworkDoesEntityExistWithNetworkId(netid) then return end
  if #(GetEntityCoords(NetToVeh(netid)) - GetEntityCoords(PlayerPedId())) >= 200 then return end
  if enable and DoesEntityExist(NetToVeh(netid)) then
    if boostLevel == 1 then CreateVehicleExhaustBackfire(NetToVeh(netid)) end
    if boostLevel == 2 then
      loadPtfxDict("veh_xs_vehicle_mods")
      SetVehicleNitroEnabled(NetToVeh(netid), true)
    end
    if boostLevel == 3 then
      loadPtfxDict("veh_xs_vehicle_mods")
      SetVehicleNitroEnabled(NetToVeh(netid), true)
      Wait(10)
      SetVehicleBoostActive(NetToVeh(netid), 1)
    end
  else
    SetVehicleNitroEnabled(NetToVeh(netid), false)
    SetVehicleBoostActive(NetToVeh(netid), 0)
    ModifyVehicleTopSpeed(NetToVeh(netid), -1.0)
  end
end)
--Exhaust Fires
function CreateVehicleExhaustBackfire(vehicle)
  local exhaustNames = { "exhaust", }
  for i = 2, 16 do exhaustNames[#exhaustNames + 1] = "exhaust_" .. i end
  loadPtfxDict("core")
  for _, exhaustName in ipairs(exhaustNames) do
    local boneIndex = GetEntityBoneIndexByName(vehicle, exhaustName)
    if boneIndex ~= -1 then
      SetPtfxAssetNextCall("core")
      UseParticleFxAssetNextCall("core")
      StartParticleFxNonLoopedOnEntity("veh_backfire", vehicle, GetOffsetFromEntityGivenWorldCoords(vehicle, GetWorldPositionOfEntityBone(vehicle, boneIndex)), 0.0, 0.0, 0.0, 1.25,
        false, false, false)
    end
  end
end

function SetNitroBoostScreenEffectsEnabled(enabled)
  if enabled then
    StopScreenEffect('RaceTurbo')
    StartScreenEffect('RaceTurbo', 0, false)
    SetTimecycleModifier('rply_motionblur')
    ShakeGameplayCam('SKY_DIVING_SHAKE', 0.25)
  else
    StopGameplayCamShaking(true)
    SetTransitionTimecycleModifier('default', 0.35)
  end
end

-- Mechanic Remove NOS
RegisterNetEvent('jim-mechanic:client:giveNOS', function()
  if not jobChecks() then return end
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  local vehicle = getClosest(coords)
  pushVehicle(vehicle)
  if lockedCar(vehicle) then return end
  TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
  Wait(1000)
  SetVehicleDoorOpen(vehicle, 4, false, false)
  playAnim("mini@repair", "fixing_a_ped", 8000, 16)
  QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["nos"].removing, math.random(7000, 10000), false, true,
    { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
    { animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
      SetVehicleDoorShut(vehicle, 4, false)

      TriggerServerEvent('jim-mechanic:server:UnloadNitrous', trim(GetVehicleNumberPlateText(vehicle)))
      TriggerServerEvent('jim-mechanic:server:giveNOS')
      emptyHands(playerPed)
      triggerNotify(nil, Loc[Config.Lan]["nos"].removed, "success")
    end, function()
      triggerNotify(nil, Loc[Config.Lan]["nos"].remfail, "error")
      emptyHands(playerPed)
    end)
end)

RegisterNetEvent('jim-mechanic:client:ChangeColour', function(Plate, newColour)
  if not LocalPlayer.state.isLoggedIn then return end
  nosColour[Plate] = newColour
  if Config.Debug then
    print("^5Debug^7: ^2Recieving new ^3nosColour^7[^6" ..
      tostring(Plate) .. "^7] = { ^2RBG: ^7= ^6" .. nosColour[Plate][1] .. "^7, ^6" .. nosColour[Plate][2] .. "^7, ^6" .. nosColour[Plate][3] .. " ^7}")
  end
end)

RegisterNetEvent('jim-mechanic:client:NOS:RGBApply', function(data)
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local vehicle = getClosest(coords)
  if not DoesEntityExist(vehicle) then return end
  TaskTurnPedToFaceEntity(ped, vehicle, 1000)
  Wait(1000)
  SetVehicleDoorOpen(vehicle, 4, false, false)
  playAnim("mini@repair", "fixing_a_ped", 8000, 16)
  loadPtfxDict("scr_recartheft")
  UseParticleFxAssetNextCall("scr_recartheft")
  SetParticleFxNonLoopedColour(data[1] / 255, data[2] / 255, data[3] / 255)
  SetParticleFxNonLoopedAlpha(1.0)
  Wait(1000)
  local spray = StartNetworkedParticleFxNonLoopedAtCoord("scr_wheel_burnout", GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.6, 0.8), 0.0, 0.0, GetEntityHeading(vehicle),
    0.5, 0.0, 0.0, 0.0)
  Wait(3000)
  TriggerServerEvent("jim-mechanic:server:ChangeColour", trim(GetVehicleNumberPlateText(vehicle)), data)
  SetVehicleDoorShut(vehicle, 4, false)
  emptyHands(ped)
  if Config.CosmeticRemoval then toggleItem(false, "noscolour") end
  triggerNotify(nil, Loc[Config.Lan]["nos"].nosColour .. " " .. Loc[Config.Lan]["check"].tireinst, "success")
  qblog("`noscolour` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
end)

RegisterNetEvent('jim-mechanic:client:NOS:RGBPicker', function()
  local coords = GetEntityCoords(PlayerPedId())
  local vehicle = getClosest(coords)
  local currentCol
  local plate = trim(GetVehicleNumberPlateText(vehicle))
  if nosColour[plate] then
    local r, g, b = table.unpack(nosColour[plate])
    currentCol = "[ <span style='color:#" ..
        rgbToHex(table.unpack(nosColour[plate])):upper() ..
        "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> " .. r .. " " .. g .. " " .. b .. " </span>]"
  else
    currentCol = "[ <span style='color:#FFFFFF; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> 255 255 255 </span>]"
  end
  if DoesEntityExist(vehicle) then
    local dialog = exports['qb-input']:ShowInput({
      header = "<center>" .. Loc[Config.Lan]["nos"].nosColour
          .. "<br>" .. Loc[Config.Lan]["paintrgb"].rgb
          .. "<br><br>- " .. Loc[Config.Lan]["common"].current .. " -<br>" .. currentCol,
      inputs = {
        { type = 'number', name = 'Red',   text = 'R' },
        { type = 'number', name = 'Green', text = 'G' },
        { type = 'number', name = 'Blue',  text = 'B' }, }
    })
    if dialog then
      local r, g, b = table.unpack({ (tonumber(dialog.Red) or 0), (tonumber(dialog.Green) or 0), (tonumber(dialog.Blue) or 0) })
      if r > 255 then r = 255 end
      if g > 255 then g = 255 end
      if b > 255 then b = 255 end
      local data = { r, g, b }
      TriggerEvent('jim-mechanic:client:NOS:RGBApply', data)
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:NOS:HEXPicker', function()
  local coords = GetEntityCoords(PlayerPedId())
  local vehicle = getClosest(coords)
  local currentCol
  local plate = trim(GetVehicleNumberPlateText(vehicle))
  if nosColour[plate] then
    local r, g, b = table.unpack(nosColour[plate])
    currentCol = "[ #<span style='color:#" ..
        rgbToHex(table.unpack(nosColour[plate])):upper() ..
        "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'>" ..
        rgbToHex(table.unpack(nosColour[plate])):upper() .. " </span>]"
  else
    currentCol = "[ #<span style='color:#FFFFFF; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'>FFFFFF </span>]"
  end
  if DoesEntityExist(vehicle) then
    local dialog = exports['qb-input']:ShowInput({
      header = "<center>" .. Loc[Config.Lan]["nos"].nosColour
          .. "<br>" .. Loc[Config.Lan]["paintrgb"].hex
          .. "<br><br>- " .. Loc[Config.Lan]["common"].current .. " -<br>" .. currentCol,
      submitText = Loc[Config.Lan]["xenons"].customconfirm,
      inputs = {
        { type = 'text', name = 'hex', text = '#' }, }
    })
    if dialog then
      if not dialog.hex then return TriggerEvent("jim-mechanic:client:NOS:HEXPicker") end
      if dialog.hex then
        local hex = dialog.hex:gsub("#", "")
        while string.len(hex) < 6 do
          hex = hex .. "0"
          Wait(10)
        end
        TriggerEvent('jim-mechanic:client:NOS:RGBApply', table.pack(HexTorgb(hex)))
      end
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:NOS:rgbORhex', function()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local vehicle = getClosest(coords)
  if not inCar() then return end
  local plate = trim(GetVehicleNumberPlateText(vehicle))
  if nosColour[plate] then
    local r, g, b = table.unpack(nosColour[plate])
    currentRBGCol = "[<span style='color:#" ..
        rgbToHex(table.unpack(nosColour[plate])):upper() ..
        "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> " .. r .. " " .. g .. " " .. b .. " </span>]<br>"
    currentHEXCol = "[#<span style='color:#" ..
        rgbToHex(table.unpack(nosColour[plate])):upper() ..
        "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'>" .. rgbToHex(r, g, b):upper() .. " </span>]<br>"
  else
    currentRBGCol =
    "[<span style='color:#FFFFFF; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> 255 255 255 </span>]<br>"
    currentHEXCol = "[#<span style='color:#FFFFFF; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'>FFFFFF </span>]<br>"
  end
  if DoesEntityExist(vehicle) then
    local PaintMenu = {}
    PaintMenu[#PaintMenu + 1] = { icon = "noscolour", header = Loc[Config.Lan]["nos"].nosColour, text = Loc[Config.Lan]["paintrgb"].customheader, isMenuHeader = true }
    PaintMenu[#PaintMenu + 1] = {
      icon = "fas fa-circle-xmark",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
      params = { event = "jim-mechanic:client:Menu:Close" }
    }
    PaintMenu[#PaintMenu + 1] = {
      header = Loc[Config.Lan]["paintrgb"].hex,
      text = Loc[Config.Lan]["common"].current .. ":<br>" .. currentHEXCol,
      params = { event = "jim-mechanic:client:NOS:HEXPicker" },
    }
    PaintMenu[#PaintMenu + 1] = {
      header = Loc[Config.Lan]["paintrgb"].rgb,
      text = Loc[Config.Lan]["common"].current .. ":<br>" .. currentRBGCol,
      params = { event = "jim-mechanic:client:NOS:RGBPicker" },
    }
    exports['qb-menu']:openMenu(PaintMenu)
  end
end)

manualPurgeLoc = {
  --SUPER CARS
  [`autarch`] = {
    { 0.25,  -0.6, -0.2, 40.0, -80.0, 90.0 },  --Left
    { -0.25, -0.6, -0.2, 40.0, 80.0,  -90.0 }, --Right
  },
  [`bullet`] = {
    { 0.60,  -1, 0.25, 40.0, 20.0,  0.0 }, --Left
    { -0.60, -1, 0.25, 40.0, -20.0, 0.0 }, --Right
  },
  [`banshee2`] = {
    { 0.40,  0.15, 0.25, 75.0, 20.0,  0.0 }, --Left
    { -0.40, 0.15, 0.25, 75.0, -20.0, 0.0 }, --Right
  },
  [`cheetah`] = {
    { 0.40,  0.15, 0.25, 75.0, 20.0,  0.0 }, --Left
    { -0.40, 0.15, 0.25, 75.0, -20.0, 0.0 }, --Right
  },
  [`cyclone`] = {
    { 0.40,  -0.55, 0.05, 75.0, 20.0,  0.0 }, --Left
    { -0.40, -0.55, 0.05, 75.0, -20.0, 0.0 }, --Right
  },
  [`deveste`] = {
    { 0.20,  0.0,   0.19, 75.0, 20.0,  0.0 }, --Left
    { 0.17,  -0.15, 0.17, 75.0, 20.0,  0.0 }, --Left
    { 0.15,  -0.30, 0.15, 75.0, 20.0,  0.0 }, --Left
    { -0.20, 0.0,   0.19, 75.0, -20.0, 0.0 }, --Right
    { -0.17, -0.15, 0.17, 75.0, -20.0, 0.0 }, --Right
    { -0.15, -0.30, 0.15, 75.0, -20.0, 0.0 }, --Right
  },
  [`emerus`] = {
    { 0.50,  0, 0.19, 60.0, 20.0,  0.0 }, --Left
    { -0.50, 0, 0.19, 60.0, -20.0, 0.0 }, --Right
  },
  [`entity2`] = {
    { 0.60,  0.2, 0.10, 75.0, 20.0,  0.0 }, --Left
    { -0.60, 0.2, 0.10, 75.0, -20.0, 0.0 }, --Right
  },
  [`entityxf`] = {
    { 0.60,  0.2, 0.20, 40.0, 20.0,  0.0 }, --Left
    { -0.60, 0.2, 0.20, 40.0, -20.0, 0.0 }, --Right
  },
  [`fmj`] = {
    { 0.25,  -0.6, 0.15, 75.0, 20.0,  0.0 }, --Left
    { -0.25, -0.6, 0.15, 75.0, -20.0, 0.0 }, --Right
  },
  [`furia`] = {
    { 0.40,  -0.55, 0.05, 75.0, 20.0,  0.0 }, --Left
    { -0.40, -0.55, 0.05, 75.0, -20.0, 0.0 }, --Right
  },
  [`gp1`] = {
    { 0.25,  -0.70, 0.25, 20.0, 20.0,  0.0 }, --Left
    { 0.25,  -0.80, 0.25, 20.0, 20.0,  0.0 }, --Left
    { 0.25,  -0.90, 0.25, 20.0, 20.0,  0.0 }, --Left

    { -0.25, -0.70, 0.25, 20.0, -20.0, 0.0 }, --Right
    { -0.25, -0.80, 0.25, 20.0, -20.0, 0.0 }, --Right
    { -0.25, -0.90, 0.25, 20.0, -20.0, 0.0 }, --Right
  },
  [`infernus`] = {
    { 0.50,  0.3, 0.45, 50.0, 20.0,  0.0 }, --Left
    { -0.50, 0.3, 0.45, 50.0, -20.0, 0.0 }, --Right
  },
  [`italigtb`] = {
    { 0.30,  2.3, 0.05, 40.0, 30.0,  0.0 }, --Left
    { -0.30, 2.3, 0.05, 40.0, -30.0, 0.0 }, --Right
  },
  [`italigtb2`] = {
    { 0.30,  2.3, 0.05, 40.0, 30.0,  0.0 }, --Left
    { -0.30, 2.3, 0.05, 40.0, -30.0, 0.0 }, --Right
  },
  [`krieger`] = {
    { 0.30,  2.3, 0.05, 40.0, 30.0,  0.0 }, --Left
    { -0.30, 2.3, 0.05, 40.0, -30.0, 0.0 }, --Right
  },
  [`le7b`] = {
    { 0.30,  2.3, 0.05, 40.0, 30.0,  0.0 }, --Left
    { -0.30, 2.3, 0.05, 40.0, -30.0, 0.0 }, --Right
  },
  [`nero`] = {
    { 0.30,  2.2, 0.0, 40.0, 30.0,  0.0 }, --Left
    { -0.30, 2.2, 0.0, 40.0, -30.0, 0.0 }, --Right
  },
  [`nero2`] = {
    { 0.40,  -0.5, 0.16, 60.0, 20.0,  0.0 }, --Left
    { -0.40, -0.5, 0.16, 60.0, -20.0, 0.0 }, --Right
  },
  [`osiris`] = {
    { 0.35,  -0.4, 0.12, 60.0, 20.0,  0.0 }, --Left
    { -0.35, -0.4, 0.12, 60.0, -20.0, 0.0 }, --Right
  },
  [`penetrator`] = {
    { 0.35,  -0.6, 0.12, 60.0, 20.0,  0.0 }, --Left
    { -0.35, -0.6, 0.12, 60.0, -20.0, 0.0 }, --Right
  },
  [`pfister811`] = {
    { 0.0, 0.35,  0.28, 0.0,  0.0, 0.0 },
    { 0.0, 0.15,  0.25, 10.0, 0.0, 0.0 },
    { 0.0, -0.05, 0.20, 20.0, 0.0, 0.0 },
    { 0.0, -0.25, 0.15, 30.0, 0.0, 0.0 },
    { 0.0, -0.50, 0.11, 40.0, 0.0, 0.0 },
  },
  [`prototipo`] = {
    { 0.30,  -0, 0.05, 40.0, 30.0,  0.0 }, --Left
    { -0.30, -0, 0.05, 40.0, -30.0, 0.0 }, --Right
  },
  [`sc1`] = {
    { 0.30,  -0.65, 0.05, 40.0, 30.0,  0.0 }, --Left
    { -0.30, -0.65, 0.05, 40.0, -30.0, 0.0 }, --Right
  },
  [`t20`] = {
    { 0.25,  -0.65, 0.10, 40.0, 10.0,  0.0 }, --Left
    { -0.25, -0.65, 0.10, 40.0, -10.0, 0.0 }, --Right
  },
  [`taipan`] = {
    { 0.32,  2.3, 0.00, 40.0, 30.0,  0.0 }, --Left
    { -0.32, 2.3, 0.00, 40.0, -30.0, 0.0 }, --Right
  },
  [`tempesta`] = {
    { 0.50,  -0.65, 0.60, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.65, 0.60, 40.0, -10.0, 0.0 }, --Right
  },
  [`tezeract`] = {
    { 0.50,  -0.65, 0.60, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.65, 0.60, 40.0, -10.0, 0.0 }, --Right
  },
  [`thrax`] = {
    { 0.50,  -0.65, 0.10, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.65, 0.10, 40.0, -10.0, 0.0 }, --Right
  },
  [`tigon`] = {
    { 0.50,  -0.65, 0.20, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.65, 0.20, 40.0, -10.0, 0.0 }, --Right
  },
  [`turismor`] = {
    { 0.50,  -0.65, 0.17, 90.0, 10.0,  0.0 }, --Left
    { -0.50, -0.65, 0.17, 90.0, -10.0, 0.0 }, --Right
  },
  [`tyrant`] = {
    { 0.32,  2.8, 0.25, 40.0, 30.0,  0.0 }, --Left
    { -0.32, 2.8, 0.25, 40.0, -30.0, 0.0 }, --Right
  },
  [`vagner`] = {
    { 0.50,  -0.65, 0.10, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.65, 0.10, 40.0, -10.0, 0.0 }, --Right
  },
  [`voltic`] = {
    { 0.50,  -0.65, 0.10, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.65, 0.10, 40.0, -10.0, 0.0 }, --Right
  },
  [`voltic2`] = {
    { 0.50,  -0.65, 0.10, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.65, 0.10, 40.0, -10.0, 0.0 }, --Right
  },
  [`xa21`] = {
    { 0.50,  -0.55, 0.00, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.55, 0.00, 40.0, -10.0, 0.0 }, --Right
  },
  [`zentorno`] = {
    --Left
    { -0.12, 0.28,  0.28, 0.0,  -10.0, 0.0 },
    { -0.12, 0.05,  0.25, 10.0, -10.0, 0.0 },
    { -0.12, -0.18, 0.20, 20.0, -10.0, 0.0 },
    { -0.12, -0.40, 0.15, 30.0, -10.0, 0.0 },
    { -0.12, -0.60, 0.11, 40.0, -10.0, 0.0 },
    { -0.12, -0.82, 0.05, 50.0, -10.0, 0.0 },
    --Right
    { 0.12,  0.28,  0.28, 0.0,  10.0,  0.0 },
    { 0.12,  0.05,  0.25, 10.0, 10.0,  0.0 },
    { 0.12,  -0.18, 0.20, 20.0, 10.0,  0.0 },
    { 0.12,  -0.40, 0.15, 30.0, 10.0,  0.0 },
    { 0.12,  -0.60, 0.11, 40.0, 10.0,  0.0 },
    { 0.12,  -0.82, 0.05, 50.0, 10.0,  0.0 },
  },
  [`zorrusso`] = {
    --Left
    { -0.20, -0.2, 0.0, 40.0, -20.0, 0.0 },
    { -0.20, 0.0,  0.0, 10.0, -20.0, 0.0 },
    --Right
    { 0.20,  -0.2, 0.0, 40.0, 20.0,  0.0 },
    { 0.20,  0.0,  0.0, 10.0, 20.0,  0.0 },
  },
  ---DLC 2699
  [`brioso3`] = {
    { 0.50,  -0.30, -0.10, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.30, -0.10, 40.0, -10.0, 0.0 }, --Right
  },
  [`corsita`] = {
    { 0.30,  2.3, 0.05, 40.0, 30.0,  0.0 }, --Left
    { -0.30, 2.3, 0.05, 40.0, -30.0, 0.0 }, --Right
  },
  [`draugur`] = {
    { 0.50,  -0.55, 0.30, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.55, 0.30, 40.0, -10.0, 0.0 }, --Right
  },
  [`kanjosj`] = {
    { 0.30,  -0.50, 0.15, 40.0, 30.0,  0.0 }, --Left
    { -0.30, -0.50, 0.15, 40.0, -30.0, 0.0 }, --Right
  },
  [`lm87`] = {
    { 0.30,  2.3, -0.15, 40.0, 30.0,  0.0 }, --Left
    { -0.30, 2.3, -0.15, 40.0, -30.0, 0.0 }, --Right
  },
  [`postlude`] = {
    { 0.60,  -0.35, 0.20, 40.0, 10.0,  0.0 }, --Left
    { -0.60, -0.35, 0.20, 40.0, -10.0, 0.0 }, --Right
  },
  [`sentinel4`] = {
    { 0.50,  -0.55, 0.20, 40.0, 10.0,  0.0 }, --Left
    { -0.50, -0.55, 0.20, 40.0, -10.0, 0.0 }, --Right
  },
  [`sm722`] = {
    { 0.50,  -0.55, 0.15, 40.0, 30.0,  0.0 }, --Left
    { -0.50, -0.55, 0.15, 40.0, -30.0, 0.0 }, --Right
  },
  [`tenf2`] = {
    { 0.30,  -0.80, 0.15, 40.0, 30.0,  0.0 }, --Left
    { -0.30, -0.80, 0.15, 40.0, -30.0, 0.0 }, --Right
  },
  [`torero2`] = {
    { 0.30,  -0.80, 0.15, 40.0, 30.0,  0.0 }, --Left
    { -0.30, -0.80, 0.15, 40.0, -30.0, 0.0 }, --Right
  },
  [`weevil2`] = {
    { 0.50,  -0.25, 0.20, 40.0, 40.0,  0.0 }, --Left
    { -0.50, -0.25, 0.20, 40.0, -40.0, 0.0 }, --Right
  },
}

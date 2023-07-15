--=== Car Wax ===--
local cleaning = false
RegisterNetEvent("jim-mechanic:client:CarWax", function(data)
  if not cleaning then cleaning = true else return end
  triggerNotify(nil, Loc[Config.Lan]["police"].cleaning)
  local vehicle
  if not IsPedInAnyVehicle(PlayerPedId(), false) then vehicle = getClosest(GetEntityCoords(PlayerPedId())) end
  TriggerEvent('animations:client:EmoteCommandStart', { "clean2" })
  while cleaning do
    if GetVehicleDirtLevel(vehicle) >= 1.0 then
      SetVehicleDirtLevel(vehicle, (tonumber(GetVehicleDirtLevel(vehicle))) - 0.3)
    elseif GetVehicleDirtLevel(vehicle) <= 1.0 then
      SetVehicleDirtLevel(vehicle, 0.0)
      WashDecalsFromVehicle(vehicle, 1.0)
      cleaning = false
      triggerNotify(nil, Loc[Config.Lan]["extras"].clean, "success")
      emptyHands(playerPed, true)
    end
    Wait(300)
  end
  Wait(1000)
  emptyHands(playerPed, true)
  if cleaning == false and data.time ~= 0 then
    TriggerServerEvent("jim-mechanic:server:WaxActivator", VehToNet(vehicle), data.time)
  end
  if Config.CosmeticRemoval and not data.skip then toggleItem(false, "cleaningkit") end
end)

RegisterNetEvent("jim-mechanic:client:CarWax:WaxTick", function(vehicle)
  if not NetworkDoesEntityExistWithNetworkId(netid) then return end
  if not LocalPlayer.state.isLoggedIn then return end
  if not NetworkDoesEntityExistWithNetworkId(vehicle) then return end
  if DoesEntityExist(NetToVeh(vehicle)) then
    if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(NetToVeh(vehicle))) <= 100.0 then
      SetVehicleDirtLevel(NetToVeh(vehicle), 0.0)
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:cleanVehicle', function(skip)
  local coords = GetEntityCoords(PlayerPedId())
  if not inCar() then return end
  if not nearPoint(coords) then return end
  local vehicle = getClosest(coords)
  pushVehicle(vehicle)
  lookVeh(vehicle)
  if DoesEntityExist(vehicle) then
    local CleanMenu = {
      {
        icon = "cleaningkit",
        isMenuHeader = true,
        header = searchCar(vehicle),
        txt = "Class: " ..
            getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
      },
      { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""), params = { event = "jim-mechanic:client:Menu:Close" } } }

    CleanMenu[#CleanMenu + 1] = { header = Loc[Config.Lan]["carwax"].head1, params = { event = "jim-mechanic:client:CarWax", args = { time = 0, skip = skip } } }
    if Config.WaxFeatures then
      CleanMenu[#CleanMenu + 1] = { header = Loc[Config.Lan]["carwax"].head2, params = { event = "jim-mechanic:client:CarWax", args = { time = 1800, skip = skip } } }
      CleanMenu[#CleanMenu + 1] = { header = Loc[Config.Lan]["carwax"].head3, params = { event = "jim-mechanic:client:CarWax", args = { time = 3600, skip = skip } } }
      CleanMenu[#CleanMenu + 1] = { header = Loc[Config.Lan]["carwax"].head4, params = { event = "jim-mechanic:client:CarWax", args = { time = 5400, skip = skip } } }
    end
    exports['qb-menu']:openMenu(CleanMenu)
  end
end)

--Quick Repair
RegisterNetEvent('jim-mechanic:quickrepair', function()
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  local repaireng = true
  local repairbody = true
  if not IsPedInAnyVehicle(playerPed, false) then
    vehicle = getClosest(coords)
    pushVehicle(vehicle)
  end
  if DoesEntityExist(vehicle) then
    currentenginehealth = GetVehicleEngineHealth(vehicle)
    currentbodyhealth = GetVehicleBodyHealth(vehicle)

    if GetVehicleEngineHealth(vehicle) >= Config.MaxDuctEngine then repaireng = false else repaireng = true end
    if Config.DuctTapeBody and GetVehicleBodyHealth(vehicle) >= Config.MaxDuctBody then repairbody = false else repairbody = true end

    if repaireng or repairbody then
      TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
      Wait(1000)
      SetVehicleDoorOpen(vehicle, 4, false, false)
      QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["repair"].applyduct, 10000, false, true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
        { animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
          SetVehicleModKit(vehicle, 0)
          Wait(1000)
          emptyHands(playerPed)
          if Config.DuctSimpleMode then
            SetVehicleEngineHealth(vehicle, Config.MaxDuctEngine)
            SetVehicleBodyHealth(vehicle, Config.MaxDuctBody)
          elseif not Config.DuctSimpleMode then
            if currentenginehealth <= 50.0 and currentenginehealth <= 200 then
              SetVehicleEngineHealth(vehicle, 300.0)
            else
              SetVehicleEngineHealth(vehicle, currentenginehealth + Config.DuctAmountEngine)
              if GetVehicleEngineHealth(vehicle) > Config.MaxDuctEngine then SetVehicleEngineHealth(vehicle, Config.MaxDuctEngine) end
            end
            if Config.DuctTapeBody then
              if currentbodyhealth <= 50.0 and currentbodyhealth <= 200 then
                SetVehicleBodyHealth(vehicle, 300.0)
              else
                SetVehicleBodyHealth(vehicle, currentbodyhealth + Config.DuctAmountBody)
                if GetVehicleBodyHealth(vehicle) > Config.MaxDuctBody then SetVehicleBodyHealth(vehicle, Config.MaxDuctBody) end
              end
            end
            SetVehicleDoorShut(vehicle, 4, false, false)
          end
          if Config.RemoveDuctTape then toggleItem(false, "ducttape") end
        end, function()
          SetVehicleDoorShut(vehicle, 4, false, false)
          emptyHands(playerPed)
        end, "ducttape")
    else
      triggerNotify(nil, Loc[Config.Lan]["repair"].ductfull, "error")
    end
  else
    triggerNotify(nil, Loc[Config.Lan]["repair"].nocar, "error")
  end
end)

--Multipurpose Door command
RegisterNetEvent('jim-mechanic:client:openDoor', function(door)
  local doornum = tonumber(door)
  if doornum < 0 or doornum > 5 then
    triggerNotify(nil, Loc[Config.Lan]["extras"].doorerr, "error")
    return
  end
  local coords = GetEntityCoords(PlayerPedId())
  if not nearPoint(coords) then return end
  local vehicle = nil
  if IsPedSittingInAnyVehicle(PlayerPedId()) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  else
    vehicle = getClosest(coords)
    pushVehicle(vehicle)
  end
  if DoesEntityExist(vehicle) then
    if GetVehicleDoorLockStatus(vehicle) == 2 then
      triggerNotify(nil, Loc[Config.Lan]["extras"].locked, "error")
      return
    else
      if GetVehicleDoorAngleRatio(vehicle, doornum) > 0.0 then
        SetVehicleDoorShut(vehicle, doornum, false)
      else
        SetVehicleDoorOpen(vehicle, doornum, false, false)
      end
    end
  end
end)

RegisterNetEvent("jim-mechanic:flipvehicle", function()
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  if not inCar() then return end
  if not nearPoint(coords) then return end
  local vehicle = getClosest(coords)
  pushVehicle(vehicle)
  if DoesEntityExist(vehicle) then
    QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["extras"].flipping, 12000, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { animDict = "missfinale_c2ig_11", anim = "pushcar_offcliff_f", flags = 17, }, {}, {}, function()
        qblog("used `/flipvehicle`")
        emptyHands(playerPed)
        local vehiclecoords = GetEntityCoords(vehicle)
        SetEntityCoords(vehicle, vehiclecoords.x + 0.5, vehiclecoords.y + 0.5, vehiclecoords.z + 1)
        Wait(200)
        SetEntityRotation(vehicle, GetEntityRotation(PlayerPedId(), 2), 2)
        Wait(500)
        SetVehicleOnGroundProperly(vehicle)
        triggerNotify(nil, Loc[Config.Lan]["extras"].flipped, "success")
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["extras"].failed, "error")
        emptyHands(playerPed)
      end, "fas fa-car-burst")
  end
end)

RegisterNetEvent("jim-mechanic:seat", function(seat)
  if not seat then
    triggerNotify(nil, Loc[Config.Lan]["extras"].noseat, "error")
    return
  end
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  local IsSeatFree = IsVehicleSeatFree(vehicle, tonumber(seat))
  local speed = GetEntitySpeed(vehicle)
  local HasHarnass = exports['qb-smallresources']:HasHarness()
  if not HasHarnass then
    local kmh = (speed * 3.6);
    if IsSeatFree then
      if kmh <= 100.0 then
        SetPedIntoVehicle(PlayerPedId(), vehicle, tonumber(seat))
        triggerNotify(nil, Loc[Config.Lan]["extras"].moveseat .. seat .. "!")
      else
        triggerNotify(nil, Loc[Config.Lan]["extras"].fastseat)
      end
    else
      triggerNotify(nil, Loc[Config.Lan]["extras"].notseat)
    end
  else
    triggerNotify(nil, Loc[Config.Lan]["extras"].harness, 'error')
  end
end)

local vehicle_sounds = {}
local soundTog = false
RegisterNetEvent("jim-mechanic:togglesound", function()
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  if not soundTog then
    soundTog = true
    currentEngine = GetVehicleMod(vehicle, 11)
    if currentEngine == 4 then
      ForceVehicleEngineAudio(vehicle, "monster")
    elseif currentEngine == 3 then
      ForceVehicleEngineAudio(vehicle, "monster")
    elseif currentEngine == 2 then
      ForceVehicleEngineAudio(vehicle, "krieger")
    elseif currentEngine == 1 then
      ForceVehicleEngineAudio(vehicle, "zentorno")
    elseif currentEngine == 0 then
      ForceVehicleEngineAudio(vehicle, "zorrusso")
    end
  elseif soundTog then
    soundTog = false
    ForceVehicleEngineAudio(vehicle, string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))))
  end
end)

--ODOMETER FUNCTION
local DistAdd = 0
local DistCount = 0
local maxspeed = 0
local ShowingOdo = false
ShowOdo = Config.ShowOdo
local owned = false
local veh, prevVeh
local invehicle = false
local databasecalc = false
local odocalc = false
local nosUpdate = false
CreateThread(function()
  while true do
    local invehicle = IsPedInAnyVehicle(PlayerPedId(), true)
    if invehicle then
      nosCheck = true
      local ped = PlayerPedId()
      local dist = ""
      veh = GetVehiclePedIsIn(ped)
      if DoesEntityExist(veh) then
        if GetPedInVehicleSeat(veh, -1) == ped then
          local plate = trim(GetVehicleNumberPlateText(veh))
          if veh ~= prevVeh then
            --ModifyVehicleTopSpeed(veh, -1.0)
            owned = IsVehicleOwned(plate)
            prevVeh = GetVehiclePedIsIn(ped)
            local nos = {}
            if VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())))] then
              nos = {
                VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())))].hasnitro,
                VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())))].level
              }
            end
            TriggerEvent('hud:client:UpdateNitrous', nos[1] or false, nos[2] or 0, false)
          end
        end
      end
    else
      TriggerEvent("jim-mechanic:client:HideText")
    end
    Wait(10000)
    if not invehicle then
      if nosCheck and VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)))] then
        TriggerServerEvent('jim-mechanic:database:UpdateNitroLevel', trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true))),
          VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)))].level) -- Update the nos when you are no longer in that vehicle
      end
      maxspeed = 0
      nosCheck = false
      odocalc = false
      databasecalc = false
      TriggerEvent("jim-mechanic:client:HideText")
      DistAdd = 0
    else
      Wait(10000)
    end
  end
end)

RegisterNetEvent("jim-mechanic:ShowOdo", function()
  print("^3ShowOdo^7: ^2Odometer toggled^7")
  ShowOdo = not ShowOdo
end)

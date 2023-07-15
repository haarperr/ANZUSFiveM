local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports['qb-core']:GetCoreObject() end)

--Don't even try to ask me how this works, found it on a tutorial site for organising tables
function pairsByKeys(t)
  local a = {}
  for n in pairs(t) do a[#a + 1] = n end
  table.sort(a)
  local i = 0
  local iter = function()
    i = i + 1
    if a[i] == nil then return nil else return a[i], t[a[i]] end
  end
  return iter
end

function rgbToHex(r, g, b)
  local rgb = (r * 0x10000) + (g * 0x100) + b
  return string.format("%06x", rgb)
end

function HexTorgb(hex)
  local hex = hex:gsub("#", "")
  return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

function cv(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k == 0) then break end
  end
  return formatted
end

function IsVehicleOwned(plate)
  local p = promise.new()
  QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(cb) p:resolve(cb) end, plate)
  return Citizen.Await(p)
end

function getClass(vehicle)
  local classlist = {
    "Compacts",
    "Sedans",
    "SUVs",
    "Coupes",
    "Muscle",
    "Sports Classics",
    "Sports",
    "Super",
    "Motorcycles",
    "Off-road",
    "Industrial",
    "Utility",
    "Vans",
    "Cycles",
    "Boats",
    "Helicopters",
    "Planes",
    "Service",
    "Emergency",
    "Military",
    "Commercial",
    "Trains",
  }
  return classlist[GetVehicleClass(vehicle) + 1]
end

function useMechJob() if GetResourceState('qb-mechanicjob') == "started" then return true else return false end end

function lookVeh(vehicle)
  if type(vehicle) == "vec3" then
    if not IsPedHeadingTowardsPosition(PlayerPedId(), vehicle, 30.0) then
      TaskTurnPedToFaceCoord(PlayerPedId(), vehicle, 1500)
      if Config.Debug then print("^5Debug^7: ^2Turning Player to^7: '^6" .. json.encode(vehicle) .. "^7'") end
      Wait(1500)
    end
  else
    if DoesEntityExist(vehicle) then
      if not IsPedHeadingTowardsPosition(PlayerPedId(), GetEntityCoords(vehicle), 30.0) then
        TaskTurnPedToFaceCoord(PlayerPedId(), GetEntityCoords(vehicle), 1500)
        if Config.Debug then print("^5Debug^7: ^2Turning Player to^7: '^6" .. vehicle .. "^7'") end
        Wait(1500)
      end
    end
  end
end

function getClosest(coords)
  local vehs = { 71, 0, 2, 4, 6, 7, 23, 127, 260, 2146, 2175, 12294, 16834, 16386, 20503, 32768, 67590, 67711, 98309, 100359 }
  for _, v in pairs(vehs) do
    if GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, v) ~= 0 then
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, v)
      break
    end
  end
  return vehicle
end

local lastCar = nil
local newName = nil
function searchCar(vehicle)
  if lastCar ~= vehicle then -- Check added to use old info instead of checking again
    lastCar = vehicle
    newName = nil
    for k, v in pairs(QBCore.Shared.Vehicles) do
      if tonumber(v.hash) == GetEntityModel(vehicle) then
        if Config.Debug then print("^5Debug^7: ^2Vehicle info found in^7 ^4vehicles^7.^4lua^7: ^6" .. v.hash .. " ^7(^6" .. QBCore.Shared.Vehicles[k].name .. "^7)") end
        newName = QBCore.Shared.Vehicles[k].name .. " " .. QBCore.Shared.Vehicles[k].brand .. "<br>"
      end
    end
    if Config.Debug then
      if not newName then
        print("^5Debug^7: ^2Vehicle ^1not ^2found in ^4vehicles^7.^4lua^7: ^6" ..
          GetEntityModel(vehicle) .. " ^7(^6" .. GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower() .. "^7)")
      end
    end
    if not newName then newName = string.upper(GetMakeNameFromVehicleModel(GetEntityModel(vehicle)) .. " " .. GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. " <br>" end
    return newName
  else
    return newName
  end
end

function searchPrice(vehicle)
  local price = nil
  for k, v in pairs(QBCore.Shared.Vehicles) do
    if tonumber(v.hash) == GetEntityModel(vehicle) then
      price = cv(QBCore.Shared.Vehicles[k].price)
    end
  end
  if not price then price = (0) .. "<br>" end
  return price
end

-- Push as in push to every player
-- Doubles up as a way to reduce spam of commands
function pushVehicle(entity)
  if Config.Debug then print("^5Debug^7: ^3pushVehicle^7: ^2Running function^7...") end
  SetVehicleModKit(entity, 0)
  if entity ~= 0 and DoesEntityExist(entity) then
    if not NetworkHasControlOfEntity(entity) then
      if Config.Debug then print("^5Debug^7: ^3pushVehicle^7: ^2Requesting network control of vehicle^7.") end
      NetworkRequestControlOfEntity(entity)
      local timeout = 2000
      while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
      end
    end
    if NetworkHasControlOfEntity(entity) and Config.Debug then print("^5Debug^7: ^3pushVehicle^7: ^2Network has control of entity^7.") end
    if not IsEntityAMissionEntity(entity) then
      if Config.Debug then print("^5Debug^7: ^3pushVehicle^7: ^2Setting vehicle as a ^7'^2mission^7' &2entity^7.") end
      SetEntityAsMissionEntity(entity, true, true)
      local timeout = 2000
      while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
      end
    end
    if IsEntityAMissionEntity(entity) and Config.Debug then print("^5Debug^7: ^3pushVehicle^7: ^2Vehicle is a ^7'^2mission^7'^2 entity^7.") end
  end
end

RegisterNetEvent("jim-mechanic:forceProperties", function(vehicle, props) -- This forces updates of the vehicle from the person who updated it
  if not NetworkDoesEntityExistWithNetworkId(vehicle) then return end     -- Add network check here
  if NetToVeh(vehicle) ~= 0 and DoesEntityExist(NetToVeh(vehicle)) then
    SetVehicleModKit(NetToVeh(vehicle), 0)
    QBCore.Functions.SetVehicleProperties(NetToVeh(vehicle), props)
  end
end)

function inCar()
  local inCar = false
  if IsPedSittingInAnyVehicle(PlayerPedId()) then
    triggerNotify(nil, Loc[Config.Lan]["functions"].inCar, "error")
    inCar = false
  else
    inCar = true
  end
  return inCar
end

function outCar()
  local outCar = false
  if not IsPedSittingInAnyVehicle(PlayerPedId()) then
    triggerNotify(nil, Loc[Config.Lan]["functions"].outCar, "error")
    outCar = false
  else
    outCar = true
  end
  return outCar
end

function lockedCar(vehicle)
  local locked = false
  if GetVehicleDoorLockStatus(vehicle) >= 2 then
    triggerNotify(nil, Loc[Config.Lan]["functions"].locked, "error")
    locked = true
  else
    locked = false
  end
  return locked
end

function nearPoint(coords)
  if not IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
    triggerNotify(nil, Loc[Config.Lan]["functions"].nearby, "error")
    near = false
  else
    near = true
  end
  return near
end

injob = nil
function locationChecks()
  local check = true
  if Config.LocationRequired then
    if injob then
      check = true
    else
      check = false
      triggerNotify(nil, Loc[Config.Lan]["functions"].shop, "error")
    end
  end
  return check
end

function jobChecks()
  local check = true
  if Config.RequiresJob == true then
    check = false
    for k, v in pairs(Config.JobRoles) do
      if v == PlayerJob.name then check = true end
    end
    if check == false then
      triggerNotify(nil, Loc[Config.Lan]["functions"].mechanic, "error")
      check = false
    end
  end
  return check
end

function qblog(text)
  local Player = QBCore.Functions.GetPlayerData()
  TriggerServerEvent('qb-log:server:CreateLog', 'vehicleupgrades',
    GetCurrentResourceName() .. " - " .. Player.charinfo.firstname .. " " .. Player.charinfo.lastname .. "(" .. Player.source .. ") [" .. Player.citizenid .. "]", 'blue', text)
end

function playAnim(animDict, animName, duration, flag)
  loadAnimDict(animDict)
  TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, flag, 1, false, false, false)
end

function stopAnim(animDict, animName)
  StopAnimTask(PlayerPedId(), animName, animDict)
  unloadAnimDict(animDict)
end

function trim(value)
  if not value then return nil end
  return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

--not a function, but a widely used event
RegisterNetEvent('jim-mechanic:client:Menu:Close', function()
  emptyHands(PlayerPedId())
  FreezeEntityPosition(PlayerPedId(), false)
  local vehicle = nil
  if IsPedSittingInAnyVehicle(PlayerPedId()) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  else
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  end
  for i = 0, 5 do SetVehicleDoorShut(vehicle, i, false, true) end
  exports['qb-menu']:closeMenu()
end)

function emptyHands(playerPed, dpemote)
  if dpemote ~= nil then
    TriggerEvent('animations:client:EmoteCommandStart', { "c" })
    ClearPedTasks(playerPed)
  else
    ClearPedTasks(playerPed)
  end
  for k, v in pairs(GetGamePool('CObject')) do
    for _, model in pairs({ `prop_sponge_01`, `prop_weld_torch`, `prop_rag_01`, `prop_fib_clipboard`, `v_ind_cs_toolbox4`, `p_amb_clipboard_01`, `ng_proc_spraycan01b` }) do
      if GetEntityModel(v) == model then
        if IsEntityAttachedToEntity(playerPed, v) then
          unloadModel(model)
          DeleteObject(v)
          DetachEntity(v, 0, 0)
          SetEntityAsMissionEntity(v, true, true)
          Wait(100)
          DeleteEntity(v)
        end
      end
    end
  end
end

function doCarDamage(currentVehicle, veh)
  smash = false
  damageOutside = false
  damageOutside2 = false
  local engine = veh.engine + 0.0
  local body = veh.body + 0.0
  if engine < 200.0 then engine = 200.0 end
  if engine > 1000.0 then engine = 1000.0 end
  if body < 150.0 then
    body = 150.0
    smash = true
  end
  if body < 900.0 then smash = true end
  if body < 800.0 then damageOutside = true end
  if body < 500.0 then damageOutside2 = true end
  SetVehicleEngineHealth(currentVehicle, engine)
  if smash then
    SmashVehicleWindow(currentVehicle, 0)
    SmashVehicleWindow(currentVehicle, 1)
    SmashVehicleWindow(currentVehicle, 2)
    SmashVehicleWindow(currentVehicle, 3)
    SmashVehicleWindow(currentVehicle, 4)
  end
  if damageOutside then
    SetVehicleDoorBroken(currentVehicle, 1, true)
    SetVehicleDoorBroken(currentVehicle, 6, true)
    SetVehicleDoorBroken(currentVehicle, 4, true)
  end
  if damageOutside2 then
    SetVehicleTyreBurst(currentVehicle, 0, true, 990.0)
    SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
    SetVehicleTyreBurst(currentVehicle, 2, true, 990.0)
    SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
    SetVehicleTyreBurst(currentVehicle, 4, true, 990.0)
    SetVehicleTyreBurst(currentVehicle, 5, false, 990.0)
    SetVehicleTyreBurst(currentVehicle, 45, true, 990.0)
    SetVehicleTyreBurst(currentVehicle, 47, false, 990.0)
  end
end

--▓
--░

function nosBar(level)
  local full, empty = table.unpack({ (Config.nosBarFull or "▓"), (Config.nosBarEmpty or "░") })
  if Config.nosBarColour then
    green, yellow, red, grey = table.unpack({ "green", "yellow", "red", "grey" })
  else
    green, yellow, red, grey = table.unpack({ "white", "white", "white", "grey" })
  end
  local bartable = {}
  for i = 1, 10 do bartable[i] = "<span style='color:" .. green .. "'>" .. full .. "</span>" end
  if level <= 91 then bartable[10] = "<span style='color:" .. grey .. "'>" .. empty .. "</span>" end
  if level <= 81 then bartable[9] = "<span style='color:" .. grey .. "'>" .. empty .. "</span>" end
  if level <= 71 then
    bartable[8] = "<span style='color:" .. grey .. "'>" .. empty .. "</span>"
    for i = 1, 7 do bartable[i] = "<span style='color:" .. yellow .. "'>" .. full .. "</span>" end
  end
  if level <= 61 then bartable[7] = "<span style='color:" .. grey .. "'>" .. empty .. "</span>" end
  if level <= 51 then bartable[6] = "<span style='color:" .. grey .. "'>" .. empty .. "</span>" end
  if level <= 41 then bartable[5] = "<span style='color:" .. grey .. "'>" .. empty .. "</span>" end
  if level <= 31 then
    bartable[4] = "<span style='color:" .. grey .. "'>" .. empty .. "</span>"
    for i = 1, 3 do bartable[i] = "<span style='color:" .. red .. "'>" .. full .. "</span>" end
  end
  if level <= 21 then bartable[3] = "<span style='color:" .. grey .. "'>" .. empty .. "</span>" end
  if level <= 11 then bartable[2] = "<span style='color:" .. grey .. "'>" .. empty .. "</span>" end
  if level <= 1 then bartable[1] = "<span style='color:" .. grey .. "'>" .. empty .. "</span>" end
  local bar = ""
  for i = 1, 10 do bar = bar .. bartable[i] end
  return bar
end

local time = 1000
function loadModel(model)
  if not HasModelLoaded(model) then
    if Config.Debug then print("^5Debug^7: ^2Loading Model^7: '^6" .. model .. "^7'") end
    while not HasModelLoaded(model) do
      if time > 0 then
        time = time - 1
        RequestModel(model)
      else
        time = 1000
        print("^5Debug^7: ^3LoadModel^7: ^2Timed out loading model ^7'^6" .. model .. "^7'")
        break
      end
      Wait(10)
    end
  end
end

function unloadModel(model)
  if Config.Debug then print("^5Debug^7: ^2Removing Model^7: '^6" .. model .. "^7'") end
  SetModelAsNoLongerNeeded(model)
end

function loadAnimDict(dict)
  if not HasAnimDictLoaded(dict) then
    if Config.Debug then print("^5Debug^7: ^2Loading Anim Dictionary^7: '^6" .. dict .. "^7'") end
    while not HasAnimDictLoaded(dict) do
      RequestAnimDict(dict)
      Wait(5)
    end
  end
end

function unloadAnimDict(dict)
  if Config.Debug then print("^5Debug^7: ^2Removing Anim Dictionary^7: '^6" .. dict .. "^7'") end
  RemoveAnimDict(dict)
end

function loadPtfxDict(dict)
  if not HasNamedPtfxAssetLoaded(dict) then
    if Config.Debug then print("^5Debug^7: ^2Loading Ptfx Dictionary^7: '^6" .. dict .. "^7'") end
    while not HasNamedPtfxAssetLoaded(dict) do
      RequestNamedPtfxAsset(dict)
      Wait(5)
    end
  end
end

function unloadPtfxDict(dict)
  if Config.Debug then print("^5Debug^7: ^2Removing Ptfx Dictionary^7: '^6" .. dict .. "^7'") end
  RemoveNamedPtfxAsset(dict)
end

CreateThread(function()
  if GetGameBuildNumber() < 2612 then
    for k in pairs(Loc[Config.Lan].vehicleResprayOptionsChameleon) do
      Loc[Config.Lan].vehicleResprayOptionsChameleon[k].id = Loc[Config.Lan].vehicleResprayOptionsChameleon[k].id - 62
    end
  end
end)

function makeProp(data, freeze, synced)
  loadModel(data.prop)
  local prop = CreateObject(data.prop, data.coords.x, data.coords.y, data.coords.z - 1.03, synced or 0, synced or 0, 0)
  SetEntityHeading(prop, data.coords.w - 180.0)
  FreezeEntityPosition(prop, freeze or 0)
  if Config.Debug then print("^5Debug^7: ^6Prop ^2Created ^7: '^6" .. prop .. "^7'") end
  return prop
end

function triggerNotify(title, message, type, src)
  if Config.Notify == "okok" then
    if not src then
      exports['okokNotify']:Alert(title, message, 6000, type or 'info')
    else
      TriggerClientEvent('okokNotify:Alert', src, title, message, 6000, type or 'info')
    end
  elseif Config.Notify == "qb" then
    if not src then
      TriggerEvent("QBCore:Notify", message, "primary")
    else
      TriggerClientEvent("QBCore:Notify", src, message, "primary")
    end
  elseif Config.Notify == "t" then
    if not src then
      exports['t-notify']:Custom({ title = title, style = type, message = message, sound = true })
    else
      TriggerClientEvent('t-notify:client:Custom', src, { style = type, duration = 6000, title = title, message = message, sound = true, custom = true })
    end
  elseif Config.Notify == "infinity" then
    if not src then
      TriggerEvent('infinity-notify:sendNotify', message, type)
    else
      TriggerClientEvent('infinity-notify:sendNotify', src, message, type)
    end
  elseif Config.Notify == "rr" then
    if not src then
      exports.rr_uilib:Notify({ msg = message, type = type, style = "dark", duration = 6000, position = "top-right", })
    else
      TriggerClientEvent("rr_uilib:Notify", src, { msg = message, type = type, style = "dark", duration = 6000, position = "top-right", })
    end
  end
end

function toggleItem(give, item, amount) TriggerServerEvent("jim-mechanic:server:toggleItem", give, item, amount) end

function HasItem(items, amount)
  amount = amount or 1
  if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player has required item^7 '^3" .. tostring(items) .. "^7'") end
  local has = exports.ox_inventory:Search('count', items)
  return has >= amount
end

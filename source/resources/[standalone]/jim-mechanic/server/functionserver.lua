local Previewing = {}
local xenonColour = {}
----Commands
--[[QBCore.Commands.Add("test", "", {}, false, function(source, args) TriggerServerEvent('jim-mechanic:server:LoadNitrous', trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(source)))) end)]]
QBCore.Commands.Add("preview", Loc[Config.Lan]["servfunction"].checkmods, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:Preview:Menu", source) end)
QBCore.Commands.Add("checkveh", "Check Performance", {}, false, function(source) TriggerClientEvent("jim-mechanic:client:cuscheck", source) end)
QBCore.Commands.Add("showodo", "Odometer", {}, false, function(source) TriggerClientEvent("jim-mechanic:ShowOdo", source) end)
QBCore.Commands.Add("checkdamage", Loc[Config.Lan]["servfunction"].checkdamage, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:Repair:Check", source, true) end)
QBCore.Commands.Add("checkmods", Loc[Config.Lan]["servfunction"].checkmods, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:Menu:List", source) end)
QBCore.Commands.Add("flipvehicle", Loc[Config.Lan]["servfunction"].flipvehicle, {}, false, function(source) TriggerClientEvent("jim-mechanic:flipvehicle", source) end)
QBCore.Commands.Add("togglesound", Loc[Config.Lan]["servfunction"].togglesound, {}, false, function(source) TriggerClientEvent("jim-mechanic:togglesound", source) end)
QBCore.Commands.Add("cleancar", Loc[Config.Lan]["servfunction"].cleancar, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:cleanVehicle", source, true) end)
QBCore.Commands.Add("hood", Loc[Config.Lan]["servfunction"].hood, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:openDoor", source, 4) end)
QBCore.Commands.Add("trunk", Loc[Config.Lan]["servfunction"].trunk, {}, false, function(source) TriggerClientEvent("jim-mechanic:client:openDoor", source, 5) end)
QBCore.Commands.Add("door", Loc[Config.Lan]["servfunction"].door, { { name = "0-3", help = "Door ID" } }, false,
  function(source, args) TriggerClientEvent("jim-mechanic:client:openDoor", source, args[1]) end)
QBCore.Commands.Add("seat", Loc[Config.Lan]["servfunction"].seat, { { name = "id", help = "Seat ID" } }, false,
  function(source, args) TriggerClientEvent("jim-mechanic:seat", source, args[1]) end)

QBCore.Functions.CreateCallback("jim-mechanic:checkVehicleOwner", function(source, cb, plate)
  MySQL.Async.fetchAll('SELECT * FROM character_vehicles WHERE plate = ?', { plate }, function(result)
    if result[1] then
      cb(true)
    else
      cb(false)
    end
  end)
end)

QBCore.Functions.CreateCallback("jim-mechanic:distGrab", function(source, cb, plate)
  local result = MySQL.scalar.await('SELECT traveldistance FROM character_vehicles WHERE plate = ?', { plate })
  if result then cb(result) else cb("") end
end)

--ODOMETER STUFF
RegisterNetEvent('jim-mechanic:server:UpdateDrivingDistance', function(plate, DistAdd)
  local result = MySQL.scalar.await('SELECT traveldistance FROM character_vehicles WHERE plate = ?', { plate })
  if result then
    if Config.Debug then print("^5Debug^7: ^3UpdateDrivingDistance^7: ^2Travel distance ^7- [^6" .. plate .. "^7]: ^6" .. ((result or 0) + DistAdd) .. "^7") end
    MySQL.Async.execute('UPDATE character_vehicles SET traveldistance = ? WHERE plate = ?', { ((result or 0) + DistAdd), plate })
  end
end)

--SAVE EXTRA DAMAGES
RegisterNetEvent('jim-mechanic:server:saveStatus', function(mechDamages, plate)
  local result = MySQL.scalar.await('SELECT status FROM character_vehicles WHERE plate = ?', { plate })
  if result then
    if Config.Debug then print("^5Debug^7: ^3saveStatus^7: ^2Save Extra Damages^7 - [^6" .. plate .. "^7]: ^4" .. json.encode(mechDamages) .. "^7") end
    MySQL.Async.execute('UPDATE character_vehicles SET status = ? WHERE plate = ?', { json.encode(mechDamages), plate })
  end
end)
--LOAD EXTRA DAMAGES
RegisterNetEvent('jim-mechanic:server:loadStatus', function(props, vehicle)
  if props and type(props.headlightColor) == "table" then
    TriggerEvent("jim-mechanic:server:ChangeXenonColour", vehicle,
      { props.headlightColor[1], props.headlightColor[2], props.headlightColor[3] })
  end
  if GetResourceState('qb-mechanicjob') ~= "started" then return end
  TriggerEvent('vehiclemod:server:setupVehicleStatus', props.plate)
  local result = MySQL.Sync.fetchAll('SELECT status FROM character_vehicles WHERE plate = ?', { props.plate })
  if result[1] then
    local status = json.decode(result[1].status) or {}
    for _, v in pairs({ "radiator", "axle", "brakes", "clutch", "fuel" }) do
      if Config.Debug then print("^5Debug^7: ^3loadStatus^7: [^6" .. props.plate .. "^7] ^2Setting damage of ^6" .. v .. "^2 to^7: ^4" .. (status[v] or 100) .. "^7") end
      TriggerEvent("vehiclemod:server:updatePart", props.plate, v, (status[v] or 100))
    end
  end
end)

--MANUALLY SAVE STASH STUFF
RegisterNetEvent('jim-mechanic:server:saveStash', function(stashId, items)
  if items then
    if Config.Debug then print("^5Debug^7: ^3saveStash^7: ^2Saving stash ^7'^6" .. stashId .. "^7'") end
    for slot, item in pairs(items) do item.description = nil end
    local sql = 'INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
    if Config.qsinventory then sql = 'INSERT INTO qs_stash (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items' end
    MySQL.Async.insert(sql, { ['stash'] = stashId, ['items'] = json.encode(items) })
  end
end)

RegisterNetEvent("jim-mechanic:server:DupeWarn", function(item, newsrc)
  local src = newsrc or source
  local P = QBCore.Functions.GetPlayer(src)
  print("^5DupeWarn: ^1" ..
    P.PlayerData.charinfo.firstname .. " " .. P.PlayerData.charinfo.lastname .. "^7(^1" .. tostring(src) .. "^7) ^2Tried to remove ^7('^3" .. item .. "^7')^2 but it wasn't there^7")
  -- DropPlayer(src, "Attempting to duplicate items")
  print("^5DupeWarn: ^1" ..
    P.PlayerData.charinfo.firstname .. " " .. P.PlayerData.charinfo.lastname .. "^7(^1" .. tostring(src) .. "^7) ^2Dropped from server for item duplicating^7")
end)

local WaxTimer = {}
RegisterNetEvent("jim-mechanic:server:WaxActivator", function(vehicle, time) WaxTimer[vehicle] = time end)
if Config.WaxFeatures then
  CreateThread(function()
    local wait = 10000
    while true do
      Wait(wait)
      if json.encode(WaxTimer) ~= "[]" then wait = 1000 else wait = 20000 end
      for veh in pairs(WaxTimer) do
        WaxTimer[veh] = WaxTimer[veh] - 1
        TriggerClientEvent("jim-mechanic:client:CarWax:WaxTick", -1, veh)
        if WaxTimer[veh] <= 0 then WaxTimer[veh] = nil end
      end
    end
  end)
end

RegisterNetEvent("jim-mechanic:server:preview", function(active, vehicle, plate)
  local src = source
  if active then
    if Config.Debug then print("^5Debug^7: ^3Preview: ^2Player^7(^4" .. src .. "^7)^2 Started previewing^7") end
    Previewing[src] = {
      active = active,
      vehicle = vehicle,
      plate = plate
    }
  else
    if Config.Debug then print("^5Debug^7: ^3Preview: ^2Player^7(^4" .. src .. "^7)^2 Stopped previewing^7") end
    Previewing[src] = nil
  end
end)

AddEventHandler('playerDropped', function()
  local src = source
  if Previewing[src] then
    if Config.Debug then print("^5Debug^7: ^3Preview: ^2Player dropped while previewing^7, ^2resetting vehicle properties^7") end
    local properties = {}
    local result = MySQL.query.await('SELECT mods FROM character_vehicles WHERE plate = ?', { Previewing[src].plate })
    if result[1] then TriggerClientEvent("jim-mechanic:preview:exploitfix", -1, Previewing[src].vehicle, json.decode(result[1].mods)) end
    print("Resetting Vehicles Properties")
  end
  Previewing[src] = nil
end)

RegisterNetEvent("jim-mechanic:server:giveList", function(info)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.AddItem("mechboard", 1, nil, info)
  TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["mechboard"], "add", 1)
end)

QBCore.Functions.CreateUseableItem("mechboard", function(source, item)
  if item.info["vehlist"] == nil then
    triggerNotify("MechBoard", "The board is empty, don't spawn this item", "error", source)
  else
    TriggerClientEvent("jim-mechanic:client:giveList", source, item)
  end
end)

RegisterNetEvent('jim-mechanic:server:updateCar', function(netId, props)
  for _, id in pairs(QBCore.Functions.GetPlayers()) do
    local P = QBCore.Functions.GetPlayer(id)
    TriggerClientEvent("jim-mechanic:forceProperties", P.PlayerData.source, netId, props)
  end
end)

QBCore.Functions.CreateCallback("jim-mechanic:checkCash", function(source, cb)
  local P = QBCore.Functions.GetPlayer(source)
  if Config.Debug then print("^5Debug^7: ^3checkCash^7: ^2Player^7(^6" .. source .. "^7) ^2cash ^7- $^6" .. P.Functions.GetMoney("cash") .. "^7") end
  cb(P.Functions.GetMoney("cash"))
end)

RegisterNetEvent('jim-mechanic:chargeCash', function(cost, society)
  QBCore.Functions.GetPlayer(source).Functions.RemoveMoney("cash", cost)

  if Config.Debug then print("^5Debug^7: ^3chargeCash^7: ^2Adding ^7$^6" .. (math.ceil(cost - (cost / 4))) .. " ^2to account ^7'^6" .. society .. "^7'") end

  if Config.RenewedBanking then
    exports['Renewed-Banking']:addAccountMoney(society, math.ceil(cost - (cost / 4)))
  else
    exports["qb-management"]:AddMoney(society, math.ceil(cost - (cost / 4)))
  end
end)

QBCore.Functions.CreateCallback('jim-mechanic:mechCheck', function(source, cb)
  local dutyList = {}
  --Make list and set them all to false
  for _, v in pairs(Config.JobRoles) do dutyList[tostring(v)] = false end

  for _, v in pairs(QBCore.Functions.GetPlayers()) do
    local Player = QBCore.Functions.GetPlayer(v)
    for l, b in pairs(Config.JobRoles) do
      if Player.PlayerData.job.name == b and Player.PlayerData.job.onduty then dutyList[tostring(b)] = true end
    end
  end
  local result = false
  for _, v in pairs(dutyList) do if v then result = true end end
  cb(result)
end)


--Attempting Duty detection
local DutyList = {}
AddEventHandler('onResourceStart', function(r)
  if GetCurrentResourceName() ~= r then return end
  for _, v in pairs(Config.JobRoles) do DutyList[tostring(v)] = false end
  for _, v in pairs(QBCore.Functions.GetPlayers()) do
    local Player = QBCore.Functions.GetPlayer(v)
    if Player then
      for _, b in pairs(Config.JobRoles) do
        if Player.PlayerData.job.name == b and Player.PlayerData.job.onduty then DutyList[tostring(b)] = true end
      end
    end
  end
end)

RegisterServerEvent("jim-mechanic:mechCheck:updateList", function(job, duty)
  DutyList[tostring(job)] = duty
  for _, v in pairs(QBCore.Functions.GetPlayers()) do
    local Player = QBCore.Functions.GetPlayer(v)
    if Player then
      TriggerClientEvent("jim-mechanic:mechCheck:forceList", Player.PlayerData.source, DutyList)
    end
  end
end)

function sendToDiscord(color, name, message, footer, htmllist, info)
  local embed = {
    {
      ["color"] = color,
      ["thumbnail"] = { ["url"] = info.thumb },
      ["title"] = "**" .. name .. "**",
      ["description"] = message,
      ["footer"] = { ["text"] = footer },
      ["fields"] = htmllist,
    } }
  --local htmllink = "https://discord.com/api/webhooks/988881990042402926/mty6aD6MBNV1FVz8l9JY4DB-IQjUt6x016J_Iwex8fU91Q05XqlKZSsYoJqkAfON-350"
  PerformHttpRequest(info.htmllink, function(err, text, headers)
  end, 'POST', json.encode({ username = info.shopName:sub(4), embeds = embed }), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent("jim-mechanic:server:discordLog", function(info)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local htmllist = {}
  local count = 0
  for i = 1, #info["modlist"] do
    htmllist[#htmllist + 1] = {
      ["name"] = info["modlist"][i]["item"],
      ["value"] = info["modlist"][i]["type"],
      ["inline"] = true
    }
    count = count + 1
    if count == 25 then
      sendToDiscord(
        info.colour,
        "New Order" .. " - " .. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
        info["veh"]:gsub('%<br>', '') .. " - " .. info["vehplate"],
        "Preview Report" .. info.shopName,
        htmllist,
        info
      )
      htmllist = {}
      count = 0
    elseif count == #info["modlist"] - 25 then
      sendToDiscord(
        info.colour,
        "Continued" .. " - " .. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
        info["veh"]:gsub('%<br>', '') .. " - " .. info["vehplate"],
        "Preview Report" .. info.shopName,
        htmllist,
        info
      )
    end
  end
  if #info["modlist"] <= 25 then
    sendToDiscord(
      info.colour,
      "New Order" .. " - " .. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
      info["veh"]:gsub('%<br>', '') .. " - " .. info["vehplate"],
      "Preview Report" .. info.shopName,
      htmllist,
      info
    )
  end
end)

QBCore.Functions.CreateCallback('jim-mechanic:GetXenonColour', function(source, cb) cb(xenonColour) end)

RegisterNetEvent('jim-mechanic:server:ChangeXenonColour', function(vehicle, newColour)
  xenonColour[vehicle] = newColour                                                    -- Update server side
  TriggerClientEvent('jim-mechanic:client:ChangeXenonColour', -1, vehicle, newColour) -- Sync the colour per car between players
end)

RegisterNetEvent('jim-mechanic:server:ChangeXenonStock', function(vehicle)
  xenonColour[vehicle] = nil                                              -- Clear server side
  TriggerClientEvent('jim-mechanic:client:ChangeXenonStock', -1, vehicle) -- Sync the colour per car between players
end)

local VehicleNitrous = {}
local nosColour = {}

AddEventHandler('onResourceStart', function(resource)
  if GetCurrentResourceName() ~= resource then return end
  TriggerEvent("jim-mechanic:GetNosUpdate")
  TriggerEvent("jim-mechanic:GetNosColourUpdate")
end)

--These events sync the VehicleNitrous table with the server, making them able to be synced with the players
RegisterNetEvent('jim-mechanic:server:LoadNitrous', function(Plate)
  VehicleNitrous[Plate] = { hasnitro = 1, level = 100 }
  TriggerClientEvent('jim-mechanic:client:LoadNitrous', -1, Plate)
  TriggerEvent('jim-mechanic:database:LoadNitro', Plate)
end)

RegisterNetEvent('jim-mechanic:server:UnloadNitrous', function(Plate)
  VehicleNitrous[Plate] = nil
  TriggerClientEvent('jim-mechanic:client:UnloadNitrous', -1, Plate)
  TriggerEvent('jim-mechanic:database:UnloadNitro', Plate)
end)

RegisterNetEvent('jim-mechanic:server:UpdateNitroLevel', function(Plate, level)
  VehicleNitrous[Plate] = { hasnitro = 1, level = level }
  TriggerClientEvent('jim-mechanic:client:UpdateNitroLevel', -1, Plate, level)
end)

--Event called on script start to grab Database info about nos
RegisterNetEvent("jim-mechanic:GetNosUpdate", function()
  local result = MySQL.Sync.fetchAll('SELECT * FROM character_vehicles WHERE hasnitro = ?', { 1 })
  if result and result[1] then
    for _, v in pairs(result) do
      if Config.Debug then
        print("^5Debug^7: ^3GetNosUpdate^7: ^2VehicleNitrous^7[^6" ..
          tostring(v["plate"]) .. "^7] = { ^2level ^7= ^6" .. tonumber(v["noslevel"]) .. "^7, ^2hasnitro ^7= ^6" .. tostring(v["hasnitro"]) .. "^7 }")
      end
      VehicleNitrous[v["plate"]] = { hasnitro = v["hasnitro"], level = tonumber(v["noslevel"]), }
    end
    if Config.Debug then print("^5Debug^7: ^3GetNosUpdate^7: ^2VehicleNitrous Results Found^7: ^6" .. #result .. "^7") end
  else
    if Config.Debug then print("^5Debug^7: ^3GetNosUpdate^7: ^2Checked Database and found no vehicles with NOS^7") end
  end
end)

--Callback to send Database info to Client
QBCore.Functions.CreateCallback('jim-mechanic:GetNosLoaded', function(source, cb) cb(VehicleNitrous) end)

--Database interactions
RegisterNetEvent('jim-mechanic:database:LoadNitro',
  function(Plate) MySQL.Async.execute('UPDATE character_vehicles SET noslevel = ?, hasnitro = ? WHERE plate = ?', { 100, true, Plate }) end)
RegisterNetEvent('jim-mechanic:database:UnloadNitro',
  function(plate) MySQL.Async.execute('UPDATE character_vehicles SET noslevel = ?, hasnitro = ? WHERE plate = ?', { 0, false, plate }) end)
RegisterNetEvent('jim-mechanic:database:UpdateNitroLevel', function(plate, level)
  if Config.Debug then print("^5Debug^7: ^2Database ^6noslevel^2 updated " .. plate .. " " .. level .. "^7") end
  MySQL.Async.execute('UPDATE character_vehicles SET noslevel = ? WHERE plate = ?', { level, plate })
end)

--Syncing stuff
RegisterNetEvent('jim-mechanic:server:SyncPurge', function(netId, enabled, size) TriggerClientEvent('jim-mechanic:client:SyncPurge', -1, netId, enabled, size) end)
RegisterNetEvent('jim-mechanic:server:SyncTrail', function(netId, enabled) TriggerClientEvent('jim-mechanic:client:SyncTrail', -1, netId, enabled) end)
RegisterNetEvent('jim-mechanic:server:SyncFlame', function(netId, scale) TriggerClientEvent('jim-mechanic:client:SyncFlame', -1, netId, scale) end)

QBCore.Functions.CreateUseableItem("noscolour", function(source, item) TriggerClientEvent("jim-mechanic:client:NOS:rgbORhex", source) end)

--Event called on script start to grab Database info about nos
RegisterNetEvent("jim-mechanic:GetNosColourUpdate", function()
  local result = MySQL.Sync.fetchAll("SELECT `nosColour`, `plate` FROM `character_vehicles` WHERE 1")
  if result and result[1] then
    for _, v in pairs(result) do
      if v["nosColour"] then
        json.decode(v["nosColour"])
        local newColour = json.decode(v["nosColour"])
        if Config.Debug then
          print("^5Debug^7: ^3nosColour^7[^6" ..
            tostring(v["plate"]) .. "^7] = { ^2RBG^7: ^6" .. newColour[1] .. "^7, ^6" .. newColour[2] .. "^7, ^6" .. newColour[3] .. " ^7}")
        end
        nosColour[v["plate"]] = newColour
      end
    end
  end
end)

--Callback to send Database info to Client
QBCore.Functions.CreateCallback('jim-mechanic:GetNosColour', function(source, cb) cb(nosColour) end)

-- This event is to make it so every car's purge colour is synced
-- If you change the colour of the purge on a car, everyone who gets in THAT car will spray this colour
RegisterNetEvent('jim-mechanic:server:ChangeColour', function(Plate, newColour)
  nosColour[Plate] = newColour                                                 -- Update server side
  TriggerClientEvent('jim-mechanic:client:ChangeColour', -1, Plate, newColour) -- Sync the colour per car between players
  TriggerEvent('jim-mechanic:database:ChangeColour', Plate, newColour)         -- Update Database with new colour
end)

RegisterNetEvent('jim-mechanic:database:ChangeColour', function(plate, newColour)
  if Config.Debug then print("Update Purge Colour") end
  MySQL.Async.execute('UPDATE character_vehicles SET nosColour = ? WHERE plate = ?', { json.encode(newColour), plate })
end)

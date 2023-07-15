vehicles = {}
categories = {}

CreateThread(function()
  if Config.Core == "ESX" then
    vehicles = MySQL.query.await('SELECT * FROM character_vehicles')
    categories = MySQL.query.await('SELECT * FROM vehicle_categories')
  end
end)

-- DO NOT TOUCH THIS FILE IF YOU DONT KNOW WHAT YOU ARE DOING

--  ██████ ██   ██  █████  ███    ██  ██████  ███████     ██████  ██       █████  ████████ ███████
-- ██      ██   ██ ██   ██ ████   ██ ██       ██          ██   ██ ██      ██   ██    ██    ██
-- ██      ███████ ███████ ██ ██  ██ ██   ███ █████       ██████  ██      ███████    ██    █████
-- ██      ██   ██ ██   ██ ██  ██ ██ ██    ██ ██          ██      ██      ██   ██    ██    ██
--  ██████ ██   ██ ██   ██ ██   ████  ██████  ███████     ██      ███████ ██   ██    ██    ███████
RegisterServerEvent("snipe-menu:server:changePlate", function(oldplate, newPlate)
  local src = source
  if src ~= 0 and onlineAdmins[src] then
    local IsVehicleOwned = MySQL.Sync.fetchAll('SELECT plate FROM ' .. Config.GarageTables[Config.Core].vehicle_table .. ' WHERE plate = ?', { oldplate })
    if IsVehicleOwned[1] == nil then
      ShowNotification(src, 'This vehicle is not owned by anyone', 'error')
      return
    end
    local platecheck = MySQL.Sync.fetchAll('SELECT plate FROM ' .. Config.GarageTables[Config.Core].vehicle_table .. ' WHERE plate = ?', { newPlate })
    if platecheck[1] ~= nil then
      ShowNotification(src, "Vehicle Plate already exists!", "error")
      return
    end
    MySQL.Async.execute('UPDATE ' .. Config.GarageTables[Config.Core].vehicle_table .. ' SET plate = ? WHERE plate = ?', { newPlate, oldplate })
    SendLogs(src, "triggered", Config.Locales["plate_change_used"] .. oldplate .. " to " .. newPlate)
    TriggerClientEvent('snipe-menu:client:changePlate', src, newPlate)
  else
    SendLogs(src, "exploit", Config.Locales["change_plate_exploit_event"])
  end
end)

--  ██████  ██ ██    ██ ███████  ██████  █████  ██████
-- ██       ██ ██    ██ ██      ██      ██   ██ ██   ██
-- ██   ███ ██ ██    ██ █████   ██      ███████ ██████
-- ██    ██ ██  ██  ██  ██      ██      ██   ██ ██   ██
--  ██████  ██   ████   ███████  ██████ ██   ██ ██   ██

RegisterServerEvent("snipe-menu:server:givecar", function(playerid, carname, properties, type)
  local src = source
  local garageType = "car"
  local garageName = "pillboxgarage"
  if src ~= 0 and onlineAdmins[src] then
    if Config.Garage == "cd" then
      if type == "boats" then
        garageType = "boat"
      elseif type == "air" then
        garageType = "air"
      end
      garageName = "A"
    elseif Config.Core == "QBCore" and Config.Garage == "none" then
      if type == "boats" then
        garageName = "lsymc"
      elseif type == "air" then
        garageName = "intairport"
      end
    end

    if Config.Garage == "cd" then
      if Config.Core == "QBCore" then
        local otherPlayer = QBCore.Functions.GetPlayer(playerid)
        local cid = otherPlayer.PlayerData.citizenid
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage_id, garage_type, in_garage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {
          otherPlayer.PlayerData.license,
          cid,
          carname,
          GetHashKey(carname),
          json.encode(properties.props),
          properties.props.plate,
          garageName,
          garageType,
          1
        })
      elseif Config.Core == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, garage_id, garage_type, in_garage) VALUES (?, ?, ?, ?, ?, ?)', {
          xPlayer.identifier,
          properties.props.plate,
          json.encode(properties.props),
          garageName,
          garageType,
          1
        })
      end
    else
      if Config.Core == "QBCore" then
        local otherPlayer = QBCore.Functions.GetPlayer(playerid)
        local cid = otherPlayer.PlayerData.citizenid

        AG.CreateVehicle({ model = carname, owner = cid, garage = garageName, shared = 0 })
      elseif Config.Core == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        MySQL.insert('INSERT INTO owned_vehicles (owner, vehicle, plate, stored, type) VALUES (?, ?, ?, ?, ?)', {
          xPlayer.identifier,
          json.encode(properties.props),
          properties.props.plate,
          true,
          garageType
        })
      end
    end
  else
    SendLogs(src, "exploit", Config.Locales["give_car_exploit_event"])
  end
end)


--  █████  ██████  ███    ███ ██ ███    ██  ██████  █████  ██████
-- ██   ██ ██   ██ ████  ████ ██ ████   ██ ██      ██   ██ ██   ██
-- ███████ ██   ██ ██ ████ ██ ██ ██ ██  ██ ██      ███████ ██████
-- ██   ██ ██   ██ ██  ██  ██ ██ ██  ██ ██ ██      ██   ██ ██   ██
-- ██   ██ ██████  ██      ██ ██ ██   ████  ██████ ██   ██ ██   ██
RegisterServerEvent("snipe-menu:server:addAdminCar", function(carname, properties, type)
  local src = source
  if src ~= 0 and onlineAdmins[src] then
    local result = MySQL.query.await('SELECT plate FROM ' .. Config.GarageTables[Config.Core].vehicle_table .. ' WHERE plate = ?', { properties.plate })
    if result[1] ~= nil then
      ShowNotification(src, Config.Locales["car_already_owned"])
      return
    end
    local query = ""
    if Config.Core == "QBCore" and Config.Garage == "cd" then
      query = 'INSERT INTO ' ..
          Config.GarageTables[Config.Core].vehicle_table .. ' (license, citizenid, vehicle, hash, mods, plate, garage_id, garage_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)'
    elseif Config.Core == "ESX" and Config.Garage == "cd" then
      query = 'INSERT INTO ' .. Config.GarageTables[Config.Core].vehicle_table .. ' (owner, vehicle, plate, garage_type) VALUES (?, ?, ?, ?)'
    elseif Config.Core == "ESX" and Config.Garage == "none" then
      query = 'INSERT INTO ' .. Config.GarageTables[Config.Core].vehicle_table .. ' (owner, vehicle, plate) VALUES (?, ?, ?)'
    elseif Config.Core == "QBCore" and Config.Garage == "none" then
      query = 'INSERT INTO ' .. Config.GarageTables[Config.Core].vehicle_table .. ' (license, citizenid, vehicle, hash, mods, plate, garage) VALUES (?, ?, ?, ?, ?, ?, ?)'
    end

    if query == "" then
      print("Error: Query is empty in addAdminCar. You have not selected a core or garage type.")
      return
    end
    if Config.Garage == "cd" then
      if type == "boats" then
        garageType = "boat"
      elseif type == "air" then
        garageType = "air"
      end
      garageName = "A"
    elseif Config.Core == "QBCore" and Config.Garage == "none" then
      if type == "boats" then
        garageName = "lsymc"
      elseif type == "air" then
        garageName = "intairport"
      end
    end
    if Config.Core == "QBCore" and Config.Garage == 'cd' then
      local otherPlayer = QBCore.Functions.GetPlayer(src)
      local cid = otherPlayer.PlayerData.citizenid
      MySQL.Async.execute(query, {
        otherPlayer.PlayerData.license,
        cid,
        carname,
        GetHashKey(carname),
        json.encode(properties),
        properties.plate,
        garageName,
        garageType,
      })
    elseif Config.Core == "ESX" and Config.Garage == "cd" then
      local xPlayer = ESX.GetPlayerFromId(src)
      MySQL.Async.execute(query, {
        xPlayer.identifier,
        json.encode(properties),
        properties.plate,
        garageType
      })
    elseif Config.Core == "ESX" and Config.Garage == "none" then
      local xPlayer = ESX.GetPlayerFromId(src)
      MySQL.Async.execute(query, {
        xPlayer.identifier,
        json.encode(properties),
        properties.plate
      })
    elseif Config.Core == "QBCore" and Config.Garage == "none" then
      local otherPlayer = QBCore.Functions.GetPlayer(src)
      local cid = otherPlayer.PlayerData.citizenid

      AG.CreateVehicle({ model = carname, owner = cid, garage = garageName, shared = 0, out = 1, plate = properties.plate })
    end
    ShowNotification(src, Config.Locales["you_own_the_car"])
    SendLogs(src, "triggered", Config.Locales["admin_car_used"] .. " " .. carname)
  else
    SendLogs(src, "exploit", Config.Locales["admin_car_exploit"])
  end
end)

CreateCallback("snipe-menu:server:getAllVehicles", function(source, cb)
  for i = 1, #vehicles do
    local vehicle = vehicles[i]
    for j = 1, #categories do
      local category = categories[j]
      if category.name == vehicle.category then
        vehicle.categoryLabel = category.label
        break
      end
    end
  end
  cb(vehicles)
end)

--  ██████  ██    ██ ████████ ███████ ██ ██████  ███████     ██    ██ ███████ ██   ██ ██  ██████ ██      ███████ ███████
-- ██    ██ ██    ██    ██    ██      ██ ██   ██ ██          ██    ██ ██      ██   ██ ██ ██      ██      ██      ██
-- ██    ██ ██    ██    ██    ███████ ██ ██   ██ █████       ██    ██ █████   ███████ ██ ██      ██      █████   ███████
-- ██    ██ ██    ██    ██         ██ ██ ██   ██ ██           ██  ██  ██      ██   ██ ██ ██      ██      ██           ██
--  ██████   ██████     ██    ███████ ██ ██████  ███████       ████   ███████ ██   ██ ██  ██████ ███████ ███████ ███████

CreateCallback("snipe-menu:server:getOutsideVehicles", function(source, cb)
  --TODO ADD AGVEHICLE
  local returnData = {}
  local vehicleColumn = "vehicle"
  local query = 'SELECT * FROM ' .. Config.GarageTables[Config.Core].vehicle_table .. ' WHERE in_garage = ?'
  if Config.Core == "QBCore" and Config.Garage == "none" then
    query = 'SELECT * FROM ' .. Config.GarageTables[Config.Core].vehicle_table .. ' WHERE state = ?'
  elseif Config.Core == "ESX" and Config.Garage == "none" then
    query = 'SELECT * FROM ' .. Config.GarageTables[Config.Core].vehicle_table .. ' WHERE stored = ?'
  end

  local result = MySQL.query.await(query, { 0 })
  if result ~= nil then
    for k, v in pairs(result) do
      if Config.Core == "QBCore" then
        returnData[#returnData + 1] = {
          id = v.vehicle,
          name = v.plate,
        }
      else
        returnData[#returnData + 1] = {
          id = k, -- since there is no vehicle name stored in ESX, we use the key
          name = v.plate,
        }
      end
    end
    cb(returnData)
  else
    cb(nil)
  end
end)

RegisterServerEvent("snipe-menu:server:changeVehicleState", function(plate)
  --TODO ADD AGVEHICLE
  local src = source
  if src ~= 0 and onlineAdmins[src] then
    local query = 'UPDATE ' .. Config.GarageTables[Config.Core].vehicle_table .. ' SET in_garage = ? WHERE plate = ?'
    if Config.Core == "QBCore" and Config.Garage == "none" then
      query = 'UPDATE ' .. Config.GarageTables[Config.Core].vehicle_table .. ' SET state = ? WHERE plate = ?'
    elseif Config.Core == "ESX" and Config.Garage == "none" then
      query = 'UPDATE ' .. Config.GarageTables[Config.Core].vehicle_table .. ' SET stored = ? WHERE plate = ?'
    end

    MySQL.query.await(query, { 1, plate })
    SendLogs(src, "triggered", Config.Locales["changed_vehicle_state"] .. plate)
  else
    SendLogs(src, "exploit", Config.Locales["changed_vehicle_state_exploit"])
  end
end)

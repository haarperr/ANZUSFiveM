local MySQL = MySQL

-- Return the correct indefinite article for the next word
local function IndefiniteArticle(nextWord)
  local firstLetter = nextWord:lower():sub(1, 1)
  if firstLetter == "a" or
      firstLetter == "e" or
      firstLetter == "i" or
      firstLetter == "o" or
      firstLetter == "u" then
    return "an"
  else
    return "a"
  end
end

-- Register a server callback to get the user's premium vehicles
-- Use QB-Core's server callback to get the data
lib.callback.register('premium-vehicleshop:server:getPremiumVehicles', function(source, cb)
  local license = GetPlayerIdentifierByType(source, "license")
  if not license then return {} end

  local license = license:sub(9)
  local result = MySQL.query.await('SELECT id, model, purchased FROM premium_vehicles WHERE license = ?', { license })
  if not result then return {} end

  for i = 1, #result do
    local vehicle = result[i]
    local vehicleData = AG.GetVehicleData(vehicle.model)
    if vehicleData then vehicle.data = vehicleData end
  end

  return result
end)

RegisterNetEvent('premium-vehicleshop:server:purchaseVehicle', function(data)
  local source = source

  if not data or not data.vehicle then
    TriggerClientEvent('QBCore:Notify', source, "An error occurred purchasing the vehicle", "error")
    return
  end

  local id = tonumber(data.vehicle)
  if not id then
    TriggerClientEvent('QBCore:Notify', source, "An error occurred purchasing the vehicle", "error")
    return
  end

  local license = GetPlayerIdentifierByType(source, "license")
  if not license then
    TriggerClientEvent('QBCore:Notify', source, "An error occurred purchasing the vehicle", "error")
    return
  end
  license = license:sub(9)

  local Player = QBCore.Functions.GetPlayer(source)
  if not Player then
    TriggerClientEvent('QBCore:Notify', source, "An error occurred purchasing the vehicle", "error")
    return
  end

  -- Get the vehicle data
  local row = MySQL.single.await('SELECT * FROM premium_vehicles WHERE id = ?', { id })
  if not row then
    TriggerClientEvent('QBCore:Notify', source, "No vehicle found with that id.", "error")
    return
  end

  -- Check if the vehicle has already been purchased
  if row.purchased ~= 0 then
    TriggerClientEvent('QBCore:Notify', source, "You've already purchased this vehicle.", "error")
    return
  end

  -- Get the vehicle data
  local vehicleData = AG.GetVehicleData(row.model)
  if not vehicleData then
    TriggerClientEvent('QBCore:Notify', source, "An error occurred purchasing the vehicle", "error")
    return
  end

  -- Check if the player has enough money
  if Player.PlayerData.money.bank < vehicleData["price"] then
    TriggerClientEvent('QBCore:Notify', source, "You don't have enough money in your bank to purchase this vehicle.", "error")
    return
  end

  -- Get the vehicle name
  local vehicleName = vehicleData["name"]

  -- Take the money from the player
  exports.pefcl:removeBankBalance(source,
    { amount = vehicleData["price"], message = string.format("Purchased %s %s from the premium vehicle shop", IndefiniteArticle(vehicleName), vehicleName) })

  -- Add the vehicle to the player's garage
  local vehicleId = AG.CreateVehicle({ model = row.model, owner = Player.PlayerData.citizenid, garage = 'legionsquare' })

  -- Update the vehicle as purchased
  local affectedRows = MySQL.update.await('UPDATE premium_vehicles SET purchased = 1, vehicle = ? WHERE id = ?', { vehicleId, id })
  if affectedRows <= 0 then
    TriggerClientEvent('QBCore:Notify', source, "An error occurred purchasing the vehicle", "error")
    return
  end

  -- Notify the player
  TriggerClientEvent('QBCore:Notify', source, "You've purchased " .. IndefiniteArticle(vehicleName) .. " " .. vehicleName .. " for $" .. Config.FormatNumber(vehicleData["price"]),
    "success")
end)

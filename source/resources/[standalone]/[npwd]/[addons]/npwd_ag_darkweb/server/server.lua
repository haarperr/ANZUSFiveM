local MySQL = MySQL
local QBCore = exports['qb-core']:GetCoreObject()

local ped = nil

lib.callback.register('npwd:ag_darkweb:checkout', function(source, data, wallet)
  local Player = QBCore.Functions.GetPlayer(source)

  local ids = {}
  for _, item in ipairs(data) do
    table.insert(ids, item.id)
  end

  local idList = table.concat(ids, ",")
  local query = string.format("SELECT * FROM `darkweb_stock` WHERE `id` IN (%s) AND `stock` > 0", idList)
  local stock = MySQL.query.await(query, {})

  if not stock or #stock < #data then
    return TriggerClientEvent('ox_lib:notify', source, { type = 'warning', description = 'Stock has updated, your checkout has been cancelled', duration = 5000 })
  end

  local sum = 0
  for i = 1, #data, 1 do
    sum += (data[i].amount * data[i].price)
  end

  local walletInfo = exports.ag_crypto:checkWalletByPasscode(wallet.key_phrase)

  if not walletInfo then
    return TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Crypto Exchange', description = 'Invalid wallet provided' })
  end

  if walletInfo.value < sum then
    return TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Crypto Exchange', description = 'Insufficient funds in the wallet' })
  end

  TriggerEvent('ag_crypto:removeWalletValue', { wallet = walletInfo.wallet, amount = sum })

  local queries = {}

  for _, item in ipairs(data) do
    queries[#queries + 1] = {
      query = "UPDATE `darkweb_stock` SET `stock` = `stock` - ? WHERE id = ?",
      values = { item.amount, item.id }
    }

    queries[#queries + 1] = {
      query = "INSERT INTO `darkweb_purchases` (`id`, `buyer`, `amount`) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE `amount` = `amount` + VALUES(`amount`)",
      values = { item.id, Player.PlayerData.citizenid, item.amount }
    }
  end

  local success = MySQL.transaction.await(queries)

  if not success then return false end

  local msg = ''

  for i = 1, #data, 1 do
    msg = ('%s %dx %s\n'):format(msg, data[i].amount, data[i].label)
  end

  local coords = Config.Pickup.locations[math.random(#Config.Pickup.locations)]

  exports.npwd:emitMessage({
    senderNumber = 'M3Market',
    targetNumber = Player.PlayerData.phone_number,
    message = ('M3Market Purchase\n\nYou have successfully purchased %s\nThe pickup location is within this message'):format(msg),
    embed = {
      type = "location",
      coords = { coords.x, coords.y, coords.z },
      phoneNumber = 'M3Market'
    }
  })
  TriggerClientEvent('ag_darkweb:spawnPed', source, { coords = coords })
  return stock
end)

lib.callback.register('npwd:ag_darkweb:getItems', function(source)
  local data = MySQL.query.await('SELECT * FROM `darkweb_stock`')
  return data
end)

lib.callback.register('ag_darkweb:getReadyPickup', function(source)
  local Player = QBCore.Functions.GetPlayer(source)
  local items = MySQL.query.await('SELECT dwp.*, dws.`item`, dws.`label` FROM `darkweb_purchases` dwp JOIN `darkweb_stock` dws ON dwp.`id` = dws.`id` WHERE dwp.`buyer` = ?',
    { Player.PlayerData.citizenid })

  return items
end)

RegisterNetEvent('ag_darkweb:pickupItems', function()
  local src = source

  local Player = QBCore.Functions.GetPlayer(src)

  local items = MySQL.query.await('SELECT dwp.*, dws.`item` FROM `darkweb_purchases` dwp JOIN `darkweb_stock` dws ON dwp.`id` = dws.`id` WHERE dwp.`buyer` = ?',
    { Player.PlayerData.citizenid })

  if #items == 0 then return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'You do not have anything awaiting pickup' }) end

  local toUpdate = {}
  local completed = {}

  for i = 1, #items, 1 do
    local item = items[i]

    local amountCanCarry = exports.ox_inventory:CanCarryAmount(src, item.item)
    if amountCanCarry == 0 then goto skip end

    local carry = item.amount
    if amountCanCarry < item.amount then
      carry = amountCanCarry
      toUpdate[#toUpdate + 1] = {
        query = 'UPDATE `darkweb_purchases` SET `amount` = `amount` - ? WHERE `id` = ? AND `buyer` = ?',
        values = { carry, item.id, Player.PlayerData.citizenid }
      }
    else
      toUpdate[#toUpdate + 1] = {
        query = 'DELETE FROM `darkweb_purchases` WHERE `id` = ? AND `buyer` = ?',
        values = { item.id, Player.PlayerData.citizenid }
      }
      completed[#completed + 1] = true
    end

    exports.ox_inventory:AddItem(src, item.item, carry)
    ::skip::
  end

  local success = MySQL.transaction.await(toUpdate)

  if #completed == #items then
    TriggerClientEvent('ag_darkweb:deletePed', src)
  else
    TriggerClientEvent('ox_lib:notify', src, { type = 'warning', description = 'You do not have enough space to carry everything, please come back', duration = 5000 })
  end
end)

lib.callback.register('ag_darkweb:getPed', function()
  return ped
end)

AddEventHandler('onResourceStart', function(resource)
  if resource ~= GetCurrentResourceName() then return end

  coords = Config.Pickup.locations[math.random(#Config.Pickup.locations)]
end)

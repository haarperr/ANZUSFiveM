RegisterNetEvent('ag_fishing:server:sellFish', function(data)
  local src = source
  if not data then return end
  if not data.item or not data.amount then return end

  local item = data.item
  local amount = data.amount

  local Player = QBCore.Functions.GetPlayer(src)
  local playerCoords = GetEntityCoords(GetPlayerPed(src))
  if #(playerCoords - Config.SellLocation.xyz) > 5.0 then
    lib.logger(Player.PlayerData.source, 'sellFish', ('Player (%s) is more than 5.0 from the sell location (%s)'):format(playerCoords, Config.SellLocation), 'type:critical')
    return
  end

  if item == 'all' then
    local sold = {}
    local value = 0
    for k, v in pairs(Config.SellPrices) do
      local count = exports.ox_inventory:Search(src, 'count', k)
      if count > 0 then
        value += v.price * count
        exports.ox_inventory:RemoveItem(src, k, count)
        sold[#sold+1] = {message = ('Sold %s x%d for %d'):format(k, count, v.price * count), item = k, count = count, amount = v.price * count, type = 'added',
        currency = 'cash' }
      end
    end

    Wait(2000)
    Player.Functions.AddMoney('cash', value)

    for i = 1, #sold, 1 do
      local msg = sold[i]
      lib.logger(src, 'sellFish', msg, 'economy:sell')
    end

    return TriggerClientEvent('ox_lib:notify', src, { type = 'success', title = locale('notify_title'), description = locale('sold_everything', value) })
  end

  local count = exports.ox_inventory:Search(src, 'count', item)
  if not count or (count < amount) then return false end

  local value = Config.SellPrices[item].price * amount
  exports.ox_inventory:RemoveItem(src, item, amount)

  lib.logger(src, 'sellFish', {
    message = ('Sold %s x%d for %d'):format(item, amount, value),
    item = item,
    amount = value,
    count = amount,
    type = 'added',
    currency = 'cash'
  }, 'economy:sell')

  Wait(2000)
  Player.Functions.AddMoney('cash', value)

  TriggerClientEvent('ox_lib:notify', src, { type = 'success', title = locale('notify_title'), description = locale('sold_single', Config.SellPrices[item].label, amount, value) })
end)

lib.callback.register('ag_fishing:getSellPrices', function()
  return Config.SellPrices
end)

---@param resourceName string
AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  for key, value in pairs(Config.SellPrices) do
    local item = exports.ox_inventory:Items(key)
    local rnd = math.random(value.min, value.max)
    Config.SellPrices[key].price = rnd
    Config.SellPrices[key].label = item.label

    lib.logger(-1, 'setPrices', {
      message = ('%s set to %d'):format(key, rnd),
      amount = rnd,
      item = key,
      type = 'set'
    }, 'economy:price')

  end
end)

lib.callback.register('ag_fishing:server:canSellFish', function(source, data)
  local item = data.item
  local amount = data.amount

  if item == 'all' then
    local can = false
    for key, _ in pairs(Config.SellPrices) do
      local count = exports.ox_inventory:Search(source, 'count', key)
      if count > 0 then
        can = true
        break
      end
    end

    return can
  end

  local count = exports.ox_inventory:Search(source, 'count', item)
  if not count or (count < amount) then return false end

  return true
end)

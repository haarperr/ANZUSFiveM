math.randomseed(os.time())
lib.locale()

local peds = {
  processer = {},
  seller = {}
}

RegisterNetEvent('ag_lumberjack:server:chopTree', function()
  local src = source

  for k, v in pairs(Config.ChopItems) do
    local amount = math.random(v.min, v.max)
    local canCarry = exports.ox_inventory:CanCarryItem(src, k, amount)
    if not canCarry then
      TriggerClientEvent('ox_lib:notify', src, { type = 'error', title = 'Lumberjacking', description = locale('cannot_carry') })
      break
    end

    exports.ox_inventory:AddItem(src, k, amount)
    lib.logger(src, 'chopTree',
      {
        message = ('Received %s x%d'):format(k, amount),
        item = k,
        amount = amount,
        type = 'added'
      }, 'economy:item')
  end
end)

RegisterNetEvent('ag_lumberjack:server:sell', function(data)
  local src = source

  if #(GetEntityCoords(GetPlayerPed(src)) - vec3(Config.Seller.coords.x, Config.Seller.coords.y, Config.Seller.coords.z)) > 5.0 then
    return lib.logger(src, 'sell',
      'Player tried to execute this event when more than 5.0 from seller', 'type:critical')
  end

  local count = exports.ox_inventory:Search(src, 'count', data.item)

  if count <= 0 then
    return
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', title = 'Lumberjacking', description = locale('no_to_sell', Config.Seller.items[data.item].label) })
  end

  local Player = QBCore.Functions.GetPlayer(src)

  exports.ox_inventory:RemoveItem(src, data.item, count)
  local value = Config.Seller.items[data.item].price * count
  Player.Functions.AddMoney('cash', value, ("Sold %s x%d"):format(data.item, count))

  lib.logger(src, 'sell', {
    message = ('Sold %s x%d for %d'):format(data.item, count, value),
    item = data.item,
    amount = value,
    count = count,
    currency = 'cash',
    type = 'added'
  }, 'economy:sell')

  TriggerClientEvent('ox_lib:notify', src, { type = 'success', title = 'Lumberjacking', description = locale('sold', Config.Seller.items[data.item].label, value) })
end)

RegisterNetEvent('ag_lumberjack:server:processLumber', function()
  local src = source

  if #(GetEntityCoords(GetPlayerPed(src)) - vec3(Config.Processer.coords.x, Config.Processer.coords.y, Config.Processer.coords.z)) > 5.0 then
    return lib.logger(src, 'processLumber',
      'Player tried to execute this event when more than 5.0 from processer', 'type:critical')
  end

  for key, value in pairs(Config.Processer.items) do
    local count = exports.ox_inventory:Search(src, 'count', key)
    if count < value.required then goto skip end

    local amount = count / value.required

    exports.ox_inventory:RemoveItem(src, key, value.required * amount)
    exports.ox_inventory:AddItem(src, value.to.item, value.to.amount * amount)
    lib.logger(src, 'processLumber',
      {
        message = ('Received %s x%d'):format(value.to.item, value.to.amount * amount),
        item = value.to.item,
        amount = value.to.amount * amount,
        type = 'added'
      }, 'economy:item')

    ::skip::
  end
end)

local function createPed(model, coords)
  local ped = CreatePed(0, model, coords.x, coords.y, coords.z, coords.w, true, false)
  local netid = NetworkGetNetworkIdFromEntity(ped)
  FreezeEntityPosition(ped, true)
  return netid
end

CreateThread(function()
  local netid = createPed(Config.Processer.ped, Config.Processer.coords)
  peds.processer[#peds.processer + 1] = netid

  netid = createPed(Config.Seller.ped, Config.Seller.coords)
  peds.seller[#peds.seller + 1] = netid

  for index, value in pairs(Config.Seller.items) do
    for item, data in pairs(exports.ox_inventory:Items()) do
      if index == item then
        Config.Seller.items[index].price = math.random(value.min, value.max)
        Config.Seller.items[index].label = data.label
        lib.logger(-1, 'setPrices', {
          message = ('%s set to %d'):format(index, Config.Seller.items[index].price),
          amount = Config.Seller.items[index].price,
          item = index,
          type = 'set'
        }, 'economy:price')
        break
      end
    end
  end
end)

lib.callback.register('ag_lumberjack:getProcesserPeds', function(source)
  return peds.processer
end)

lib.callback.register('ag_lumberjack:getSellerPeds', function(source)
  return peds.seller
end)

lib.callback.register('ag_lumberjack:getSellerConfig', function(source)
  return Config.Seller
end)

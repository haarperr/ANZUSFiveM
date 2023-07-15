local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-pawnshop:server:sellPawnItems', function(itemName, itemAmount, itemPrice)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local totalPrice = (tonumber(itemAmount) * itemPrice)
  local playerCoords = GetEntityCoords(GetPlayerPed(src))
  local dist
  for _, v in pairs(Config.PawnLocation) do
    dist = #(playerCoords - vec3(v.x, v.y, v.z))
    if #(playerCoords - vec3(v.x, v.y, v.z)) < 2 then
      dist = #(playerCoords - vec3(v.x, v.y, v.z))
      break
    end
  end
  if dist > 5 then
    lib.logger(src, 'sellPawnItems',
      ('Tried to sell pawn items when %s from ped'):format(tostring(dist)), 'type', 'critical')
    return
  end
  if Player.Functions.RemoveItem(itemName, tonumber(itemAmount)) then
    if Config.BankMoney then
      Player.Functions.AddMoney('bank', totalPrice)
    else
      Player.Functions.AddMoney('cash', totalPrice)
    end

    lib.logger(src, 'sellPawnItems', {
      message = ('Sold %s x%d for %d'):format(itemName, tonumber(itemAmount), totalPrice),
      item = itemName,
      amount = totalPrice,
      count = tonumber(itemAmount),
      currency = Config.BankMoney and 'bank' or 'cash',
      type = 'added'
    }, 'economy:sell')


    TriggerClientEvent('QBCore:Notify', src, Lang:t('success.sold', { value = tonumber(itemAmount), value2 = exports.ox_inventory:Items(itemName).label, value3 = totalPrice }),
      'success')
  else
    TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
  end
  TriggerClientEvent('qb-pawnshop:client:openMenu', src)
end)

RegisterNetEvent('qb-pawnshop:server:meltItemRemove', function(itemName, itemAmount, item)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem(itemName, itemAmount) then
    local meltTime = (tonumber(itemAmount) * item.time)
    TriggerClientEvent('qb-pawnshop:client:startMelting', src, item, itemAmount, (meltTime * 60000 / 1000))
    TriggerClientEvent('QBCore:Notify', src, Lang:t('info.melt_wait', { value = meltTime }), 'primary')
  else
    TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
  end
end)

RegisterNetEvent('qb-pawnshop:server:pickupMelted', function(item)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local playerCoords = GetEntityCoords(GetPlayerPed(src))
  local dist
  for _, v in pairs(Config.PawnLocation) do
    dist = #(playerCoords - vec3(v.x, v.y, v.z))
    if #(playerCoords - vec3(v.x, v.y, v.z)) < 2 then
      dist = #(playerCoords - vec3(v.x, v.y, v.z))
      break
    end
  end
  if dist > 5 then
    lib.logger(src, 'pickupMelted',
      ('Tried to pickup items when %s from ped'):format(tostring(dist)), 'type', 'critical')
    return
  end
  for _, v in pairs(item.items) do
    local meltedAmount = v.amount
    for _, m in pairs(v.item.reward) do
      local rewardAmount = m.amount
      if Player.Functions.AddItem(m.item, (meltedAmount * rewardAmount)) then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.items_received', { value = (meltedAmount * rewardAmount), value2 = exports.ox_inventory:Items(m.item).label }),
          'success')
      else
        TriggerClientEvent('qb-pawnshop:client:openMenu', src)
        return
      end
    end
  end
  TriggerClientEvent('qb-pawnshop:client:resetPickup', src)
  TriggerClientEvent('qb-pawnshop:client:openMenu', src)
end)

lib.callback.register('qb-pawnshop:server:getInv', function(source)
  local Player = QBCore.Functions.GetPlayer(source)
  local inventory = Player.PlayerData.items
  return inventory
end)

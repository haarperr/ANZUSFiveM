lib.locale()
local itemLabels = {}

AddEventHandler('onResourceStart', function(resource)
  if GetCurrentResourceName() ~= resource then return end

  for item, data in pairs(exports.ox_inventory:Items()) do
    for i = 1, #Config.CornerSelling.items do
      if item == Config.CornerSelling.items[i] then
        itemLabels[item] = data.label
      end
    end
  end
end)

local QBCore = exports['qb-core']:GetCoreObject()
local function getAvailableDrugs(source)
  local AvailableDrugs = {}
  local Player = QBCore.Functions.GetPlayer(source)

  if not Player then return nil end

  for i = 1, #Config.CornerSelling.items do
    local item = exports.ox_inventory:Search(source, 'count', Config.CornerSelling.items[i])
    if item > 0 then
      AvailableDrugs[#AvailableDrugs + 1] = {
        item = Config.CornerSelling.items[i],
        amount = item,
        label = itemLabels[Config.CornerSelling.items[i]]
      }
    end
  end
  return table.type(AvailableDrugs) ~= "empty" and AvailableDrugs or nil
end

lib.callback.register('ag_drugs:server:getAvailableDrugs', function(source)
  return getAvailableDrugs(source)
end)

RegisterNetEvent('ag_drugs:server:giveStealItems', function(drugType, amount)
  local src = source
  local availableDrugs = getAvailableDrugs(src)

  if not availableDrugs then return end

  exports.ox_inventory:AddItem(src, availableDrugs[drugType].item, amount)
end)

RegisterNetEvent('ag_drugs:server:sellCornerDrugs', function(drugType, amount, price)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local availableDrugs = getAvailableDrugs(src)

  if not availableDrugs or not Player then return end

  local item = availableDrugs[drugType].item

  local hasItem = exports.ox_inventory:Search(source, 'count', item)
  if hasItem < amount then return TriggerClientEvent('ag_drugs:client:cornerselling', src) end

  TriggerClientEvent('ox_lib:notify', src, { type = 'success', description = locale("offer_accepted") })
  exports.ox_inventory:RemoveItem(src, item, amount)
  Player.Functions.AddMoney('cash', price, "sold-cornerdrugs")
  TriggerClientEvent('ag_drugs:client:refreshAvailableDrugs', src, getAvailableDrugs(src))

  lib.logger(src, 'sellCornerDrugs', {
    message = ('Sold %s x%d for %d'):format(item, amount, price),
    item = item,
    amount = price,
    count = amount,
    type = 'added'
  }, 'economy:sell')
end)

RegisterNetEvent('ag_drugs:server:robCornerDrugs', function(drugType, amount)
  local src = source
  local availableDrugs = getAvailableDrugs(src)

  if not availableDrugs then return end

  local item = availableDrugs[drugType].item

  exports.ox_inventory:RemoveItem(src, item, amount)
  TriggerClientEvent('ag_drugs:client:refreshAvailableDrugs', src, getAvailableDrugs(src))
end)

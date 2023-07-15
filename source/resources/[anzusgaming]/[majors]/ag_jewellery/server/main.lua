PoliceAlerted = false
QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ag_jewellery:server:removeItem', function(item)
  exports.ox_inventory:RemoveItem(source, item, 1)
end)

RegisterNetEvent('ag_jewellery:server:setPoliceAlerted', function()
  if PoliceAlerted then return end
  PoliceAlerted = true
  TriggerClientEvent('ag_jewellery:client:setPoliceAlerted', -1)
end)

lib.callback.register('ag_jewellery:server:getJewelleryConfig', function()
  return Config.Jewellery
end)

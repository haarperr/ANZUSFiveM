local QBCore = exports['qb-core']:GetCoreObject()

local location = vec4(989.086, 31.365, 71.466, 62.956)

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  exports.ox_inventory:RegisterShop('Casino', {
    name = 'Diamond Casino',
    blip = {
      id = 679, colour = 46, scale = 0.8
    },
    inventory = {
      { name = 'casinochips', price = 1, license = 'casino' },
    },
    locations = {
      vec3(location.x, location.y, location.z),
    },
  })
end)

RegisterNetEvent('ag_misc:server:cashIn', function(amount)
  local src = source

  local ped = GetPlayerPed(src)
  local coords = GetEntityCoords(ped)
  if #(coords - vec3(location.x, location.y, location.z)) > 10 then return end

  local has = exports.ox_inventory:Search(src, 'count', 'casinochips')
  if has < amount then return end

  exports.ox_inventory:RemoveItem(src, 'casinochips', amount)
  local player = QBCore.Functions.GetPlayer(src)
  player.Functions.AddMoney('cash', amount)
end)

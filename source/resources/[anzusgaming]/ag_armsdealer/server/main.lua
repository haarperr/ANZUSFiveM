local location = nil

lib.callback.register('ag_armsdealer:getLoc', function()
  return location
end)

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end
  local rnd = math.random(#Config.Locations)

  location = Config.Locations[rnd]

  exports.ox_inventory:RegisterShop('BlackMarketArms', {
    name = 'Black Market (Arms)',
    inventory = Config.ShopInventory,
    locations = {
      vec3(location.x, location.y, location.z),
    },
  })
end)

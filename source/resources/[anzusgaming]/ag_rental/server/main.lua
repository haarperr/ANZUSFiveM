local QBCore = exports['qb-core']:GetCoreObject()

local comma_value = function(n) -- credit http://richard.warburton.it
  local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
  return left .. (num:reverse():gsub('(%d%d%d)', '%1,'):reverse()) .. right
end

---@param resourceName string
AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  local landOptions = {}
  for key, value in pairs(Config.Rental.land.vehicles) do
    local vehicle = AG.GetVehicleData(key)
    landOptions[#landOptions + 1] = {
      title = vehicle.name,
      description = ('$%s'):format(comma_value(value.money)),
      serverEvent = 'ag_rental:RentVehicle',
      args = key
    }
  end

  GlobalState:set('rentalLand', landOptions, true)
end)

---@param data {vehicle: number, slot: number}
RegisterNetEvent('ag_rental:ReturnVehicle', function(data)
  local src = source
  local vehicle = AG.GetVehicleFromNetId(data.vehicle)
  if vehicle.script ~= GetCurrentResourceName() then return end

  lib.logger(src, 'ReturnVehicle',
    ('Returned rented vehicle %s'):format(vehicle.plate))

  vehicle:despawn()

  exports.ox_inventory:RemoveItem(source, 'rentalpapers', 1, nil, data.slot)
end)

---@param data string
RegisterNetEvent('ag_rental:RentVehicle', function(data)
  local src = source
  if not Config.Rental.land.vehicles[data] then return end
  local config = Config.Rental.land.vehicles[data]

  local count = exports.ox_inventory:Search(source, 'count', 'money')
  if not count or count < config.money then
    TriggerClientEvent('ox_lib:notify', src, {
      type = 'error',
      description = 'You do not have enough cash'
    })
    return
  end

  local coords = lib.callback.await('ag_rental:ClosestParkingspot', src)
  if not coords then
    return TriggerClientEvent('ox_lib:notify', src, {
      type = 'error',
      description = 'Unable to rent vehicle'
    })
  end
  local vehicle = AG.CreateVehicle({ model = data }, coords, coords.w)

  if not vehicle then
    return TriggerClientEvent('ox_lib:notify', src, {
      type = 'error',
      description = 'Unable to rent vehicle'
    })
  end

  local Player = QBCore.Functions.GetPlayer(src)

  exports.ox_inventory:AddItem(src, 'rentalpapers', 1,
    { description = ('Vehicle %s has been rented by %s'):format(vehicle.plate, Player.PlayerData.fullname), plate = vehicle.plate, renter = src })

  lib.logger(src, 'RentVehicle',
    ('Rented vehicle %s for %d'):format(vehicle.plate, config.money))

  exports['qb-vehiclekeys']:GiveKeys(src, vehicle.plate)
end)

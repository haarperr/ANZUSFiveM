local db = require 'server.db'
local QBCore = exports['qb-core']:GetCoreObject()

local showroomVehicles = {}
local testDrives = {}

local function spawnShowroomVehicles()
  for k, v in pairs(Config.dealerships) do
    showroomVehicles[k] = {}
    for _, v2 in pairs(v.showRoomCars) do
      local vehicle = AG.CreateVehicle({ model = v2.defaultCar, lockStatus = 1, properties = { fuelLevel = 0 }, plate = 'showroom' }, v2.location, v2.location.w)
      if not vehicle then goto skip end
      FreezeEntityPosition(vehicle.entity, true)
      Entity(vehicle.entity).state:set('fuel', 0, true)
      Entity(vehicle.entity).state:set('showroomVehicle', true, true)

      GlobalState:set(('ag_dealership_%s_%s_busy'):format(k, v2.id), false, true)
      showroomVehicles[k][v2.id] = {
        netId = NetworkGetNetworkIdFromEntity(vehicle.entity),
        label = v2.label,
        id = v2.id,
        class = v2.class,
      }
      ::skip::
    end
  end
end

---@param model string
---@param id string
---@param dealer {buyer?: string}
RegisterNetEvent('ag_dealership:server:purchaseVehicle', function(model, id, dealer)
  local src = source
  if not model then return end
  if not id then return end

  local config = Config.dealerships[id]
  if not config then return end

  local veh = db.getVehicle(model)
  if not veh then return end

  local price = veh.price
  local tax = GlobalState.tax

  local buyer = nil
  local seller = nil

  if dealer and dealer.buyer then
    buyer = QBCore.Functions.GetPlayer(dealer.buyer)
    seller = QBCore.Functions.GetPlayer(src)
  else
    buyer = QBCore.Functions.GetPlayer(src)
  end

  local buyerSrc = buyer.PlayerData.source

  local res = lib.callback.await('ag_dealership:confirmPayment', buyerSrc, { price = price, tax = tax })
  if not res.success then
    if seller then
      TriggerClientEvent('ox_lib:notify', seller.PlayerData.source, { type = 'error', description = 'Customer has declined payment' })
    end

    return
  end

  local payment = res.payment
  local fullPrice = math.floor(price * (1 + (tax / 100)))
  local dealersPart = fullPrice * (1 + (config.salesCommission / 100))

  local hasEnoughMoney = false
  if payment == 'cash' then
    if buyer.PlayerData.money.cash >= fullPrice then hasEnoughMoney = true end
  elseif payment == 'bank' then
    if buyer.PlayerData.money.bank >= math.floor(fullPrice) then hasEnoughMoney = true end
  end

  TriggerClientEvent('ox_lib:notify', buyerSrc, { type = 'info', description = 'Processing payment', title = 'Dealership', duration = 3500 })

  if not hasEnoughMoney then
    TriggerClientEvent('ox_lib:notify', buyerSrc, { type = 'error', description = 'You do not have enough money to purchase this vehicle', title = 'Dealership' })
    if seller then
      TriggerClientEvent('ox_lib:notify', seller.PlayerData.source, { type = 'error', description = 'The customer is unable to purchase this vehicle', title = 'Dealership' })
    end
    return
  end

  local updated = db.removeStock(model, 1)
  if updated ~= 1 then return TriggerClientEvent('ox_lib:notify', buyerSrc, { type = 'error', description = 'Unable to purchase vehicle', title = 'Dealership' }) end

  local vehicle = AG.CreateVehicle({ model = model, owner = buyer.PlayerData.citizenid }, config.purchaseLoc, config.purchaseLoc.w)
  if not vehicle then return TriggerClientEvent('ox_lib:notify', buyerSrc, { type = 'error', description = 'Unable to spawn vehicle', title = 'Dealership' }) end

  buyer.Functions.RemoveMoney(payment, fullPrice, ('Purchased %s'):format(model))

  if seller then
    seller.Functions.AddMoney(payment, dealersPart, ('Comission on sale %s'):format(model))
  end

  local comissionText = ''

  if payment == 'bank' then
    exports.pefcl:addBankBalanceByIdentifier(buyer.PlayerData.source, { identifier = 'governor', amount = (price * tax), message = 'Legal Purchase Tax' })
    comissionText = ' in your bank account'
  end

  TriggerClientEvent('ox_lib:notify', buyer.PlayerData.source, { type = 'success', description = 'Your vehicle is outside', title = 'Dealership' })

  if seller then
    TriggerClientEvent('ox_lib:notify', seller.PlayerData.source,
      { type = 'success', description = ('You have received $%s as comission%s'):format(dealersPart, comissionText), title = 'Dealership' })
  end


  if seller then
    lib.logger(seller.PlayerData.source, 'purchaseVehicle',
      {
        message = ('Commission %d from sale %s to %s'):format(dealersPart, vehicle.vin, buyer.PlayerData.citizenid),
        vehicle = vehicle.vin,
        model = model,
        amount = fullPrice,
        currency = payment,
        type = 'added'
      }, 'economy:commission')
  end

  lib.logger(buyer.PlayerData.source, 'purchaseVehicle',
    {
      message = ('Purchased %s x%d for %d'):format(model, 1, fullPrice),
      vehicle = vehicle.vin,
      model = model,
      amount = fullPrice,
      currency = payment,
      type = 'removed'
    }, 'economy:buy')


  exports['qb-vehiclekeys']:GiveKeys(buyerSrc, vehicle.plate)

  local moneyUpdate = price * (1 + (config.societyCut / 100))
  --TODO Add society cut
  -- PFS.TriggerServerEvent('PFS_DealerShip:AddSociety', currentDealership.society, moneyUpdate)
  exports.pefcl:addBankBalanceByIdentifier(buyer.PlayerData.source, { identifier = currentDealership.society, amount = moneyUpdate, message = 'Society cut of vehicle purchase' })
end)


lib.callback.register('ag_dealership:getShowroomVehicles', function(source, dealership)
  return showroomVehicles[dealership]
end)

lib.callback.register('ag_dealership:getCategoryVehicles', function(source, showroom, class, id)
  GlobalState:set(('ag_dealership_%s_%s_busy'):format(showroom, id), true, true)
  local res = db.getVehicles(class)
  return res
end)

RegisterNetEvent('ag_dealership:server:resetCategoryState', function(showroom, id)
  GlobalState:set(('ag_dealership_%s_%s_busy'):format(showroom, id), false, true)
end)

lib.callback.register('ag_dealership:getOnlineDealerCount', function(source, id)
  local res = QBCore.Functions.GetDutyCountJob(Config.dealerships[id].job)
  return res
end)

RegisterNetEvent('ag_dealership:server:changeDisplayVehicle', function(model, showroom, id)
  local src = source
  if not showroomVehicles[showroom][id] then return end

  local veh = AG.GetVehicleFromNetId(showroomVehicles[showroom][id].netId)
  if not veh then return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'Server error handled, contact developers with - AGD393A' }) end
  veh:despawn()

  local config = Config.dealerships[showroom].showRoomCars

  local car = nil
  for _, v in pairs(config) do
    if v.id == id then
      car = v
      break
    end
  end

  if not car then return false end

  local vehicle = AG.CreateVehicle({ model = model, lockStatus = 1, properties = { fuelLevel = 0 }, plate = 'showroom' }, car.location, car.location.w)
  if not vehicle then return end

  FreezeEntityPosition(vehicle.entity, true)
  Entity(vehicle.entity).state:set('fuel', 0, true)
  Entity(vehicle.entity).state:set('showroomVehicle', true, true)

  showroomVehicles[showroom][car.id] = {
    netId = NetworkGetNetworkIdFromEntity(vehicle.entity),
    label = car.label,
    id = car.id,
    class = car.class
  }
end)

lib.callback.register('ag_dealership:getVehicleData', function(source, showroom, id)
  local veh = nil

  for k, v in pairs(showroomVehicles[showroom]) do
    if k == id then
      veh = v
      break
    end
  end

  if not veh then return false end

  local vehicle = AG.GetVehicleFromNetId(veh.netId)
  if not vehicle then return 0 end

  local stats = db.getVehicle(vehicle.model)
  return stats
end)

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end
  spawnShowroomVehicles()
end)

--- TEST DRIVE ---

---@param source any
---@param showroom string
---@param model string
lib.callback.register('ag_dealership:spawnTestVehicle', function(source, showroom, model)
  local coords = Config.dealerships[showroom].testDriveLoc
  if not coords then return end

  local vehicle = AG.CreateVehicle({ model = model, plate = 'TESTDRIV', properties = {} }, coords, coords.w)
  if not vehicle then return false end

  SetPedIntoVehicle(GetPlayerPed(source), vehicle.entity, -1)
  testDrives[source] = { vehicle = vehicle.entity, bucket = GetPlayerRoutingBucket(source) }

  SetPlayerRoutingBucket(source, 2)
  SetEntityRoutingBucket(vehicle.entity, 2)
  SetRoutingBucketPopulationEnabled(2, false)

  return vehicle.netid
end)

---@param coords vector3
RegisterNetEvent('ag_dealership:server:endTestDrive', function(coords)
  local src = source

  local s = testDrives[src]
  SetPlayerRoutingBucket(src, s.bucket)

  local veh = AG.GetVehicle(s.vehicle)
  if not veh then return end
  veh:despawn()

  SetEntityCoords(GetPlayerPed(src), coords.x, coords.y, coords.z, true, false, false, false)
  testDrives[source] = nil
end)

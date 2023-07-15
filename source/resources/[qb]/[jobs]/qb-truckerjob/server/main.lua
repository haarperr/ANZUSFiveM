local QBCore = exports['qb-core']:GetCoreObject()
local PaymentTax = 15
local Bail = {}

RegisterNetEvent('qb-trucker:server:DoBail', function(bool, vehInfo)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end
  if bool then
    if Player.PlayerData.money.cash >= Config.BailPrice then
      Bail[Player.PlayerData.citizenid] = Config.BailPrice
      Player.Functions.RemoveMoney('cash', Config.BailPrice, "tow-received-bail")
      TriggerClientEvent('ox_lib:notify', src,
        { title = 'Delivery', description = Lang:t("success.paid_with_cash", { value = Config.BailPrice }), duration = 5000, type = 'success' })
      TriggerClientEvent('qb-trucker:client:SpawnVehicle', src, vehInfo)
    elseif Player.PlayerData.money.bank >= Config.BailPrice then
      Bail[Player.PlayerData.citizenid] = Config.BailPrice
      Player.Functions.RemoveMoney('bank', Config.BailPrice, "tow-received-bail")
      TriggerClientEvent('ox_lib:notify', src,
        { title = 'Delivery', description = Lang:t("success.paid_with_bank", { value = Config.BailPrice }), duration = 5000, type = 'success' })
      TriggerClientEvent('qb-trucker:client:SpawnVehicle', src, vehInfo)
    else
      TriggerClientEvent('ox_lib:notify', src, { title = 'Delivery', description = Lang:t("error.no_deposit", { value = Config.BailPrice }), duration = 5000, type = 'error' })
    end
  else
    if Bail[Player.PlayerData.citizenid] then
      local veh = AG.GetVehicleFromNetId(vehInfo)
      if not veh then return end
      veh:despawn()

      Player.Functions.AddMoney('cash', Bail[Player.PlayerData.citizenid], "trucker-bail-paid")
      Bail[Player.PlayerData.citizenid] = nil

      TriggerClientEvent('ox_lib:notify', src,
        { title = 'Delivery', description = Lang:t("success.refund_to_cash", { value = Config.BailPrice }), duration = 5000, type = 'success' })
    end
  end
end)

RegisterNetEvent('qb-trucker:server:01101110', function(drops)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end
  drops = tonumber(drops)
  local bonus = 0
  local DropPrice = math.random(100, 120)

  if drops >= 5 then
    bonus = math.ceil((DropPrice / 10) * 5) + 100
  elseif drops >= 10 then
    bonus = math.ceil((DropPrice / 10) * 7) + 300
  elseif drops >= 15 then
    bonus = math.ceil((DropPrice / 10) * 10) + 400
  elseif drops >= 20 then
    bonus = math.ceil((DropPrice / 10) * 12) + 500
  end

  local price = (DropPrice * drops) + bonus
  local taxAmount = math.ceil((price / 100) * PaymentTax)
  local payment = price - taxAmount
  Player.Functions.AddJobReputation(drops)
  Player.Functions.AddMoney("cash", payment, "trucker-salary")
  lib.logger(src, '01101110', { message = ('Received %s'):format(payment), amount = payment, type = 'added', currency = 'cash' }, 'economy:paycheck')
  TriggerClientEvent('ox_lib:notify', src, { title = 'Delivery', description = Lang:t("success.you_earned", { value = payment }), duration = 5000, type = 'success' })
end)

lib.callback.register('qb-trucker:server:spawnVehicle', function(source, model)
  local src = source
  local plate = "TRUK" .. tostring(math.random(1000, 9999))
  local veh = AG.CreateVehicle({ model = model, plate = plate }, Config.Locations.vehicle.coords)
  if not veh or veh == 0 then return end

  local netId = veh.netid
  if not netId or netId == 0 then return end

  exports['qb-vehiclekeys']:GiveKeys(src, veh.plate)
  return netId
end)

local QBCore = exports['qb-core']:GetCoreObject()
lib.locale()

local function isPlayerNearBus(src)
  local ped = GetPlayerPed(src)
  local coords = GetEntityCoords(ped)
  for _, v in pairs(Config.NPCLocations.Locations) do
    local dist = #(coords - vec3(v.x, v.y, v.z))
    if dist < 20 then
      return true
    end
  end
  return false
end

lib.callback.register('qb-busjob:server:spawnBus', function(source, model)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)

  if Player.PlayerData.money.cash < Config.deposit then return false end
  Player.Functions.RemoveMoney('cash', Config.deposit)
  local plate = locale('bus_plate') .. tostring(math.random(1000, 9999))

  local vehicle = AG.CreateVehicle({ model = model, plate = plate }, Config.Location, Config.Location.w)
  if not vehicle then return end

  exports['qb-vehiclekeys']:GiveKeys(src, vehicle.plate)
  return vehicle.netid
end)

RegisterNetEvent('qb-busjob:server:deleteBus', function(netid)
  local src = source
  local vehicle = AG.GetVehicleFromNetId(netid)

  if vehicle.script ~= GetCurrentResourceName() then return end
  vehicle:despawn()
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.AddMoney('cash', Config.deposit)
end)

RegisterNetEvent('qb-busjob:server:NpcPay', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end
  if Player.PlayerData.job.name ~= "bus" or not isPlayerNearBus(src) then
    return DropPlayer(src,
      locale('exploit_attempt'))
  end

  local payment = math.random(15, 20)
  if math.random(1, 100) < Config.BonusChance then
    payment = payment + math.random(10, 20)
  end
  Player.Functions.AddMoney('cash', payment)
  lib.logger(src, 'NpcPay', { message = ('Received %s'):format(payment), amount = payment, type = 'added', currency = 'cash' }, 'economy:paycheck')
end)

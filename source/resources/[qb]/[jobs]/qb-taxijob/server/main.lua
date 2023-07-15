local QBCore = exports['qb-core']:GetCoreObject()

local vehicles = {}

local function NearTaxi(src)
  local ped = GetPlayerPed(src)
  local coords = GetEntityCoords(ped)
  for _, v in pairs(Config.NPCLocations.DeliverLocations) do
    local dist = #(coords - vector3(v.x, v.y, v.z))
    if dist < 20 then
      return true
    end
  end
end

---@param data {key: number}
lib.callback.register('qb-taxijob:StartShift', function(source, data)
  local src = source

  local player = QBCore.Functions.GetPlayer(source)
  if player.PlayerData.money.cash < Config.VehicleTakeOutFee then return false end

  player.Functions.RemoveMoney('cash', Config.VehicleTakeOutFee, 'Taxi vehicle fee')

  local vehicle = AG.CreateVehicle({ model = Config.AllowedVehicles[data.key].model },
    vec3(Config.Location.x, Config.Location.y, Config.Location.z), Config.Location.w)
  if not vehicle then return end
  vehicles[#vehicles + 1] = { source = src, vehicle = vehicle }


  exports['qb-vehiclekeys']:GiveKeys(src, vehicle.plate)

  return vehicle
end)

RegisterNetEvent('qb-taxijob:server:StopShift', function()
  local src = source
  for i = 1, #vehicles, 1 do
    local v = vehicles[i]
    if v.source == source then
      v.vehicle:despawn()

      local player = QBCore.Functions.GetPlayer(src)
      player.Functions.AddMoney('cash', Config.VehicleTakeOutFee, 'Taxi vehicle fee')
    end
  end
end)

local Tasks = {}

RegisterNetEvent('qb-taxijob:server:GotTask', function(data)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.PlayerData.job.name ~= "taxi" then return end

  local miles = #(data.coords - data.destination)

  Tasks[Player.PlayerData.citizenid] = {
    time = os.time() + (Config.TimePerMile * miles) * 60
  }
end)

RegisterNetEvent('qb-taxi:server:NpcPay', function(Payment)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.PlayerData.job.name == "taxi" then
    if NearTaxi(src) then
      local task = Tasks[Player.PlayerData.citizenid]

      if os.time() > task.time then
        return TriggerClientEvent('ox_lib:notify', src,
          { type = 'error', description = 'You took too long, I\'m not paying' })
      end

      local randomAmount = math.random(1, 5)
      local r1, r2 = math.random(1, 5), math.random(1, 5)
      if randomAmount == r1 or randomAmount == r2 then Payment = Payment + math.random(10, 20) end
      Player.Functions.AddMoney('cash', Payment, 'Taxi NPC Pay', true)
      local chance = math.random(1, 100)
      if chance <= 15 then
        Player.Functions.AddItem("trojan_usb", 1, false)
      end
      lib.logger(src, 'NpcPay', { message = ('Received %s'):format(Payment), amount = Payment, type = 'added', currency = 'cash' }, 'economy:paycheck')
    else
      lib.logger(src, 'NpcPay', 'Player not near a taxi', 'type:warning')
    end
  else
    lib.logger(src, 'NpcPay', 'Player is not a taxi driver', 'type:critical')
  end
end)

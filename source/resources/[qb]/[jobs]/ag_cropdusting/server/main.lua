lib.locale()
local QBCore = exports['qb-core']:GetCoreObject()
local HasVehicle = {}
local JobLocations = {}

local function GetLocation(src)
  local location = Config.JobLocations[math.random(1, #Config.JobLocations)]
  for k, v in pairs(JobLocations[src]) do
    if v and v.data and #(v.data.coords - location.coords) == 0 then
      return GetLocation(src)
    end
  end
  return location
end

local function JobComplete(src)
  local Player = QBCore.Functions.GetPlayer(src)
  local CompleteJobs = 0
  for i = 1, Config.MaxLocations, 1 do
    if JobLocations[src] and JobLocations[src][i] and JobLocations[src][i].HasDone then CompleteJobs = CompleteJobs + 1 end
  end
  local Reward = (CompleteJobs * Config.RewardPerJob)
  Player.Functions.AddMoney('cash', Reward)
  lib.logger(src, 'JobComplete', { message = ('Received %s'):format(Reward), amount = Reward, type = 'added', currency = 'cash' }, 'economy:paycheck')

  TriggerClientEvent('ox_lib:notify', src, { type = 'success', description = locale('pay', Reward, CompleteJobs) })
  JobLocations[src] = nil
end

lib.callback.register('ag_cropdusting:server:SpawnVehicle', function(source)
  local ped = GetPlayerPed(source)
  if not coords then coords = GetEntityCoords(ped) end
  local veh = CreateVehicle(Config.JobVehicle, Config.StartJob.vehcoords.x, Config.StartJob.vehcoords.y - 5, Config.StartJob.vehcoords.z, Config.StartJob.vehcoords.w, true, true)
  while not DoesEntityExist(veh) do Wait(0) end
  while NetworkGetEntityOwner(veh) ~= source do Wait(0) end
  return NetworkGetNetworkIdFromEntity(veh)
end)

lib.callback.register('ag_cropdusting:server:VehicleCheck', function(source)
  local src = source
  if HasVehicle[src] then return true end
  return false
end)


lib.callback.register('ag_cropdusting:server:HasJob', function(source)
  if JobLocations[source] then return true end
  return false
end)

lib.callback.register('ag_cropdusting:server:MoneyCheck', function(source)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player.PlayerData.money.cash >= Config.DepositAmount then
    Player.Functions.RemoveMoney('cash', Config.DepositAmount)
    HasVehicle[source] = true
    return true
  else
    return false
  end
end)

lib.callback.register('ag_cropdusting:server:GetLocation', function(source)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  JobLocations[src] = JobLocations[src] or {}
  for i = 1, Config.MaxLocations, 1 do
    JobLocations[src][#JobLocations[src] + 1] = {
      HasDone = false,
      data = GetLocation(src)
    }
  end
  return JobLocations[src]
end)

RegisterNetEvent('ag_cropdusting:server:UpdateVal', function(currentLoc)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local item = exports.ox_inventory:GetItemCount(src, Config.FertilizerName)
  if item then
    exports.ox_inventory:RemoveItem(src, Config.FertilizerName, 1)
    TriggerClientEvent('ag_cropdusting:client:UpdatedVal', src)
  else
    TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('no_sufficient_fertilizer', Config.RequiredFertilizerAmount) })
    TriggerClientEvent('ag_cropdusting:client:DestroyAll', src)
  end
  JobLocations[src][currentLoc].HasDone = true
end)

RegisterNetEvent('ag_cropdusting:server:DestroyAll', function()
  local src = source
  JobLocations[src] = nil
  TriggerClientEvent('ag_cropdusting:client:DestroyAll', src)
end)

RegisterNetEvent('ag_cropdusting:server:JobComplete', function()
  local src = source
  JobComplete(src)
end)

RegisterNetEvent('ag_cropdusting:server:LostVehicle', function()
  local src = source
  if not JobLocations[src] and not HasVehicle[src] then return end
  local Player = QBCore.Functions.GetPlayer(src)
  JobLocations[src] = nil
  HasVehicle[src] = nil
  TriggerClientEvent('ag_cropdusting:client:DestroyAll', src)
  TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('start_again') })
end)

RegisterNetEvent('ag_cropdusting:server:ReturnVehicle', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  JobComplete(src)
  JobLocations[src] = nil
  HasVehicle[src] = nil
  TriggerClientEvent('ag_cropdusting:client:DestroyAll', src)
  Player.Functions.AddMoney('cash', Config.DepositAmount)
  TriggerClientEvent('ox_lib:notify', src, { type = 'success', description = locale('start_again') })
end)

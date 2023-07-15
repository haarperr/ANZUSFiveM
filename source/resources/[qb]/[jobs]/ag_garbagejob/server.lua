local QBCore = exports['qb-core']:GetCoreObject()
local searchedBins = {}
local curjobs = {}
local currentvehicles = {}

local function addToSet(set, key)
  set[key] = true
end

local function tableHasKey(table, key)
  return table[key] ~= nil
end

local function removeKey(key)
  local value = curjobs[key]
  if (value == nil) then
    return
  end
  curjobs[key] = nil
  currentvehicles[key] = nil
end

local function addValue(key, value, vehicle)
  if (value == nil) then
    removeKey(key)
    return
  end
  curjobs[key] = value
  currentvehicles[key] = vehicle
end

local function getValue(key)
  return curjobs[key]
end

local function getVehicle(key)
  return currentvehicles[key]
end

lib.callback.register('gl-garbage:spawnVehicle', function(source)
  local src = source
  if not Config.VehicleSpawn then
    return TriggerClientEvent('ox_lib:notify', src, {
      type = 'error',
      description = 'Unable to spawn vehicle'
    })
  end
  local vehicle = AG.CreateVehicle({ model = 'trash' }, vec3(Config.VehicleSpawn.x, Config.VehicleSpawn.y, Config.VehicleSpawn.z), Config.VehicleSpawn.w)

  if not vehicle then
    return TriggerClientEvent('ox_lib:notify', src, {
      type = 'error',
      description = 'Unable to spawn vehicle'
    })
  end

  exports['qb-vehiclekeys']:GiveKeys(src, vehicle.plate)

  return vehicle.netid
end)

RegisterNetEvent('gl-garbage:makeMultiJob', function(jobID, zone, vehicle)
  local src = source
  local hasValue = getValue(jobID)
  local id = jobID
  if hasValue then
    local newID = math.random(10000, 99999)
    addValue(newID, zone, vehicle)
    TriggerClientEvent('gl-garbage:newJobID', src, newID)
    TriggerClientEvent("QBCore:Notify", src, "Job ID was in progress, your new job ID is " .. newID)
  else
    addValue(jobID, zone, vehicle)
  end
end)

RegisterNetEvent('gl-garbage:joinMultiJob', function(ID)
  local src = source
  local jobID = tonumber(ID)
  local doesJobExist = getValue(jobID)
  if doesJobExist then
    local zone = getValue(jobID)
    local vehicle = getVehicle(jobID)
    TriggerClientEvent('gl-garbage:joinedMultiJob', src, jobID, zone, vehicle)
    TriggerClientEvent('gl-garbage:updatePeople', -1, jobID)
  else
    TriggerClientEvent("QBCore:Notify", src, "Job ID does not exist", 'error')
  end
end)

RegisterNetEvent('gl-garbage:checkBin', function(netID)
  local src = source
  local searched = tableHasKey(searchedBins, netID)
  if not searched then
    addToSet(searchedBins, netID)
    TriggerClientEvent('gl-garbage:getTrash', src)
  else
    TriggerClientEvent("QBCore:Notify", src, "It seems to be empty!")
  end
end)

RegisterNetEvent('gl-garbage:depositTrash', function(jobID, trashAmt)
  TriggerClientEvent('gl-garbage:depositTrashClient', -1, jobID)
end)

RegisterNetEvent('gl-garbage:cashOut', function(jobID, people)
  TriggerClientEvent('gl-garbage:cashedOut', -1, jobID, people)
end)

RegisterNetEvent('gl-garbage:newShift', function(jobID, zone, vehicle)
  removeKey(jobID)
  addValue(jobID, zone, vehicle)
  TriggerClientEvent('gl-garbage:updateShift', -1, jobID, zone)
end)

RegisterNetEvent('gl-garbage:getPaid', function(jobid, trash, people)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local Money = (trash * Config.Payout) / people
  Player.Functions.AddMoney('cash', Money)

  lib.logger(src, 'getPaid', { message = ('Received %s'):format(Money), amount = Money, type = 'added', currency = 'cash' }, 'economy:paycheck')

  local rng = math.random(0, 10)
  if trash >= 10 then
    if rng >= 5 then
      Player.Functions.AddItem('recvoucher', 1)
    end
  end
end)

RegisterNetEvent('gl-garbage:redeemMaterial', function(choice, amount)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local voucher = Player.Functions.GetItemByName('recvoucher')
  if voucher and voucher.amount > 0 then
    Player.Functions.RemoveItem('recvoucher', 1)
    Player.Functions.AddItem(choice, amount)
  else
    TriggerClientEvent("QBCore:Notify", src, "Looks like you don't have any recycling vouchers.", 'error')
  end
end)

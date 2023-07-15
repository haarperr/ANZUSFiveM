lib.locale()
local QBCore = exports['qb-core']:GetCoreObject()
local netid = nil
local guards = {}

local function generateCoords()
  local closestPlayers = {}
  local closestDistance = 300
  local timeout = 0

  repeat
    local vehCoords = Config.Locations[math.random(#Config.Locations)]
    local test = vec3(vehCoords.x, vehCoords.y, vehCoords.z)
    for _, player in pairs(QBCore.Functions.GetPlayers()) do
      local ped = GetPlayerPed(player)
      local coords = GetEntityCoords(ped)

      local dist = #(coords - test)
      if dist <= closestDistance then
        closestPlayers[#closestPlayers + 1] = { player = player, coords = vehCoords }
      end
    end

    timeout += 1
    Wait(0)
  until timeout >= 15

  local closestPlayer = closestPlayers[math.random(#closestPlayers)]

  return closestPlayer and closestPlayer.player or nil, closestPlayer and closestPlayer.coords or nil
end

local function generateTruck()
  local closestPlayer, vehCoords = generateCoords()
  if not closestPlayer or not vehCoords then return print('no player found', closestPlayer, vehCoords) end

  local vehicle = AG.CreateVehicle({ model = 'stockade' }, vehCoords, vehCoords.w)
  if not vehicle then return end
  Wait(500)
  Entity(vehicle.entity).state:set('isTruckBusy', false, true)
  Entity(vehicle.entity).state:set('isTruckRobbed', false, true)
  Entity(vehicle.entity).state:set('canTruckBeRobbed', false, true)
  lib.logger(-1, 'generateTruck', ('Truck spawned at %s player closest %s'):format(vehCoords, Player(closestPlayer).state.citizenid))

  SetVehicleDoorsLocked(vehicle.entity, 2)

  netid = vehicle.netid

  TriggerClientEvent('ag_truckrobbery:client:initTruckRobbery', closestPlayer, { vehicle = vehicle.netid })
end

RegisterNetEvent('ag_truckrobbery:server:setGuards', function(data)
  guards = data
end)

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end
  generateTruck()
end)

lib.cron.new('*/30 * * * *', function(task, date)
  if netid then return end
  generateTruck()
end)

RegisterNetEvent('ag_truckrobbery:server:removeItem', function(item)
  local src = source
  exports.ox_inventory:RemoveItem(src, item, 1)
end)

RegisterNetEvent('ag_truckrobbery:server:getReward', function(net)
  local src = source
  if net ~= netid then return lib.logger(src, 'getReward', ('Tried to execute this function while the netid does not match %d - %d'):format(net, netid), 'type', 'critical') end

  local max = Config.MaxRewards
  local curr = 0

  for key, value in pairs(Config.Rewards) do
    if curr == max then break end
    local chance = math.random(1, 100)
    local amount = value.min and math.random(value.min, value.max) or value.amount
    local canHave = false
    if (not value.chance) or (value.chance and value.chance >= chance) then
      canHave = true
    end
    if not canHave then goto skip end

    local canCarry = exports.ox_inventory:CanCarryItem(src, key, amount)
    if not canCarry then
      TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('cannot_carry') })
      break
    end

    curr += 1
    exports.ox_inventory:AddItem(src, key, amount)
    ::skip::
  end

  local n = netid
  if Config.DespawnAfterLooted.enable then
    SetTimeout(Config.DespawnAfterLooted.time, function()
      local vehicle = AG.GetVehicleFromNetId(n)
      vehicle:despawn()
      for _, v in pairs(guards) do
        local ent = NetworkGetEntityFromNetworkId(v)
        if DoesEntityExist(ent) then
          DeleteEntity(ent)
        end
      end
      guards = {}
      netid = nil
    end)
  else
    for _, v in pairs(guards) do
      local ent = NetworkGetEntityFromNetworkId(v)
      if DoesEntityExist(ent) then
        DeleteEntity(ent)
      end
    end
    netid = nil
  end
end)

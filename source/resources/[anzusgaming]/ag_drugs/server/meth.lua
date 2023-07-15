---@param data {labindex: number}
lib.callback.register('ag_drugs:isLabBlownUp', function(source, data)
  if not data.labindex then return false end
  return Config.meth.labs[data.labindex].blownUp
end)

local Objects = {}
local randomBarrelLocation = {}
local randomBarrelObjects = {}
local barrelObjects = {}

local busy = {}

CreateThread(function()
  for index, value in ipairs(Config.meth.factories) do
    barrelObjects[index] = {}
    local randomBArell = math.random(1, #value.barrels)
    randomBarrelLocation[index] = value.barrels[randomBArell]
    randomBarrelObjects[index] = CreateObject(`prop_barrel_01a`, value.barrels[randomBArell])
    busy[index] = false

    for i, v in ipairs(value.barrels) do
      local barrel = CreateObject(`prop_barrel_01a`, v)
      barrelObjects[index][i] = barrel
    end
  end
end)

local function checkCoordsToBarrel(coords)
  local near = false
  local id = nil
  for i, v in pairs(randomBarrelLocation) do
    if #(coords - v) < 2 then
      near = true
      id = i
      break
    end
  end

  return near, id
end

lib.callback.register('ag_drugs:getRandomBarrelLocation', function(source)
  return randomBarrelLocation
end)

lib.callback.register('ag_drugs:labRunsThisRestart', function(source, labIndex)
  return Config.meth.labs[labIndex].runsThisRestart
end)

local function CreateObjectId()
  if Objects then
    local objectId = math.random(10000, 99999)
    while Objects[objectId] do
      objectId = math.random(10000, 99999)
    end
    return objectId
  else
    local objectId = math.random(10000, 99999)
    return objectId
  end
end

RegisterNetEvent('ag_drugs:giveFullBottles', function()
  local src = source
  local success = exports.ox_inventory:RemoveItem(src, 'empty_bottle', 20)

  if not success then
    return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('not_enough_bottles') })
  end

  success = exports.ox_inventory:RemoveItem(src, 'open_barrel_methylamine', 1)

  if not success then
    exports.ox_inventory:AddItem(src, 'empty_bottle', 20)
    return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('no_barrel') })
  end

  success, _ = exports.ox_inventory:AddItem(src, 'bottle_methylamine', 20)

  if not success then
    exports.ox_inventory:AddItem(src, 'empty_bottle', 20)
    exports.ox_inventory:AddItem(src, 'open_barrel_methylamine', 1)
    return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('not_enough_space') })
  end
end)

RegisterNetEvent('ag_drugs:finishedMethLab', function(labName, labIndex)
  local src = source
  local finishedCount = 0

  for v = 1, #Config.meth.labs[labIndex] do
    local currentLab = Config.meth.labs[labIndex][v]
    if not currentLab.ingredientAdded then
      TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('missing_something') })
      return
    end
    finishedCount = finishedCount + 1
  end

  if Config.meth.labs[labIndex].cooldown then return end

  if finishedCount == #Config.meth.labs[labIndex] then
    local randomMethAmount = math.random(1, 5)

    local success = exports.ox_inventory:AddItem(src, 'high_purity_meth', randomMethAmount)
    if not success then
      return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('not_enough_space') })
    end

    Config.meth.labs[labIndex].cooldown = true
    Config.meth.labs[labIndex].runsThisRestart = Config.meth.labs[labIndex].runsThisRestart + 1

    -- Needs to run on another thread, so it doesn't clog up resources
    CreateThread(function()
      SetTimeout(7200000, function() -- 2 hours
        Config.meth.labs[labIndex].cooldown = false
      end)
    end)
  end
end)

RegisterNetEvent('ag_drugs:adjustIngredientsToMeth', function(type, labName, ingredient, labIndex, ingredientIndex)
  local src = source

  if Config.meth.labs[labIndex].blownUp or Config.meth.labs[labIndex].cooldown then
    return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('lab_out_of_order') })
  end

  if type == 'add' then
    local success = exports.ox_inventory:RemoveItem(src, ingredient, 5)

    if not success then
      return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('missing_something') })
    end

    Config.meth.labs[labIndex][ingredientIndex].ingredientAdded = true
  elseif type == 'remove' then
    Config.meth.labs[labIndex][ingredientIndex].ingredientAdded = false
  elseif type == 'blown' then
    Config.meth.labs[labIndex].blownUp = true
  end
end)

RegisterNetEvent('ag_drugs:giveBarrel', function(barrelIndex)
  local src = source
  if busy[barrelIndex] then return end

  busy[barrelIndex] = true
  local coords = GetEntityCoords(GetPlayerPed(src))
  local near, id = checkCoordsToBarrel(coords)

  if not near then
    local Player = QBCore.Functions.GetPlayer(src)
    busy[barrelIndex] = false
    return lib.logger(src, 'giveBarrel', ('Player is %d distance from the nearest barrel'):format(near), 'citizenid', Player.PlayerData.citizenid)
  end

  local success, _ = exports.ox_inventory:AddItem(src, 'barrel_methylamine', 1)

  if not success then
    busy[barrelIndex] = false
    return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('not_enough_space') })
  end

  DeleteEntity(NetworkGetEntityFromNetworkId(randomBarrelObjects[id]))
  randomBarrelObjects[id] = nil
  randomBarrelLocation[id] = nil

  TriggerClientEvent('ag_drugs:client:removeBarrelZone', -1, id)

  randomBarrelLocation[barrelIndex] = nil
  busy[barrelIndex] = nil
end)

-- Needs checks
RegisterNetEvent('ag_drugs:createdMeth', function(ingreidents)
  local src = source

  if not ingreidents.ephedrine or not ingreidents.acetone or not addIngreidents.coughsyrup or not ingreidents.batteryacid then
    local Player = QBCore.Functions.GetPlayer(src)
    return lib.logger(Player.PlayerData.source, 'createdMeth', ('Player does not have all ingreidents [%s]'):format(json.decode(ingreidents)), 'citizenid',
      Player.PlayerData.citizenid)
  end

  local randomMethAmount = math.random(1, 15)
  local success, _ = exports.ox_inventory:AddItem(src, 'low_purity_meth', randomMethAmount)

  if not success then
    return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('not_enough_space') })
  end
end)

RegisterNetEvent('ag_drugs:removeIngreident', function(item)
  local src = source
  local success = exports.ox_inventory:RemoveItem(src, item, 1)

  if not success then
    return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('missing_something') })
  end
end)

-- Needs checks
local function spawnMethTable(player)
  local objectId = CreateObjectId()
  Objects[objectId] = type
  TriggerClientEvent("ag-meth:client:spawnObject", player, objectId)
end

exports('spawnMethTable', spawnMethTable)

-- Needs checks
RegisterNetEvent('ag_drugs:deleteObject', function(objectId)
  local src = source

  if not Objects[objectId] then
    local Player = QBCore.Functions.GetPlayer(src)
    return lib.logger(Player.PlayerData.source, 'deleteObject', ('Player provided an incorrect objectId (%d)'):format(objectId))
  end

  local success, _ = exports.ox_inventory:AddItem(src, 'methtable', 1)

  if not success then
    return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('not_enough_space') })
  end

  TriggerClientEvent('ag-meth:client:removeObject', src, objectId)
  Objects[objectId] = nil
end)

function StopMeth()
  for i = 1, #randomBarrelObjects do
    local entity = NetworkGetEntityFromNetworkId(randomBarrelObjects[i])
    if DoesEntityExist(entity) then
      DeleteEntity(entity)
    end
  end

  for i = 1, #barrelObjects do
    for k = 1, #barrelObjects[i] do
      local entity = NetworkGetEntityFromNetworkId(barrelObjects[i][k])
      if DoesEntityExist(entity) then
        DeleteEntity(entity)
      end
    end
  end
end

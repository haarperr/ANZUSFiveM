math.randomseed(os.time())
local Inventory = exports.ox_inventory
local QBCore = exports['qb-core']:GetCoreObject()
local objects = {}
local policeAlerted = false
local rewarded = {}

RegisterNetEvent('ag_fleeca:server:disableCameras', function(bank)
  if not OnCooldown() then SetCooldown(true, bank) end

  Config.Banks[bank].cameracontrol.disabled = true
  TriggerClientEvent('ag_fleeca:client:disableCameras', -1, bank, true)
end)

RegisterNetEvent('ag_fleeca:server:alertPolice', function()
  if policeAlerted then return end
  policeAlerted = true
  TriggerClientEvent('ag_fleeca:client:alertPolice', -1, true)
end)

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end
  SetCooldown(false)
  GlobalState:set('fleecaData', { cooldown = false, allowedBank = 0 }, true)

  repeat
    print('ox_doorlock not started')
    Wait(10)
  until GetResourceState('ox_doorlock') == 'started'

  for k, v in ipairs(Config.Banks) do
    objects[#objects + 1] = CreateServerObject(v.cameracontrol.model, v.cameracontrol.coords, v.cameracontrol.coords.w)
    local managerCoords = v.manager.coords[math.random(#v.manager.coords)]

    ---@diagnostic disable-next-line: param-type-mismatch
    CreateManager(k, v.manager.model, managerCoords)
    CreateCashStack(k)
    CreateTrolly(k)

    local door = exports.ox_doorlock:getDoorFromName(v.door.doorlock)
    Config.Banks[k].door.doorlock = door.id
    Config.Banks[k].door.busy = false

    rewarded[k] = { cashstack = false, trolly = false, lockbox = {} }
    for k2, _ in ipairs(v.lockbox) do
      rewarded[k].lockbox[k2] = false
      Config.Banks[k].lockbox[k2].busy = false
    end
  end
end)

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  for i = 1, #objects do
    local entity = NetworkGetEntityFromNetworkId(objects[i])
    if DoesEntityExist(entity) then
      DeleteEntity(entity)
    end
  end

  ResetDoorLocks()
  DestroyManagers()
  DestroyCashStacks()
  DestroyTrollys()
end)

RegisterNetEvent('ag_fleeca:server:syncPtfx', function(coords)
  TriggerClientEvent('ag_fleeca:client:syncPtfx', -1, coords)
end)

---@param data {type: 'cashstack' | 'lockbox' | 'trolly', key: number, index?: number}
RegisterNetEvent('ag_fleeca:server:rewardItem', function(data)
  local src = source
  if not Config.Rewards[data.type] then return end

  if not Config.Banks[data.key].vault_door.opened then
    return lib.logger(src, 'rewardItem', 'Tried to get a reward when the vault door is still closed', 'type:critical')
  end

  if data.type == 'cashstack' and not Config.Banks[data.key].door.opened then
    return lib.logger(src, 'rewardItem', 'Tried to get a reward when the inner door is still closed', 'type:critical')
  end

  if data.type == 'cashstack' and rewarded[data.key].cashstack then return end

  if data.type == 'trolly' and rewarded[data.key].trolly then return end
  if data.type == 'lockbox' and rewarded[data.key].lockbox[data.index] then return end
  if data.type == 'lockbox' then
    rewarded[data.key].lockbox[data.index] = true
  else
    rewarded[data.key][data.type] = true
  end
  local player = QBCore.Functions.GetPlayer(src)

  local items = Config.Rewards[data.type]
  local max = Config.Rewards.max
  local curr = 0
  for k, value in pairs(items) do
    if curr == max then break end
    local chance = math.random(1, 100)
    local amount = math.random(value.min, value.max)
    local canHave = false
    if (not value.chance) or (value.chance and value.chance >= chance) then
      canHave = true
    end
    if not canHave then goto skip end
    curr += 1
    if k == 'cash' then
      player.Functions.AddMoney('cash', amount)
      lib.logger(src, 'rewardItem',
        {
          message = ('Received %s x%d'):format(k, amount),
          amount = amount,
          type = 'added'
        }, 'economy:cash')
    else
      Inventory:AddItem(src, k, amount)
      lib.logger(src, 'rewardItem',
        {
          message = ('Received %s x%d'):format(k, amount),
          item = k,
          amount = amount,
          type = 'added'
        }, 'economy:item')
    end
    ::skip::
  end
end)

function CreateServerObject(hash, coords, rotation)
  local obj = CreateObjectNoOffset(hash, coords.x, coords.y, coords.z, true, true, false)
  if coords.w then
    SetEntityHeading(obj, coords.w)
    Wait(10)
  end
  if rotation then
    if type(rotation) == 'number' then
      ---@diagnostic disable-next-line: missing-parameter
      SetEntityRotation(obj, rotation)
    else
      SetEntityRotation(obj, rotation.x, rotation.y, rotation.z, 2, true)
    end
  end
  return NetworkGetNetworkIdFromEntity(obj)
end

RegisterNetEvent('ag_fleeca:server:removeItem', function(item)
  local src = source
  exports.ox_inventory:RemoveItem(src, item, 1)
end)

lib.callback.register('ag_fleeca:server:getBanksConfig', function()
  return Config.Banks
end)

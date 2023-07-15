math.randomseed(os.time())
lib.locale()
local Inventory = exports.ox_inventory
PoliceAlerted = false

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  SetupManager()

  repeat
    print('ox_doorlock not started')
    Wait(10)
  until GetResourceState('ox_doorlock') == 'started'

  for k, v in ipairs(Config.Bank.door) do
    local door = exports.ox_doorlock:getDoorFromName(v.doorlock)
    Config.Bank.door[k].doorlock = door.id
    Config.Bank.door[k].busy = false
  end

  for k, v in ipairs(Config.Bank.keypad) do
    local door = exports.ox_doorlock:getDoorFromName(v.doorlock)
    Config.Bank.keypad[k].doorlock = door.id
    Config.Bank.keypad[k].busy = false
  end

  for index, _ in ipairs(Config.Bank.stack) do
    CreateStack(index)
  end

  for index, _ in ipairs(Config.Bank.trolly) do
    CreateTrolly(index)
  end
end)

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  ResetDoorLocks()
  ResetKeypadLocks()
  DestroyStacks()
  DestroyTrollys()
end)

RegisterNetEvent('ag_pacific:server:removeItem', function(item)
  local src = source
  exports.ox_inventory:RemoveItem(src, item, 1)
end)

RegisterNetEvent('ag_pacific:server:syncPtfx', function(coords)
  TriggerClientEvent('ag_pacific:client:syncPtfx', -1, coords)
end)

---@param data {item: string, use: boolean, durability: number}
RegisterNetEvent('ag_pacific:server:useItem', function(data)
  local src = source

  local slot = exports.ox_inventory:GetSlotWithItem(src, data.item)
  if not slot then return end

  local curr = slot.metadata.durability or 100
  local new = curr - (data.durability or 50)

  if new <= 0 then
    return exports.ox_inventory:RemoveItem(src, data.item, 1, slot.metadata, slot.slot)
  end

  exports.ox_inventory:SetDurability(src, slot.slot, new)
end)

RegisterNetEvent('ag_pacific:server:notifyPolice', function()
  if PoliceAlerted then return end
  PoliceAlerted = true
  TriggerClientEvent('ag_pacific:client:notifyPolice', -1, true)
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

---@param data {type: string, key: string, bool: boolean}
RegisterNetEvent('ag_pacific:server:setBusy', function(data)
  Config.Bank[data.type][data.key].busy = data.bool

  TriggerClientEvent('ag_pacific:client:setBusy', -1, data)
end)

---@param data {key: string, index: string, number: number}
RegisterNetEvent('ag_pacific:server:getReward', function(data)
  local src = source
  if not data.key or not data.index or not data.number then return end

  local conf = Config.Bank[data.key][data.number]
  local can = true

  if conf.needed then
    local has = 0
    local needed = 0
    for k, v in pairs(conf.needed) do
      if type(v) == "number" then
        needed += 1
        if k == 'vault' or k == 'door' then
          if Config.Bank[k][v].opened then has += 1 end
        else
          if Config.Bank[k][v].busy then has += 1 end
        end
      elseif type(v) == "table" then
        needed += #v
        for _, v2 in pairs(v) do
          if k == 'vault' or k == 'door' then
            if Config.Bank[k][v2].opened then has += 1 end
          else
            if Config.Bank[k][v2].busy then has += 1 end
          end
        end
      end
    end
    if has < needed then can = false end
  end

  if not can then
    TriggerEvent('ag_pacific:server:setBusy', { type = data.key, key = data.number, bool = false })
    TriggerClientEvent('ox_lib:notify', src, { type = 'warning', description = locale('nice_try') })
    return lib.logger(src, 'getReward', ('Tried to get a reward when the needed criteria is not met. (%s %d)'):format(data.key, data.number), 'type:critical')
  end

  local reward = Config.Rewards[data.key][data.index]
  if not reward then return end

  if data.key == 'stack' then
    DeleteStack(data.number)
  end

  local chance = math.random(1, 100)
  local amount = reward.min and math.random(reward.min, reward.max) or reward.amount

  if (not reward.chance) or (reward.chance and reward.chance >= chance) then
    Inventory:AddItem(src, reward.item, amount)
    lib.logger(src, 'getReward',
      {
        message = ('Received %s x%d'):format(reward.item, amount),
        item = reward.item,
        amount = amount,
        type = 'added'
      }, 'economy:item')
  end
end)

lib.callback.register('ag_pacific:server:getConfig', function()
  return Config.Bank
end)

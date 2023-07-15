lib.locale()
Inventory = exports.ox_inventory
PoliceAlerted = false
local objects = {}

lib.callback.register('ag_paleto:server:getConfig', function()
  return Config.Paleto
end)

---@param data {item: string, durability: number}
RegisterNetEvent('ag_paleto:server:useItem', function(data)
  local src = source

  local slot = Inventory:GetSlotWithItem(src, data.item)
  if not slot then return end

  local curr = slot.metadata.durability or 100
  local new = curr - (data.durability or 50)

  if new <= 0 then
    return Inventory:RemoveItem(src, data.item, 1, slot.metadata, slot.slot)
  end

  Inventory:SetDurability(src, slot.slot, new)
end)

RegisterNetEvent('ag_paleto:server:removeItem', function(item)
  Inventory:RemoveItem(source, item, 1)
end)

---@param data {index: string, key: number, bool: boolean}
RegisterNetEvent('ag_paleto:server:setBusy', function(data)
  Config.Paleto[data.key][data.index].busy = data.bool

  TriggerClientEvent('ag_paleto:client:setBusy', -1, data)
end)

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  repeat
    print('ox_doorlock not started')
    Wait(10)
  until GetResourceState('ox_doorlock') == 'started'

  for k, v in ipairs(Config.Paleto.door) do
    local door = exports.ox_doorlock:getDoorFromName(v.doorlock)
    Config.Paleto.door[k].doorlock = door.id
  end

  for k, v in ipairs(Config.Paleto.control_door) do
    local door = exports.ox_doorlock:getDoorFromName(v.doorlock)
    Config.Paleto.control_door[k].doorlock = door.id
  end

  for k, v in ipairs(Config.Paleto.offices) do
    local door = exports.ox_doorlock:getDoorFromName(v.doorlock)
    Config.Paleto.offices[k].doorlock = door.id
  end

  for k, v in pairs(Config.Paleto.trolly) do
    local netid = CreateObject(v.model, v.coords)
    objects[#objects + 1] = netid
  end

  SetupCabinets()
  SetupVaultCodes()
end)

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  for _, v in pairs(objects) do
    local entity = NetworkGetEntityFromNetworkId(v)
    DeleteEntity(entity)
  end
end)

RegisterNetEvent('ag_paleto:server:notifyPolice', function()
  if PoliceAlerted then return end
  PoliceAlerted = true
  TriggerClientEvent('ag_paleto:client:notifyPolice', -1, true)
end)

---@param data {index: number, key: string, bool: boolean}
RegisterNetEvent('ag_paleto:server:openDoor', function(data)
  Config.Paleto[data.key][data.index].opened = true
  TriggerClientEvent('ag_paleto:client:setOpened', -1, data)
  TriggerEvent('ox_doorlock:setState', Config.Paleto[data.key][data.index].doorlock, 0)
end)

function CreateObject(hash, coords, rotation)
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

---@param data {index: number, key: string}
RegisterNetEvent('ag_paleto:server:getReward', function(data)
  local src = source

  local conf = Config.Paleto[data.key][data.index]
  local can = true

  if conf.needed then
    local has = 0
    local needed = 0
    for k, v in pairs(conf.needed) do
      if type(v) == "number" then
        needed += 1
        if k == 'door' or k == 'keypad' or k == 'computer' then
          if Config.Paleto[k][v].opened then has += 1 end
        else
          if Config.Paleto[k][v].busy then has += 1 end
        end
      elseif type(v) == "table" then
        needed += #v
        for _, v2 in pairs(v) do
          if k == 'door' or k == 'keypad' or k == 'computer' then
            if Config.Paleto[k][v2].opened then has += 1 end
          else
            if Config.Paleto[k][v2].busy then has += 1 end
          end
        end
      end
    end
    if has < needed then can = false end
  end

  if not can then
    TriggerEvent('ag_paleto:server:setBusy', { key = data.key, index = data.index, bool = false })
    TriggerClientEvent('ox_lib:notify', src, { type = 'warning', description = locale('nice_try') })
    return lib.logger(src, 'getReward', ('Tried to get a reward when the needed criteria is not met. (%s %d)'):format(data.key, data.index), 'type:critical')
  end

  local items = Config.Rewards[data.key]
  local max = Config.MaxRewards
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
    Inventory:AddItem(src, k, amount)
    lib.logger(src, 'rewardItem',
      {
        message = ('Received %s x%d'):format(k, amount),
        item = k,
        amount = amount,
        type = 'added'
      }, 'economy:item')
    ::skip::
  end
end)

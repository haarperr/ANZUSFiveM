lib.locale()
local Inventory = exports.ox_inventory
PoliceAlerted = false

lib.callback.register('ag_artgallery:server:getConfig', function()
  return Config.Artgallery
end)

---@param data {item: string, durability: number}
RegisterNetEvent('ag_artgallery:server:useItem', function(data)
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

RegisterNetEvent('ag_artgallery:server:removeItem', function(item)
  Inventory:RemoveItem(source, item, 1)
end)

---@param data {index: string, key: number, bool: boolean}
RegisterNetEvent('ag_artgallery:server:setBusy', function(data)
  Config.Artgallery[data.key][data.index].busy = data.bool

  TriggerClientEvent('ag_artgallery:client:setBusy', -1, data)
end)

RegisterServerEvent('ag_artgallery:server:ActivateLasers', function()
  TriggerClientEvent('ag_artgallery:client:ActivateLasers', -1)
end)

---@param data {index: number, key: string, bool: boolean}
RegisterNetEvent('ag_artgallery:server:openDoor', function(data)
  Config.Artgallery[data.key][data.index].opened = true
  TriggerEvent('ox_doorlock:setState', Config.Artgallery[data.key][data.index].doorlock, 0)
end)

---@param data {key: number}
RegisterNetEvent('ag_artgallery:server:swapCase', function(data)
  TriggerClientEvent('ag_artgallery:client:swapCase', -1, data)
end)

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end
  GenerateVaultCode()

  repeat
    print('ox_doorlock not started')
    Wait(10)
  until GetResourceState('ox_doorlock') == 'started'

  for index, v in ipairs(Config.Artgallery.computer) do
    local door = exports.ox_doorlock:getDoorFromName(v.doorlock)
    Config.Artgallery.computer[index].doorlock = door.id
    Config.Artgallery.computer[index].busy = false
    Config.Artgallery.computer[index].opened = false
  end

  for index, v in ipairs(Config.Artgallery.door) do
    local door = exports.ox_doorlock:getDoorFromName(v.doorlock)
    Config.Artgallery.door[index].doorlock = door.id
    Config.Artgallery.door[index].busy = false
    Config.Artgallery.door[index].opened = false
  end

  for index, v in ipairs(Config.Artgallery.keypad) do
    local door = exports.ox_doorlock:getDoorFromName(v.doorlock)
    Config.Artgallery.keypad[index].doorlock = door.id
    Config.Artgallery.keypad[index].busy = false
    Config.Artgallery.keypad[index].opened = false
  end
end)

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end
  ResetKeypadLocks()
end)

---@param data {index: number, key: string}
RegisterNetEvent('ag_artgallery:server:getReward', function(data)
  local src = source

  local conf = Config.Artgallery[data.key][data.index]
  local can = true

  if conf.needed then
    local has = 0
    local needed = 0
    for k, v in pairs(conf.needed) do
      if type(v) == "number" then
        needed += 1
        if k == 'door' or k == 'keypad' or k == 'computer' then
          if Config.Artgallery[k][v].opened then has += 1 end
        else
          if Config.Artgallery[k][v].busy then has += 1 end
        end
      elseif type(v) == "table" then
        needed += #v
        for _, v2 in pairs(v) do
          if k == 'door' or k == 'keypad' or k == 'computer' then
            if Config.Artgallery[k][v2].opened then has += 1 end
          else
            if Config.Artgallery[k][v2].busy then has += 1 end
          end
        end
      end
    end
    if has < needed then can = false end
  end

  if not can then
    TriggerEvent('ag_artgallery:server:setBusy', { key = data.key, index = data.index, bool = false })
    TriggerClientEvent('ox_lib:notify', src, { type = 'warning', description = locale('nice_try') })
    return lib.logger(src, 'getReward', ('Tried to get a reward when the needed criteria is not met. (%s %d)'):format(data.key, data.index), 'type:critical')
  end

  if data.key == 'egg' then
    return Inventory:AddItem(src, 'faberge_egg', 1)
  elseif data.key == 'painting' then
    return Inventory:AddItem(src, ('artg_%s'):format(Config.Artgallery.painting[data.index].name), 1)
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

RegisterNetEvent('ag_artgallery:server:notifyPolice', function()
  if PoliceAlerted then return end
  PoliceAlerted = true
  TriggerClientEvent('ag_artgallery:client:notifyPolice', -1, true)
end)

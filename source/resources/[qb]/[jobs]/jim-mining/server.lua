math.randomseed(os.time())
local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Server:UpdateObject', function()
  if source ~= '' then return false end
  QBCore = exports['qb-core']:GetCoreObject()
end)
local function HasItem(src, item, amount)
  local count = exports.ox_inventory:Search(src, 'count', item)
  if count < amount then return false end

  return true
end

local function getRandomItem(pool)
    pool = Config[pool]
  
    local weight = 0
    for _, data in ipairs(pool) do
      weight = weight + data.weight
    end
  
    local randomNumber = math.random(weight)
  
    local cumulative = 0
    for _, data in ipairs(pool) do
      cumulative = cumulative + data.weight
      if randomNumber <= cumulative then
        return {item = data.item, max = data.max or 2}
      end
    end
  
    return {item = "default_item", max = 1}
  
  end
---Crafting
RegisterServerEvent('jim-mining:GetItem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    --This grabs the table from client and removes the item requirements
    if data.craftable[data.tablenumber]["amount"] then amount = data.craftable[data.tablenumber]["amount"] else amount = 1 end
    for k, v in pairs(data.craftable[data.tablenumber][data.item]) do
        Player.Functions.RemoveItem(tostring(k), v)
    end
    --This should give the item, while the rest removes the requirements
    Player.Functions.AddItem(data.item, amount)
    TriggerClientEvent("jim-mining:CraftMenu", src, data)
end)

RegisterServerEvent('jim-mining:MineReward', function()
  local src = source
  local randomChance = math.random(1, 3)
  if not exports.ox_inventory:CanCarryItem(src, 'stone', randomChance) then return end
  exports.ox_inventory:AddItem(src, 'stone', randomChance)
end)



--Stone Cracking Checking Triggers
--Command here to check if any stone is in inventory
RegisterServerEvent('jim-mining:CrackReward', function(cost)
  local src = source

    for i = 1, math.random(1, 2) do
        local randItem = getRandomItem('CrackPool')
        local amount = math.random(1, randItem.max)
        if not exports.ox_inventory:CanCarryItem(src, randItem.item, amount) then return end
        exports.ox_inventory:AddItem(src, randItem.item, amount)
    end

  exports.ox_inventory:RemoveItem(src, 'stone', cost)
end)

--Stone Cracking Checking Triggers
--Command here to check if any stone is in inventory
RegisterServerEvent('jim-mining:WashReward', function(cost)
  local src = source
  local randItem = getRandomItem('WashPool')
  local amount = math.random(1, randItem.max)
  if not exports.ox_inventory:CanCarryItem(src, randItem.item, amount) then return end
  exports.ox_inventory:AddItem(src, randItem.item, amount)
  exports.ox_inventory:RemoveItem(src, 'stone', cost)
end)


-- RegisterServerEvent('jim-mining:PanReward', function()
--     local src = source
--     for j = 1, 200 do -- Loop 120 times
--         for i = 1, math.random(1, 2) do
--             local randItem = getRandomItem('PanPool')
--             local amount = math.random(1, randItem.max)
--             if not exports.ox_inventory:CanCarryItem(src, randItem.item, amount) then return end
--             exports.ox_inventory:AddItem(src, randItem.item, amount)
--         end
--     end
-- end)

RegisterServerEvent('jim-mining:PanReward', function()
  local src = source

    for i = 1, math.random(1, 2) do
        local randItem = getRandomItem('PanPool')
        local amount = math.random(1, randItem.max)
        if not exports.ox_inventory:CanCarryItem(src, randItem.item, amount) then return end
        exports.ox_inventory:AddItem(src, randItem.item, amount)
    end
end)

RegisterNetEvent("jim-mining:Selling", function(data)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local count = exports.ox_inventory:Search(src, 'count', data.item)
  if count == 0 then return end

  local pay = (count * Config.SellItems[data.item])
  exports.ox_inventory:RemoveItem(src, data.item, count)
  Player.Functions.AddMoney('cash', pay)

  lib.logger(src, 'Selling', {
    message = ('Sold %s x%d for %d'):format(data.item, count, pay),
    item = data.item,
    amount = pay,
    count = count,
    currency = 'cash',
    type = 'added'
  }, 'economy:sell')
end)

RegisterNetEvent('jim-mining:server:toggleItem', function(give, item, amount)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  if give == 0 or give == false then
    if HasItem(src, item, amount or 1) then -- check if you still have the item
      exports.ox_inventory:RemoveItem(src, item, amount or 1)
    else
      lib.logger(src, 'toggleItem', ('Player tried to remove item (%s %dx) but they dont have it?'):format(item, amount or 1))
      return
    end
  else
    if not exports.ox_inventory:CanCarryItem(src, item, amount) then return end
    exports.ox_inventory:AddItem(src, item, amount or 1)
  end
end)

AddEventHandler('onResourceStart', function(resource)
  if GetCurrentResourceName() ~= resource then return end
  local itemNames = {}

  for item, data in pairs(exports.ox_inventory:Items()) do
    itemNames[item] = data.label
  end

  for k, v in pairs(Config.SellItems) do if not exports.ox_inventory:Items(k) then print("Selling: Missing Item from ox_inventory: '" .. k .. "'") end end
  for i = 1, #Config.CrackPool do if not itemNames[Config.CrackPool[i]] then print("CrackPool: Missing Item from ox_inventory: '" .. Config.CrackPool[i] .. "'") end end
  for i = 1, #Config.WashPool do if not itemNames[Config.WashPool[i]] then print("WashPool: Missing Item from ox_inventory: '" .. Config.WashPool[i] .. "'") end end
  for i = 1, #Config.PanPool do if not itemNames[Config.PanPool[i]] then print("PanPool: Missing Item from ox_inventory: '" .. Config.PanPool[i] .. "'") end end
  for i = 1, #Config.Items.items do if not itemNames[Config.Items.items[i].name] then print("Shop: Missing Item from ox_inventory: '" .. Config.Items.items[i].name .. "'") end end
  local itemcheck = {}
  ---@diagnostic disable-next-line: redundant-parameter
  for _, v in pairs(Crafting) do
    for _, b in pairs(v) do
      for k, l in pairs(b) do
        if k ~= "amount" then
          itemcheck[k] = {}
          for j in pairs(l) do itemcheck[j] = {} end
        end
      end
    end
  end
  for k in pairs(itemcheck) do
    if not itemNames[k] then print("Crafting recipe couldn't find item '" .. k .. "' in the shared") end
  end
end)

QBCore = exports['qb-core']:GetCoreObject()
local PrisonAlarmActive = false

-- Ballas, Families, Vagos (Prison Gangs for DB)
QBCore.Functions.CreateCallback("gl-prison:getGangAffil", function(source, cb)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  MySQL.Async.fetchAll('SELECT * FROM gl_pgangs WHERE identifier = ?', { Player.PlayerData.citizenid }, function(result)
    cb(result)
  end)
end)

RegisterNetEvent('gl-prison:joinPrisonGang', function(gang)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)

  MySQL.Async.fetchAll('SELECT * FROM gl_pgangs WHERE identifier = ?', { Player.PlayerData.citizenid }, function(result)
    local ifOwner = table.unpack(result)
    if ifOwner ~= nil then
      TriggerClientEvent('QBCore:Notify', src, 'You are in another gang', 'error')
    else
      TriggerClientEvent('QBCore:Notify', src, 'You joined a gang!', 'primary')
      MySQL.Async.insert('INSERT INTO gl_pgangs (identifier, gang) VALUES (?, ?)', { Player.PlayerData.citizenid, gang })
    end
  end)
end)

RegisterNetEvent('gl-prison:updatePrisonRep', function(reputation, newsource)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player == nil then Player = QBCore.Functions.GetPlayer(newsource) end
  MySQL.Async.execute('UPDATE gl_pgangs SET reputation = ? WHERE identifier = ?', { reputation, Player.PlayerData.citizenid })
end)

-- Drug Stuff
RegisterNetEvent('gl-prison:checkDrugIngredients', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local canMix = true

  for k, v in pairs(Config.DrugIngredients) do
    local item = Player.Functions.GetItemByName(k)
    if not item or item.amount < v then
      canMix = false
    end
  end

  if canMix then
    for k, v in pairs(Config.DrugIngredients) do
      Player.Functions.RemoveItem(k, v)
      TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[k], "remove", v)
    end
    TriggerClientEvent('gl-prison:doTheMixing', src)
    Wait(30000)
    Player.Functions.AddItem(Config.UnprocessedName, 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.UnprocessedName], "add", 1)
  end
end)

RegisterNetEvent('gl-prison:bakeDrugs', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local drugItem = Player.Functions.GetItemByName(Config.UnprocessedName)
  if drugItem and drugItem.amount > 0 then
    Player.Functions.RemoveItem(Config.UnprocessedName, 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.UnprocessedName], "remove", 1)
    TriggerClientEvent('gl-prison:doTheBaking', src)
  end
end)

RegisterNetEvent('gl-prison:drugReady', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.AddItem(Config.DrugName, Config.ProcessedAmount)
  TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.DrugName], "add", Config.ProcessedAmount)
end)

-- Not Gang Stuff
RegisterNetEvent('gl-prison:checkCanCook', function(item, time, cost)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local itemC = Player.Functions.GetItemByName('ingredients')
  if itemC and itemC.amount >= cost then
    Player.Functions.RemoveItem('ingredients', cost)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['ingredients'], "remove", cost)
    TriggerClientEvent('gl-prison:beginCookFood', src, time, cost)
    Wait(time)
    Player.Functions.AddItem(item, 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add", 1)
  else
    TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any ingredients', 'error')
  end
end)

RegisterNetEvent('gl-prison:checkIngredients', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local itemC = Player.Functions.GetItemByName('ingredients')
  if itemC and itemC.amount < 20 then
    local doSomeMath = 20 - itemC.amount
    Player.Functions.AddItem('ingredients', doSomeMath)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['ingredients'], "add", doSomeMath)
  elseif not itemC then
    Player.Functions.AddItem('ingredients', 20)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['ingredients'], "add", 20)
  else
    TriggerClientEvent('QBCore:Notify', src, 'Try to cook something with the ingredients you have first', 'error')
  end
end)

RegisterNetEvent('gl-prison:tryTakeItem', function(item)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local itemC = Player.Functions.GetItemByName(item)
  if not itemC or itemC.amount < 3 then
    Player.Functions.AddItem(item, 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add", 1)
  end
end)

RegisterNetEvent('gl-prison:turnInJob', function(job)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if job == 'Cook' then
    local itemC = Player.Functions.GetItemByName('prisonmeal')
    Player.Functions.RemoveItem('prisonmeal', itemC.amount)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['prisonmeal'], "remove", itemC.amount)
  end

  if Config.GiveMoney then
    Player.Functions.AddMoney('cash', Config.MoneyReward)
  elseif Config.GiveItem then
    Player.Functions.AddItem(Config.ItemReward, Config.ItemAmount)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.ItemReward], "add", Config.ItemAmount)
  end
end)

RegisterNetEvent('gl-prison:prisonerJob', function(item, amount)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if item == nil then
    TriggerClientEvent('gl-prison:prisonJobDoThing', src)
  else
    local itemC = Player.Functions.GetItemByName(item)
    if itemC and itemC.amount >= amount then
      Player.Functions.RemoveItem(item, amount)
      TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "remove", amount)
      TriggerClientEvent('gl-prison:prisonJobDoThing', src)
    end
  end
end)

RegisterNetEvent('gl-prison:checkPrisonerJob', function(item, min, max, reputation)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local doSomeMathG = math.random(min, max)
  local newRep = reputation + Config.RepGains
  if item ~= nil then
    local itemC = Player.Functions.GetItemByName(item)
    if itemC and itemC.amount >= 1 then
      Player.Functions.RemoveItem(item, 1)
      TriggerClientEvent('QBCore:Notify', src, 'Yo thanks man, take this.', 'success')
      Player.Functions.AddItem(Config.PrisonReward, doSomeMathG)
      TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.PrisonReward], "add", doSomeMathG)
      TriggerEvent('gl-prison:updatePrisonRep', newRep, src)
    end
  else
    Player.Functions.AddItem(Config.PrisonReward, doSomeMathG)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.PrisonReward], "add", doSomeMathG)
    TriggerEvent('gl-prison:updatePrisonRep', newRep, src)
  end
end)

RegisterNetEvent('gl-prison:checkTrade', function(item, cost)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local itemC = Player.Functions.GetItemByName(Config.PrisonReward)
  if itemC and itemC.amount >= cost then
    Player.Functions.RemoveItem(Config.PrisonReward, cost)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.PrisonReward], "remove", cost)
    Player.Functions.AddItem(item, 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.PrisonReward], "add", 1)
  end
end)

-- Prison Alarm Stuff
RegisterNetEvent('gl-prison:ToggleAlarm', function()
  if PrisonAlarmActive then
    TriggerClientEvent('QBCore:Notify', source, 'Alarm Has Been Deactivated', 'primary')
    TriggerClientEvent('gl-prison:breakOutAlarm', -1, false)
  else
    TriggerClientEvent('QBCore:Notify', source, 'Alarm Has Been Activated', 'primary')
    TriggerEvent('gl-prison:PrisonBreakAlarm')
  end
end)

RegisterNetEvent('gl-prison:PrisonBreakAlarm', function()
  PrisonAlarmActive = true
  TriggerClientEvent('gl-prison:breakOutAlarm', -1, true)
  SetTimeout(5 * 60000, function()
    PrisonAlarmActive = false
    TriggerClientEvent('gl-prison:breakOutAlarm', -1, false)
  end)
end)

-- Recreational Stuff
RegisterNetEvent('gl-prison:sendDeleteBall', function(ballID)
  TriggerClientEvent('gl-prison:deleteBall', -1, ballID)
end)

RegisterNetEvent('gl-prison:syncBall', function(ballID)
  TriggerClientEvent('gl-prison:syncBall', -1, ballID)
end)

RegisterNetEvent('gl-prison:sendDeleteBasketBall', function(ballBasketID)
  TriggerClientEvent('gl-prison:deleteBasketBall', -1, ballBasketID)
end)

RegisterNetEvent('gl-prison:syncBasketBall', function(ballBasketID)
  TriggerClientEvent('gl-prison:syncBasketBall', -1, ballBasketID)
end)

-- Sync Tossed Drugs
RegisterNetEvent('gl-prison:syncTossedDrug', function(drugID)
  TriggerClientEvent('gl-prison:syncTossedDrug', -1, drugID)
end)

-- Open Drug Bag
RegisterNetEvent('gl-prison:openedDrugBag', function(drugID)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.AddItem(Config.DrugName, 40)
  TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.DrugName], "add", 40)
  TriggerClientEvent("gl-prison:deleteDrugBag", -1, drugID)
end)

-- Pack Drug Bag
RegisterNetEvent('gl-prison:packDrugBag', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local bag = Player.Functions.GetItemByName('drugbag')
  local drug = Player.Functions.GetItemByName(Config.DrugName)
  if bag and bag.amount > 0 and drug and drug.amount >= 40 then
    Player.Functions.AddItem('fullbag', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[fullbag], "add", 1)
    Player.Functions.RemoveItem(Config.DrugName, 40)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.DrugName], "remove", 40)
    Player.Functions.RemoveItem('drugbag', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[drugbag], "remove", 1)
  end
end)

-- Commissary
RegisterNetEvent('gl-prison:buyFromCom', function(item, cost, curr)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if curr == 'money' then
    if Player.PlayerData.money['cash'] >= cost then
      Player.Functions.RemoveMoney('cash', cost)
      Player.Functions.AddItem(item, 1)
      TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add", 1)
    else
      TriggerClientEvent('QBCore:Notify', src, 'Come back when you have enough money', 'error')
    end
  else
    local itemC = Player.Functions.GetItemByName(curr)
    if itemC and itemC.amount >= cost then
      Player.Functions.RemoveItem(curr, cost)
      TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[curr], "remove", cost)
      Player.Functions.AddItem(item, 1)
      TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add", 1)
    else
      TriggerClientEvent('QBCore:Notify', src, 'Come back when you have enough to trade me for', 'error')
    end
  end
end)

RegisterNetEvent('prison:server:SetJailStatus', function(jailTime)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.SetMetaData("injail", jailTime)
end)

RegisterNetEvent('prison:server:SaveJailItems', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.SetMetaData("jailitems", Player.PlayerData.items)
  Wait(2000)
  exports.ox_inventory:ClearInventory(src)
end)

RegisterNetEvent('prison:server:GiveJailItems', function(escaped)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end
  Wait(1000)
  if escaped then
    Player.Functions.SetMetaData("jailitems", {})
    return
  end
  for _, v in pairs(Player.PlayerData.metadata["jailitems"]) do
    exports.ox_inventory:AddItem(src, v.name, v.count, v.metadata, v.slot)
  end
  Wait(1000)
  Player.Functions.SetMetaData("jailitems", {})
end)


RegisterNetEvent('gl-prison:foundBedItem', function(item, amount)
  local src = source

  local ped = GetPlayerPed(src)
  local pedCoords = GetEntityCoords(ped)

  local can = false
  local dist = 0
  local lastDist = 0
  for i = 1, #Config.BedLocations, 1 do
    local loc = Config.BedLocations[i]
    dist = #(pedCoords - loc.coords)
    if lastDist == 0 or dist < lastDist then lastDist = dist end
    if dist < 5 then
      can = true
      break
    end
  end

  if not can then
    return lib.logger(src, 'foundBedItem', ('Executed this when %d away from the nearest bed'):format(lastDist), 'type:critical')
  end

  exports.ox_inventory:AddItem(src, item, amount)
end)

-- Prison Break
-- RegisterNetEvent('gl-prison:setBlackout',function()
-- 	exports["qb-weathersync"]:setBlackout(true)
-- 	SetTimeout(Config.PowerOutageTimer * 60000, function()
-- 		exports["qb-weathersync"]:setBlackout(false)
--     end)
-- end)

-- RegisterNetEvent('gl-prison:RemoveExplosive',function(item)
-- 	local src = source
-- 	local Player = QBCore.Functions.GetPlayer(src)
-- 	Player.Functions.RemoveItem(item, 1)
-- 	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
-- end)

-- RegisterNetEvent('gl-prison:ExplosiveEffect', function (coords)
-- 	TriggerClientEvent('gl-prison:ExplosiveEffect', -1, coords)
-- end)

-- RegisterNetEvent('gl-prison:SetGate', function (id, state)
-- 	TriggerClientEvent('gl-prison:SetGate', -1, id, state)
-- end)

-- RegisterNetEvent('gl-prison:SetPower', function (id, state)
-- 	TriggerClientEvent('gl-prison:SetPower', -1, id, state)
-- end)

-- RegisterNetEvent('gl-prison:SetSwitch', function (id, state)
-- 	TriggerClientEvent('gl-prison:SetSwitch', -1, id, state)
-- end)


-- Sangria
QBCore.Functions.CreateUseableItem('sangria', function(source)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.RemoveItem('sangria', 1)
  TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['sangria'], "remove", 1)
  TriggerClientEvent('gl-prison:onSangria', src)
end)

-- Tinfoil
QBCore.Functions.CreateUseableItem('tinfoil', function(source)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.RemoveItem('tinfoil', 1)
  TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['tinfoil'], "remove", 1)
  Player.Functions.AddItem('foilpipe', 1)
  TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['foilpipe'], "add", 1)
end)

-- Tinfoil Pipe (To smoke Mud)
QBCore.Functions.CreateUseableItem('foilpipe', function(source)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local mud = Player.Functions.GetItemByName(Config.DrugName)
  if mud and mud.amount > 0 then
    Player.Functions.RemoveItem(Config.DrugName, 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.DrugName], "remove", 1)
    TriggerClientEvent('gl-prison:onMud', src)
  end
end)

-- Add Throwing Drugs and Throwing Money
QBCore.Functions.CreateUseableItem('drugbag', function(source)
  local src = source
  local Player = QBCore.Functions.GetPlayer(source)
  local mud = Player.Functions.GetItemsByName(Config.DrugName)
  local bag = Player.Functions.GetItemByName('drugbag')
  local amount = 0
  local amountToRemove = 40
  for k, v in pairs(mud) do
    amount = amount + v.amount
  end
  if amount >= 40 and bag then
    for k, v in pairs(mud) do
      if amountToRemove == 0 then
        break
      end
      if amountToRemove >= v.amount then
        amountToRemove = amountToRemove - v.amount
        Player.Functions.RemoveItem(Config.DrugName, v.amount, v.slot)
      elseif amountToRemove <= v.amount then
        Player.Functions.RemoveItem(Config.DrugName, amountToRemove, v.slot)
        amountToRemove = 0
      end
    end
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config.DrugName], "remove", 40)
    Player.Functions.RemoveItem('drugbag', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['drugbag'], "remove", 1)
    Player.Functions.AddItem('fullbag', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['fullbag'], "add", 1)
  end
end)

QBCore.Functions.CreateUseableItem('fullbag', function(source)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.RemoveItem('fullbag', 1)
  TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['fullbag'], "remove", 1)
  TriggerClientEvent('gl-prison:throwFullBag', src)
end)

function StashTidy(stash, stashId)
  if Config.Debug then print("^5Debug^7: ^3StashTidy^7: ^2Tidying Stash^7 - '^6" .. stashId .. "^7'") end
  for k, v in pairs(stash) do
    for l, b in pairs(stash) do
      if v.name == b.name and k ~= l then
        if Config.Debug then
          print("^5Debug^7: ^3StashTidy^7: ^2Found duplicate item^7: '^6" .. v.name .. "^7'")
          print("^5Debug^7: ^3StashTidy^7: ^2Removing Stash slot ^7[^6" .. l .. "^7] (^2x^6" .. b.amount .. "^7) ^2and Adding to Stash slot ^7[^6" ..
            k .. "^7] (^2x^6" .. v.amount .. "^7)")
        end
        v.amount = v.amount + b.amount
        if Config.Debug then print("^5Debug^7: ^3StashTidy^7: ^2Adjusted Slot ^7- [^6" .. k .. "^7] - '^6" .. v.name .. "^7' (^2x^6" .. v.amount .. "^7)") end
        stash[l] = nil
      end
    end
  end
  if Config.Debug then print("^5Debug^7: ^3StashTidy^7: ^2Tidying Complete^7!") end
  TriggerEvent('jim-mechanic:server:saveStash', stashId, stash)
  return stash
end

function GetStashItems(stashId)
  local items = {}
  local sql = 'SELECT items FROM stashitems WHERE stash = ?'
  if Config.qsinventory then sql = 'SELECT items FROM qs_stash WHERE stash = ?' end
  local result = MySQL.Sync.fetchScalar(sql, { stashId })
  if result then
    local stashItems = json.decode(result)
    if stashItems then
      for k, item in pairs(stashItems) do
        local itemInfo = QBCore.Shared.Items[item.name:lower()]
        if itemInfo then
          items[item.slot] = {
            name = itemInfo["name"],
            amount = tonumber(item.amount),
            info = item.info ~= nil and item.info or "",
            label = itemInfo["label"],
            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
            weight = itemInfo["weight"],
            type = itemInfo["type"],
            unique = itemInfo["unique"],
            useable = itemInfo["useable"],
            image = itemInfo["image"],
            slot = item.slot,
          }
        end
      end
    end
  end
  if Config.Debug then print("^5Debug^7: ^3GetStashItems^7: ^2Stash information for ^7'^6" .. stashId .. "^7' ^2retrieved^7") end
  return items
end

QBCore.Functions.CreateCallback('jim-mechanic:server:GetStashItems', function(source, cb, stashName)
  local stash = StashTidy(GetStashItems(stashName), stashName)
  cb(stash)
end)

---Crafting
RegisterServerEvent('jim-mechanic:Crafting:GetItem', function(ItemMake, craftable)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  --This grabs the table from client and removes the item requirements
  if craftable["amount"] then amount = craftable["amount"] else amount = 1 end
  if Config.StashCraft then
    local stashItems = GetStashItems(Player.PlayerData.job.name .. "Safe")
    for k, v in pairs(craftable[ItemMake]) do
      for l, b in pairs(stashItems) do
        if k == b.name then
          stashItems[l].amount = stashItems[l].amount - v
          if stashItems[l].amount <= 0 then stashItems[l] = nil end
          TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], "use", v)
          TriggerEvent('jim-mechanic:server:saveStash', Player.PlayerData.job.name .. "Safe", stashItems)
          if Config.Debug then
            print("^5Debug^7: ^3Crafting^7: ^2Removing ^6" ..
              QBCore.Shared.Items[k].label .. " ^2x^6" .. v .. " ^2from stash^7: '^6" .. Player.PlayerData.job.name .. "Safe^7'")
          end
        end
      end
    end
  else
    for k, v in pairs(craftable[ItemMake]) do
      TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tostring(k)], "remove", v)
      Player.Functions.RemoveItem(tostring(k), v)
    end
  end
  --This should give the item, while the rest removes the requirements
  Player.Functions.AddItem(ItemMake, amount)
  TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ItemMake], "add", amount)
end)

---ITEM REQUIREMENT CHECKS
QBCore.Functions.CreateCallback('jim-mechanic:Crafting:get', function(source, cb, item, craftable)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local hasitem = true
  local testtable = {}
  for k, v in pairs(craftable[item]) do testtable[k] = false end
  if Config.StashCraft then
    local stashItems = StashTidy(GetStashItems(Player.PlayerData.job.name .. "Safe"), Player.PlayerData.job.name .. "Safe")
    for k, v in pairs(craftable[item]) do
      for _, b in pairs(stashItems) do
        if k == b.name and b.amount >= v then
          testtable[k] = true
          if Config.Debug then print("^5Debug^7: ^3Crafting^7: ^6" .. b.label .. " ^2x^6" .. b.amount .. " ^2found in stash^7: '^6" .. Player.PlayerData.job.name .. "Safe^7'") end
        end
      end
    end
  else
    for k, v in pairs(craftable[item]) do
      if QBCore.Functions.GetPlayer(source).Functions.GetItemByName(k) and QBCore.Functions.GetPlayer(source).Functions.GetItemByName(k).amount >= v then
        testtable[k] = true
        if Config.Debug then print("^5Debug^7: ^3Crafting^7: ^6" .. k .. " ^7(^2x^6" .. v .. "^7) ^2found^7") end
      end
    end
  end
  for k, v in pairs(testtable) do
    if not v then
      hasitem = false
      if Config.Debug then print("^5Debug^7: ^3Crafting^7: ^6" .. QBCore.Shared.Items[k].label .. " ^1NOT ^2found^7") end
    end
  end
  cb(hasitem)
end)

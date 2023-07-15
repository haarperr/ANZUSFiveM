RegisterServerEvent(GetCurrentResourceName() .. ":server:removeItem", function(itemName)
  local src = source
  local success = exports.ox_inventory:RemoveItem(src, itemName, 1)
  if not success then
    TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'You don\'t have any ' .. itemName })
  end
end)


RegisterServerEvent(GetCurrentResourceName() .. ':server:harvestWeed', function(id, loc)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local received = true
  local addedItems = {}
  local amountToGive = 0
  if WeedPlants[id] and WeedPlants[id].coords == loc then
    for _, v in pairs(Config.Seed[WeedPlants[id].seed].returnItems) do
      if type(v.amount) == "table" then
        if v.amount[1] < v.amount[2] then
          amountToGive = math.random(v.amount[1], v.amount[2])
        else
          amountToGive = math.random(v.amount[2], v.amount[1])
        end
      else
        amountToGive = v.amount
      end

      amountToGive = amountToGive
      if v.basedOnHealth then
        amountToGive = math.floor(amountToGive * (WeedPlants[id].health / 100))
      end

      if amountToGive <= 0 then amountToGive = 1 end

      if math.random(1, 100) <= v.probability then
        if exports.ox_inventory:AddItem(src, v.itemName, amountToGive) then
          table.insert(addedItems, { item = v.itemName, amount = amountToGive })
          received = received and true
        else
          received = received and false
        end
      end
    end
    if received then
      table.remove(WeedPlants, id)
      StorePlantsTable()
      TriggerClientEvent(GetCurrentResourceName() .. ':client:deleteWeedPlant', -1, id, "harvested")
      Player.Functions.SetMetaData("farmingrep", Player.PlayerData.metadata["farmingrep"] + Config.RepGiven)
    else
      for _, v in pairs(addedItems) do
        exports.ox_inventory:RemoveItem(src, v.item, v.amount)
      end
      TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = Config.Locale["inventory_full_error"] })
    end
  else
    for k, data in ipairs(WeedPlants) do
      if data.coords ~= loc then goto skip end
      for _, v in pairs(Config.Seed[WeedPlants[k].seed].returnItems) do
        amountToGive = v.amount

        if type(v.amount) == "table" then
          if v.amount[1] < v.amount[2] then
            amountToGive = math.random(v.amount[1], v.amount[2])
          else
            amountToGive = math.random(v.amount[2], v.amount[1])
          end
        end

        amountToGive = amountToGive

        if v.basedOnHealth then amountToGive = math.floor(amountToGive * (WeedPlants[k].health / 100)) end

        if amountToGive <= 0 then amountToGive = 1 end

        if math.random(1, 100) <= v.probability then
          received = received and false
          if exports.ox_inventory:AddItem(src, v.itemName, amountToGive) then
            table.insert(addedItems, { item = v.itemName, amount = amountToGive })
            received = received and true
          end
        end
      end
      if received then
        table.remove(WeedPlants, id)
        StorePlantsTable()
        TriggerClientEvent(GetCurrentResourceName() .. ':client:deleteWeedPlant', -1, k, "harvested")
        Player.Functions.SetMetaData("farmingrep", Player.PlayerData.metadata["farmingrep"] + Config.RepGiven)
      else
        for _, v in pairs(addedItems) do
          exports.ox_inventory:RemoveItem(src, v.item, v.amount)
        end
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = Config.Locale["inventory_full_error"] })
      end
    end
    ::skip::
  end
end)

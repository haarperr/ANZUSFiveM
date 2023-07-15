local QBCore = exports['qb-core']:GetCoreObject()
-- Main Function

local function craft(src, item, multiplier)
  local xPlayer = QBCore.Functions.GetPlayer(src)
  local cancraft = false
  local total = 0
  local count = 0
  local uses = 0
  local perm = false
  local recipe = nil

  if not Config.Recipes[item] then
    for _, v in pairs(Config.Workbenches) do
      for k, v2 in pairs(v.recipes) do
        if k == item then
          recipe = v2
          break
        end
      end
    end
  else
    recipe = Config.Recipes[item]
  end

  local reward = recipe.Amount * multiplier
  for k, v in pairs(recipe.Ingredients) do
    total = total + 1
    if not Config.PermanentItems[k] then
      v = v * multiplier
    end

    local mat = xPlayer.Functions.GetItemsByName(k)
    local tmpamount = 0
    for i = 1, #mat, 1 do
      local slot = mat[i]
      tmpamount = tmpamount + slot.count
      if Config.PermanentItems[slot.name] then
        uses = slot.info and slot.info.uses or 10
        perm = true
      end
    end
    if mat ~= nil and tmpamount >= v then
      count = count + 1
    end
  end
  if perm and uses < multiplier then
    cancraft = false
  elseif total == count then
    cancraft = true
  else
    TriggerClientEvent('QBCore:Notify', src, 'You dont have enough materials', "error")
  end

  if cancraft then
    TriggerClientEvent("core_crafting:craftStart", src, item, reward, multiplier, recipe)
  end
end

-- Main Event

RegisterNetEvent("core_crafting:craft", function(item, multiplier, retrying)
  local src = source
  craft(src, item, multiplier, retrying)
end)

RegisterNetEvent("core_crafting:itemCrafted", function(item, count, multiplier)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local can = true
  local recipe = nil

  if not Config.Recipes[item] then
    for _, v in pairs(Config.Workbenches) do
      for k, v2 in pairs(v.recipes) do
        if k == item then
          recipe = v2
          break
        end
      end
    end
  else
    recipe = Config.Recipes[item]
  end

  if recipe.SuccessRate >= math.random(0, 100) then
    for k, v in pairs(recipe.Ingredients) do
      v = v * multiplier
      if not Config.PermanentItems[k] then
        if exports.ox_inventory:GetItemCount(src, k) >= v then
          Player.Functions.RemoveItem(k, v)
        else
          can = false
          break
        end
      else
        local items = Player.Functions.GetItemsByName(k)
        local permItem = nil
        for i = 1, #items, 1 do
          local data = items[i]
          if Config.PermanentItems[k] then
            if data.info.uses >= v then
              permItem = data
            end
          end
        end

        if permItem.info.uses == v then
          Player.Functions.RemoveItem(permItem.name, 1, permItem.slot)
        else
          Player.PlayerData.items[permItem.slot].info.uses = permItem.info.uses - (1 * multiplier)
          Player.Functions.SetInventory(Player.PlayerData.items)
        end
      end
    end
    if can then
      if recipe.isGun then
        Player.Functions.AddItem(item, count)
      else
        if Config.PermanentItems[item] then
          local uses = 100
          if item == "wrench" then
            uses = 50
          elseif item == "wrench" then
            uses = 50
          elseif item == "blowtorch" then
            uses = 50
          elseif item == "smithingwrench" then
            uses = 50
          elseif item == "advancedscrewdriver" then
            uses = 50
          end
          Player.Functions.AddItem(item, count, false, { uses = uses })
        else
          Player.Functions.AddItem(item, count)
        end
      end
      TriggerClientEvent('QBCore:Notify', src, 'Successful assembly', 'success')
      Player.Functions.SetMetaData("craftingrep", Player.PlayerData.metadata["craftingrep"] + (Config.Recipes[item].ExperiancePerCraft * multiplier))
    end
  else
    TriggerClientEvent('QBCore:Notify', src, 'Failed assembly!', 'error')
  end
end)

QBCore.Commands.Add("craftxp", '', { { name = "level", help = 'level' } }, false, function(source, args)
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.SetMetaData('craftingrep', tonumber(args[1]) * ((tonumber(args[1]) + 4) / 17 * 100))
end)


QBCore.Commands.Add("rpgbp", '', {}, false, function(source, args)
  exports['ag-blueprints']:GiveBlueprint(source, 'weapon_hominglauncher')
end)

-- Prop
--

QBCore.Functions.CreateUseableItem("craft1", function(source, item)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  if exports.ox_inventory:RemoveItem(src, 'craft1', 1) then
    TriggerClientEvent("core_crafting:Placecraft1", src, item.name)
  end
end)
RegisterNetEvent('core_crafting:server:Removecraft1', function()
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  exports.ox_inventory:RemoveItem(src, 'craft1', 1)
end)

RegisterNetEvent('core_crafting:server:Pickupcraft1', function()
  local src = source
  exports.ox_inventory:AddItem(src, 'craft1', 1)
end)

-- Animal Shit

RegisterNetEvent('core_crafting:server:pickupshit', function()
  local src = source
  exports.ox_inventory:RemoveItem(src, 'cowshit', 1)
end)

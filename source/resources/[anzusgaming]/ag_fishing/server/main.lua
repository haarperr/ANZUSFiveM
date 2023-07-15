lib.locale()
QBCore = exports['qb-core']:GetCoreObject()
math.randomseed(os.time())

RegisterNetEvent('ag_fishing:server:decreaseDurability', function(slot)
  local src = source
  if slot.name ~= 'fishingrod' then return end

  local item = exports.ox_inventory:GetSlot(src, slot.slot)

  if item.name ~= 'fishingrod' then return end

  local durability = item.metadata.durability or 100
  if (durability - 5) == 0 then
    exports.ox_inventory:RemoveItem(src, 'fishingrod', 1, nil, slot)
  else
    exports.ox_inventory:SetDurability(src, slot.slot, durability - 5)
  end
end)

RegisterNetEvent('ag_fishing:server:RemoveBait', function()
  local src = source

  exports.ox_inventory:RemoveItem(src, 'fishingbait', 1)
end)

RegisterNetEvent('ag_fishing:server:ReceiveFish', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end

  local max = Config.maxRewards
  local curr = 0
  local received = ''

  for key, value in pairs(Config.Rewards) do
    if curr == max then break end
    local chance = math.random(1, 100)
    local amount = math.random(value.min, value.max)
    local canHave = false
    if (not value.chance) or (value.chance and value.chance >= chance) then
      canHave = true
    end
    if not canHave then goto skip end
    curr += 1
    local canCarry = exports.ox_inventory:CanCarryItem(src, key, amount)
    if not canCarry then
      TriggerClientEvent('ox_lib:notify', src, { type = 'error', title= locale('notify_title'), description = locale('inventory_full') })
      break
    end
    received = received .. ('%s x%d '):format(key, amount)

    exports.ox_inventory:AddItem(src, key, amount)
    ::skip::
  end

  lib.logger(Player.PlayerData.source, 'ReceiveFish', ('Player has received %s'):format(received))
end)



QBCore.Functions.CreateUseableItem('unopenedchest', function(source, item)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local randomchance = math.random(1, 100)
  if Player.Functions.RemoveItem("unopenedchest", 1) then
    if randomchance <= 2 then
      if exports.ox_inventory:CanCarryItem(src, 'goldbar', 5) then
        exports.ox_inventory:AddItem(src, "goldbar", 5)
      end
    elseif randomchance >= 3 and randomchance <= 5 then
      if exports.ox_inventory:CanCarryItem(src, 'goldbar', 1) then
        exports.ox_inventory:AddItem(src, "goldbar", 1)
      end
    elseif randomchance >= 6 and randomchance <= 15 then
      if exports.ox_inventory:CanCarryItem(src, 'watch_1', 1) then
        exports.ox_inventory:AddItem(src, "watch_1", 1)
      end
    elseif randomchance >= 16 and randomchance <= 30 then
      if exports.ox_inventory:CanCarryItem(src, 'watch_2', 1) then
        exports.ox_inventory:AddItem(src, "watch_2", 1)
      end
    elseif randomchance >= 31 and randomchance <= 55 then
      if exports.ox_inventory:CanCarryItem(src, 'watch_3', 1) then
        exports.ox_inventory:AddItem(src, "watch_3", 1)
      end
    elseif randomchance >= 56 and randomchance <= 70 then
      if exports.ox_inventory:CanCarryItem(src, 'earring_1', 1) then
        exports.ox_inventory:AddItem(src, "earring_1", 1)
      end
    else
      if exports.ox_inventory:CanCarryItem(src, 'earring_2', 1) then
        exports.ox_inventory:AddItem(src, "earring_2", 1)
      end
    end
  end
end)

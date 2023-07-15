local Inventory = exports.ox_inventory

---@param data {key: number}
RegisterNetEvent('ag_jewellery:server:swapCase', function(data)
  TriggerClientEvent('ag_jewellery:client:swapCase', -1, data)
end)

---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_jewellery:server:setCaseBusy', function(data)
  Config.Jewellery.case[data.key].busy = data.bool
  TriggerClientEvent('ag_jewellery:client:setCaseBusy', -1, data)
end)

RegisterNetEvent('ag_jewellery:server:getReward', function(key)
  local src = source
  local player = QBCore.Functions.GetPlayer(src)

  local items = Config.Rewards.case
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

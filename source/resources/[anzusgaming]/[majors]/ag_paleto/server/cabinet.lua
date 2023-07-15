---@param data {index: number}
RegisterNetEvent('ag_major:paleto:openCabinet', function(data)
  local src = source
  TriggerClientEvent('ox_inventory:openInventory', src, 'stash', Config.Paleto.cabinet[data.index].id)
end)

function SetupCabinets()
  for k, _ in ipairs(Config.Paleto.cabinet) do
    local items = {}

    for item, data in pairs(Config.Inventories.cabinet.items) do
      local chance = math.random(1, 100)
      local amount = data.min and math.random(data.min, data.max) or data.amount
      local canHave = false
      if (not data.chance) or (data.chance and data.chance >= chance) then
        canHave = true
      end
      if not canHave then goto skip end
      items[#items + 1] = { item, amount }
      ::skip::
    end

    Config.Paleto.cabinet[k].id = Inventory:CreateTemporaryStash({ label = ('Cabinet %s'):format(k), slots = 10, owner = false, maxWeight = 100, items = items })
  end
end

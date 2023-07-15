exports.ox_inventory:registerHook('swapItems', function(payload)
  local has = false
  if payload.toType == 'player' then has = true end
  TriggerClientEvent(('ag_misc:client:%s'):format(payload.fromSlot.name), payload.source, has)

  if payload.fromSlot.metadata.store then
    if string.find(payload.toInventory, payload.fromSlot.metadata.store) then
      exports.ox_inventory:AddItem(payload.toInventory, payload.fromSlot.metadata.ingredient, payload.fromSlot.metadata.amount or 1)
      CreateThread(function()
        Wait(10)
        exports.ox_inventory:RemoveItem(payload.toInventory, 'crate', 1, payload.fromSlot.metadata)
      end)
    end
  end
  return true
end, {
  itemFilter = {
    crate = true,
    barrel_methylamine = true
  },
})

exports.ox_inventory:registerHook('createItem', function(payload)
  if type(payload.inventoryId) == 'string' then return end
  TriggerClientEvent(('ag_misc:client:%s'):format(payload.item.name), payload.inventoryId, true)
end, {
  itemFilter = {
    crate = true,
    barrel_methylamine = true
  },
})

local combinations = {
  crowbar = { needs = 'barrel_methylamine', result = 'open_barrel_methylamine' }
}

exports.ox_inventory:registerHook('swapItems', function(payload)
  local src = payload.source

  if payload.fromSlot ~= nil and payload.toSlot ~= nil and combinations[payload.fromSlot.name] ~= nil and payload.toSlot.name == combinations[payload.fromSlot.name].needs then
    TriggerClientEvent('ox_inventory:closeInventory', src)
    lib.callback('ag_misc:client_combine', src, function(res)
      if not res then return end
      exports.ox_inventory:RemoveItem(src, payload.fromSlot.name, 1)
      exports.ox_inventory:RemoveItem(src, combinations[payload.fromSlot.name].needs, 1)
      exports.ox_inventory:AddItem(src, combinations[payload.fromSlot.name].result, 1)
      TriggerClientEvent(('ag_misc:client:%s'):format(payload.fromSlot.name), src, false)
    end)
    return false
  end
end, {
  barrel_methylamine = true,
  crowbar = true
})

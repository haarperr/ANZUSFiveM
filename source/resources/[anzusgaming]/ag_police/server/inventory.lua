exports.ox_inventory:registerHook('swapItems', function(payload)
  local src = payload.source
  local playerState = Player(src).state
  local pd_issued = payload.fromSlot.metadata.pd_issued or false
  if pd_issued and playerState.job.type == "leo" then
    TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'PD issued weaponry must be stored in the gunrack' })
    return false
  end
  return true
end, {
  inventoryFilter = {
    '^glove[%w]+',
    '^trunk[%w]+',
  }
})

exports.ox_inventory:registerHook('swapItems', function(payload)
  local src = payload.source
  local pd_issued = payload.fromSlot.metadata.pd_issued or false
  if not pd_issued then
    TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'Non PD issued weaponry must be stored in the trunk' })
    return false
  end
  return true
end, {
  inventoryFilter = {
    '^gunrack-[%w]+',
  }
})

exports.ox_inventory:registerHook('buyItem', function(payload)
  if not string.find(payload.itemName, "WEAPON_") then return true end
  local item = exports.ox_inventory:Items(payload.itemName)
  local src = payload.source
  local playerState = Player(src).state

  if item.ammoname == nil then return true end
  exports['ps-mdt']:CreateWeaponInfo(payload.metadata.serial, nil, '', playerState.citizenid, nil, payload.itemName)
  return true
end)

---@param data string
---@return boolean
lib.callback.register('ag_police:OpenEvidenceDraw', function(source, data)
  local playerState = Player(source).state
  if playerState.job.type ~= 'leo' then return false end

  local coords = GetEntityCoords(GetPlayerPed(source))
  exports.ox_inventory:RegisterStash(string.format('policeevidence_%s', data), string.format('Evidence Drawer | %s', data), 50, 100000, nil, { lspd = 0 }, coords)

  return true
end)

lib.callback.register('ag_police:OpenLocker', function(source)
  local playerState = Player(source).state
  if playerState.job.type ~= 'leo' then return false end

  exports.ox_inventory:RegisterStash(string.format('policelocker_%s', playerState.citizenid), 'Police Locker', 50, 100000, playerState.citizenid, nil, coords)

  return true
end)

---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_fleeca:server:setVaultDoor', function(data)
  if not OnCooldown() then SetCooldown(true, data.key) end
  Config.Banks[data.key].vault_door.opened = data.bool

  TriggerClientEvent('ag_fleeca:client:setVaultDoor', -1, data)
end)

---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_fleeca:server:setDrilling', function(data)
  if not OnCooldown() then SetCooldown(true, data.key) end
  Config.Banks[data.key].vault_door.drilling = data.bool

  TriggerClientEvent('ag_fleeca:client:setDrilling', -1, data)
end)

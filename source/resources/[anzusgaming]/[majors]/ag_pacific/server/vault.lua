---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_pacific:server:setVaultDoor', function(data)
  -- if not OnCooldown() then SetCooldown(true, data.key) end
  Config.Bank.vault[data.key].opened = data.bool

  TriggerClientEvent('ag_pacific:client:setVaultDoor', -1, data)
end)
---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_pacific:server:setVaultBusy', function(data)
  -- if not OnCooldown() then SetCooldown(true, data.key) end
  Config.Bank.vault[data.key].busy = data.bool

  TriggerClientEvent('ag_pacific:client:setVaultBusy', -1, data)
end)

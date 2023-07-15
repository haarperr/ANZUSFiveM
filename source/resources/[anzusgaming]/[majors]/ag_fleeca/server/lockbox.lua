---@param data {key: number, index: number, bool: boolean}
RegisterNetEvent('ag_fleeca:server:setLockboxBusy', function(data)
  if not OnCooldown() then SetCooldown(true, data.key) end
  Config.Banks[data.key].lockbox[data.index].busy = data.bool

  TriggerClientEvent('ag_fleeca:client:setLockboxBusy', -1, data)
end)

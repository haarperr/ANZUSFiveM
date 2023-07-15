---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_fleeca:server:setDoorBusy', function(data)
  if not OnCooldown() then SetCooldown(true, data.key) end
  Config.Banks[data.key].door.busy = data.bool

  TriggerClientEvent('ag_fleeca:client:setDoorBusy', -1, data)
end)

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_fleeca:server:openDoor', function(data)
  Config.Banks[data.key].door.opened = true
  TriggerEvent('ox_doorlock:setState', Config.Banks[data.key].door.doorlock, 0)
end)

function ResetDoorLocks()
  for k, v in ipairs(Config.Banks) do
    Config.Banks[k].door.busy = false
    Config.Banks[k].door.opened = false
    TriggerEvent('ox_doorlock:setState', v.door.doorlock, 1)
    TriggerClientEvent('ag_fleeca:client:setDoorBusy', -1, { key = k, bool = false })
  end
end

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_pacific:server:openDoor', function(data)
  Config.Bank.door[data.key].opened = true
  TriggerEvent('ox_doorlock:setState', Config.Bank.door[data.key].doorlock, 0)
end)

function ResetDoorLocks()
  for k, v in ipairs(Config.Bank.door) do
    Config.Bank.door[k].busy = false
    Config.Bank.door[k].opened = false
    TriggerEvent('ox_doorlock:setState', v.doorlock, 1)
    TriggerClientEvent('ag_pacific:client:setDoorBusy', -1, { key = k, bool = false })
  end
end

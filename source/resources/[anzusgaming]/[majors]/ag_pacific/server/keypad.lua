---@param data {key: string}
RegisterNetEvent('ag_pacific:server:openKeyDoor', function(data)
  Config.Bank.keypad[data.key].opened = true
  TriggerEvent('ox_doorlock:setState', Config.Bank.keypad[data.key].doorlock, 0)
end)

function ResetKeypadLocks()
  for k, v in ipairs(Config.Bank.keypad) do
    Config.Bank.keypad[k].busy = false
    Config.Bank.keypad[k].opened = false
    TriggerEvent('ox_doorlock:setState', v.doorlock, 1)
    TriggerClientEvent('ag_pacific:client:setKeypadBusy', -1, { key = k, bool = false })
  end
end

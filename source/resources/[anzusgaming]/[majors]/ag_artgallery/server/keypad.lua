---@param data {index: string}
RegisterNetEvent('ag_artgallery:server:openKeyDoor', function(data)
  Config.Artgallery.keypad[data.index].opened = true
  TriggerEvent('ox_doorlock:setState', Config.Artgallery.keypad[data.index].doorlock, 0)
end)

function ResetKeypadLocks()
  for k, v in ipairs(Config.Artgallery.keypad) do
    Config.Artgallery.keypad[k].busy = false
    Config.Artgallery.keypad[k].opened = false
    TriggerEvent('ox_doorlock:setState', v.doorlock, 1)
    TriggerEvent('ag_artgallery:server:setBusy', { key = 'keypad', index = k, bool = false })
  end
end

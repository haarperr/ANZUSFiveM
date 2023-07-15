---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_jewellery:server:setPanelBusy', function(data)
  Config.Jewellery.panel[data.key].busy = data.bool

  TriggerClientEvent('ag_jewellery:client:setPanelBusy', -1, data)
end)

function ResetPanels()
  for k, _ in ipairs(Config.Jewellery.panel) do
    Config.Jewellery.panel[k].busy = false
    TriggerClientEvent('ag_jewellery:client:setPanelBusy', -1, { key = k, bool = false })
  end
end

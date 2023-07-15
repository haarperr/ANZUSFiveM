local destroyedCannisters = 0
GasEnabled = true

RegisterNetEvent('ag_jewellery:server:setGas', function(bool)
  GasEnabled = bool
  TriggerClientEvent('ag_jewellery:client:setGas', -1, bool)
end)

RegisterNetEvent('ag_jewellery:server:destroyCannister', function()
  destroyedCannisters += 1

  if destroyedCannisters == #Config.Jewellery.vent then
    TriggerEvent('ag_jewellery:client:setCannistersBroken', true)
    TriggerEvent('ag_jewellery:server:setGas', false)
  end
end)

---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_jewellery:server:setCannisterBusy', function(data)
  Config.Jewellery.vent[data.key].busy = data.bool

  TriggerClientEvent('ag_jewellery:client:setCannisterBusy', -1, data)
end)

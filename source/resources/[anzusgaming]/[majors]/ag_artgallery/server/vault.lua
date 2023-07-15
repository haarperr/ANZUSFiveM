---@param data {code: string, index: number, bool: boolean}
RegisterNetEvent('ag_artgallery:server:setVaultDoor', function(data)
  Config.Artgallery.code[data.index].door.opened = data.bool

  TriggerClientEvent('ag_artgallery:client:setVaultDoor', -1, data)
end)

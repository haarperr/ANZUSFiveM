local objects = {}

---@param key number
function CreateTrolly(key)
  local config = Config.Banks[key].trolly
  Config.Banks[key].trolly.busy = false

  local obj = CreateServerObject(config.model, config.coords, config.w)
  objects[key] = obj
end

---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_fleeca:server:setTrollyBusy', function(data)
  if not OnCooldown() then SetCooldown(true, data.key) end
  Config.Banks[data.key].trolly.busy = data.bool

  TriggerClientEvent('ag_fleeca:client:setTrollyBusy', -1, data)
end)

---@param data {key: number}
RegisterNetEvent('ag_fleeca:server:deleteTrolly', function(data)
  local entity = NetworkGetEntityFromNetworkId(objects[data.key])
  DeleteEntity(entity)
  objects[data.key] = false
end)

function DestroyTrollys()
  for k, v in ipairs(objects) do
    local entity = NetworkGetEntityFromNetworkId(v)
    DeleteEntity(entity)
    objects[k] = false
  end
end

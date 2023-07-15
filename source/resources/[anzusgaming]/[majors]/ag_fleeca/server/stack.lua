local objects = {}

---@param key number
function CreateCashStack(key)
  local config = Config.Banks[key].cash
  Config.Banks[key].cash.busy = false

  local obj = CreateServerObject(config.model, config.coords, config.w)
  objects[key] = obj
end

---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_fleeca:server:setCashStackBusy', function(data)
  if not OnCooldown() then SetCooldown(true, data.key) end
  Config.Banks[data.key].cash.busy = data.bool

  TriggerClientEvent('ag_fleeca:client:setCashStackBusy', -1, data)
end)

---@param data {key: number}
RegisterNetEvent('ag_fleeca:server:deleteCashStack', function(data)
  local entity = NetworkGetEntityFromNetworkId(objects[data.key])
  DeleteEntity(entity)
  objects[data.key] = false
end)

function DestroyCashStacks()
  for k, v in ipairs(objects) do
    local entity = NetworkGetEntityFromNetworkId(v)
    DeleteEntity(entity)
    objects[k] = false
  end
end

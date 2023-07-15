local objects = {}

---@param key number
function CreateStack(key)
  local config = Config.Bank.stack[key]
  Config.Bank.stack[key].busy = false

  local obj = CreateServerObject(config.hash, config.coords, config.w)
  objects[key] = obj
end

function DeleteStack(key)
  local entity = NetworkGetEntityFromNetworkId(objects[key])
  DeleteEntity(entity)
  objects[key] = false
end

function DestroyStacks()
  for k, v in ipairs(objects) do
    local entity = NetworkGetEntityFromNetworkId(v)
    DeleteEntity(entity)
    objects[k] = false
  end
end

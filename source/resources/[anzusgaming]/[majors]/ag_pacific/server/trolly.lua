local objects = {}

---@param key number
function CreateTrolly(key)
  local config = Config.Bank.trolly[key]
  Config.Bank.trolly[key].busy = false

  if config.create then
    local obj = CreateServerObject(config.hash, config.coords, config.w)
    objects[key] = obj
  end
end

function DestroyTrollys()
  for k, v in ipairs(objects) do
    local entity = NetworkGetEntityFromNetworkId(v)
    DeleteEntity(entity)
    objects[k] = false
  end
end

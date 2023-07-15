local managerLocations = {}

---@param key string
---@param model number
---@param coords vector4
function CreateManager(key, model, coords)
  local ped = CreatePed(0, model, coords.x, coords.y, coords.z, coords.w, true, false)
  local netid = NetworkGetNetworkIdFromEntity(ped)
  managerLocations[key] = { netid = netid }
  Config.Banks[key].manager.stolen = false
end

lib.callback.register('ag_fleeca:getManagerNet', function(source, key)
  return managerLocations[key]
end)

RegisterNetEvent('ag_fleeca:server:stealSecurityCard', function(key)
  local src = source
  if Config.Banks[key].manager.stolen then return end

  if not OnCooldown() then SetCooldown(true, key) end

  exports.ox_inventory:AddItem(src, 'fleeca_keycard', 1)
  Config.Banks[key].manager.stolen = true
  TriggerClientEvent('ag_fleeca:client:stealSecurityCard', -1, { key = key, bool = true })
end)

---@param data {key: number}
RegisterNetEvent('ag_fleeca:server:setManagerDead', function(data)
  if Config.Banks[data.key].manager.dead then return end
  Config.Banks[data.key].manager.dead = true

  SetTimeout(5 * 60 * 1000, function()
    DeleteEntity(NetworkGetEntityFromNetworkId(managerLocations[data.key].netid))
    managerLocations[data.key] = nil
  end)
end)

function DestroyManagers()
  for k, v in ipairs(managerLocations) do
    local entity = NetworkGetEntityFromNetworkId(v.netid)
    if DoesEntityExist(entity) then
      DeleteEntity(entity)
    end
    managerLocations[k] = false
  end
end

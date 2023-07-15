local hint = nil
local key = nil
local manager = nil
local guards = {}

function SetupManager()
  local random = math.random(#Config.Manager)
  local config = Config.Manager[random]
  key = random
  hint = config.hint

  local ped = CreatePed(0, config.manager.model, config.manager.coords.x, config.manager.coords.y, config.manager.coords.z, config.manager.coords.w, true, false)
  manager = NetworkGetNetworkIdFromEntity(ped)
  Config.KeycardStolen = false

  for _, v in ipairs(config.guards) do
    local guard = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, true, false)
    GiveWeaponToPed(guard, v.weapon, 420, false, true)
    guards[#guards + 1] = NetworkGetNetworkIdFromEntity(guard)
  end
  print(config.manager.coords)
end

lib.callback.register('ag_pacific:server:getHint', function()
  return hint
end)

lib.callback.register('ag_pacific:server:getPeds', function()
  return { manager = manager, guards = guards }
end)

RegisterNetEvent('ag_pacific:server:stealSecurityCard', function()
  if Config.KeycardStolen then return end
  Config.KeycardStolen = true

  TriggerClientEvent('ag_pacific:client:setKeycardStolen', -1, true)

  exports.ox_inventory:AddItem(source, 'pacific_keycard', 1)
end)

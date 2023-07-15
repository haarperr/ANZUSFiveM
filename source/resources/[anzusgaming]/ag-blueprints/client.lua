local QBCore = exports['qb-core']:GetCoreObject();

RegisterNetEvent('ag-blueprints:client:Hack', function(item)
  if not item then return end

  if item.metadata.encryption == 'VAR' then
    exports['ps-ui']:VarHack(function(success)
      if success then
        TriggerServerEvent('ag-blueprints:server:Hack', item)
      end
    end, 5, 8)
  end
end)

function HasBlueprint(blueprint)
  local bps = QBCore.Functions.GetPlayerData().metadata.blueprints or {}
  local has = false
  for i = 1, #bps, 1 do
    local bp = bps[i]
    if bp == blueprint then
      has = true
      break
    end
  end
  return has
end

exports('HasBlueprint', HasBlueprint)

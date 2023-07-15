local QBCore = exports['qb-core']:GetCoreObject()

local function updateBlips()
  local dutyPlayers = {}
  local players = QBCore.Functions.GetQBPlayers()
  for _, v in pairs(players) do
    if v and (v.PlayerData.job.type == "leo" or v.PlayerData.job.name == "ambulance") and v.PlayerData.job.onduty then
      local ped = GetPlayerPed(v.PlayerData.source)
      local coords = GetEntityCoords(ped)
      local heading = GetEntityHeading(ped)
      local blipLabel = v.PlayerData.metadata.callsign ~= 'NO CALLSIGN' and ('[%s] %s'):format(v.PlayerData.metadata.callsign, v.PlayerData.charinfo.lastname) or
          v.PlayerData.charinfo.lastname

      dutyPlayers[#dutyPlayers + 1] = {
        source = v.PlayerData.source,
        label = blipLabel,
        job = v.PlayerData.job.name,
        location = {
          x = coords.x,
          y = coords.y,
          z = coords.z,
          w = heading
        }
      }
    end
  end
  TriggerClientEvent("ag_blips:client:UpdateBlips", -1, dutyPlayers)
end

CreateThread(function()
  while true do
    Wait(5000)
    updateBlips()
  end
end)

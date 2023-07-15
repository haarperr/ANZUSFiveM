CreateCallback("snipe-menu:server:fetchPlayerListCustom", function(source, cb)
  local players = {}
  for _, player in ipairs(GetPlayers()) do
    table.insert(players, {
      id = player,
      name = GetPlayerName(player)
    })
  end
  cb(players)
end)

RegisterNetEvent('snipe-menu:server:PutPlayerInVehicle', function(playerId)
  local src = source
  if playerId == 0 then
    playerId = source
  end

  if onlineAdmins[src] then
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    TriggerClientEvent("snipe-menu:client:PutInVehicle", EscortPlayer.PlayerData.source)
  else
    print("triggering event")
  end
end)

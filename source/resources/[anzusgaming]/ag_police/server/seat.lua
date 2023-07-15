---@param data {target: number, veh: number, freeSeat: number}
RegisterNetEvent('ag_police:server:seatIntoVehicle', function(data)
  local ped = GetPlayerPed(data.target)
  local veh = NetworkGetEntityFromNetworkId(data.veh)

  local player = Player(data.target).state

  if player.isEscorted then
    player:set('isEscorted', false, true)
    ClearPedTasks(ped)
  end

  TaskWarpPedIntoVehicle(ped, veh, data.freeSeat)
end)

---@param data {target: number, veh: number}
RegisterNetEvent('ag_police:server:seatOutVehicle', function(data)
  local ped = GetPlayerPed(data.target)
  local veh = NetworkGetEntityFromNetworkId(data.veh)

  TaskLeaveVehicle(ped, veh, 16)
end)

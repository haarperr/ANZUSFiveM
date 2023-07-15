---@param data {netId: number}
lib.callback.register('ag_police:IsCivVehicle', function(source, data)
  local playerState = Player(source).state
  if playerState.job.type ~= 'leo' then return false end

  local vehicle = AG.GetVehicleFromNetId(data.netId)
  if not vehicle then return false end
  if not vehicle.owner then return false end

  return true
end)

---@param data {netId: number}
lib.callback.register('ag_police:ImpoundScuff', function(source, data)
  local playerState = Player(source).state
  if playerState.job.type ~= 'leo' then return false end

  local vehicle = AG.GetVehicleFromNetId(data.netId)
  if not vehicle then
    DeleteEntity(NetworkGetEntityFromNetworkId(data.netId))
    return true
  end

  vehicle:despawn()

  return true
end)

---@param data {netId: number}
lib.callback.register('ag_police:ImpoundVehicle', function(source, data)
  local playerState = Player(source).state
  if playerState.job.type ~= 'leo' then return false end

  local veh = NetworkGetEntityFromNetworkId(data.netId)
  local vehicle = AG.GetVehicle(veh)
  if not vehicle then
    print('vehicle not detected')
    return false
  end

  vehicle.set('impound', os.time(os.date("!*t")))
  vehicle.setGarage('impound', true)

  return true
end)

RegisterCommand('duty', function(source, args, raw)
  local player = QBCore.Functions.GetPlayer(source)
  local state = Player(source).state

  player.Functions.SetJobDuty(not player.PlayerData.job.onduty)

  local newState = state.job
  newState.onduty = not player.PlayerData.job.onduty

  state:set('job', newState, true)
end)

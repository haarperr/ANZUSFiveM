local function seatIntoVehicle(data)
  if LocalPlayer.state.invBusy then return end
  if exports.ag_misc:isCarrying() then
    exports.ag_misc:stopCarrying()
    Wait(250)
  end

  local veh = data.entity

  local id, ped = lib.getClosestPlayer(GetEntityCoords(cache.ped))
  if not id then return lib.notify({ description = 'No one nearby', type = 'error' }) end

  local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
  local target = Player(playerId).state
  if not target.isZiptied and not target.isCuffed and not target.isDown and not target.isDead then
    return lib.notify({
      description = 'Closest player is not cuffed, ziptied or down',
      type = 'error'
    })
  end

  local success = lib.progressCircle({
    duration = 2000,
    label = "Seating into vehicle",
    position = 'bottom',
    canCancel = true,
    disable = {
      car = true,
      move = true,
      combat = true
    },
  })

  if not success then return end

  local distance = #(GetEntityCoords(cache.ped) - GetEntityCoords(ped))
  if distance > 3 then return lib.notify({ description = 'Target is too far away', type = 'error' }) end

  distance = #(GetEntityCoords(cache.ped) - GetEntityCoords(veh)) or #(GetEntityCoords(ped) - GetEntityCoords(veh))
  if distance > 5 then return lib.notify({ description = 'Vehicle is too far away', type = 'error' }) end

  local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(veh)

  for i = maxSeats - 1, 0, -1 do
    if IsVehicleSeatFree(veh, i) then
      freeSeat = i
      break
    end
  end

  TriggerServerEvent('ag_police:server:seatIntoVehicle', { target = playerId, veh = NetworkGetNetworkIdFromEntity(veh), freeSeat = freeSeat })
end

exports('seatIntoVehicle', seatIntoVehicle)

local function seatOutVehicle(data)
  if LocalPlayer.state.invBusy then return end

  local veh = data.entity

  local distance = #(GetEntityCoords(cache.ped) - GetEntityCoords(veh)) or #(GetEntityCoords(ped) - GetEntityCoords(veh))
  if distance > 5 then return lib.notify({ description = 'Vehicle is too far away', type = 'error' }) end

  local maxSeats = GetVehicleMaxNumberOfPassengers(veh)

  local peds = {}

  for i = maxSeats - 1, 0, -1 do
    if not IsVehicleSeatFree(veh, i) then
      local inSeat = GetPedInVehicleSeat(veh, i)
      local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(inSeat))
      local target = Player(playerId).state
      if target.isZiptied or target.isCuffed or target.isDown or target.isDead then
        peds[#peds + 1] = playerId
      end
    end
  end

  if #peds == 0 then return lib.notify({ type = 'error', description = 'No one in the vehicle can be pulled out' }) end

  local success = lib.progressCircle({
    duration = 2000,
    label = "Pulling player(s) out",
    position = 'bottom',
    canCancel = true,
    disable = {
      car = true,
      move = true,
      combat = true
    },
  })
  if not success then return end

  for i = 1, #peds, 1 do
    TriggerServerEvent('ag_police:server:seatOutVehicle', { target = peds[i], veh = NetworkGetNetworkIdFromEntity(data.entity) })
  end
end

exports('seatOutVehicle', seatOutVehicle)

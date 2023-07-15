AddEventHandler('jim-mechanic:client:ScratchVin', function()
  local job = QBCore.Functions.GetPlayerData().job
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  if job.name == 'mechanic' then
    QBCore.Functions.Progressbar("scratch_vin", 'Scratching VIN', math.random(7000, 10000), false,
      true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { animDict = "mini@repair", anim = "fixing_a_ped", flags = 16, }, {}, {}, function()
        SetVehicleDoorShut(vehicle, 4, false)
        TriggerServerEvent('jim-mechanic:server:ScratchVin', { plate = GetVehicleNumberPlateText(vehicle) })
        emptyHands(playerPed)
        triggerNotify(nil, 'Scratched VIN', "success")
      end, function()
        triggerNotify(nil, 'Failed to remove VIN', "error")
        emptyHands(playerPed)
      end)
  end
end)

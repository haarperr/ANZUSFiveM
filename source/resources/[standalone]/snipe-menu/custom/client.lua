RegisterNUICallback("custom-clicked", function(_, cb)
  print("Custom button clicked")
end)

RegisterNUICallback("customfetchurl", function(_, cb)
  local p = promise.new()
  TriggerCallback("snipe-menu:server:fetchPlayerListCustom", function(data)
    p:resolve(data)
  end)
  local data = Citizen.Await(p)
  print(json.encode(data)) -- check how this data looks in your f8 console
  cb(data)
end)

RegisterNUICallback("customfetchurl2", function(_, cb)
  local returnData = { "value1", "value2" }
  cb(returnData)
end)

RegisterNUICallback("customPanelSubmit", function(data, cb)
  print("Custom panel submitted", json.encode(data))
  cb("ok")
end)

RegisterNUICallback("putinvehicle", function(_, cb)
  if hasAdminPerms then
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
      local playerId = GetPlayerServerId(player)
      TriggerServerEvent("snipe-menu:server:PutPlayerInVehicle", playerId)
      cb('ok')
    else
      -- uncomment the line below if you want yourself to put into car if no one is near by
      -- TriggerServerEvent("snipe-menu:server:PutPlayerInVehicle", 0)
      QBCore.Functions.Notify("No one nearby", "error")
      cb('ok')
    end
  end
end)

RegisterNetEvent('snipe-menu:client:PutInVehicle', function()
  local ped = PlayerPedId()
  local vehicle = QBCore.Functions.GetClosestVehicle()
  if DoesEntityExist(vehicle) then
    for i = GetVehicleMaxNumberOfPassengers(vehicle), 0, -1 do
      if IsVehicleSeatFree(vehicle, i) then
        Player(ped).state:set('isEscorted', false, true)
        ClearPedTasks(ped)
        DetachEntity(ped, true, false)

        Wait(100)
        SetPedIntoVehicle(ped, vehicle, i)
        return
      end
    end
  end
end)

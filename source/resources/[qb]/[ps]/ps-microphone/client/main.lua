local oldProximity = 0.0

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  for k, v in pairs(Config.MicrophoneZones) do
    lib.zones.box({
      coords = v.coords,
      size = v.size,
      rotation = v.rotation,
      onEnter = function()
        oldProximity = LocalPlayer.state.proximity.distance
        exports["pma-voice"]:overrideProximityRange(v.range, true)

        if v.spawnProp then
          Config.MicrophoneZones[k].obj = CreateObject(`v_ilev_fos_mic`, vector3(v.coords.x, v.coords.y, v.coords.z - 1.0), false)
          if v.data.heading ~= nil then
            SetEntityHeading(Config.MicrophoneZones[k].obj, v.heading)
          end
          FreezeEntityPosition(Config.MicrophoneZones[k].obj, true)
          Config.MicrophoneZones[k].obj = obj
        end
      end,
      onExit = function()
        exports["pma-voice"]:clearProximityOverride()
        if Config.MicrophoneZones[k].obj then
          DeleteEntity(Config.MicrophoneZones[k].obj)
          Config.MicrophoneZones[k].obj = nil
        end
      end
    })
  end
end)

AddEventHandler('onResourceStop', function(resource)
  if (GetCurrentResourceName() ~= resource) then return end
  for k, v in pairs(Config.MicrophoneZones) do
    if v.obj then
      DeleteEntity(v.obj)
      v.obj = nil
    end
  end
end)

lib.locale()
PoliceAlerted = false

RegisterNetEvent('ag_fleeca:client:disableCameras', function(bank, bool)
  Config.Banks[bank].cameracontrol.disabled = bool
end)

RegisterNetEvent('ag_fleeca:client:alertPolice', function(bool)
  PoliceAlerted = bool
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  Config.Banks = lib.callback.await('ag_fleeca:server:getBanksConfig', false)
  lib.requestModel(`ch_prop_ch_fuse_box_01a`)

  for k, v in ipairs(Config.Banks) do
    CreateZoneAroundBank(k, v.centre)
    CreateVaultOptions(k)
    SetupCameraControlZone(k, v.cameracontrol.coords)
    CreateDoorZone(k)
    CreateStackTarget(k)
    CreateTrollyTarget(k)

    for _, v2 in pairs(v.cameras) do
      SetupCameraZone(k, v2.coords, v2.size, v2.rotation)
    end

    for k2, _ in pairs(v.lockbox) do
      CreateLockboxTarget(k, k2)
    end
  end
end)

CreateThread(function()
  Config.Banks = lib.callback.await('ag_fleeca:server:getBanksConfig', false)
  Wait(5000)
  lib.requestModel(`ch_prop_ch_fuse_box_01a`)

  for k, v in ipairs(Config.Banks) do
    CreateZoneAroundBank(k, v.centre)
    CreateVaultOptions(k)
    SetupCameraControlZone(k, v.cameracontrol.coords)
    CreateDoorZone(k)
    CreateStackTarget(k)
    CreateTrollyTarget(k)

    for _, v2 in pairs(v.cameras) do
      SetupCameraZone(k, v2.coords, v2.size, v2.rotation)
    end

    for k2, _ in pairs(v.lockbox) do
      CreateLockboxTarget(k, k2)
    end
  end
end)

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  DestroyCameraZones()
end)

RegisterNetEvent('ag_fleeca:client:syncPtfx', function(coords)
  lib.requestNamedPtfxAsset('scr_ornate_heist')
  UseParticleFxAsset('scr_ornate_heist')
  local ptfx = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

  Wait(13000)
  StopParticleFxLooped(ptfx, false)
end)

function IsEnoughPoliceAvailable()
  if exports.ag_misc:getDuty('leo') < Config.PoliceRequired then
    lib.notify({ type = 'error', description = locale('not_enough_police') })
    return false
  end

  return true
end

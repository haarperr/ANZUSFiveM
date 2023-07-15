lib.locale()
PoliceAlerted = false
SyncData = {}

RegisterNetEvent('ag_paleto:client:setBusy', function(data)
  Config.Paleto[data.key][data.index].busy = data.bool
end)

RegisterNetEvent('ag_paleto:client:setOpened', function(data)
  Config.Paleto[data.key][data.index].opened = data.bool
end)

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_paleto:client:setHacked', function(data)
  SyncData[data.key].hacked = data.bool
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  Config.Paleto = lib.callback.await('ag_paleto:server:getConfig', false)
  SyncData = lib.callback.await('ag_paleto:server:getSyncData', false)
  lib.requestModel(`hei_prop_mini_sever_01`)
  CreateZoneAroundBank(1, Config.Paleto.centre)
  SetupControlPanel()

  for index, _ in ipairs(Config.Paleto.camera) do
    SetupCameraZone(index)
  end

  for index, _ in ipairs(Config.Paleto.door) do
    SetupDoorZone(index)
  end

  for index, _ in ipairs(Config.Paleto.atm) do
    SetupATMZone(index)
  end

  for index, _ in ipairs(Config.Paleto.cabinet) do
    SetupCabinetZone(index)
  end

  for index, _ in ipairs(Config.Paleto.safe) do
    SetupSafeZone(index)
  end

  for index, _ in ipairs(Config.Paleto.vault) do
    SetupVaultZone(index)
  end

  for index, _ in ipairs(Config.Paleto.trolly) do
    SetupTrollyZone(index)
  end

  for index, _ in ipairs(Config.Paleto.lockbox) do
    SetupLockboxZone(index)
  end

  for index, _ in ipairs(Config.Paleto.offices) do
    if index ~= 3 then
      SetupOfficeZone(index)
    end
  end
end)

CreateThread(function()
  Wait(5000)
  Config.Paleto = lib.callback.await('ag_paleto:server:getConfig', false)
  SyncData = lib.callback.await('ag_paleto:server:getSyncData', false)
  lib.requestModel(`hei_prop_mini_sever_01`)
  CreateZoneAroundBank(1, Config.Paleto.centre)
  SetupControlPanel()

  for index, _ in ipairs(Config.Paleto.camera) do
    SetupCameraZone(index)
  end

  for index, _ in ipairs(Config.Paleto.door) do
    SetupDoorZone(index)
  end

  for index, _ in ipairs(Config.Paleto.atm) do
    SetupATMZone(index)
  end

  for index, _ in ipairs(Config.Paleto.cabinet) do
    SetupCabinetZone(index)
  end

  for index, _ in ipairs(Config.Paleto.safe) do
    SetupSafeZone(index)
  end

  for index, _ in ipairs(Config.Paleto.vault) do
    SetupVaultZone(index)
  end

  for index, _ in ipairs(Config.Paleto.trolly) do
    SetupTrollyZone(index)
  end

  for index, _ in ipairs(Config.Paleto.lockbox) do
    SetupLockboxZone(index)
  end

  for index, _ in ipairs(Config.Paleto.offices) do
    if index ~= 3 then
      SetupOfficeZone(index)
    end
  end
end)

function IsEnoughPoliceAvailable()
  if exports.ag_misc:getDuty('leo') < Config.PoliceRequired then
    lib.notify({ type = 'error', description = locale('not_enough_police') })
    return false
  end

  return true
end

RegisterNetEvent('ag_paleto:client:notifyPolice', function(bool)
  PoliceAlerted = bool
end)

function AlertPolice()
  if not PoliceAlerted then
    exports['ps-dispatch']:PaletoBankRobbery()
    TriggerServerEvent('ag_paleto:server:notifyPolice')
  end
end

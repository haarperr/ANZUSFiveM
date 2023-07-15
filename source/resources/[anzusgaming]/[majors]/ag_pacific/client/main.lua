lib.locale()

PoliceAlerted = false
PowerstationBlownUp = true

CreateThread(function()
  Wait(5000)
  Config.Bank = lib.callback.await('ag_pacific:server:getConfig', false)

  CreateZoneAroundBank(Config.Bank.centre)

  for index, _ in ipairs(Config.Bank.door) do
    SetupDoorZone(index)
  end

  for index, _ in ipairs(Config.Bank.computer) do
    SetupComputerZone(index)
  end

  for index, _ in ipairs(Config.Bank.keypad) do
    SetupKeypadZone(index)
  end

  for index, _ in ipairs(Config.Bank.vault) do
    SetupVaultZone(index)
  end

  for index, _ in ipairs(Config.Bank.gate) do
    SetupGateZone(index)
  end

  for index, _ in ipairs(Config.Bank.stack) do
    SetupStackZone(index)
  end

  for index, _ in ipairs(Config.Bank.trolly) do
    SetupTrollyZone(index)
  end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  Config.Bank = lib.callback.await('ag_pacific:server:getConfig', false)

  Wait(2500)
  CreateZoneAroundBank(Config.Bank.centre)

  for index, _ in ipairs(Config.Bank.door) do
    SetupDoorZone(index)
  end

  for index, _ in ipairs(Config.Bank.computer) do
    SetupComputerZone(index)
  end

  for index, _ in ipairs(Config.Bank.keypad) do
    SetupKeypadZone(index)
  end

  for index, _ in ipairs(Config.Bank.vault) do
    SetupVaultZone(index)
  end

  for index, _ in ipairs(Config.Bank.gate) do
    SetupGateZone(index)
  end

  for index, _ in ipairs(Config.Bank.stack) do
    SetupStackZone(index)
  end

  for index, _ in ipairs(Config.Bank.trolly) do
    SetupTrollyZone(index)
  end
end)

RegisterNetEvent('ag_pacific:client:syncPtfx', function(coords)
  lib.requestNamedPtfxAsset('scr_ornate_heist')
  UseParticleFxAsset('scr_ornate_heist')
  local ptfx = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

  Wait(13000)
  StopParticleFxLooped(ptfx, false)
end)

RegisterNetEvent('ag_pacific:client:setKeycardStolen', function(bool)
  Config.KeycardStolen = bool
end)

---@param data {type: string, key: string, bool: boolean}
RegisterNetEvent('ag_pacific:client:setBusy', function(data)
  Config.Bank[data.type][data.key].busy = data.bool
end)

RegisterNetEvent('ag_pacific:client:notifyPolice', function(bool)
  PoliceAlerted = bool
end)

function AlertPolice()
  if not PoliceAlerted then
    exports['ps-dispatch']:PacificBankRobbery()
    TriggerServerEvent('ag_pacific:server:notifyPolice')
  end
end

function IsEnoughPoliceAvailable()
  if exports.ag_misc:getDuty('leo') < Config.PoliceRequired then
    lib.notify({ type = 'error', description = locale('not_enough_police') })
    return false
  end

  return true
end

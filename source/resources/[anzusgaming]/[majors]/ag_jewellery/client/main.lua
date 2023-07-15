lib.locale()
PoliceAlerted = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  Config.Jewellery = lib.callback.await('ag_jewellery:server:getJewelleryConfig', false)

  for key, _ in pairs(Config.Jewellery.panel) do
    SetupPanel(key)
  end

  for key, _ in pairs(Config.Jewellery.vent) do
    SetupCannister(key)
  end

  for key, _ in pairs(Config.Jewellery.case) do
    SetupCaseZone(key)
  end

  SetupGasWithinRange()
  SetupInsideZone()
end)

function IsEnoughPoliceAvailable()
  if exports.ag_misc:getDuty('leo') < Config.PoliceRequired then
    lib.notify({ type = 'error', description = locale('not_enough_police') })
    return false
  end

  return true
end

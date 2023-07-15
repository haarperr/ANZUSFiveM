lib.locale()
PoliceAlerted = false

RegisterNetEvent('ag_artgallery:client:setBusy', function(data)
  Config.Artgallery[data.key][data.index].busy = data.bool
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  Config.Artgallery = lib.callback.await('ag_artgallery:server:getConfig', false)

  for index, _ in ipairs(Config.Artgallery.computer) do
    SetupComputerZone(index)
  end

  for index, _ in ipairs(Config.Artgallery.painting) do
    SetupPaintingZone(index)
  end

  for index, _ in ipairs(Config.Artgallery.case) do
    SetupCaseZone(index)
  end

  for index, _ in ipairs(Config.Artgallery.keypad) do
    SetupKeypadZone(index)
  end

  for index, _ in ipairs(Config.Artgallery.server) do
    SetupServerZone(index)
  end

  for index, _ in ipairs(Config.Artgallery.code) do
    SetupCodeZone(index)
  end

  for index, _ in ipairs(Config.Artgallery.egg) do
    SetupEggZone(index)
  end

  for index, _ in ipairs(Config.Artgallery.door) do
    SetupDoorZone(index)
  end
end)

function IsEnoughPoliceAvailable()
  if exports.ag_misc:getDuty('leo') < Config.PoliceRequired then
    lib.notify({ type = 'error', description = locale('not_enough_police') })
    return false
  end

  return true
end

RegisterNetEvent('ag_artgallery:client:notifyPolice', function(bool)
  PoliceAlerted = bool
end)

function AlertPolice()
  if not PoliceAlerted then
    exports['ps-dispatch']:ArtGalleryRobbery()
    TriggerServerEvent('ag_artgallery:server:notifyPolice')
  end
end

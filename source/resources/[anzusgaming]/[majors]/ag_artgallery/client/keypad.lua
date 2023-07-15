local function useKeycard(index)
  LocalPlayer.state:set("invBusy", true, true)
  local config = Config.Artgallery.keypad[index]
  TriggerEvent('ox_inventory:disarm')

  local ped = cache.ped
  local pedCoords = GetEntityCoords(ped)
  local obj = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 3.0, config.model, false, false, false)

  local scene = { pos = GetEntityCoords(obj), rot = GetEntityRotation(obj) }

  local animDict = 'anim_heist@hs3f@ig3_cardswipe@male@'

  lib.requestAnimDict(animDict)
  lib.requestModel(config.swipe)

  local cardObj = CreateObject(config.swipe, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)
  local cardSwipe = NetworkCreateSynchronisedScene(scene.pos.x, scene.pos.y, scene.pos.z, scene.rot.x, scene.rot.y, scene.rot.z, 2, false, false, 1065353216, 0, 1.3)
  NetworkAddPedToSynchronisedScene(ped, cardSwipe, animDict, 'success_var01', 1.5, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(cardObj, cardSwipe, animDict, 'success_var01_card', 4.0, -8.0, 1)

  NetworkStartSynchronisedScene(cardSwipe)
  Wait(3000)

  TriggerServerEvent('ag_artgallery:server:removeItem', 'artgallery_keycard')

  lib.notify({ type = 'success', description = locale('valid_keycard'), duration = 2500 })
  TriggerServerEvent('ag_artgallery:server:openKeyDoor', { index = index })

  DeleteObject(cardObj)
  LocalPlayer.state:set("invBusy", false, true)
end

function SetupKeypadZone(index)
  local config = Config.Artgallery.keypad[index]

  exports.ox_target:addBoxZone({
    coords = config.zone.coords,
    size = config.zone.size,
    rotation = config.zone.rotation,
    options = {
      {
        label = locale('use_keycard'),
        icon = 'fa-brands fa-keycdn',
        item = 'artgallery_keycard',
        canInteract = function()
          return not Config.Artgallery.keypad[index].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          AlertPolice()
          TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'keypad', index = index, bool = true })
          useKeycard(index)
        end,
      }
    }
  })
end

local function useKeycard(key)
  LocalPlayer.state:set("invBusy", true, true)
  local config = Config.Bank.keypad[key]
  TriggerEvent('ox_inventory:disarm')

  local ped = cache.ped
  local pedCoords = GetEntityCoords(ped)
  local obj = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 3.0, config.model, false, false, false)

  local scene = { pos = GetEntityCoords(obj), rot = GetEntityRotation(obj) }

  local animDict = 'anim_heist@hs3f@ig3_cardswipe@male@'

  lib.requestAnimDict(animDict)
  lib.requestModel(`ch_prop_swipe_card_01c`)

  local cardObj = CreateObject(`ch_prop_swipe_card_01c`, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)
  local cardSwipe = NetworkCreateSynchronisedScene(scene.pos.x, scene.pos.y, scene.pos.z, scene.rot.x, scene.rot.y, scene.rot.z, 2, false, false, 1065353216, 0, 1.3)
  NetworkAddPedToSynchronisedScene(ped, cardSwipe, animDict, 'success_var01', 1.5, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(cardObj, cardSwipe, animDict, 'success_var01_card', 4.0, -8.0, 1)

  NetworkStartSynchronisedScene(cardSwipe)
  Wait(3000)

  TriggerServerEvent('ag_pacific:server:removeItem', 'pacific_keycard')
  lib.notify({ type = 'success', description = locale('valid_keycard'), duration = 2500 })
  TriggerServerEvent('ag_pacific:server:openKeyDoor', { key = key })

  DeleteObject(cardObj)
  LocalPlayer.state:set("invBusy", false, true)
end

function SetupKeypadZone(key)
  local config = Config.Bank.keypad[key]

  exports.ox_target:addBoxZone({
    coords = config.zone.coords,
    size = config.zone.size,
    rotation = config.zone.rotation,
    options = {
      {
        label = locale('use_keycard'),
        icon = 'fa-brands fa-keycdn',
        item = 'pacific_keycard',
        canInteract = function()
          return not Config.Bank.keypad[key].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_pacific:server:setBusy', { type = 'keypad', key = key, bool = true })
          useKeycard(key)
        end,
      }
    }
  })
end

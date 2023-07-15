local function stealPainting(index)
  local config = Config.Artgallery.painting[index]
  LocalPlayer.state:set("invBusy", true, true)

  TriggerServerEvent('ag_artgallery:server:useItem', { item = 'scissors', durability = 25 })

  local animDict = "anim_heist@hs3f@ig11_steal_painting@male@"
  lib.requestAnimDict(animDict)

  local painting = GetClosestObjectOfType(config.coords.x, config.coords.y, config.coords.z, 2.0, config.hash, false, false, false)
  FreezeEntityPosition(cache.ped, true)
  SetEntityHeading(cache.ped, config.heading)
  TaskPlayAnim(cache.ped, animDict, "with_painting_exit", 8.0, 8.0, -1, 0, 0, false, false, false)
  Wait(1000)
  while IsEntityPlayingAnim(cache.ped, animDict, "with_painting_exit", 3) do Wait(50) end
  FreezeEntityPosition(cache.ped, false)

  TriggerServerEvent('ag_artgallery:server:getReward', { key = 'painting', index = index })

  LocalPlayer.state:set("invBusy", false, true)
end

function SetupPaintingZone(index)
  local config = Config.Artgallery.painting[index]

  exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        label = locale('grab_painting'),
        icon = config.icon,
        items = 'scissors',
        canInteract = function()
          return not Config.Artgallery.painting[index].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          AlertPolice()
          TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'painting', index = index, bool = true })
          stealPainting(index)
        end,
        distance = 2
      }
    },
  })
end

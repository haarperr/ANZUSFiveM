local function hackComputer()
  -- if not utils.hasItem('raspberry_pi') then return end
  TriggerServerEvent('ag_artgallery:server:useItem', { item = 'raspberry_pi', durability = 34 })

  -- utils.sendAlert('artgallery')
  LocalPlayer.state:set("invBusy", true, true)

  local ped = cache.ped
  TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)
  Wait(2000)

  exports['ps-ui']:Scrambler(function(success)
    if success then
      TriggerServerEvent('ag_artgallery:server:ActivateLasers')
      TriggerServerEvent('ag_artgallery:server:openDoor', { key = 'computer', index = 1 })
    else
      TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'computer', index = 1, bool = false })
    end
    ClearPedTasks(cache.ped)
    LocalPlayer.state:set("invBusy", false, true)
  end, "runes", 15, 0)
end

function SetupComputerZone(key)
  local config = Config.Artgallery.computer[key]
  exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        label = locale('hack_computer'),
        items = 'raspberry_pi',
        canInteract = function()
          return not Config.Artgallery.computer[key].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          AlertPolice()
          TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'computer', index = 1, bool = true })
          hackComputer()
        end
      }
    },
  })
end

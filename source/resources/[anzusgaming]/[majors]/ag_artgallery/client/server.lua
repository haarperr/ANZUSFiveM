local function hackServer(index)
  LocalPlayer.state:set("invBusy", true, true)

  local ped = cache.ped
  TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)
  Wait(2000)

  TriggerEvent("utk_fingerprint:Start", 4, 2, 2, function(outcome, reason)
    Wait(5000)
    if true then
      -- GET VAULT CODE
      local code = lib.callback.await('ag_artgallery:server:getVaultCode', false)
      lib.alertDialog({
        header = locale('server_header'),
        content = locale('vault_code', code),
        centered = true
      })
    end

    TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'server', index = index, bool = false })
    ClearPedTasks(cache.ped)
    LocalPlayer.state:set("invBusy", false, true)
  end)
end

function SetupServerZone(index)
  local config = Config.Artgallery.server[index]

  exports.ox_target:addBoxZone({
    coords = config.zone.coords,
    size = config.zone.size,
    rotation = config.zone.rotation,
    options = {
      {
        label = locale('hack_server'),
        icon = 'fa-brands fa-keycdn',
        item = 'artgallery_keycard',
        canInteract = function()
          return not Config.Artgallery.server[index].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          AlertPolice()
          TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'server', index = index, bool = true })
          hackServer(index)
        end,
      }
    }
  })
end

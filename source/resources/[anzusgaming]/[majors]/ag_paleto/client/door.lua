---@param index number
local function hackKeypad(index)
  TriggerServerEvent('ag_artgallery:server:useItem', { item = 'raspberry_pi', durability = 34 })

  LocalPlayer.state:set("invBusy", true, true)

  local ped = cache.ped
  TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)
  Wait(2000)

  exports['ps-ui']:Scrambler(function(success)
    if success then
      TriggerServerEvent('ag_paleto:server:openDoor', { key = 'door', index = index, bool = true })
    else
      TriggerServerEvent('ag_paleto:server:setBusy', { key = 'door', index = index, bool = false })
      lib.notify({ type = 'error', description = locale('failed_case') })
    end

    ClearPedTasks(cache.ped)
    LocalPlayer.state:set("invBusy", false, true)
  end, "runes", 20, 1)
end

function SetupDoorZone(index)
  local config = Config.Paleto.door[index]

  exports.ox_target:addBoxZone({
    coords = config.zone.coords,
    size = config.zone.size,
    rotation = config.zone.rotation,
    options = {
      {
        label = config.label,
        icon = config.icon,
        items = 'raspberry_pi',
        canInteract = function()
          return not Config.Paleto.door[index].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_paleto:server:setBusy', { key = 'door', index = index, bool = true })
          hackKeypad(index)
        end,
      }
    },
  })
end

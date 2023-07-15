---@param index number
local function hackATM(index)
  TriggerServerEvent('ag_artgallery:server:useItem', { item = 'raspberry_pi', durability = 34 })

  -- utils.sendAlert('paleto')

  LocalPlayer.state:set("invBusy", true, true)

  local ped = cache.ped
  TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)
  Wait(2000)

  exports['ps-ui']:Scrambler(function(success)
    if success then
      TriggerServerEvent('ag_paleto:server:getReward', { key = 'atm', index = key })
    else
      TriggerServerEvent('ag_paleto:server:setBusy', { key = 'atm', index = index, bool = false })
    end

    ClearPedTasks(cache.ped)
    LocalPlayer.state:set("invBusy", false, true)
  end, "greek", 30, 0)
end

function SetupATMZone(index)
  local config = Config.Paleto.atm[index]

  exports.ox_target:addBoxZone({
    coords = config.zone.coords,
    size = config.zone.size,
    rotation = config.zone.rotation,
    options = {
      {
        label = 'Hack ATM',
        icon = 'fa-solid fa-microchip',
        canInteract = function()
          return not Config.Paleto.atm[index].busy
        end,
        items = 'raspberry_pi',
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_paleto:server:setBusy', { key = 'atm', index = index, bool = true })
          hackATM(index)
        end,
        distance = 2
      }
    },
  })
end

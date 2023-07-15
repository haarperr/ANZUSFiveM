local hint = nil

local function hackSchedule()
  local ped = cache.ped
  LocalPlayer.state:set("invBusy", true, true)
  TriggerEvent('ox_inventory:disarm')
  TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)
  Wait(2000)

  TriggerEvent('ultra-voltlab', 60, function(result, reason)
    if result == 1 then
      hint = lib.callback.await('ag_pacific:server:getHint', 200)

      Wait(3000)
      lib.alertDialog({
        header = locale('manager_schedule_header'),
        content = locale('current_meeting', hint),
        centered = true
      })
    end
    LocalPlayer.state:set("invBusy", false, true)
    ClearPedTasks(cache.ped)
  end)
end

function SetupComputerZone(key)
  local config = Config.Bank.computer[key]

  exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        label = locale('hack_schedule'),
        canInteract = function()
          if not PowerstationBlownUp then return false end
          return true
        end,
        onSelect = function()
          if hint then
            lib.alertDialog({
              header = locale('manager_schedule_header'),
              content = locale('current_meeting', hint),
              centered = true
            })
          else
            hackSchedule()
          end
        end
      }
    }
  })
end

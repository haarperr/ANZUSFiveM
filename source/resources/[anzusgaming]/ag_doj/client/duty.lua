local zones = {}

function SetupDutyZones()
  for key, value in pairs(Config.Duty) do
    zones[#zones + 1] = exports.ox_target:addBoxZone({
      coords = value.coords,
      size = value.size,
      rotation = value.rotation,
      options = {
        {
          name = 'ag_doj:toggleDuty',
          label = 'Toggle Duty',
          icon = "fas fa-clipboard",
          onSelect = function()
            local res = lib.callback.await('ag_doj:ToggleDuty', 200)
            lib.notify({ type = 'success', title = 'San Andreas Government', description = ('You are now %s'):format(res) })
          end
        }
      }
    })
  end
end

function DestroyDutyZones()
  for key, value in pairs(zones) do
    exports.ox_target:removeZone(value)
  end
end

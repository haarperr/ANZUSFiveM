local zones = {}

function CreateTargetOptions()
  for i = 1, #PD_Zones, 1 do
    local zone = PD_Zones[i]
    if not zone.duty then
      -- print(string.format('Missing duty configuration for %s', zone.name))
      goto skip
    end
    zones[#zones + 1] = exports.ox_target:addBoxZone({
      coords = zone.duty.coords,
      size = zone.duty.size,
      rotation = zone.duty.rotation,
      options = {
        {
          name = 'ag_police:toggleDuty',
          label = 'Toggle Duty',
          icon = "fas fa-clipboard",
          onSelect = function()
            local res = lib.callback.await('ag_police:ToggleDuty', 200)
            lib.notify({ type = 'success', title = 'Law Enforcement', description = ('You are now %s'):format(res) })

            TriggerServerEvent('ps-mdt:server:ClockSystem')
          end
        }
      }
    })
    ::skip::

    if not zone.trash then
      -- print(string.format('Missing tash configuration for %s', zone.name))
      goto skip_trash
    end
    zones[#zones + 1] = exports.ox_target:addBoxZone({
      coords = zone.trash.coords,
      size = zone.trash.size,
      rotation = zone.trash.rotation,
      options = {
        {
          name = 'ag_police:trash',
          label = 'Trash',
          groups = { 'lspd' },
          onSelect = function()
            exports.ox_inventory:openInventory('stash', string.format('policetrash_%s', zone.name))
          end
        }
      }
    })

    ::skip_trash::
  end
end

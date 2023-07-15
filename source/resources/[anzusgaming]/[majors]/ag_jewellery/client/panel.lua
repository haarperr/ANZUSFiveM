local zones = {}

local function openVoltLab()
  LocalPlayer.state:set("invBusy", true, true)

  TriggerEvent('ultra-voltlab', 20, function(result, reason)
    if result == 1 then
      lib.notify({ type = 'success', title = 'ThriftEx', description = locale('alarms_disabled') })
      TriggerServerEvent('ag_jewellery:server:setAlarm', false)
    else
      TriggerServerEvent('ag_jewellery:server:setPanelBusy', { key = key, bool = false })
    end
    LocalPlayer.state:set("invBusy", false, true)
  end)
end

function SetupPanel(key)
  local config = Config.Jewellery.panel[key]

  zones[#zones + 1] = exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        name = ('ag_jewellery:JewelleryPanel%s'):format(key),
        label = locale('hack_panel'),
        icon = config.icon,
        canInteract = function()
          return not Config.Jewellery.panel[key].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_jewellery:server:setPanelBusy', { key = key, bool = true })
          openVoltLab()
        end
      }
    },
  })
end

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_jewellery:client:setPanelBusy', function(data)
  Config.Jewellery.panel[data.key].busy = data.bool
end)

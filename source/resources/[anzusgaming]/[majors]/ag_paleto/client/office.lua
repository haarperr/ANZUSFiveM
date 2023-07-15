local function decryptComputer(index)
  local office = ('office%d'):format(index)

  TriggerServerEvent('ag_artgallery:server:useItem', { item = 'raspberry_pi', durability = 34 })

  -- utils.sendAlert('paleto')

  local success = lib.progressCircle({
    duration = 20000,
    label = 'Reading /dev/sda1',
    position = 'bottom',
    canCancel = false,
    disable = {
      car = true,
    },
  })

  if not success then
    return TriggerServerEvent('ag_paleto:server:setBusy', { key = 'offices', index = index, bool = false })
  end

  TriggerServerEvent('ag_paleto:server:setHacked', { key = office, bool = true })
  lib.notify({ type = 'success', description = 'You were able to find the encryption key for a server', duration = 2500 })
end

function SetupOfficeZone(index)
  local config = Config.Paleto.offices[index]
  exports.ox_target:addBoxZone({
    coords = config.computer.coords,
    size = config.computer.size,
    rotation = config.computer.rotation,
    options = {
      {
        label = 'Decrypt Data',
        icon = 'fa-solid fa-database',
        canInteract = function()
          return not Config.Paleto.offices[index].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_paleto:server:setBusy', { key = 'offices', index = index, bool = true })
          decryptComputer(index)
        end,
        distance = 2
      }
    },
  })
end

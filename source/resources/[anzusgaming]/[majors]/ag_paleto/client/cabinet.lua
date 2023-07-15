---@param index number
local function rummageCabinet(index)
  LocalPlayer.state:set("invBusy", true, true)

  lib.progressCircle({
    label = 'Rummaging',
    duration = math.random(5000, 10000),
    canCancel = false,
    disable = {
      move = true,
      combat = true
    },
    anim = {
      dict = 'missexile3',
      clip = 'ex03_dingy_search_case_a_michael'
    }
  })

  TriggerServerEvent('ag_paleto:server:openCabinet', { key = key })
end

function SetupCabinetZone(index)
  local config = Config.Paleto.cabinet[index]

  exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        label = 'Rummage',
        icon = 'fa-solid fa-magnifying-glass',
        canInteract = function()
          return not Config.Paleto.cabinet[index].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_paleto:server:setBusy', { key = 'cabinet', index = index, bool = true })
          rummageCabinet(k)
        end
      }
    },
  })
end

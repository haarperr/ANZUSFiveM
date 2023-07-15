---@param index number
local function crackSafe(index)
  LocalPlayer.state:set("invBusy", true, true)

  -- utils.sendAlert('paleto')

  local codea, codeb, codec, coded = math.random(0, 99), math.random(0, 99), math.random(0, 99), math.random(0, 99)
  local res = CreateSafe({ codea, codeb, codec, coded })
  if res then
    TriggerServerEvent('ag_paleto:server:safeCrack', { index = index })
  else
    TriggerServerEvent('ag_paleto:server:setBusy', { key = 'safe', index = index, bool = false })
  end

  LocalPlayer.state:set("invBusy", false, true)
end

function SetupSafeZone(index)
  local config = Config.Paleto.safe[index]

  exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        label = 'Crack Safe',
        icon = 'fa-solid fa-vault',
        onInteract = function()
          if Config.Paleto.safe[index].busy then return false end
          if not SyncData['office1'].hacked and not SyncData['office2'].hacked then return false end
          return true
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_paleto:server:setBusy', { key = 'safe', index = index, bool = true })
          crackSafe(index)
        end,
        distance = 1
      }
    },
  })
end

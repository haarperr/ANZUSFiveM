---@param index number
---@param office string
local function enterPassword(index, office)
  if Config.Paleto.offices[index].opened then return end
  -- if not utils.isEnoughPolice('paleto') then return lib.notify({ type = 'error', description = 'Not enough police online' }) end
  LocalPlayer.state:set("invBusy", true, true)

  local input = lib.inputDialog('Door System', {
    { type = 'input', label = 'Code', description = 'Door Code', required = true },
  })
  if not input or not input[1] then return end

  local code = input[1]

  lib.callback('ag_paleto:server:correctDoorCode', false, function(isCorrect)
    if isCorrect then
      TriggerServerEvent('ag_paleto:server:openDoor', { key = 'offices', index = index, bool = true })
      lib.notify({ type = 'success', title = 'Secure System', description = 'Correct code entered' })
    else
      lib.notify({ type = 'error', title = 'Secure System', description = 'Invalid code entered' })
    end

    LocalPlayer.state:set("invBusy", false, true)
  end, { code = code, office = office })
end

local function viewControlPanel()
  local options = {}

  for k, v in ipairs(Config.Paleto.offices) do
    local opt = {
      title = v.title,
      icon = 'fa-solid fa-circle-xmark',
      onSelect = function()
        lib.hideContext()
        enterPassword(k, ('office%d'):format(k))
      end,
    }
    if v.opened then
      opt.disabled = true
      opt.icon = 'fa-solid fa-circle-check'
    end
    options[#options + 1] = opt
  end

  for k, v in ipairs(Config.Paleto.control_door) do
    local opt = {
      title = v.name,
      icon = 'fa-solid fa-circle-xmark',
      onSelect = function()
        lib.hideContext()
        TriggerServerEvent('ag_paleto:server:openDoor', { key = 'control_door', index = k, bool = true })
      end,
    }
    if v.opened then
      opt.disabled = true
      opt.icon = 'fa-solid fa-circle-check'
    end
    options[#options + 1] = opt
  end

  lib.registerContext({
    id = 'paleto_major_cp',
    title = 'Control Panel',
    options = options
  })

  lib.showContext('paleto_major_cp')
end

function SetupControlPanel()
  exports.ox_target:addBoxZone({
    coords = vec3(-92.85, 6463.75, 31.55),
    size = vec3(0.35, 0.6, 0.25),
    rotation = 318.75,
    options = {
      {
        name = 'agmajor:PaletoControlPanel',
        label = 'Control Panel',
        icon = 'fa-solid fa-gamepad',
        onSelect = function()
          viewControlPanel()
        end
      }
    },
  })
end

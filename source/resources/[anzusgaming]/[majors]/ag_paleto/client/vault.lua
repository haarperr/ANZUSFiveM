local attempts = 0

local function enterCode(index)
  LocalPlayer.state:set("invBusy", true, true)

  local input = lib.inputDialog(locale('code_header'), {
    { type = 'input', label = 'Code', description = 'Vault Code' },
  })

  if not input or not input[1] then
    TriggerServerEvent('ag_paleto:server:setBusy', { key = 'vault', index = index, bool = false })
    LocalPlayer.state:set("invBusy", false, true)
    return
  end

  local res = lib.callback.await('ag_paleto:server:checkCode', 200, { code = input[1] })
  if not res.correct then
    lib.notify({ type = 'error', description = locale('invalid_code', res.attempts, Config.MaxCodeAttempts) })
    TriggerServerEvent('ag_paleto:server:setBusy', { key = 'vault', index = index, bool = false })
  else
    lib.notify({ type = 'success', description = locale('correct_code') })
    TriggerServerEvent('ag_paleto:server:setVaultDoor', { code = input[1], index = index, bool = true })
  end

  LocalPlayer.state:set("invBusy", false, true)
end

function SetupVaultZone(index)
  local config = Config.Paleto.vault[index]

  exports.ox_target:addBoxZone({
    coords = config.zone.coords,
    size = config.zone.size,
    rotation = config.zone.rotation,
    options = {
      {
        label = locale('enter_code'),
        icon = 'fa-brands fa-keycdn',
        canInteract = function()
          return not Config.Paleto.vault[index].busy and attempts < Config.MaxCodeAttempts
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_paleto:server:setBusy', { key = 'vault', index = index, bool = true })
          enterCode(index)
        end
      }
    },
  })
end

RegisterNetEvent('ag_paleto:client:setAttemptCount', function(amount)
  attempts = amount
end)

---@param index number
function ToggleVault(index)
  local config = Config.Paleto.vault[index]

  local coords = GetEntityCoords(cache.ped)

  local object = GetClosestObjectOfType(config.coords.x, config.coords.y, config.coords.z, 5, config.model, false, false, false)
  if not object then return end

  local heading = config.opened and config.open or config.closed
  FreezeEntityPosition(object, true)

  if #(coords - config.coords) > 50 then
    SetEntityHeading(object, heading)
  else
    if heading < GetEntityHeading(object) then
      repeat
        SetEntityHeading(object, GetEntityHeading(object) - 0.15)
        Wait(10)
      until GetEntityHeading(object) <= heading
    else
      repeat
        SetEntityHeading(object, GetEntityHeading(object) + 0.15)
        Wait(10)
      until GetEntityHeading(object) >= heading
    end
  end

  FreezeEntityPosition(object, true)
end

---@param data {index: number, bool: boolean}
RegisterNetEvent('ag_paleto:client:setVaultDoor', function(data)
  Config.Paleto.vault[data.index].opened = data.bool

  ToggleVault(data.index)
end)

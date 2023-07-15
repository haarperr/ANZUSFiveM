local function smashCase(key)
  local config = Config.Jewellery.case[key]
  local selectedWeapon = GetSelectedPedWeapon(cache.ped)
  local weaponConf = Config.Weapons[selectedWeapon]

  if not weaponConf then
    TriggerServerEvent('ag_jewellery:server:setCaseBusy', { key = key, bool = false })
    return lib.notify({ type = 'error', description = locale('glass_too_strong') })
  end

  local animDict = "missheist_jewel"
  lib.requestAnimDict(animDict)

  LocalPlayer.state:set("invBusy", true, true)

  if not PoliceAlerted then
    exports['ps-dispatch']:VangelicoRobbery()
    TriggerServerEvent('ag_jewellery:client:setPoliceAlerted')
  end

  local success = lib.skillCheck(Config.SkillCheck.difficulty, Config.SkillCheck.keys)
  if not success then
    LocalPlayer.state:set("invBusy", false, true)
    TriggerServerEvent('hud:server:GainStress', math.random(1, 5))
    TriggerServerEvent('ag_jewellery:server:setCaseBusy', { key = key, bool = false })
    return lib.notify({ type = 'error', description = locale('failed_case') })
  end

  TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
  success = lib.progressCircle({
    duration = math.abs(20000 * (1 - weaponConf)),
    label = 'Smashing case..',
    disable = {
      car = true,
      combat = true,
      move = true
    },
    anim = {
      dict = animDict,
      clip = 'smash_case'
    }
  })

  if not success then
    LocalPlayer.state:set("invBusy", false, true)
    TriggerServerEvent('hud:server:GainStress', math.random(1, 5))
    TriggerServerEvent('ag_jewellery:server:setCaseBusy', { key = key, bool = false })
    return lib.notify({ type = 'error', description = locale('failed_case') })
  end

  if not GasEnabled and not CannistersBroken then
    TriggerServerEvent('ag_jewellery:server:setGas', true)
  end

  TriggerServerEvent('ag_jewellery:server:swapCase', { key = key })
  TriggerServerEvent('ag_jewellery:server:getReward', key)
end

function SetupCaseZone(key)
  local config = Config.Jewellery.case[key]

  exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        name = ('ag_jewellery:case%s'):format(key),
        label = locale('smash_case'),
        icon = 'fa-solid fa-person-through-window',
        canInteract = function()
          return not Config.Jewellery.case[key].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_jewellery:server:setCaseBusy', { key = key, bool = true })
          smashCase(key)
        end
      }
    },
  })
end

---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_jewellery:client:setCaseBusy', function(data)
  Config.Jewellery.case[data.key].busy = data.bool
end)

---@param data {key: number}
RegisterNetEvent('ag_jewellery:client:swapCase', function(data)
  local config = Config.Jewellery.case[data.key]
  CreateModelSwap(config.coords.x, config.coords.y, config.coords.z, 0.3, config.oldModel, config.newModel, false)
end)

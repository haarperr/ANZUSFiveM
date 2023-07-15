local function grabEgg(index)
  local selectedWeapon = GetSelectedPedWeapon(cache.ped)
  local weaponConf = Config.Weapons[selectedWeapon]

  if not weaponConf then
    TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'egg', index = index, bool = false })
    return lib.notify({ type = 'error', description = locale('glass_too_strong') })
  end

  local animDict = "missheist_jewel"
  lib.requestAnimDict(animDict)

  LocalPlayer.state:set("invBusy", true, true)

  -- if not PoliceAlerted then
  --   exports['ps-dispatch']:VangelicoRobbery()
  --   TriggerServerEvent('ag_jewellery:client:setPoliceAlerted')
  -- end

  local success = lib.skillCheck(Config.SkillCheck.difficulty, Config.SkillCheck.keys)
  if not success then
    LocalPlayer.state:set("invBusy", false, true)
    TriggerServerEvent('hud:server:GainStress', math.random(1, 5))
    TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'egg', index = index, bool = false })
    return lib.notify({ type = 'error', description = locale('failed_case') })
  end

  TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
  success = lib.progressCircle({
    duration = math.abs(60000 * (1 - weaponConf)),
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
    TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'egg', index = index, bool = false })
    return lib.notify({ type = 'error', description = locale('failed_case') })
  end

  TriggerServerEvent('ag_artgallery:server:getReward', { key = 'egg', index = index })
end

function SetupEggZone(index)
  local config = Config.Artgallery.egg[index]

  exports.ox_target:addBoxZone({
    coords = config.zone.coords,
    size = config.zone.size,
    rotation = config.zone.rotation,
    options = {
      {
        name = ('ag_artgallery:case%s'):format(index),
        label = locale('smash_case'),
        icon = 'fa-solid fa-person-through-window',
        canInteract = function()
          return not Config.Artgallery.egg[index].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          AlertPolice()
          TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'egg', index = index, bool = true })
          grabEgg(index)
        end,
        distance = 2
      }
    },
  })
end

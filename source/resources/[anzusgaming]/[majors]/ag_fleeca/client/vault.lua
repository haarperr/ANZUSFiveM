local safeZone = (1.0 - GetSafeZoneSize()) * 0.5
local timerBar = {
  baseX = 0.918 - safeZone,
  baseY = 0.984 - safeZone,
  baseWidth = 0.165,
  baseHeight = 0.035,
  baseGap = 0.038,
  titleX = 0.012,
  titleY = -0.009,
  textX = 0.0785,
  textY = -0.0165,
  txtDict = "timerbars",
  txtName = "all_black_bg",
}

local function s2m(s)
  if s <= 0 then
    return "00:00"
  else
    local m = string.format("%02.f", math.floor(s / 60))
    return m .. ":" .. string.format("%02.f", math.floor(s - m * 60))
  end
end

local function DrawTimerBar(title, text)
  local titleColor = { 255, 255, 255, 255 }
  local textColor = { 255, 255, 255, 255 }
  local titleScale = 0.3
  local titleFont = 0
  local titleFontOffset = 0.0

  local yOffset = timerBar.baseY - (1 * timerBar.baseGap)

  if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
    RequestStreamedTextureDict(timerBar.txtDict, true)

    local t = GetGameTimer() + 5000

    repeat
      Wait(0)
    until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
  end

  DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

  BeginTextCommandDisplayText("CELL_EMAIL_BCON")
  SetTextFont(titleFont)
  SetTextScale(titleScale, titleScale)
  SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
  SetTextRightJustify(true)
  SetTextWrap(0.0, timerBar.baseX + timerBar.titleX)
  AddTextComponentSubstringPlayerName(title)
  EndTextCommandDisplayText(timerBar.baseX + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

  BeginTextCommandDisplayText("CELL_EMAIL_BCON")
  SetTextFont(0)
  SetTextScale(0.425, 0.425)
  SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
  SetTextRightJustify(true)
  SetTextWrap(0.0, timerBar.baseX + timerBar.textX)
  AddTextComponentSubstringPlayerName(text)
  EndTextCommandDisplayText(timerBar.baseX + timerBar.textX, yOffset + timerBar.textY)
end
---@param key number
local function spawnDrill(key)
  local drill = lib.requestModel(`k4mb1_prop_drill2`)
  local config = Config.Banks[key]

  local success = lib.progressCircle({
    duration = 3333,
    label = locale('placing_drill'),
    anim = {
      dict = 'anim@scripted@heist@ig11_bomb_plant@male@',
      clip = 'enter',
    },
    disable = {
      move = true,
      car = true,
      combat = true
    },
    canCancel = false,
    useWhileDead = false
  })

  if not success then
    return TriggerServerEvent('ag_fleeca:server:setDrilling', { key = key, bool = false })
  end

  TriggerServerEvent('ag_fleeca:server:removeItem', 'drill')
  lib.requestModel(`hei_p_m_bag_var22_arm_s`)

  local ped = PlayerPedId()
  local pedCo = GetEntityCoords(ped)
  local door = GetClosestObjectOfType(pedCo.x, pedCo.y, pedCo.z, 4.0, config.vault_door.model, false, false, false)
  local animDict = 'anim@scripted@heist@ig11_bomb_plant@male@'
  local drillRot = GetEntityRotation(door) + vector3(0.0, 0.0, 180.0)

  local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pedCo.x, pedCo.y, pedCo.z, true, true, false)

  local sceneRot = GetEntityRotation(cache.ped)

  local scene = NetworkCreateSynchronisedScene(pedCo.x, pedCo.y, pedCo.z + 0.75, sceneRot.x, sceneRot.y, sceneRot.z, 2, false, false, 1065353216, 0, 0.5)
  NetworkAddPedToSynchronisedScene(ped, scene, animDict, 'enter', 1.5, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(bag, scene, animDict, 'enter_bag', 4.0, -8.0, 1)
  SetPedComponentVariation(ped, 5, 0, 0, 0)
  NetworkStartSynchronisedScene(scene)
  Wait(2000)
  DeleteObject(bag)

  drill = CreateObject(`k4mb1_prop_drill2`, config.vault_door.drill.coords.x, config.vault_door.drill.coords.y, config.vault_door.drill.coords.z, true, true, false)
  SetEntityRotation(drill, drillRot.x, drillRot.y, drillRot.z, 0, false)
  FreezeEntityPosition(drill, true)
  local soundId = GetSoundId()
  PlaySoundFromEntity(soundId, "Drill", drill, "DLC_HEIST_FLEECA_SOUNDSET", true, 0)
  lib.requestNamedPtfxAsset('scr_fbi5a')
  UseParticleFxAssetNextCall('scr_fbi5a')
  local ptfx = StartNetworkedParticleFxLoopedOnEntity('scr_bio_grille_cutting', drill, 0.044, -0.25, 0.0, 0.0, 90.0, 0.0, 1.2, false, false, false)

  exports['ps-dispatch']:FleecaBankRobbery()

  local start_time = GetGameTimer()
  local end_time = start_time + (Config.DrillTime * 60 * 1000)

  local remaining = true
  while remaining do
    local coords = GetEntityCoords(cache.ped)
    if #(config.vault_door.drill.coords - coords) > 10 then
      DeleteObject(drill)
      StopSound(soundId)
      TriggerServerEvent('ag_fleeca:server:setDrilling', { key = key, bool = false })
      return lib.notify({ type = 'error', description = locale('too_far') })
    end

    local remaining_time = math.floor((end_time - GetGameTimer()) / 1000)
    if remaining_time <= 0 then remaining = false end
    DrawTimerBar("TIME", s2m(remaining_time))
    Wait(0)
  end

  if not remaining then
    DeleteObject(drill)
    StopSound(soundId)
    TriggerServerEvent('ag_fleeca:server:setVaultDoor', { key = key, bool = true })
  end
end

---@param key number
function CreateVaultOptions(key)
  local config = Config.Banks[key]

  exports.ox_target:addBoxZone({
    coords = config.vault_door.coords,
    size = config.vault_door.size,
    rotation = config.vault_door.rotation,
    options = {
      {
        name = 'vault_electric',
        icon = 'fa-solid fa-bolt',
        label = locale('use_drill'),
        item = 'drill',
        canInteract = function(_, distance)
          if GlobalState.fleecaData.cooldown and GlobalState.fleecaData.allowedBank ~= key then return false end
          return distance < 2.0 and not Config.Banks[key].vault_door.drilling and not Config.Banks[key].vault_door.opened
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_fleeca:server:setDrilling', { key = key, bool = true })
          spawnDrill(key)
        end
      },
    }
  })
end

---@param key string
function ToggleVault(key)
  local config = Config.Banks[key]

  local coords = GetEntityCoords(cache.ped)

  local object = GetClosestObjectOfType(config.vault_door.coords.x, config.vault_door.coords.y, config.vault_door.coords.z, 5, config.vault_door.model, false, false, false)
  if not object then return end

  local heading = config.vault_door.opened and config.vault_door.open or config.vault_door.closed

  if #(coords - config.vault_door.coords) > 50 then
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

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_fleeca:client:setVaultDoor', function(data)
  Config.Banks[data.key].vault_door.opened = data.bool

  ToggleVault(data.key)
end)

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_fleeca:client:setDrilling', function(data)
  Config.Banks[data.key].vault_door.drilling = data.bool
end)

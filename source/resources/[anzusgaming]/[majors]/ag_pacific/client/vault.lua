local LaptopAnimation = {
  objects = {
    'hei_p_m_bag_var22_arm_s',
    'hei_prop_hst_laptop',
    'hei_prop_heist_card_hack_02'
  },
  animations = {
    { 'hack_enter', 'hack_enter_bag', 'hack_enter_laptop', 'hack_enter_card' },
    { 'hack_loop',  'hack_loop_bag',  'hack_loop_laptop',  'hack_loop_card' },
    { 'hack_exit',  'hack_exit_bag',  'hack_exit_laptop',  'hack_exit_card' }
  },
  scenes = {},
  sceneObjects = {}
}

local HackKeypad = {
  animations = {
    { 'action_var_01',             'action_var_01_ch_prop_ch_usb_drive01x',             'action_var_01_prop_phone_ing' },
    { 'hack_loop_var_01',          'hack_loop_var_01_ch_prop_ch_usb_drive01x',          'hack_loop_var_01_prop_phone_ing' },
    { 'success_react_exit_var_01', 'success_react_exit_var_01_ch_prop_ch_usb_drive01x', 'success_react_exit_var_01_prop_phone_ing' },
    { 'fail_react',                'fail_react_ch_prop_ch_usb_drive01x',                'fail_react_prop_phone_ing' },
    { 'reattempt',                 'reattempt_ch_prop_ch_usb_drive01x',                 'reattempt_prop_phone_ing' },
  },
  scenes = {}
}

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

local function hackVault(key)
  TriggerServerEvent('ag_pacific:server:useItem', { item = 'raspberry_pi', durability = 34 })

  LocalPlayer.state:set("invBusy", true, true)
  TriggerEvent('ox_inventory:disarm')
  local ped = cache.ped
  local pedCo, pedRotation = GetEntityCoords(cache.ped), GetEntityRotation(cache.ped)
  local sceneObject = GetClosestObjectOfType(pedCo.x, pedCo.y, pedCo.z, 2.0, -160937700, false, false, false)
  local scenePos = GetEntityCoords(sceneObject)
  local sceneRot = GetEntityRotation(sceneObject)
  local animDict = 'anim@heists@ornate_bank@hack'
  lib.requestAnimDict(animDict)

  for k, v in pairs(LaptopAnimation.objects) do
    lib.requestModel(v)
    LaptopAnimation.sceneObjects[k] = CreateObject(joaat(v), pedCo.x, pedCo.y, pedCo.z, true, true, false)
  end

  for i = 1, #LaptopAnimation.animations do
    LaptopAnimation.scenes[i] = NetworkCreateSynchronisedScene(scenePos.x, scenePos.y, scenePos.z, sceneRot.x, sceneRot.y, sceneRot.z, 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, LaptopAnimation.scenes[i], animDict, LaptopAnimation.animations[i][1], 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(LaptopAnimation.sceneObjects[1], LaptopAnimation.scenes[i], animDict, LaptopAnimation.animations[i][2], 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(LaptopAnimation.sceneObjects[2], LaptopAnimation.scenes[i], animDict, LaptopAnimation.animations[i][3], 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(LaptopAnimation.sceneObjects[3], LaptopAnimation.scenes[i], animDict, LaptopAnimation.animations[i][4], 4.0, -8.0, 1)
  end

  NetworkStartSynchronisedScene(LaptopAnimation.scenes[1])
  Wait(6300)
  NetworkStartSynchronisedScene(LaptopAnimation.scenes[2])
  Wait(2000)

  TriggerEvent("utk_fingerprint:Start", 4, 6, 2, function(outcome, reason)
    NetworkStartSynchronisedScene(LaptopAnimation.scenes[3])
    Wait(4600)

    DeleteObject(LaptopAnimation.sceneObjects[1])
    DeleteObject(LaptopAnimation.sceneObjects[2])
    DeleteObject(LaptopAnimation.sceneObjects[3])
    ClearAreaOfObjects(pedCo.x, pedCo.y, pedCo.z, 1, 0)
    LocalPlayer.state:set("invBusy", false, true)

    if outcome then
      TriggerServerEvent('ag_pacific:server:setVaultDoor', { key = key, bool = true })
    else
      TriggerServerEvent('ag_pacific:server:setBusy', { type = 'vault', key = key, bool = false })
    end
  end)
end

local function hackFingerprintScanner(key)
  TriggerServerEvent('ag_pacific:server:useItem', { item = 'raspberry_pi', durability = 34 })

  TriggerEvent('ox_inventory:disarm')
  LocalPlayer.state:set("invBusy", true, true)

  local ped = cache.ped
  local pedCo = GetEntityCoords(ped)
  local animDict = 'anim_heist@hs3f@ig1_hack_keypad@arcade@male@'
  local usbModel = `ch_prop_ch_usb_drive01x`
  local phoneModel = `prop_phone_ing`
  lib.requestAnimDict(animDict)
  lib.requestModel(usbModel)
  lib.requestModel(phoneModel)

  local usb = CreateObject(usbModel, pedCo.x, pedCo.y, pedCo.z, true, true, false)
  local phone = CreateObject(phoneModel, pedCo.x, pedCo.y, pedCo.z, true, true, false)
  local keypad = GetClosestObjectOfType(pedCo.x, pedCo.y, pedCo.z, 2.0, 996668613, false, false, false)
  local keypadCoords = GetEntityCoords(keypad)
  local keypadRot = GetEntityRotation(keypad)

  for i = 1, #HackKeypad.animations do
    HackKeypad.scenes[i] = NetworkCreateSynchronisedScene(keypadCoords.x, keypadCoords.y, keypadCoords.z, keypadRot.x, keypadRot.y, keypadRot.z, 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, HackKeypad.scenes[i], animDict, HackKeypad.animations[i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(usb, HackKeypad.scenes[i], animDict, HackKeypad.animations[i][2], 1.0, -1.0, 1148846080)
    NetworkAddEntityToSynchronisedScene(phone, HackKeypad.scenes[i], animDict, HackKeypad.animations[i][3], 1.0, -1.0, 1148846080)
  end

  NetworkStartSynchronisedScene(HackKeypad.scenes[1])
  Wait(4000)
  NetworkStartSynchronisedScene(HackKeypad.scenes[2])
  Wait(2000)

  TriggerEvent("utk_fingerprint:Start", 4, 2, 2, function(outcome, reason)
    Wait(5000)
    if outcome then
      NetworkStartSynchronisedScene(HackKeypad.scenes[3])
      Wait(4000)
      TriggerServerEvent('ag_pacific:server:setVaultDoor', { key = key, bool = true })
    elseif not outcome then
      NetworkStartSynchronisedScene(HackKeypad.scenes[4])
      Wait(4000)
      TriggerServerEvent('ag_pacific:server:setVaultBusy', { key = key, bool = false })
    end

    DeleteObject(usb)
    DeleteObject(phone)
    ClearPedTasks(ped)
    ClearAreaOfObjects(pedCo.x, pedCo.y, pedCo.z, 1, 0)
    LocalPlayer.state:set("invBusy", false, true)
  end)
end

local function drillVault(key)
  local drill = lib.requestModel(`k4mb1_prop_thermaldrill`)
  LocalPlayer.state:set("invBusy", true, true)
  local config = Config.Bank.vault[key]
  TriggerEvent('ox_inventory:disarm')

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
    LocalPlayer.state:set("invBusy", false, true)
    return TriggerServerEvent('ag_pacific:server:setVaultBusy', { key = key, bool = false })
  end
  AlertPolice()
  TriggerServerEvent('ag_pacific:server:removeItem', 'drill')
  lib.requestModel(`hei_p_m_bag_var22_arm_s`)

  local ped = cache.ped
  local pedCo = GetEntityCoords(ped)
  local door = GetClosestObjectOfType(pedCo.x, pedCo.y, pedCo.z, 4.0, config.model, false, false, false)
  local animDict = 'anim@scripted@heist@ig11_bomb_plant@male@'
  local drillRot = GetEntityRotation(door)

  local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pedCo.x, pedCo.y, pedCo.z, true, true, false)

  local sceneRot = GetEntityRotation(cache.ped)

  local scene = NetworkCreateSynchronisedScene(pedCo.x, pedCo.y, pedCo.z + 0.75, sceneRot.x, sceneRot.y, sceneRot.z, 2, false, false, 1065353216, 0, 0.5)
  NetworkAddPedToSynchronisedScene(ped, scene, animDict, 'enter', 1.5, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(bag, scene, animDict, 'enter_bag', 4.0, -8.0, 1)
  SetPedComponentVariation(ped, 5, 0, 0, 0)
  NetworkStartSynchronisedScene(scene)
  Wait(2000)
  DeleteObject(bag)

  drill = CreateObject(`k4mb1_prop_thermaldrill`, config.drill.coords.x, config.drill.coords.y, config.drill.coords.z, true, true, false)
  SetEntityRotation(drill, drillRot.x, drillRot.y, drillRot.z, 0, false)
  FreezeEntityPosition(drill, true)
  local soundId = GetSoundId()
  PlaySoundFromEntity(soundId, "Drill", drill, "DLC_HEIST_FLEECA_SOUNDSET", true, 0)
  lib.requestNamedPtfxAsset('scr_fbi5a')
  UseParticleFxAssetNextCall('scr_fbi5a')
  local ptfx = StartNetworkedParticleFxLoopedOnEntity('scr_bio_grille_cutting', drill, 0.044, -0.25, 0.0, 0.0, 90.0, 0.0, 1.2, false, false, false)

  LocalPlayer.state:set("invBusy", false, true)
  local start_time = GetGameTimer()
  local end_time = start_time + (Config.DrillTime * 60 * 1000)

  local remaining = true
  while remaining do
    local coords = GetEntityCoords(cache.ped)
    if #(config.drill.coords - coords) > 20 then
      DeleteObject(drill)
      StopSound(soundId)
      ClearAreaOfObjects(pedCo.x, pedCo.y, pedCo.z, 1, 0)
      TriggerServerEvent('ag_pacific:server:setVaultBusy', { key = key, bool = false })
      return lib.notify({ type = 'error', description = locale('too_far') })
    end

    local remaining_time = math.floor((end_time - GetGameTimer()) / 1000)
    if remaining_time <= 0 then
      DeleteObject(drill)
      StopSound(soundId)
      ClearAreaOfObjects(pedCo.x, pedCo.y, pedCo.z, 1, 0)
      TriggerServerEvent('ag_pacific:server:setVaultDoor', { key = key, bool = true })
      remaining = false
    end
    DrawTimerBar("TIME", s2m(remaining_time))
    Wait(0)
  end
end

function SetupVaultZone(key)
  local config = Config.Bank.vault[key]
  local label = nil
  local onSelect = nil
  local item = nil

  if config.type == 'hack' then
    item = 'raspberry_pi'
    label = locale('hack_laptop')
    onSelect = function()
      if not IsEnoughPoliceAvailable() then return end
      AlertPolice()
      TriggerServerEvent('ag_pacific:server:setBusy', { type = 'vault', key = key, bool = true })
      hackVault(key)
    end
  elseif config.type == 'drill' then
    item = 'drill'
    label = locale('drill_vault')
    onSelect = function()
      if not IsEnoughPoliceAvailable() then return end
      TriggerServerEvent('ag_pacific:server:setBusy', { type = 'vault', key = key, bool = true })
      drillVault(key)
    end
  elseif config.type == 'hack2' then
    item = 'raspberry_pi'
    label = locale('hack_laptop')
    onSelect = function()
      if not IsEnoughPoliceAvailable() then return end
      AlertPolice()
      TriggerServerEvent('ag_pacific:server:setBusy', { type = 'vault', key = key, bool = true })
      hackFingerprintScanner(key)
    end
  end

  if not onSelect or not item or not label then return end

  exports.ox_target:addBoxZone({
    coords = config.zone.coords,
    size = config.zone.size,
    rotation = config.zone.rotation,
    options = {
      {
        label = label,
        item = item,
        canInteract = function()
          return not Config.Bank.vault[key].busy
        end,
        onSelect = onSelect
      }
    }
  })
end

---@param key number
function ToggleVault(key)
  local config = Config.Bank.vault[key]

  local coords = GetEntityCoords(cache.ped)

  local object = GetClosestObjectOfType(config.coords.x, config.coords.y, config.coords.z, 5, config.model, false, false, false)
  if not object then return end
  FreezeEntityPosition(object, true)

  local heading = config.open
  if not config.opened then
    heading = config.closed
  end

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

---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_pacific:client:setVaultDoor', function(data)
  Config.Bank.vault[data.key].opened = data.bool

  ToggleVault(data.key)
end)

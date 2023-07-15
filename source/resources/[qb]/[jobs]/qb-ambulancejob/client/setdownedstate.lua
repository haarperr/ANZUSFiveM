---displays text on the player's screen.
---@param x number
---@param y number
---@param width number
---@param height number
---@param scale number
---@param text string
---@param r number
---@param g number
---@param b number
---@param a number
local function drawTxt(x, y, width, height, scale, text, r, g, b, a)
  SetTextFont(4)
  SetTextProportional(false)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(2, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - width / 2, y - height / 2 + 0.005)
end

local function displayRespawnText()
  if DeathTime > 0 and DoctorCount > 0 then
    drawTxt(0.93, 1.44, 1.0, 1.0, 0.6, Lang:t('info.respawn_txt', { deathtime = math.ceil(DeathTime) }), 255, 255, 255, 255)
  else
    drawTxt(0.865, 1.44, 1.0, 1.0, 0.6, Lang:t('info.respawn_revive', { holdtime = RespawnHoldTime, cost = Config.BillCost }), 255, 255, 255, 255)
  end
end

---@param ped number
local function playDeadAnimation(ped)
  if cache.vehicle then
    lib.requestAnimDict("veh@low@front_ps@idle_duck")
    if not IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
      TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, false, false, false)
    end
  else
    if IsInHospitalBed then
      if not IsEntityPlayingAnim(ped, InBedDict, InBedAnim, 3) then
        lib.requestAnimDict(InBedDict)
        TaskPlayAnim(ped, InBedDict, InBedAnim, 1.0, 1.0, -1, 1, 0, false, false, false)
      end
    else
      if not IsEntityPlayingAnim(ped, DeadAnimDict, DeadAnim, 3) then
        lib.requestAnimDict(DeadAnimDict)
        TaskPlayAnim(ped, DeadAnimDict, DeadAnim, 1.0, 1.0, -1, 1, 0, false, false, false)
      end
    end
  end
end

---@param ped number
local function handleDead(ped)
  if not IsInHospitalBed then
    displayRespawnText()
  end

  playDeadAnimation(ped)
  SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
end

---@param ped number
local function playEscortedLastStandAnimation(ped)
  if cache.vehicle then
    lib.requestAnimDict("veh@low@front_ps@idle_duck")
    if IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
      StopAnimTask(ped, "veh@low@front_ps@idle_duck", "sit", 3)
    end
  else
    lib.requestAnimDict(LastStandDict)
    if IsEntityPlayingAnim(ped, LastStandDict, LastStandAnim, 3) then
      StopAnimTask(ped, LastStandDict, LastStandAnim, 3)
    end
  end
end

---@param ped number
local function playUnescortedLastStandAnimation(ped)
  if cache.vehicle then
    lib.requestAnimDict("veh@low@front_ps@idle_duck")
    if not IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
      TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, false, false, false)
    end
  else
    lib.requestAnimDict(LastStandDict)
    if not IsEntityPlayingAnim(ped, LastStandDict, LastStandAnim, 3) then
      TaskPlayAnim(ped, LastStandDict, LastStandAnim, 1.0, 1.0, -1, 1, 0, false, false, false)
    end
  end
end

---@param ped number
local function playLastStandAnimation(ped)
  if IsEscorted then
    playEscortedLastStandAnimation(ped)
  else
    playUnescortedLastStandAnimation(ped)
  end
end

---Player is able to send a notification to EMS there are any on duty
local function handleRequestingEms()
  if DoctorCount == 0 then return end
  if not EmsNotified then
    drawTxt(0.91, 1.40, 1.0, 1.0, 0.6, Lang:t('info.request_help'), 255, 255, 255, 255)
    if IsControlJustPressed(0, 47) then
      exports['ps-dispatch']:InjuriedPerson()
      EmsNotified = true
    end
  else
    drawTxt(0.90, 1.40, 1.0, 1.0, 0.6, Lang:t('info.help_requested'), 255, 255, 255, 255)
  end
end

---@param ped number
local function handleLastStand(ped)
  if LocalPlayer.state.stabilized then
    drawTxt(0.93, 1.44, 1.0, 1.0, 0.6, Lang:t('info.stabilized'), 255, 255, 255, 255)
  elseif LaststandTime > Laststand.MinimumRevive then
    drawTxt(0.94, 1.44, 1.0, 1.0, 0.6, Lang:t('info.bleed_out', { time = math.ceil(LaststandTime) }), 255, 255, 255, 255)
  else
    drawTxt(0.845, 1.44, 1.0, 1.0, 0.6, Lang:t('info.bleed_out_help', { time = math.ceil(LaststandTime) }), 255, 255, 255, 255)
    handleRequestingEms()
  end

  playLastStandAnimation(ped)
end

local function disableControls()
  DisableAllControlActions(0)
  EnableControlAction(0, 1, true)
  EnableControlAction(0, 2, true)
  EnableControlAction(0, 245, true)
  EnableControlAction(0, 38, true)
  EnableControlAction(0, 0, true)
  EnableControlAction(0, 322, true)
  EnableControlAction(0, 288, true)
  EnableControlAction(0, 213, true)
  EnableControlAction(0, 249, true)
  EnableControlAction(0, 46, true)
  EnableControlAction(0, 47, true)
end

---Set dead and last stand states.
CreateThread(function()
  while true do
    if IsDead or InLaststand then
      disableControls()
      if IsDead then
        handleDead(cache.ped)
      elseif InLaststand then
        handleLastStand(cache.ped)
      end
      Wait(0)
    else
      Wait(1000)
    end
  end
end)

RegisterCommand('stab', function()
  LocalPlayer.state:set('stabilized', true, true)
  Wait(5000)

  LocalPlayer.state:set('stabilized', false, true)
end)

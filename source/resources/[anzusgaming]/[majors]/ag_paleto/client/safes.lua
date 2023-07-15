local _onSpot = false
local isMinigame = false
local _SafeCrackingStates = "Setup"
local _requiredDialRotationDirection
local _safeLockStatus
local form
local _initDialRotationDirection
local _safeCombination
local _currentLockNum
local _lastDialRotationDirection
local _currentDialRotationDirection

local function initSafeLocks()
  if not _safeCombination then
    return
  end

  local locks = {}
  for i = 1, #_safeCombination do
    locks[#locks + 1] = true
  end

  return locks
end

local function getCurrentSafeDialNumber(currentDialAngle)
  local number = math.floor(100 * (currentDialAngle / 360))
  if number > 0 then
    number = 100 - number
  end

  return math.abs(number)
end

local function releaseCurrentPin()
  _safeLockStatus[_currentLockNum] = false
  _currentLockNum = _currentLockNum + 1

  if _requiredDialRotationDirection == "Anticlockwise" then
    _requiredDialRotationDirection = "Clockwise"
  else
    _requiredDialRotationDirection = "Anticlockwise"
  end

  PlaySoundFrontend(0, "TUMBLER_PIN_FALL_FINAL", "SAFE_CRACK_SOUNDSET", true)
end

local function stopCracking(safeUnlocked)
  if safeUnlocked then
    PlaySoundFrontend(0, "SAFE_DOOR_OPEN", "SAFE_CRACK_SOUNDSET", true)
  else
    PlaySoundFrontend(0, "SAFE_DOOR_CLOSE", "SAFE_CRACK_SOUNDSET", true)
  end
  isMinigame = false
  SafeCrackingStates = "Setup"
  ClearPedTasksImmediately(cache.ped)
end

local function setSafeDialStartNumber()
  local dialStartNumber = math.random(0, 100)
  SafeDialRotation = 3.6 * dialStartNumber
end

local function relockSafe()
  if not _safeCombination then
    return
  end

  _safeLockStatus = initSafeLocks()
  _currentLockNum = 1
  _requiredDialRotationDirection = _initDialRotationDirection
  _onSpot = false

  for i = 1, #_safeCombination do
    _safeLockStatus[i] = true
  end
end

local function initializeSafe(safeCombination)
  _initDialRotationDirection = "Clockwise"
  _safeCombination = safeCombination

  relockSafe()
  setSafeDialStartNumber()
end

local function drawSprites(drawLocks)
  local textureDict = "MPSafeCracking"
  local _aspectRatio = GetAspectRatio(true)

  DrawSprite(textureDict, "Dial_BG", 0.48, 0.3, 0.3, _aspectRatio * 0.3, 0, 255, 255, 255, 255)
  DrawSprite(textureDict, "Dial", 0.48, 0.3, 0.3 * 0.5, _aspectRatio * 0.3 * 0.5, SafeDialRotation, 255, 255, 255, 255)

  if not drawLocks then
    return
  end

  local xPos = 0.6
  local yPos = (0.3 * 0.5) + 0.035
  for _, lockActive in pairs(_safeLockStatus) do
    local lockString
    if lockActive then
      lockString = "lock_closed"
    else
      lockString = "lock_open"
    end

    DrawSprite(textureDict, lockString, xPos, yPos, 0.025, _aspectRatio * 0.015, 0, 231, 194, 81, 255)
    yPos = yPos + 0.05
  end
end

local function playFx(dict, anim)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Wait(10)
  end

  TaskPlayAnim(cache.ped, dict, anim, 3.0, 3.0, -1, 2, 0, false, false, false)
end

local function rotateSafeDial(rotationDirection)
  if rotationDirection == "Anticlockwise" or rotationDirection == "Clockwise" then
    local multiplier
    local rotationPerNumber = 3.6
    if rotationDirection == "Anticlockwise" then
      multiplier = 1
    elseif rotationDirection == "Clockwise" then
      multiplier = -1
    end

    local rotationChange = multiplier * rotationPerNumber
    SafeDialRotation = SafeDialRotation + rotationChange
    PlaySoundFrontend(0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", true)
  end

  _currentDialRotationDirection = rotationDirection
  _lastDialRotationDirection = rotationDirection
end

local function handleSafeDialMovement()
  if IsControlJustPressed(0, 35) then
    playFx('anim@scripted@heist@ig15_safe_crack@male@', 'input_safe_code_right_player')
    rotateSafeDial("Anticlockwise")
  elseif IsControlJustPressed(0, 34) then
    playFx('anim@scripted@heist@ig15_safe_crack@male@', 'input_safe_code_left_player')
    rotateSafeDial("Clockwise")
  else
    rotateSafeDial("Idle")
  end
end

local function startCracking()
  if _SafeCrackingStates == "Setup" then
    _SafeCrackingStates = "Cracking"
  elseif _SafeCrackingStates == "Cracking" then
    local isDead = GetEntityHealth(cache.ped) <= 101
    if isDead then
      stopCracking(false)
      return false
    end

    if IsControlJustPressed(0, 177) then
      stopCracking(false)
      return false
    end

    if IsControlJustPressed(0, 38) then
      if _onSpot then
        releaseCurrentPin()
        _onSpot = false
        if _safeLockStatus[_currentLockNum] == nil then
          stopCracking(true)
          return true
        end
      else
        stopCracking(false)
        return false
      end
    end

    handleSafeDialMovement()

    local incorrectMovement = _currentLockNum ~= 0 and _requiredDialRotationDirection ~= "Idle" and _currentDialRotationDirection ~= "Idle" and
        _currentDialRotationDirection ~= _requiredDialRotationDirection

    if not incorrectMovement then
      local currentDialNumber = getCurrentSafeDialNumber(SafeDialRotation)
      local correctMovement = _requiredDialRotationDirection ~= "Idle" and
          (_currentDialRotationDirection == _requiredDialRotationDirection or _lastDialRotationDirection == _requiredDialRotationDirection)
      if correctMovement then
        local pinUnlocked = _safeLockStatus[_currentLockNum] and currentDialNumber == _safeCombination[_currentLockNum]
        if pinUnlocked then
          PlaySoundFrontend(0, "TUMBLER_PIN_FALL", "SAFE_CRACK_SOUNDSET", true)
          _onSpot = true
        end
      end
    elseif incorrectMovement then
      _onSpot = false
    end
  end
end

local function buttonMessage(text)
  BeginTextCommandScaleformString("STRING")
  AddTextComponentSubstringKeyboardDisplay(text)
  EndTextCommandScaleformString()
end

local function button(ControlButton)
  N_0xe83a3e3557a56640(ControlButton)
end

local function setupScaleform(scaleform)
  local scaleform = RequestScaleformMovie(scaleform)
  while not HasScaleformMovieLoaded(scaleform) do
    Wait(0)
  end

  -- draw it once to set up layout
  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 0, 0)

  BeginScaleformMovieMethod(scaleform, "CLEAR_ALL")
  EndScaleformMovieMethod()

  BeginScaleformMovieMethod(scaleform, "SET_CLEAR_SPACE")
  ScaleformMovieMethodAddParamInt(200)
  EndScaleformMovieMethod()

  BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
  ScaleformMovieMethodAddParamInt(0)
  button(GetControlInstructionalButton(2, 35, true))
  buttonMessage("Turn right")
  EndScaleformMovieMethod()

  BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
  ScaleformMovieMethodAddParamInt(1)
  button(GetControlInstructionalButton(2, 34, true))
  buttonMessage("Turn left")
  EndScaleformMovieMethod()

  BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
  ScaleformMovieMethodAddParamInt(2)
  button(GetControlInstructionalButton(2, 38, true))
  buttonMessage("Confirm")
  EndScaleformMovieMethod()

  BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
  ScaleformMovieMethodAddParamInt(3)
  button(GetControlInstructionalButton(2, 177, true))
  buttonMessage("Exit")

  EndScaleformMovieMethod()

  BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
  EndScaleformMovieMethod()

  BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_COLOUR")
  ScaleformMovieMethodAddParamInt(0)
  ScaleformMovieMethodAddParamInt(0)
  ScaleformMovieMethodAddParamInt(0)
  ScaleformMovieMethodAddParamInt(80)
  EndScaleformMovieMethod()

  return scaleform
end

function CreateSafe(combination)
  local res
  isMinigame = not isMinigame
  RequestStreamedTextureDict("MPSafeCracking", false)
  RequestAmbientAudioBank("SAFE_CRACK", false)
  if isMinigame then
    initializeSafe(combination)
    form = setupScaleform("instructional_buttons")
    while isMinigame do
      drawSprites(true)
      DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
      res = startCracking()
      if res or res == false then
        return res
      end
      Wait(0)
    end
  end
end

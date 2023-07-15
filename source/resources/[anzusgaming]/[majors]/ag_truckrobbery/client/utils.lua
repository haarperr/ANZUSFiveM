local utils = {}

---@param event string
---@param fn function
function utils.registerNetEvent(event, fn)
  RegisterNetEvent(event, function(...)
    if source ~= '' then fn(...) end
  end)
end

---@param entity number
---@param bool boolean
function utils.setBusy(entity, bool)
  Entity(entity).state:set('isTruckBusy', bool, true)
end

---@param entity number
---@param bool boolean
function utils.setRobbed(entity, bool)
  Entity(entity).state:set('isTruckRobbed', bool, true)
end

---@param entity number
---@param bool boolean
function utils.setCanTruckBeRobbed(entity, bool)
  Entity(entity).state:set('canTruckBeRobbed', bool, true)
end

---@param entity number
---@return boolean
function utils.isBusy(entity)
  return Entity(entity).state.isTruckBusy or false
end

---@param entity number
---@return boolean
function utils.isRobbed(entity)
  return Entity(entity).state.isTruckRobbed or false
end

---@param entity number
---@return boolean
function utils.canTruckBeRobbed(entity)
  return Entity(entity).state.canTruckBeRobbed or false
end

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

---@param s number
---@return string
function utils.s2m(s)
  if s <= 0 then
    return "00:00"
  else
    local m = string.format("%02.f", math.floor(s / 60))
    return m .. ":" .. string.format("%02.f", math.floor(s - m * 60))
  end
end

---@param title string
---@param text string
function utils.drawTimerBar(title, text)
  local titleColor = { 255, 255, 255, 255 }
  local textColor = { 255, 255, 255, 255 }
  local titleScale = 0.3
  local titleFont = 0
  local titleFontOffset = 0.0

  local yOffset = timerBar.baseY - (1 * timerBar.baseGap)

  if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
    lib.requestStreamedTextureDict(timerBar.txtDict)
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

return utils

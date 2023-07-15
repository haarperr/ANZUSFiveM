local cooldown = false
local allowedBank = 0

function OnCooldown()
  return cooldown
end

function CanRobBank(bank)
  return cooldown and allowedBank == bank
end

function SetAllowedBank(bank)
  allowedBank = bank
end

---@param bool boolean
---@param bank? number
function SetCooldown(bool, bank)
  if bool and not cooldown and bank then
    allowedBank = bank
    CreateThread(function()
      cooldown = true
      Wait(Config.Cooldown)
      SetCooldown(false)
    end)
  else
    allowedBank = 0
  end

  GlobalState:set('fleecaData', { cooldown = bool, allowedBank = allowedBank }, true)
end

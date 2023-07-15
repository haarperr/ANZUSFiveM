local ox_target = exports.ox_target
local ox_inventory = exports.ox_inventory
local activeRegister = false
local activeComputer = false
local activeSafe = false
local conditionsMet = false
local generatedCode = nil
local safePin = nil
local wrongPIN = 0
local failedHack = 0
local verifyReward = false
local registeredCoords = {}

-- Function that runs after all conditions have been met
local function initiateRegisterRobbery()
  -- Conditions have not been met from the above function
  if not conditionsMet then return end
  local cooldown = GlobalState.registerCooldown
  if cooldown then
    -- A cooldown is currently active, so the robbery will not proceed
    lib.notify({ id = 'registerCooldown', title = Notify.title, description = Notify.registerCooldown, icon = Notify.icon, type = 'error', position = Notify.position })
    activeRegister = false
    return
  end

  local success = lib.skillCheck(Config.RegisterDiffuculty, Config.RegisterInput)
  if not success then
    -- Player failed to successfully lockpick the register, so a chance at breaking happens below
    local lockpickBreakChance = math.random(1, 100)
    if lockpickBreakChance <= Config.LockpickBreakChance then
      -- lib.callback('lation_247robbery:removeItem', false, source, Config.RegisterRobberyItem, 1)
      lib.notify({ id = 'lockpickBroke', title = Notify.title, description = Notify.lockpickBroke, icon = Notify.icon, type = 'error', position = Notify.position })
    end
    activeRegister = false
    return
  end

  -- Add your dispatch system/notification here
  exports['ps-dispatch']:StoreRobbery()
  if lib.progressCircle({
        label = ProgressCircle.registerLabel,
        duration = ProgressCircle.registerDuration,
        position = ProgressCircle.position,
        useWhileDead = false,
        canCancel = true,
        disable = { car = true, move = true, combat = true },
        anim = { dict = 'anim@heists@ornate_bank@grab_cash', clip = 'grab' }
      }) then
    local codeChance = math.random(1, 100)
    if codeChance > Config.CodeChance then
      -- No code was received, player must proceed by hacking the PC
      -- Player gets rewarded, cooldown begins
      -- The computer becomes available, player must simply complete a hack to proceed
      activeComputer = true
      verifyReward = true
      local reward = lib.callback.await('lation_247robbery:registerSuccessful', false, verifyReward)
      if reward then
        verifyReward = false
      else
        -- Kick/drop player? Potential cheating?
        verifyReward = false
      end
      return
    end
    generatedCode = math.random(1111, 9999)
    safePin = generatedCode
    local note = lib.alertDialog({
      header = AlertDialog.registerHeader,
      content = AlertDialog.registerContent .. generatedCode,
      centered = true,
      cancel = true,
      labels = {
        cancel = AlertDialog.registerCancelButton,
        confirm = AlertDialog.registerConfirmButton
      }
    })

    if note ~= 'confirm' then
      -- Player responded "Who Cares?" to the code they received, so robbery ends (meme'd)
      -- Player is not rewarded
      -- Cooldown is not activated
      activeRegister = false
      return
    end

    -- Code was received, robbery proceeds
    -- Player gets rewarded, cooldown begins
    -- The safe becomes available, player must simply input the code to unlock
    activeSafe = true
    verifyReward = true
    local reward = lib.callback.await('lation_247robbery:registerSuccessful', false, verifyReward)
    if reward then
      verifyReward = false
    else
      -- Kick/drop player? Potential cheating?
      verifyReward = false
    end
  else
    -- Player cancelled the cash register robbery progress, so robbery ends
    -- Player is not rewarded
    -- Cooldown is not activated
    activeRegister = false
    lib.notify({ id = 'robberyCancel', title = Notify.title, description = Notify.robberyCancel, icon = Notify.icon, type = 'error', position = Notify.position })
  end
end

-- Function that checks that all conditions have been met before proceeding
local function checkConditions()
  if not Config.RequirePolice then
    local hasItem = ox_inventory:Search('count', Config.RegisterRobberyItem)
    if hasItem >= 1 then
      conditionsMet = true
      initiateRegisterRobbery()
    else
      conditionsMet = false
      activeRegister = false
      lib.notify({ id = 'itemMissing', title = Notify.title, description = Notify.missingItem, icon = Notify.icon, type = 'error', position = Notify.position })
    end
    return
  end

  local policeCount = exports.ag_misc:getDuty('leo')
  if policeCount < Config.PoliceCount then
    conditionsMet = false
    activeRegister = false
    lib.notify({ id = 'policeMissing', title = Notify.title, description = Notify.notEnoughPolice, icon = Notify.icon, type = 'error', position = Notify.position })
    return
  end

  local hasItem = ox_inventory:Search('count', Config.RegisterRobberyItem)
  if hasItem == 0 then
    conditionsMet = false
    activeRegister = false
    lib.notify({ id = 'itemMissing', title = Notify.title, description = Notify.missingItem, icon = Notify.icon, type = 'error', position = Notify.position })
    return
  end

  conditionsMet = true
  initiateRegisterRobbery()
end

-- Function that runs after the register robbery if necessary
local function initiateComputerHack()
  activeComputer = false                      -- Deactivates target option
  if failedHack > Config.MaxHackAttempts then -- Player has failed the hack too many times, robbery ends/restarts
    activeRegister = false
    activeComputer = false
    failedHack = 0
    lib.notify({ id = 'tooManyHackFails', title = Notify.title, description = Notify.tooManyHackFails, icon = Notify.icon, type = 'error', position = Notify.position })

    return
  end
  lib.requestAnimDict('anim@heists@prison_heiststation@cop_reactions', 100)
  TaskPlayAnim(cache.ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
  if Config.EnableQuestionnaire then
    local questions = {}
    local answers = {}

    local amount = 0
    local done = {}
    repeat
      local rndIndex = math.random(Config.TotalQuestions)

      repeat
        rndIndex = math.random(Config.TotalQuestions)
      until not done[rndIndex]

      local value = Config.Questions['question' .. rndIndex]
      done[rndIndex] = true
      amount += 1

      if value.options then
        local options = {}
        for ka, v2 in pairs(value.options) do
          options[#options + 1] = { value = tostring(ka), label = v2 }
        end

        questions[#questions + 1] = {
          type = 'select',
          title = ('Question %d'):format(amount),
          required = true,
          icon = value.icon,
          description = value.question,
          options = options
        }
      else
        questions[#questions + 1] = {
          type = 'input',
          title = ('Question %d'):format(amount),
          description = value.question,
          required = true,
          icon = value.icon
        }
      end
      answers[#answers + 1] = 'question' .. rndIndex
    until amount == 4

    local input = lib.inputDialog('Security Questions', questions)

    if not input then
      ClearPedTasks(cache.ped)
      activeComputer = true
      failedHack = failedHack + 1
      lib.notify({ id = 'failedHack', title = Notify.title, description = Notify.failedHack, icon = Notify.icon, type = 'error', position = Notify.position })
      return
    end

    local can = false
    for index, value in ipairs(input) do
      local answer = Config.Questions[answers[index]].answer
      if string.lower(value) == answer then
        can = true
      else
        can = false
      end
    end

    ClearPedTasks(cache.ped)
    exports['ps-dispatch']:StoreRobbery()

    if not can then
      activeComputer = true
      failedHack = failedHack + 1
      lib.notify({ id = 'failedHack', title = Notify.title, description = Notify.failedHack, icon = Notify.icon, type = 'error', position = Notify.position })
      return
    end

    failedHack = 0
    ClearPedTasks(cache.ped)
    generatedCode = math.random(1111, 9999)
    safePin = generatedCode
    lib.alertDialog({
      header = AlertDialog.computerHeader,
      content = AlertDialog.computerContent .. generatedCode,
      centered = true,
      cancel = false,
      labels = {
        confirm = AlertDialog.computerConfirmButton
      }
    })
    activeSafe = true
  else
    local success = lib.skillCheck(Config.ComputerDifficulty, Config.ComputerInput)
    if success then -- Player passes the hack
      failedHack = 0
      ClearPedTasks(cache.ped)
      generatedCode = math.random(1111, 9999)
      safePin = generatedCode
      lib.alertDialog({
        header = AlertDialog.computerHeader,
        content = AlertDialog.computerContent .. generatedCode,
        centered = true,
        cancel = false,
        labels = {
          confirm = AlertDialog.computerConfirmButton
        }
      })
      activeSafe = true
    else -- Player failed the hack
      ClearPedTasks(cache.ped)
      activeComputer = true
      failedHack = failedHack + 1
      lib.notify({ id = 'failedHack', title = Notify.title, description = Notify.failedHack, icon = Notify.icon, type = 'error', position = Notify.position })
    end


    exports['ps-dispatch']:StoreRobbery()
  end
end

-- Function that runs after a successful register robbery and/or computer hacking
local function initiateSafeRobbery()
  activeSafe = false -- Deactivates target option
  if wrongPIN >= Config.MaxCodeAttempts then
    activeRegister = false
    activeSafe = false
    wrongPIN = 0
    lib.notify({ id = 'tooManyFails', title = Notify.title, description = Notify.tooManySafeFails, icon = Notify.icon, type = 'error', position = Notify.position })

    return
  end

  local inputCode = lib.inputDialog('Store Safe', {
    { type = 'input', label = 'Enter PIN', description = 'Input the PIN to unlock the safe', placeholder = '6969', icon = 'lock', required = true, min = 4, max = 16 },
  })
  local convertedCode = tonumber(inputCode[1])
  if convertedCode ~= safePin then -- Wrong PIN
    wrongPIN = wrongPIN + 1
    activeSafe = true
    lib.notify({ id = 'wrongPIN', title = Notify.title, description = Notify.wrongPin, icon = Notify.icon, type = 'error', position = Notify.position })
    exports['ps-dispatch']:StoreRobbery()
    -- Add another dispatch notification here, if desired
  elseif convertedCode == safePin then -- Correct PIN
    activeSafe = false
    wrongPIN = 0
    if lib.progressCircle({
          label = ProgressCircle.safeLabel,
          duration = ProgressCircle.safeDuration,
          position = ProgressCircle.position,
          useWhileDead = false,
          canCancel = true,
          disable = { car = true, move = true, combat = true },
          anim = { dict = 'anim@heists@ornate_bank@grab_cash', clip = 'grab' }
        }) then
      activeRegister = false
      verifyReward = true
      local reward = lib.callback.await('lation_247robbery:safeSuccessful', false, verifyReward)
      if reward then
        verifyReward = false
      else
        -- Kick/drop player? Potential cheating?
        verifyReward = false
      end
    end
  else -- Something went wrong
    lib.notify({ id = 'wrongPIN', title = Notify.title, description = Notify.errorOccured, icon = Notify.icon, type = 'error', position = Notify.position })
  end
end

-- Creates all the targets for the registers noted in the Config
for k, v in pairs(Config.Locations.Registers) do
  ox_target:addSphereZone({
    name = 'cash_register' .. k,
    coords = v,
    radius = 0.35,
    debug = Target.debugTargets,
    options = {
      {
        icon = Target.registerIcon,
        label = Target.registerLabel,
        canInteract = function()
          if activeRegister then
            return false
          else
            return true
          end
        end,
        onSelect = function()
          activeRegister = true
          checkConditions()
        end,
        distance = 2
      }
    },
  })
end

-- Creates all the targets for the computers noted in the Config
for k, v in pairs(Config.Locations.Computers) do
  ox_target:addSphereZone({
    name = 'computer' .. k,
    coords = v,
    radius = 0.35,
    debug = Target.debugTargets,
    options = {
      {
        icon = Target.computerIcon,
        label = Target.computerLabel,
        canInteract = function()
          if activeComputer then
            return true
          else
            return true
          end
        end,
        onSelect = function()
          initiateComputerHack()
        end,
        distance = 2
      }
    },
  })
end

-- Creates all the targets for the safes noted in the Config
for k, v in pairs(Config.Locations.Safes) do
  ox_target:addSphereZone({
    name = 'safe' .. k,
    coords = v,
    radius = 0.45,
    debug = Target.debugTargets,
    options = {
      {
        icon = Target.safeIcon,
        label = Target.safeLabel,
        canInteract = function()
          if GlobalState.safeCooldown then return false end
          if activeSafe then
            return true
          else
            return false
          end
        end,
        onSelect = function()
          initiateSafeRobbery()
        end,
        distance = 2
      }
    },
  })
end

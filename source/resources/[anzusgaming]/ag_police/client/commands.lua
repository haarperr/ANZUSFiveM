local licenseOptions = {
  grant = {
    { value = 'firearm', label = 'Firearm' },
  },
  revoke = {
    { value = 'firearm', label = 'Firearm' },
    { value = 'driver',  label = 'Driver' },
  }
}

---@param header string
---@param text string
---@return boolean
local function ConfirmDialog(header, text)
  local confirm = lib.alertDialog({
    header = header,
    content = text,
    cancel = true,
    centered = true
  })

  if confirm == 'cancel' then
    lib.notify({ type = 'error', title = 'Law Enforcement', description = 'Cancelled' })
    return false
  end

  return true
end

local function JailPlayer(source)
  if Job.type ~= 'leo' then return end
  if not Job.onduty then return end
  local input = lib.inputDialog('Jail Player', {
    { type = 'input',  label = 'Citizen ID', required = true },
    { type = 'number', label = 'Months',     max = 360,      required = true },
    { type = 'input',  label = 'Reason',     required = true }
  })

  if not input then return end
  local stateId = input[1]
  local months = input[2]
  local reason = input[3]

  local playerName = lib.callback.await('ag_police:getNameFromStateID', 200, stateId)
  if playerName == nil then
    return lib.notify({
      type = 'error',
      title = 'Law Enforcement',
      description = 'Player not online'
    })
  end

  if not ConfirmDialog('Confirmation of Sentence', string.format('Please confirm you want to jail %s for %d months', playerName, months)) then return end

  local res = lib.callback.await('ag_police:jailPlayer', 200, { stateId = stateId, months = months, reason = reason })
  if not res.success then return lib.notify({ type = 'error', title = 'Law Enforcement', description = res.message }) end

  lib.notify({ type = 'success', title = 'Law Enforcement', description = res.message })
end

local function FineCommand(source)
  if Job.type ~= 'leo' then return end
  if not Job.onduty then return end
  local input = lib.inputDialog('Fine Player', {
    { type = 'input',  label = 'Citizen ID', required = true },
    { type = 'number', label = 'Amount',     max = 100000,   required = true },
    { type = 'input',  label = 'Reason',     required = true }
  })

  if not input then return end
  local stateId = input[1]
  local amount = input[2]
  local reason = input[3]

  local playerName = lib.callback.await('ag_police:getNameFromStateID', 200, stateId)
  if playerName == nil then
    return lib.notify({
      type = 'error',
      title = 'Law Enforcement',
      description = 'Player not online'
    })
  end

  if not ConfirmDialog('Confirmation of Fine', string.format('Please confirm you want to fine %s for $%d', playerName, amount)) then return end

  local success = lib.callback.await('ag_police:finePlayer', 200,
    { stateId = stateId, amount = amount, reason = reason })
  if not success then
    return lib.notify({
      type = 'error',
      title = 'Law Enforcement',
      description = 'Player has insufficient funds'
    })
  end

  lib.notify({ type = 'success', title = 'Law Enforcement', description = 'Successfully fined' })
end

local function ManageLicense(source, action)
  if Job.type ~= 'leo' and Job.name ~= 'doj' then return end
  if Job.type ~= 'leo' and Job.grade.level < 20 then return end
  if not Job.onduty then return end

  local title = (action == 'grant') and 'Grant License' or 'Revoke License'
  local confirmText = 'Please confirm you want to ' .. action .. ' this license'

  local input = lib.inputDialog(title, {
    { type = 'input',  label = 'Citizen ID', required = true },
    { type = 'select', label = 'License',    options = licenseOptions[action], required = true },
  })

  if not input then return end
  local stateId = input[1]
  local license = input[2]

  if confirmText and not ConfirmDialog('San Andreas Government', confirmText) then return end

  lib.callback('ag_police:licenseControl', false, function(success)
    if not success then
      local errorMessage = (action == 'grant') and 'Unable to issue license' or 'Unable to revoke license'
      return lib.notify({ type = 'error', title = 'Law Enforcement', description = errorMessage })
    end

    local successMessage = (action == 'grant') and ('Successfully given a %s license'):format(license) or
        ('Successfully revoked %s license'):format(license)
    lib.notify({ type = 'success', title = 'Law Enforcement', description = successMessage })
  end, { type = action, stateId = stateId, license = license })
end

local function Whitelist(source)
  if Job.type ~= 'leo' and Job.grade.level < 40 then return end
  if not Job.onduty then return end
  local input = lib.inputDialog('Whitelist Player', {
    { type = 'input',  label = 'Citizen ID', required = true },
    { type = 'number', label = 'Grade',      max = Job.grade.level - 10, required = true },
    { type = 'input',  label = 'Reason',     required = true }
  })

  if not input then return end
  local stateId = input[1]
  local grade = input[2]
  local reason = input[3]

  if not ConfirmDialog('Confirmation of Whitelist', string.format('Please confirm you want to whitelist %s for %d', stateId, grade)) then return end
  local success = lib.callback.await('ag_police:whitelistPlayer', 200,
    { stateId = stateId, grade = grade, reason = reason })
  if not success then
    return lib.notify({
      type = 'error',
      title = 'Law Enforcement',
      description = 'Unable to issue whitelist'
    })
  end

  lib.notify({ type = 'success', title = 'Law Enforcement', description = 'Successfully whitelisted' })
end

local function DeWhitelist(source)
  if Job.type ~= 'leo' and Job.grade.level < 50 then return end
  if not Job.onduty then return end
  local input = lib.inputDialog('DeWhitelist Player', {
    { type = 'input', label = 'Citizen ID', required = true },
    { type = 'input', label = 'Reason',     required = true }
  })

  if not input then return end
  local stateId = input[1]
  local reason = input[2]

  if not ConfirmDialog('Confirmation of Whitelist', string.format('Please confirm you want to dewhitelist %s for %s', stateId, reason)) then return end
  local success = lib.callback.await('ag_police:deWhitelistPlayer', 200, { stateId = stateId, reason = reason })
  if not success then
    return lib.notify({
      type = 'error',
      title = 'Law Enforcement',
      description = 'Unable to issue dewhitelist'
    })
  end

  lib.notify({ type = 'success', title = 'Law Enforcement', description = 'Successfully dewhitelisted' })
end

local function unJail(source)
  if Job.type ~= 'leo' then return end
  if not Job.onduty then return end
  local input = lib.inputDialog('UnJail Player', {
    { type = 'input', label = 'Citizen ID', required = true },
    { type = 'input', label = 'Reason',     required = true }
  })

  if not input then return end
  local stateId = input[1]
  local reason = input[2]

  local playerName = lib.callback.await('ag_police:getNameFromStateID', 200, stateId)
  if playerName == nil then
    return lib.notify({
      type = 'error',
      title = 'Law Enforcement',
      description = 'Player not online'
    })
  end

  if not ConfirmDialog('Confirmation of Sentence Vacation', string.format('Please confirm you want to unjail %s', playerName)) then return end

  local res = lib.callback.await('ag_police:unJailPlayer', 200, { stateId = stateId, reason = reason })
  if not res.success then return lib.notify({ type = 'error', title = 'Law Enforcement', description = res.message }) end

  lib.notify({ type = 'success', title = 'Law Enforcement', description = res.message })
end

function SetupCommands()
  RegisterCommand('fine', FineCommand)
  RegisterCommand('jail', JailPlayer)
  RegisterCommand('whitelist', Whitelist)
  RegisterCommand('dewhitelist', DeWhitelist)
  RegisterCommand('unjail', unJail)
  RegisterCommand('grantlicense', function(source, args, raw)
    ManageLicense(source, 'grant')
  end)
  RegisterCommand('revokelicense', function(source, args, raw)
    ManageLicense(source, 'revoke')
  end)

  TriggerEvent('chat:addSuggestion', 'fine', "Issue a Fine")
  TriggerEvent('chat:addSuggestion', 'jail', "Send someone to Jail")
  TriggerEvent('chat:addSuggestion', 'unjail', "Release someone from Jail")
  TriggerEvent('chat:addSuggestion', 'whitelist', "Whitelist for Police")
  TriggerEvent('chat:addSuggestion', 'dewhitelist', "Remove Whitelist for Police")
  TriggerEvent('chat:addSuggestion', 'grantlicense', "Issue a License")
  TriggerEvent('chat:addSuggestion', 'revokelicense', "Revoke a License")
end

function RemoveCommands()
  TriggerEvent('chat:removeSuggestion', '/fine')
  TriggerEvent('chat:removeSuggestion', '/jail')
  TriggerEvent('chat:removeSuggestion', '/unjail')
  TriggerEvent('chat:removeSuggestion', '/whitelist')
  TriggerEvent('chat:removeSuggestion', '/dewhitelist')
end

---@class finePlayerProps
---@field stateId string;
---@field amount number;
---@field reason string;

---@param data finePlayerProps
lib.callback.register('ag_police:finePlayer', function(source, data)
  local Issuer = QBCore.Functions.GetPlayer(source).PlayerData
  if Issuer.job.type ~= 'leo' then return false end

  local Target = QBCore.Functions.GetPlayerByCitizenId(data.stateId).PlayerData
  local balance = exports.pefcl:getDefaultAccountBalance(Target.source)

  if balance.data - data.amount < 0 then
    return false
  end

  local res = exports.pefcl:forcePayInvoice(Target.source, {
    to = 'San Andreas Law Enforcement | Fine Brueo',
    toIdentifier = data.stateId,
    from = 'San Andreas Law Enforcement',
    fromIdentifier = data.stateId,
    amount = data.amount,
    message = data.reason,
    receiverAccountIdentifier = 'lspd'
  })

  if res.status == 'error' then return false end


  lib.logger(source, 'finePlayer',
    ('Fined %s for %d with reason %s'):format(Target.citizenid, data.amount, data.reason))

  TriggerClientEvent('ox_lib:alertDialog', Target.source, {
    header = 'Fine Issued',
    content = string.format('You have been force fined $%d by %s for the following reason: %s', data.amount, Issuer.fullname, data.reason),
    centered = true
  })

  return true
end)

---@class jailPlayerProps
---@field stateId string;
---@field months number;
---@field reason string;

---@param data jailPlayerProps
lib.callback.register('ag_police:jailPlayer', function(source, data)
  local Issuer = QBCore.Functions.GetPlayer(source).PlayerData
  local Target = QBCore.Functions.GetPlayerByCitizenId(data.stateId).PlayerData

  if not Issuer or not Target or Issuer.job.type ~= "leo" then
    return { success = false }
  end

  local playerPed = GetPlayerPed(source)
  local targetPed = GetPlayerPed(Target.source)
  local playerCoords = GetEntityCoords(playerPed)
  local targetCoords = GetEntityCoords(targetPed)

  if #(playerCoords - targetCoords) > 2.5 then
    return { success = false, message = 'You must be within 2 meters of the target' }
  end

  local currentDate = os.date("*t")
  if currentDate.day == 31 then
    currentDate.day = 30
  end

  local target = Player(Target.source).state

  target:set('inJail', data.months, true)
  target:set('isCuffed', false, true)
  target:set('isEscorted', false, true)
  target:set('cuffType', 'NONE', true)
  target:set('isZiptied', false, true)

  lib.logger(source, 'jailPlayer',
    ('Jailed %s for %d with reason %s'):format(Target.citizenid, data.months, data.reason))
  return { success = true, message = string.format('You sent the person to prison for %d months', data.months) }
end)

---@class unJailPlayerProps
---@field stateId string;
---@field reason string;

---@param data unJailPlayerProps
lib.callback.register('ag_police:unJailPlayer', function(source, data)
  local Issuer = QBCore.Functions.GetPlayer(source).PlayerData
  local Target = QBCore.Functions.GetPlayerByCitizenId(data.stateId)

  if not Issuer or not Target or Issuer.job.type ~= "leo" then
    return { success = false }
  end

  if Target.PlayerData.injail == 0 then return { success = false } end

  local target = Player(Target.PlayerData.source).state

  target:set('inJail', 0, true)
  target:set('isCuffed', false, true)
  target:set('isEscorted', false, true)
  target:set('cuffType', 'NONE', true)
  target:set('isZiptied', false, true)

  TriggerClientEvent('prison:client:leaveJail', Target.PlayerData.source)

  lib.logger(source, 'unJailPlayer',
    ('Unjailed %s with reason %s'):format(Target.PlayerData.citizenid, data.reason))
  return { success = true, message = string.format('You have successfully unjailed %s', Target.PlayerData.citizenid) }
end)

---@param source any
---@param data {stateId: string, grade: number, reason: string}
lib.callback.register('ag_police:whitelistPlayer', function(source, data)
  local Issuer = Player(source).state
  if Issuer.job.type ~= 'leo' or Issuer.job.grade.level <= data.grade then return false end

  local jobs = exports['ps-multijob']:GetJobs(data.stateId)
  if not jobs or not jobs['lspd'] then
    exports['ps-multijob']:AddJob(data.stateId, 'lspd', data.grade, {})
    lib.logger(source, 'whitelistPlayer',
      ('Whitelisted %s for %s with grade %d with reason %s'):format(data.stateId, 'lspd', data.grade, data.reason))
    return true
  end

  if tonumber(jobs['lspd'].grade) >= Issuer.job.grade.level then return false end

  local target = QBCore.Functions.GetPlayerByCitizenId(data.stateId)
  if target then
    if target.PlayerData.job.name == 'lspd' then
      target.Functions.SetJob('lspd', data.grade)
    end
  end

  exports['ps-multijob']:AddJob(data.stateId, 'lspd', data.grade)

  lib.logger(source, 'whitelistPlayer',
    ('Whitelisted %s for %s with grade %s and they were at grade %s with reason %s'):format(data.stateId, 'lspd', tostring(data.grade), tostring(jobs['lspd'].grade), data.reason))
  return true
end)

---@param source any
---@param data {stateId: string, reason: string}
lib.callback.register('ag_police:deWhitelistPlayer', function(source, data)
  local Issuer = Player(source).state
  if Issuer.job.type ~= 'leo' then return false end

  local jobs = exports['ps-multijob']:GetJobs(data.stateId)

  if (jobs and tonumber(jobs['lspd'].grade) >= Issuer.job.grade.level) or not jobs then
    return false
  end

  local target = QBCore.Functions.GetPlayerByCitizenId(data.stateId)
  if target then
    if target.PlayerData.job.name == 'lspd' then
      target.Functions.SetJob('unemployed', 0)
    end
  end

  exports['ps-multijob']:RemoveJob(data.stateId, 'lspd')
  lib.logger(source, 'deWhitelistPlayer',
    ('Dewhitelisted %s for %s and they were at grade %s with reason %s'):format(data.stateId, 'lspd', jobs['lspd'].grade, data.reason))
  return true
end)

lib.callback.register('ag_police:licenseControl', function(source, data)
  local Issuer = QBCore.Functions.GetPlayer(source)

  if Issuer.PlayerData.job.type ~= 'leo' and Issuer.PlayerData.job.name ~= 'doj' then return false end
  if Issuer.PlayerData.job.type == 'leo' and Issuer.PlayerData.job.grade.level < 20 then return false end
  local target = QBCore.Functions.GetPlayerByCitizenId(data.stateId)

  if not target then return false end
  if data.license ~= 'firearm' and data.license ~= 'driver' then return false end

  if data.type == 'grant' then
    if target.PlayerData.metadata.licences[data.license] then return false end

    local id = MySQL.insert.await('INSERT INTO `licenses` (issuedByIdent, issuedToIdent, type, issuedOn) VALUES (?, ?, ?, ?)',
      { Issuer.PlayerData.citizenid, target.PlayerData.citizenid, data.license, os.date('%Y-%m-%d %H:%M:%S') })

    if id == 0 then return false end

    target.PlayerData.metadata.licences[data.license] = true
    target.Functions.SetMetaData('licences', target.PlayerData.metadata.licences)
    TriggerClientEvent('QBCore:Notify', source,
      'Granted ' .. data.license .. ' license to ' .. target.PlayerData.charinfo.firstname .. ' ' .. target.PlayerData.charinfo.lastname .. ' on ' .. os.date('%Y-%m-%d %H:%M:%S'))
    TriggerClientEvent('QBCore:Notify', target.PlayerData.source, 'You have been granted ' .. data.license .. ' license')
    return true
  elseif data.type == 'revoke' then
    if not target.PlayerData.metadata.licences[data.license] then return false end

    MySQL.query.await('DELETE FROM licenses WHERE issuedToIdent = ?', { target.PlayerData.citizenid })
    target.PlayerData.metadata.licences[data.license] = false
    target.Functions.SetMetaData('licences', target.PlayerData.metadata.licences)
    TriggerClientEvent('QBCore:Notify', source, 'Removed ' .. data.license .. ' license from ' .. target.PlayerData.charinfo.firstname .. ' ' .. target.PlayerData.charinfo.lastname)
    TriggerClientEvent('QBCore:Notify', target.PlayerData.source,
      'Your ' .. data.license .. ' license is revoked on ' .. os.date('%Y-%m-%d %H:%M:%S') .. ' by ' ..
      Issuer.PlayerData.charinfo.firstname .. ' ' .. Issuer.PlayerData.charinfo.lastname)
    return true
  end

  return false
end)

local function GetVirtualLicense(ident, type)
  local result = MySQL.single.await([[
      SELECT
        l.*,
        COALESCE(CONCAT(JSON_UNQUOTE(JSON_EXTRACT(issuer_character.`charinfo`, '$.firstname')), ' ',
        JSON_UNQUOTE(JSON_EXTRACT(issuer_character.`charinfo`, '$.lastname'))
        ), 'Unidentified') as issuer_name,
        CONCAT(JSON_UNQUOTE(JSON_EXTRACT(to_character.`charinfo`, '$.firstname')),
        ' ', JSON_UNQUOTE(JSON_EXTRACT(to_character.`charinfo`, '$.lastname'))) as to_name
      FROM
        `licenses` l
        LEFT JOIN `characters` issuer_character ON l.`issuedByIdent` = issuer_character.`citizenid`
        JOIN `characters` to_character ON l.`issuedToIdent` = to_character.`citizenid`
      WHERE
        l.`issuedToIdent` = ?
        AND l.`type` =  ?
      LIMIT
        1
        ]], {
    ident, type
  })
  if not result then return false end
  if result then return result end
end

exports('GetVirtualLicense', GetVirtualLicense)

local function GetPhysicalLicence(ident, type)
  local virtual = GetVirtualLicense(ident, type)
  if not virtual then return false end

  local Player = QBCore.Functions.GetPlayerByCitizenId(ident)
  if not Player then return false end

  local item = exports.ox_inventory:GetItem(Player.PlayerData.source, LicenseItemNames[type], nil, false)
  if item and item.metadata.issuedByIdent == virtual.issuedByIdent then return item end
  return false
end

exports('GetPhysicalLicence', GetPhysicalLicence)

QBCore = exports['qb-core']:GetCoreObject()
Accounts = {}

---@param src number
---@param accountName string
---@param type 'job'|'gang'
---@return table?
function GetEmployees(src, accountName, type)
  local player = QBCore.Functions.GetPlayer(src)

  if not player.PlayerData[type].isboss then
    lib.logger(src, 'GetEmployees', ('Potential exploit %s (%s) is not set to boss'):format(type, player.PlayerData[type].name))
    return
  end

  local employees = {}
  local players = MySQL.query.await(([[SELECT c.citizenid, c.charinfo, JSON_UNQUOTE(JSON_EXTRACT(cj.`jobdata`, '$.lspd.grade')) AS job_grade
  FROM `character_jobs` cj
  JOIN `characters` c ON cj.`citizenid` = c.`citizenid`
  WHERE JSON_EXTRACT(jobdata, '$.%s.grade') IS NOT NULL;]]):format(accountName), {})
  if not players then return {} end
  for _, value in pairs(players) do
    local isOnline = QBCore.Functions.GetPlayerByCitizenId(value.citizenid)

    if isOnline then
      employees[#employees + 1] = {
        empSource = isOnline.PlayerData.citizenid,
        grade = isOnline.PlayerData[type].grade,
        isboss = isOnline.PlayerData[type].isboss,
        name = '🟢' .. isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname
      }
    else
      local g = QBCore.Shared.Jobs[accountName].grades[tonumber(value.job_grade)]
      if g then
        g.level = tonumber(value.job_grade)
        employees[#employees + 1] = {
          empSource = value.citizenid,
          grade = g,
          isboss = QBCore.Shared.Jobs[accountName].grades[tonumber(value.job_grade)].isboss,
          name = '❌' .. json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
        }
      end
    end
  end
  table.sort(employees, function(a, b)
    return a.grade.level > b.grade.level
  end)
  return employees
end

---@param src number
---@param data {cid: string, grade: integer, gradename: string}
---@param type 'job'|'gang'
function UpdateGrade(src, data, type)
  local player = QBCore.Functions.GetPlayer(src)
  local employee = QBCore.Functions.GetPlayerByCitizenId(data.cid)

  if not player.PlayerData[type].isboss then
    lib.logger(src, 'GradeUpdate', ('Potential exploit %s (%s) is not set to boss'):format(type, player.PlayerData[type].name))
    return
  end
  if data.grade > player.PlayerData[type].grade.level then
    TriggerClientEvent('QBCore:Notify', src, "You cannot promote to this rank!", "error")
    return
  end

  if not employee then
    TriggerClientEvent('QBCore:Notify', src, "Civilian is not in city.", "error")
    return
  end

  local success
  if type == 'gang' then
    success = employee.Functions.SetGang(player.PlayerData[type].name, data.grade)
  else
    success = employee.Functions.SetJob(player.PlayerData[type].name, data.grade)
  end

  if success then
    TriggerClientEvent('QBCore:Notify', src, "Successfully promoted!", "success")
    TriggerClientEvent('QBCore:Notify', employee.PlayerData.source, "You have been promoted to " .. data.gradename .. ".", "success")
  else
    TriggerClientEvent('QBCore:Notify', src, "Grade does not exist.", "error")
  end
end

---@param src number
---@return table
function GetPlayers(src)
  local players = {}
  local playerPed = GetPlayerPed(src)
  local pCoords = GetEntityCoords(playerPed)
  for _, v in pairs(QBCore.Functions.GetPlayers()) do
    local targetped = GetPlayerPed(v)
    local tCoords = GetEntityCoords(targetped)
    local dist = #(pCoords - tCoords)
    if playerPed ~= targetped and dist < 10 then
      local ped = QBCore.Functions.GetPlayer(v)
      players[#players + 1] = {
        id = v,
        coords = GetEntityCoords(targetped),
        name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
        citizenid = ped.PlayerData.citizenid,
        sources = GetPlayerPed(ped.PlayerData.source),
        sourceplayer = ped.PlayerData.source
      }
    end
  end

  table.sort(players, function(a, b)
    return a.name < b.name
  end)

  return players
end

AddEventHandler('onServerResourceStart', function(resourceName)
  if resourceName ~= 'ox_inventory' and resourceName ~= GetCurrentResourceName() then return end

  local data = Config.GangMenuZones
  for k in pairs(data) do
    exports.ox_inventory:RegisterStash('gang_' .. k, "Stash: " .. k, 100, 4000000, false)
  end
end)

function AddMoney(job, amount, message)
  message = message or 'Money received'
  exports.pefcl:addBankBalanceByIdentifier(-1, { identifier = job, amount = amount, message = message })
end

exports('AddMoney', AddMoney)

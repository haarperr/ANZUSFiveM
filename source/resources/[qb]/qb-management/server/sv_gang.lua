-- Get Employees
lib.callback.register('qb-gangmenu:server:GetEmployees', function(source, gangname)
  local src = source
  return GetEmployees(src, gangname, 'gang')
end)

-- Grade Change
RegisterNetEvent('qb-gangmenu:server:GradeUpdate', function(data)
  local src = source
  UpdateGrade(src, data, 'gang')
  TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

-- Fire Member
RegisterNetEvent('qb-gangmenu:server:FireMember', function(target)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local Employee = QBCore.Functions.GetPlayerByCitizenId(target)

  if not Player.PlayerData.gang.isboss then
    lib.logger(src, 'FireEmployee', ('Potential exploit grade (%s) is not set to boss'):format(Player.PlayerData.gang.name))
    return
  end

  if Employee then
    if target ~= Player.PlayerData.citizenid then
      if Employee.PlayerData.gang.grade.level > Player.PlayerData.gang.grade.level then
        TriggerClientEvent('QBCore:Notify', src, "You cannot fire this citizen!", "error")
        return
      end
      if Employee.Functions.SetGang("none", '0') then
        TriggerEvent("qb-log:server:CreateLog", "gangmenu", "Gang Fire", "orange",
          Player.PlayerData.charinfo.firstname ..
          " " ..
          Player.PlayerData.charinfo.lastname ..
          ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.gang.name .. ")", false)
        TriggerClientEvent('QBCore:Notify', src, "Gang Member fired!", "success")
        TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source, "You have been expelled from the gang!", "error")
      else
        TriggerClientEvent('QBCore:Notify', src, "Error.", "error")
      end
    else
      TriggerClientEvent('QBCore:Notify', src, "You can\'t kick yourself out of the gang!", "error")
    end
  else
    local player = MySQL.query.await('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { target })
    if player[1] then
      Employee = player[1]
      Employee.gang = json.decode(Employee.gang)
      if Employee.gang.grade.level > Player.PlayerData.job.grade.level then
        TriggerClientEvent('QBCore:Notify', src, "You cannot fire this citizen!", "error")
        return
      end
      local gang = {}
      gang.name = "none"
      gang.label = "No Affiliation"
      gang.payment = 0
      gang.onduty = true
      gang.isboss = false
      gang.grade = {}
      gang.grade.name = nil
      gang.grade.level = 0
      MySQL.update('UPDATE players SET gang = ? WHERE citizenid = ?', { json.encode(gang), target })
      TriggerClientEvent('QBCore:Notify', src, "Gang member fired!", "success")
      TriggerEvent("qb-log:server:CreateLog", "gangmenu", "Gang Fire", "orange",
        Player.PlayerData.charinfo.firstname ..
        " " ..
        Player.PlayerData.charinfo.lastname ..
        ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.gang.name .. ")", false)
    else
      TriggerClientEvent('QBCore:Notify', src, "Civilian is not in city.", "error")
    end
  end
  TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qb-gangmenu:server:HireMember', function(recruit)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local Target = QBCore.Functions.GetPlayer(recruit)

  if not Player.PlayerData.gang.isboss then
    lib.logger(src, 'HireEmployee', ('Potential exploit grade (%s) is not set to boss'):format(Player.PlayerData.gang.name))
    return
  end

  if Target and Target.Functions.SetGang(Player.PlayerData.gang.name, 0) then
    TriggerClientEvent('QBCore:Notify', src,
      "You hired " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. " come " .. Player.PlayerData.gang.label .. "", "success")
    TriggerClientEvent('QBCore:Notify', Target.PlayerData.source, "You have been hired as " .. Player.PlayerData.gang.label .. "", "success")
    TriggerEvent('qb-log:server:CreateLog', 'gangmenu', 'Recruit', 'yellow',
      (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname) ..
      ' successfully recruited ' .. Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.gang.name .. ')', false)
  end
  TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

-- Get closest player sv
lib.callback.register('qb-gangmenu:getplayers', function(source)
  local src = source
  return GetPlayers(src)
end)

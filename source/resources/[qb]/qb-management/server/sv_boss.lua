-- Get Employees
lib.callback.register('qb-bossmenu:server:GetEmployees', function(source, jobname)
  local src = source
  return GetEmployees(src, jobname, 'job')
end)

-- Grade Change
RegisterNetEvent('qb-bossmenu:server:GradeUpdate', function(data)
  local src = source
  UpdateGrade(src, data, 'job')
  TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Fire Employee
RegisterNetEvent('qb-bossmenu:server:FireEmployee', function(target)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local Employee = QBCore.Functions.GetPlayerByCitizenId(target)

  if not Player.PlayerData.job.isboss then
    lib.logger(src, 'FireEmployee', ('Potential exploit job (%s) is not set to boss'):format(Player.PlayerData.job.name))
    return
  end

  if Employee then
    if target ~= Player.PlayerData.citizenid then
      if Employee.PlayerData.job.grade.level > Player.PlayerData.job.grade.level then
        TriggerClientEvent('QBCore:Notify', src, "You cannot fire this citizen!", "error")
        return
      end
      local cachedJob = Employee.job.grade.level
      if Employee.Functions.SetJob("unemployed", 0) then
        lib.logger(src, 'FireEmployee', ('Fired %s from %s they were %d'):format(target, Player.PlayerData.job.name, cachedJob))
        TriggerClientEvent('QBCore:Notify', src, "Employee fired!", "success")
        exports['ps-multijob']:RemoveJob(target)
        TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source, "You have been fired! Good luck.", "error")
      else
        TriggerClientEvent('QBCore:Notify', src, "Error..", "error")
      end
    else
      TriggerClientEvent('QBCore:Notify', src, "You can\'t fire yourself", "error")
    end
  else
    local player = MySQL.query.await('SELECT * FROM characters WHERE citizenid = ? LIMIT 1', { target })
    if player[1] then
      Employee = player[1]
      Employee.job = json.decode(Employee.job)
      print(json.encode(Employee.job))
      if Employee.job.name ~= Player.PlayerData.job.name then
        MySQL.update(([[
          UPDATE character_jobs
          SET jobdata = JSON_REMOVE(jobdata, '$.%s')
          WHERE JSON_EXTRACT(jobdata, '$.%s.grade') IS NOT NULL AND citizenid = ?;
        ]]):format(Player.PlayerData.job.name, Player.PlayerData.job.name), { target })
        TriggerClientEvent('QBCore:Notify', src, "Employee fired!", "success")
        return
      end
      if Employee.job.grade.level > Player.PlayerData.job.grade.level then
        TriggerClientEvent('QBCore:Notify', src, "You cannot fire this citizen!", "error")
        return
      end
      local job = {}
      job.name = "unemployed"
      job.label = "Unemployed"
      job.payment = QBCore.Shared.Jobs[job.name].grades[0].payment or 500
      job.onduty = true
      job.isboss = false
      job.grade = {}
      job.grade.name = nil
      job.grade.level = 0
      MySQL.update('UPDATE characters SET job = ? WHERE citizenid = ?', { json.encode(job), target })
      MySQL.update(([[
        UPDATE character_jobs
        SET jobdata = JSON_REMOVE(jobdata, '$.%s')
        WHERE JSON_EXTRACT(jobdata, '$.%s.grade') IS NOT NULL AND citizenid = ?;
      ]]):format(Player.PlayerData.job.name, Player.PlayerData.job.name), { target })
      TriggerClientEvent('QBCore:Notify', src, "Employee fired!", "success")
      lib.logger(src, 'FireEmployee', ('Fired %s from %s they were %d'):format(target, Player.PlayerData.job.name, Employee.job.grade.level))
    else
      TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
    end
  end
  TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qb-bossmenu:server:HireEmployee', function(recruit)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local Target = QBCore.Functions.GetPlayer(recruit)

  if not Player.PlayerData.job.isboss then
    lib.logger(src, 'HireEmployee', ('Potential exploit job (%s) is not set to boss'):format(Player.PlayerData.job.name))
    return
  end

  if Target and Target.Functions.SetJob(Player.PlayerData.job.name, 0) then
    TriggerClientEvent('QBCore:Notify', src,
      "You hired " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. " come " .. Player.PlayerData.job.label .. "", "success")
    TriggerClientEvent('QBCore:Notify', Target.PlayerData.source, "You were hired as " .. Player.PlayerData.job.label .. "", "success")
    TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Recruit', "lightgreen",
      (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname) ..
      " successfully recruited " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. ' (' .. Player.PlayerData.job.name .. ')', false)
  end
  TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Get closest player sv
lib.callback.register('qb-bossmenu:getplayers', function(source)
  local src = source
  return GetPlayers(src)
end)

local QBCore = exports['qb-core']:GetCoreObject()

local function GetJobs(citizenid)
  local p = promise.new()
  MySQL.Async.fetchAll("SELECT jobdata FROM character_jobs WHERE citizenid = @citizenid", {
    ["@citizenid"] = citizenid
  }, function(jobs)
    if jobs[1] and jobs ~= "[]" then
      jobs = json.decode(jobs[1].jobdata)
    else
      local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)
      if Player then
        local temp = {}
        if not Config.IgnoredJobs[Player.PlayerData.job.name] then
          temp[Player.PlayerData.job.name] = { grade = Player.PlayerData.job.grade.level, licences = {} }
          MySQL.insert('INSERT INTO character_jobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
            citizenid = citizenid,
            jobdata = json.encode(temp),
          })
        end
        jobs = temp
      else
        jobs = {}
      end
    end
    p:resolve(jobs)
  end)
  return Citizen.Await(p)
end

exports('GetJobs', GetJobs)

local function AddJob(citizenid, job, grade, licences)
  local jobs = GetJobs(citizenid)
  for ignored in pairs(Config.IgnoredJobs) do
    if jobs[ignored] then
      jobs[ignored] = nil
    end
  end

  jobs[job] = { grade = grade, licences = licences }
  MySQL.insert('INSERT INTO character_jobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
    citizenid = citizenid,
    jobdata = json.encode(jobs),
  })
end
exports('AddJob', AddJob)

local function RemoveJob(citizenid, job, rgrade)
  local jobs = GetJobs(citizenid)
  jobs[job] = nil

  local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)
  if Player and Player.PlayerData.job.name == job then
    for k, v in pairs(jobs) do
      Player.Functions.SetJob(k, v)
      break
    end
  end
  MySQL.insert('INSERT INTO character_jobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
    citizenid = citizenid,
    jobdata = json.encode(jobs),
  })
end

exports('RemoveJob', RemoveJob)

QBCore.Commands.Add('removejob', 'Remove Multi Job (Admin Only)',
  { { name = 'id', help = 'ID of player' }, { name = 'job', help = 'Job Name' }, { name = 'grade', help = 'Job Grade' } }, false, function(source, args)
    local source = source
    if source == 0 or not args[1] then return TriggerClientEvent("QBCore:Notify", source, "Wrong usage!") end

    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if not Player then return TriggerClientEvent("QBCore:Notify", source, "Wrong usage!") end
    if not args[2] and not args[3] then return TriggerClientEvent("QBCore:Notify", source, "Wrong usage!") end

    RemoveJob(Player.PlayerData.citizenid, args[2], args[3])
  end, 'admin')

QBCore.Commands.Add('addjob', 'Add Multi Job (Admin Only)', { { name = 'id', help = 'ID of player' }, { name = 'job', help = 'Job Name' }, { name = 'grade', help = 'Job Grade' } },
  false, function(source, args)
    local source = source
    if source == 0 or not args[1] then return TriggerClientEvent("QBCore:Notify", source, "Wrong usage!") end

    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if not Player then return TriggerClientEvent("QBCore:Notify", source, "Wrong usage!") end
    if not args[2] and not args[3] then return TriggerClientEvent("QBCore:Notify", source, "Wrong usage!") end

    AddJob(Player.PlayerData.citizenid, args[2], args[3], {})
  end, 'admin')

QBCore.Functions.CreateCallback("ps-multijob:getJobs", function(source, cb)
  local Player = QBCore.Functions.GetPlayer(source)
  local jobs = GetJobs(Player.PlayerData.citizenid)
  local multijobs = {}
  local whitelistedjobs = {}
  local civjobs = {}
  local active = {}
  local getjobs = {}
  local Players = QBCore.Functions.GetPlayers()
  for i = 1, #Players, 1 do
    local xPlayer = QBCore.Functions.GetPlayer(Players[i])
    if active[xPlayer.PlayerData.job.name] and xPlayer.PlayerData.job.onduty then
      active[xPlayer.PlayerData.job.name] = active[xPlayer.PlayerData.job.name] + 1
    end
  end
  for job, value in pairs(jobs) do
    local online = active[job]
    if online == nil then online = 0 end
    getjobs = {
      name = job,
      grade = value.grade,
      description = Config.Descriptions[job],
      icon = Config.FontAwesomeIcons[job],
      label = QBCore.Shared.Jobs[job].label,
      licences = value.licences,
      grade_label = QBCore.Shared.Jobs[job].grades[tonumber(value.grade)].name,
      salary = QBCore.Shared.Jobs[job].grades[tonumber(value.grade)].payment,
      active = online,
    }
    if Config.WhitelistJobs[job] then
      whitelistedjobs[#whitelistedjobs + 1] = getjobs
    else
      civjobs[#civjobs + 1] = getjobs
    end
    multijobs = {
      whitelist = whitelistedjobs,
      civilian = civjobs,
    }
  end

  cb(multijobs)
end)

RegisterNetEvent("ps-multijob:changeJob", function(cjob, cgrade)
  local source = source
  local Player = QBCore.Functions.GetPlayer(source)

  if cjob == "unemployed" and cgrade == 0 then return Player.Functions.SetJob(cjob, cgrade) end

  local jobs = GetJobs(Player.PlayerData.citizenid)
  for job, value in pairs(jobs) do
    if cjob == job and cgrade == value.grade then
      Player.Functions.SetJob(job, value.grade, value.licences)
      break
    end
  end
end)

RegisterNetEvent("ps-multijob:removeJob", function(job, grade)
  local source = source
  local Player = QBCore.Functions.GetPlayer(source)
  RemoveJob(Player.PlayerData.citizenid, job, grade)
end)

-- QBCORE EVENTS

RegisterNetEvent("qb-bossmenu:server:FireEmployee", function(target)
  local source = source
  local Player = QBCore.Functions.GetPlayer(source)

  if not Player.PlayerData.job.isboss then return end
  if target == Player.PlayerData.citizenid then return end

  local Employee = QBCore.Functions.GetPlayerByCitizenId(target)

  RemoveJob(target, Employee.PlayerData.job.name, Employee.PlayerData.job.grade.level)
end)

RegisterNetEvent('QBCore:Server:OnJobUpdate', function(source, newJob)
  local source = source
  local Player = QBCore.Functions.GetPlayer(source)
  local jobs = GetJobs(Player.PlayerData.citizenid)
  local amount = #jobs
  local setjob = newJob
  -- for k, v in pairs(jobs) do
  --     amount = amount + 1
  -- end
  -- if amount > Config.MaxJobs and Config.IgnoredJobs[setjob.name] then return end
  if jobs[setjob.name] and jobs[setjob.name].grade == newJob.grade.level then return end

  AddJob(Player.PlayerData.citizenid, setjob.name, setjob.grade.level, setjob.licences)
end)

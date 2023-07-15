local db = require 'server.db'

---@param source any
---@return boolean
lib.callback.register('ag_doj:StartElection', function(source, data)
  local player = Player(source).state
  if player.job.name ~= 'doj' or player.job.grade.level < 10 then return false end

  local success = db.startElection()

  if not success then return false end

  GlobalState:set("electionStarted", true, true)

  TriggerClientEvent('ox_lib:notify', -1,
    { type = 'info', title = 'Department of Justice', description = 'An election has been started!\nHead to the Town Hall to vote', icon = 'scale-balanced', duration = 10000 })

  OnElectionStart()

  lib.logger(source, 'StartElection', ('Player started election'):format(data.name), 'citizenid', buyer.PlayerData.citizenid)

  return success
end)

---@param source any
---@return string[]
lib.callback.register('ag_doj:GetCandidates', function(source)
  local result = db.getCandidates()
  local candidates = {}

  for i = 1, #result, 1 do
    local res = result[i]
    candidates[#candidates + 1] = { id = res.id, name = res.name }
  end

  return candidates
end)

---@param source any
---@param data {id: number}
lib.callback.register('ag_doj:DeleteCandidate', function(source, data)
  local player = Player(source).state
  if player.job.name ~= 'doj' or player.job.grade.level < 10 then return false end
  local result = db.deleteCandidate(data.id)

  lib.logger(source, 'DeleteCandidate', ('Player removed candidate %d'):format(data.id), 'citizenid', buyer.PlayerData.citizenid)

  return result == 1 and true or false
end)

---@param source any
---@param data {name: string}
lib.callback.register('ag_doj:AddCandidate', function(source, data)
  local player = Player(source).state
  if player.job.name ~= 'doj' or player.job.grade.level < 10 then return false end

  local result = db.addCandidate(data.name)

  lib.logger(source, 'AddCandidate', ('Player added candidate %d'):format(data.name), 'citizenid', buyer.PlayerData.citizenid)
  return result
end)

---@param source any
---@return {votes: number, name: string}[]
lib.callback.register('ag_doj:ViewResults', function(source)
  local player = Player(source).state
  if player.job.name ~= 'doj' or player.job.grade.level < 10 then return {} end

  local res = db.getResults()
  local results = {}
  local decoded = json.decode(res[1].results)

  for i = 1, #decoded, 1 do
    local data = decoded[i]
    results[#results + 1] = { votes = data.sum, name = data.name }
  end

  return results
end)

function OnElectionStart()
  local election_started = db.getSetting('election_started')

  GlobalState:set("electionStarted", (election_started == '1' and true or false), true)

  if not GlobalState.electionStarted then return end

  local election_end = db.getSetting('election_end')
  local diff = os.difftime(election_end, os.time())
  Wait(diff)

  local success = db.stopElection()
  if not success then return end

  GlobalState:set("electionStarted", false, true)

  TriggerClientEvent('ox_lib:notify', -1, { type = 'info', title = 'Department of Justice', description = 'The election has finished!', icon = 'person-booth', duration = 10000 })
end

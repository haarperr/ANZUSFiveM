local db = require 'server.db'
local votes = {}

---@param source any
---@param data {id: number}
---@return boolean -- If vote was successful
lib.callback.register('ag_doj:Vote', function(source, data)
  local player = Player(source).state
  local userid = player.userid

  if player.hasVoted then return false end

  local res = db.voteCandidate(data.id, userid)
  if res then
    player:set('hasVoted', true, true)

    lib.logger(source, 'Vote', ('Player has voted for %d'):format(data.id))
  end

  return res
end)

function GetAllVotes()
  local res = db.getVotes()

  for i = 1, #res, 1 do
    local data = res[i]
    votes[data.userid] = true
  end
end

AddEventHandler('QBCore:Server:PlayerLoaded', function(player)
  Player(player.PlayerData.source).state:set('hasVoted', votes[player.PlayerData.userid] and true or false, true)
end)

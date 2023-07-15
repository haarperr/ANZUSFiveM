local zones = {}
local hasVoted = LocalPlayer.state.hasVoted or false

---@param id number id of the candidate
local function Vote(id)
  local res = lib.callback.await('ag_doj:Vote', 200, { id = id })
  if not res then return end

  lib.notify({ type = 'success', title = 'Department of Justice', description = 'Successfully voted for candidate', duration = 2500 })
end

---@param id number Index of the poll booth
local function OpenMenu(id)
  local candidates = lib.callback.await('ag_doj:GetCandidates', 500)
  local options = {}

  for i = 1, #candidates, 1 do
    local candidate = candidates[i]
    options[#options + 1] = {
      title = candidate.name,
      icon = 'check-to-slot',
      onSelect = function()
        Vote(candidate.id)
      end,
    }
  end


  lib.registerContext({
    id = string.format('poll_booth%d', id),
    title = string.format('Poll Booth %d', id),
    options = options
  })
  lib.showContext(string.format('poll_booth%d', id))
end

function SetupVoteZones()
  local booths = Config.Election.booths

  for i = 1, #booths, 1 do
    local zone = booths[i]

    zones[#zones + 1] = lib.zones.box({
      coords = zone.coords,
      size = zone.size,
      rotation = zone.rotation,
      onEnter = function()
        if hasVoted then return end
        lib.addRadialItem({
          id = 'vote',
          label = 'Vote',
          icon = 'person-booth',
          onSelect = function()
            if hasVoted then return end
            OpenMenu(i)
          end
        })
      end,
      onExit = function()
        lib.removeRadialItem('vote')
      end,
    })
  end
end

AddStateBagChangeHandler('hasVoted', ('player:%s'):format(cache.serverId), function(_, _, value)
  if hasVoted == value then return end
  hasVoted = value
end)

local GlobalState = GlobalState

local zone = nil
local candidates = {}

---@param options {title: string, icon: string, onSelect: function}[]
---@param id string
---@param title string
local function showSubMenu(options, id, title)
  options[#options + 1] = {
    title = 'Go back',
    icon = 'arrow-left',
    onSelect = function()
      lib.showContext('election_management')
    end
  }

  lib.registerContext({
    id = id,
    title = title,
    options = options
  })

  lib.showContext(id)
end

local function viewResults()
  local options = {}
  local results = lib.callback.await('ag_doj:ViewResults', 200, {})

  for i = 1, #results, 1 do
    local result = results[i]
    options[#options + 1] = {
      title = string.format('%s - %s', result.votes, result.name),
      icon = 'user-tie'
    }
  end

  showSubMenu(options, 'view_results', 'Results')
end

local function viewCandidates()
  local options = {}

  for i = 1, #candidates, 1 do
    local candidate = candidates[i]
    local toAdd = {
      title = candidate.name,
      description = 'Click to remove',
      icon = 'user-tie',
      disabled = GlobalState.electionStarted,
    }

    if not GlobalState.electionStarted then
      toAdd.onSelect = function()
        local res = lib.callback.await('ag_doj:DeleteCandidate', 200, { id = candidate.id })
        if res then table.remove(candidates, i) end
        viewCandidates()
      end
    end

    options[#options + 1] = toAdd
  end

  local toAdd = {
    title = 'Add Candidate',
    description = 'Add a name',
    icon = 'person-circle-plus',
    disabled = GlobalState.electionStarted,
  }

  if not GlobalState.electionStarted then
    toAdd.onSelect = function()
      local input = lib.inputDialog('Add Candidate', { 'Name' })
      if not input then return end

      local res = lib.callback.await('ag_doj:AddCandidate', 200, { name = input[1] })
      if res then candidates[#candidates + 1] = { id = res, name = input[1] } end
      viewCandidates()
    end
  end

  options[#options + 1] = toAdd


  showSubMenu(options, 'view_candidates', 'Candidates')
end

local function openMenu()
  lib.registerContext({
    id = 'election_management',
    title = 'Election Mangement',
    options = {
      {
        title = 'View Candidates',
        description = 'View all candidates',
        icon = 'person-booth',
        onSelect = function()
          candidates = lib.callback.await('ag_doj:GetCandidates', 200)
          viewCandidates()
        end,
      },
      {
        title = 'View Results',
        description = 'View the results of previous election',
        icon = 'square-poll-vertical',
        onSelect = function()
          viewResults()
        end,
      },
      {
        title = 'Start Election',
        description = GlobalState.electionStarted and 'Election is currently in progress' or 'Start the polling!',
        icon = 'check',
        disabled = GlobalState.electionStarted,
        onSelect = function()
          lib.callback.await('ag_doj:StartElection', 500, { candidates = candidates })
        end,
      }
    }
  })
  lib.showContext('election_management')
end

function SetupElectionZones()
  exports.ox_target:addBoxZone({
    coords = Config.Election.start.coords,
    size = Config.Election.start.size,
    rotation = Config.Election.start.rotation,
    options = {
      {
        name = 'startElection',
        icon = 'fa-solid fa-cube',
        label = 'Start Election',
        onSelect = function()
          openMenu()
        end,
      }
    }
  })
end

function DestroyElectionZones()
  if zone ~= nil then
    exports.ox_target:removeZone(zone)
    zone = nil
  end
end

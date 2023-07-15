local QBCore = exports['qb-core']:GetCoreObject()
local dutyCount = 0

local function updateDOJ(src, unload)
  if not unload then
    dutyCount += 1
  else
    dutyCount -= 1
  end
end


lib.callback.register('ag_doj:ToggleDuty', function(source)
  local player = QBCore.Functions.GetPlayer(source)
  local state = Player(source).state

  player.Functions.SetJobDuty(not player.PlayerData.job.onduty)

  local newState = state.job
  newState.onduty = not player.PlayerData.job.onduty

  if newState.onduty then
    updateDOJ(source, false)
  else
    updateDOJ(source, true)
  end

  state:set('job', newState, true)

  return not player.PlayerData.job.onduty and 'on duty' or 'off duty'
end)

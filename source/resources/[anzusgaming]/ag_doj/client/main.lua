local job = LocalPlayer.state.job

local function Setup()
  if GlobalState.electionStarted then
    lib.notify({ type = 'info', description = 'The election is currently in progress', title = 'Department of Justice', duration = 10000 })
    SetupVoteZones()
  end
end

AddEventHandler('onClientResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end
  Setup()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  Setup()
end)

AddStateBagChangeHandler('job', ('player:%s'):format(cache.serverId), function(_, _, value)
  if job == value then return end
  job = value

  DestroyElectionZones()
  DestroyTaxZones()
  DestroyDutyZones()
  if not job then return end

  if job.name == 'doj' then
    SetupElectionZones()
    SetupDutyZones()
  end

  if job.name == 'gov' then
    SetupTaxZones()
    SetupDutyZones()
  end
end)

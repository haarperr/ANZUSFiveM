local QBCore = exports['qb-core']:GetCoreObject()
local isInside = false
local AllowJobs = {'police', 'ambulance'}

local function JobCheck(job)
  for k, v in pairs(AllowJobs) do
    if v == job then return true end
  end
  return false
end

local function onEnter()
  local ped = PlayerPedId()
  if not IsPedInAnyPlane(ped) and not IsPedInAnyHeli(ped) then return end
  local PlayerData = QBCore.Functions.GetPlayerData()
  if JobCheck(PlayerData.job.name) then return end
  if isInside then return end
  isInside = true
  lib.notify({
      title = 'Law Enforcement',
      description = 'You 10 seconds to leave restricted DOC airspace or your aircraft will be disabled',
      type = 'warning',
      duration = 10000,
  })
  SetTimeout(10000, function()
      if not isInside then return end
      local veh = GetVehiclePedIsIn(ped, false)
      if veh == 0 then return end
      SetVehicleEngineOn(veh, false, true, false)
      SetVehicleEngineHealth(veh, 0)
      ExplodeVehicle(veh, true, false)
  end)
end

local poly = lib.zones.poly({
    points = {
        vec3(1805.0, 2344.0, 134.0),
        vec3(2026.0, 2638.0, 134.0),
        vec3(1743.0, 2879.0, 134.0),
        vec3(1399.0, 2471.0, 134.0),
        vec3(1556.0, 2345.0, 134.0),
    },
    thickness = 200.5,
    debug = false,
    onEnter = onEnter,
    onExit = function()
      isInside = false
    end,
})

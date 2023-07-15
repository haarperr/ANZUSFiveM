local QBCore = exports['qb-core']:GetCoreObject()
local playerState = LocalPlayer.state

AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)
  if GetCurrentResourceName() ~= res then return end

  local playerData = QBCore.Functions.GetPlayerData()
  playerState:set('job', playerData.job, true)
  playerState:set('isCuffed', playerData.metadata.ishandcuffed, true)
  playerState:set('cuffType', playerData.metadata.cuffType, true)
  playerState:set('isZiptied', playerData.metadata.isziptied, true)
  playerState:set('isEscorted', false, true)
  playerState:set('isEscorting', false, true)
  playerState:set('isKidnapping', false, true)
  playerState:set('isKidnapped', false, true)
  playerState:set('inJail', playerData.metadata.injail, true)
  playerState:set('citizenid', playerData.citizenid, true)
  playerState:set('userid', playerData.userid, true)
  playerState:set('isDown', playerData.metadata.inlaststand, true)
  playerState:set('isDead', playerData.metadata.isdead, true)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  local playerData = QBCore.Functions.GetPlayerData()
  playerState:set('job', playerData.job, true)
  playerState:set('isZiptied', playerData.metadata.isziptied, true)
  playerState:set('isCuffed', playerData.metadata.ishandcuffed, true)
  playerState:set('cuffType', playerData.metadata.cuffType, true)
  playerState:set('isEscorted', false, true)
  playerState:set('isEscorting', false, true)
  playerState:set('isKidnapping', false, true)
  playerState:set('isKidnapped', false, true)
  playerState:set('inJail', playerData.metadata.injail, true)
  playerState:set('citizenid', playerData.citizenid, true)
  playerState:set('userid', playerData.userid, true)
  playerState:set('isDown', playerData.metadata.inlaststand, true)
  playerState:set('isDead', playerData.metadata.isdead, true)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  playerState:set('isCuffed', false, true)
  playerState:set('isZiptied', false, true)
  playerState:set('isEscorted', false, true)
  playerState:set('isEscorting', false, true)
  playerState:set('isKidnapping', false, true)
  playerState:set('isKidnapped', false, true)
  playerState:set('cuffType', 'NONE', true)
  playerState:set('job', nil, true)
  playerState:set('inJail', 0, true)
  playerState:set('citizenid', nil, true)
  playerState:set('userid', nil, true)
  playerState:set('isDown', nil, true)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
  playerState:set('job', job, true)
end)


local function seatIntoVehicle()
  local coords = GetEntityCoords(cache.ped)
  local vehicle = lib.getClosestVehicle(coords, 4, true)

  if not vehicle then return lib.notify({ type = 'error', description = 'No vehicle nearby' }) end
  if GetVehicleDoorLockStatus(vehicle) ~= 1 then return lib.notify({ type = 'error', description = 'Vehicle is locked' }) end

  exports.ag_police:seatIntoVehicle({ entity = vehicle })
end

local function seatOutVehicle()
  local coords = GetEntityCoords(cache.ped)
  local vehicle = lib.getClosestVehicle(coords, 4, true)

  if not vehicle then return lib.notify({ type = 'error', description = 'No vehicle nearby' }) end
  if GetVehicleDoorLockStatus(vehicle) ~= 1 then return lib.notify({ type = 'error', description = 'Vehicle is locked' }) end

  exports.ag_police:seatOutVehicle({ entity = vehicle })
end

RegisterCommand('seatinto', seatIntoVehicle)
RegisterCommand('pullout', seatOutVehicle)

TriggerEvent('chat:addSuggestion', 'seatinto', "Seat someone (cuffed) into a vehicle forcably")
TriggerEvent('chat:addSuggestion', 'pullout', "Pull everyone (cuffed) out of a vehicle")

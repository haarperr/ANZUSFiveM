Cops = {}
DutyCount = 0
QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('QBCore:Server:OnPlayerUnload', function(source)
  local player = QBCore.Functions.GetPlayer(source)
  local target = Player(source).state

  player.Functions.SetMetaData("ishandcuffed", target.isCuffed)
  player.Functions.SetMetaData("handcuffType", target.cuffType)
end)

---@param target string Citizen ID to retrieve name from
---@return boolean
lib.callback.register('ag_police:getNameFromStateID', function(source, target)
  local playerState = Player(source).state
  if playerState.job.type ~= 'leo' then return false end

  local Target = QBCore.Functions.GetPlayerByCitizenId(target)

  if Target == nil then return nil end

  return Target.PlayerData.fullname
end)

RegisterNetEvent("baseevents:enteredVehicle", function(currentVehicle, currentSeat, vehicleDisplayName, netId)
  Player(source).state:set('inVehicle', true, true)
end)

RegisterNetEvent('baseevents:leftVehicle', function(currentVehicle, currentSeat, vehicleDisplayName, netId)
  Player(source).state:set('inVehicle', false, true)
end)

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() ~= resourceName or GetCurrentResourceName() ~= 'qb-core' then return end
  local Players = QBCore.Functions.GetQBPlayers()

  for _, value in pairs(Players) do
    if value.PlayerData.job.type ~= 'leo' then goto skip end
    value.Functions.SetJobDuty(false)
    ::skip::
  end
end)

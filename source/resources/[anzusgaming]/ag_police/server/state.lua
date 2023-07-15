---@param resourceName string
AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  for i = 1, #PD_Zones, 1 do
    local zone = PD_Zones[i]
    if not zone.trash then goto skip end
    exports.ox_inventory:RegisterStash(string.format('policetrash_%s', zone.name), 'Police Trash', 300, 4000000, nil, { lspd = 0 }, zone.trash.coords)
    exports.ox_inventory:ClearInventory(string.format('policetrash_%s', zone.name))
    ::skip::
  end
end)

local function findCop(src)
  local found = nil
  local cops = Cops
  for index, value in pairs(cops) do
    if value.source == src then
      found = { index = index, cop = value }
      break
    end
  end

  return found
end

local function updateCops(src, unload)
  if not unload then
    local PlayerData = QBCore.Functions.GetPlayer(src).PlayerData
    local blipLabel = PlayerData.metadata.callsign ~= 'NO CALLSIGN' and ('[%s] %s'):format(PlayerData.metadata.callsign, PlayerData.charinfo.lastname) or
        PlayerData.charinfo.lastname
    Cops[#Cops + 1] = { source = source, callsign = PlayerData.metadata.callsign, name = PlayerData.charinfo.lastname, label = blipLabel }
    DutyCount += 1
    TriggerClientEvent("police:SetCopCount", -1, DutyCount)
  else
    local data = findCop(src)
    if not data then return end

    Cops[data.index] = nil
    DutyCount -= 1
    TriggerClientEvent("police:SetCopCount", -1, DutyCount)
  end
end

lib.callback.register('ag_police:ToggleDuty', function(source)
  local player = QBCore.Functions.GetPlayer(source)
  local state = Player(source).state

  player.Functions.SetJobDuty(not player.PlayerData.job.onduty)

  local newState = state.job
  newState.onduty = not player.PlayerData.job.onduty

  if newState.onduty then
    updateCops(source, false)
  else
    updateCops(source, true)
  end

  state:set('job', newState, true)

  return not player.PlayerData.job.onduty and 'on duty' or 'off duty'
end)


---@param newJob any
RegisterNetEvent('QBCore:Server:OnJobUpdate', function(source, newJob)
  local data = findCop(source)
  if data and newJob.type ~= 'leo' then
    updateCops(source, true)
    return
  end

  if newJob.type ~= 'leo' then return end
  if not newJob.onduty then return end
  updateCops(source, false)
end)

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
  local PlayerData = QBCore.Functions.GetPlayer(source).PlayerData
  local job = PlayerData.job

  if job.type ~= 'leo' then return end
  if not job.onduty then return end

  updateCops(source, false)
end)

RegisterNetEvent('QBCore:Server:OnPlayerUnload', function(src)
  updateCops(src, true)
end)

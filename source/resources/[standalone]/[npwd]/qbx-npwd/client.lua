local hasPhone = false
local QBCore = exports['qb-core']:GetCoreObject()

local itemLabels = {}

for item, data in pairs(exports.ox_inventory:Items()) do
  if string.find(item, "license") then
    itemLabels[item] = data.label
  end
end

local function DoPhoneCheck(isUnload)
  hasPhone = false

  if isUnload then
    exports.npwd:setPhoneDisabled(true)
    return
  end

  local items = exports.ox_inventory:Search('count', Config.PhoneList)

  if type(items) == 'number' then
    hasPhone = items > 0
  else
    for _, v in pairs(items) do
      if v > 0 then
        hasPhone = true
        break
      end
    end
  end

  exports.npwd:setPhoneDisabled(not hasPhone)
end

local function HasPhone()
  return hasPhone
end

exports("HasPhone", HasPhone)

local function sendLicenses(licences)
  if not licences then
    exports['npwd']:SetLicences(json.encode({}))
    return
  end
  local licenses = { '' }
  for key, v in pairs(licences) do
    if v then
      licenses[#licenses + 1] = itemLabels[key .. '_license']
    end
  end
  table.remove(licenses, 1)

  exports['npwd']:SetLicences(json.encode(licenses))
end

-- Handles state right when the player selects their character and location.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  DoPhoneCheck()
  local data = QBCore.Functions.GetPlayerData()
  sendLicenses(data.metadata['licences'])
  exports['npwd']:GetCitizenID(data.citizenid)
end)

-- Resets state on logout, in case of character change.
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  DoPhoneCheck(true)
  TriggerServerEvent("qbx-npwd:server:UnloadPlayer")
end)

-- Handles state when PlayerData is changed. We're just looking for inventory updates.
RegisterNetEvent('QBCore:Player:SetPlayerData', function(PlayerData)
  DoPhoneCheck()
  sendLicenses(PlayerData.metadata['licences'])
  exports['npwd']:GetCitizenID(PlayerData.citizenid)
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
  if GetCurrentResourceName() ~= resource or GetResourceState('npwd') ~= 'started' then return end

  DoPhoneCheck()
  local data = QBCore.Functions.GetPlayerData()
  sendLicenses(data.metadata['licences'])
  exports['npwd']:GetCitizenID(data.citizenid)
end)

-- Allows use of phone as an item.
RegisterNetEvent('qbx-npwd:client:setPhoneVisible', function(isPhoneVisible)
  exports.npwd:setPhoneVisible(isPhoneVisible)
end)

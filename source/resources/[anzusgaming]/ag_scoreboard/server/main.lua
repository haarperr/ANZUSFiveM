local QBCore = exports['qb-core']:GetCoreObject()

local online = {}
local recentDisconnects = {}

local function steamIdentifier(id)
  local identifiers = GetPlayerIdentifiers(id)
  local steam = 'Steam Not Found'
  for _, v in pairs(identifiers) do
    if string.find(v, "steam") then
      steam = v
      break
    end
  end
  return steam
end

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
  local src = source
  local PlayerData = QBCore.Functions.GetPlayer(src).PlayerData
  online[PlayerData.citizenid] = {
    source = src,
    steam = steamIdentifier(src)
  }
end)

RegisterNetEvent('QBCore:Server:OnPlayerUnload', function(src)
  local PlayerData = QBCore.Functions.GetPlayer(src).PlayerData
  recentDisconnects[PlayerData.citizenid] = online[PlayerData.citizenid]
  online[PlayerData.citizenid] = nil
end)

lib.callback.register('ag_scoreboard:getPlayers', function(source)
  lib.logger(source, 'getPlayers', 'Player opened scoreboard')
  return { online = online, recentDisconnects = recentDisconnects }
end)

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  for _, value in pairs(QBCore.Functions.GetQBPlayers()) do
    online[value.PlayerData.citizenid] = {
      source = value.PlayerData.source,
      steam = steamIdentifier(value.PlayerData.source)
    }
  end
end)

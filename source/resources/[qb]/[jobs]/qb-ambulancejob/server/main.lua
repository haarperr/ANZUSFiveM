local QBCore = exports['qb-core']:GetCoreObject()

local Doctors = {}
local doctorsCount = 0

---@class Player object from core

---@alias source number

---@class PlayerStatus
---@field limbs BodyParts
---@field isBleeding number

---@type table<source, PlayerStatus>
local playerStatus = {}

---@type table<source, number[]> weapon hashes
local playerWeaponWounds = {}

local doctorCalled = false


-- Events

---Compatibility with txAdmin Menu's heal options.
---This is an admin only server side event that will pass the target player id or -1.
---@class EventData
---@field id number
---@param eventData EventData
AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
  if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
    return
  end

  TriggerClientEvent('hospital:client:Revive', eventData.id)
  TriggerClientEvent("hospital:client:HealInjuries", eventData.id, "full")
end)

---@param player Player
local function billPlayer(player)
  player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
  -- exports['qbx-management']:AddMoney("ambulance", Config.BillCost)
  TriggerClientEvent('hospital:client:SendBillEmail', player.PlayerData.source, Config.BillCost)
end

---@param player Player
local function wipeInventory(player)
  if doctorsCount ~= 0 then
    exports.ox_inventory:ClearInventory(player.PlayerData.source, { 'phone', 'radio' })
    TriggerClientEvent('ox_lib:notify', player.PlayerData.source, { description = Lang:t('error.possessions_taken'), type = 'error' })
  end
end

---@param player Player
---@param bedsKey "beds"|"jailbeds"
---@param i integer
---@param bed Bed
local function respawnAtBed(player, bedsKey, i, bed)
  TriggerClientEvent('hospital:client:SendToBed', player.PlayerData.source, i, bed, true)
  TriggerClientEvent('hospital:client:SetBed', -1, bedsKey, i, true)
  if Config.WipeInventoryOnRespawn then
    wipeInventory(player)
  end
  billPlayer(player)
end

---@param player Player
---@param bedsKey "beds"|"jailbeds"
local function respawnAtHospital(player, bedsKey)
  local beds = Config.Locations[bedsKey]
  local ped = GetPlayerPed(player.PlayerData.source)
  local coords = GetEntityCoords(ped)
  local closestIndex = nil
  local closestBed = nil
  for i, bed in pairs(beds) do
    if not bed.taken then
      if not closestIndex then
        closestIndex = i
        closestBed = bed
      end
      if #(vec3(bed.coords.x, bed.coords.y, bed.coords.z) - coords) < #(vec3(closestBed.coords.x, closestBed.coords.y, closestBed.coords.z) - coords) then
        closestIndex = i
        closestBed = bed
      end
    end
  end
  respawnAtBed(player, bedsKey, closestIndex, closestBed)
end

RegisterNetEvent('hospital:server:RespawnAtHospital', function()
  if GetInvokingResource() then return end
  local player = QBCore.Functions.GetPlayer(source)
  if player.PlayerData.metadata.injail > 0 then
    respawnAtHospital(player, "jailbeds")
  else
    respawnAtHospital(player, "beds")
  end
end)

---@param bedId integer
---@param isRevive boolean
RegisterNetEvent('hospital:server:SendToBed', function(bedId, isRevive)
  if GetInvokingResource() then return end
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  TriggerClientEvent('hospital:client:SendToBed', src, bedId, Config.Locations.beds[bedId], isRevive)
  TriggerClientEvent('hospital:client:SetBed', -1, "beds", bedId, true)
  billPlayer(player)
end)

---@param text string
RegisterNetEvent('hospital:server:ambulanceAlert', function(text)
  if GetInvokingResource() then return end
  local src = source
  local ped = GetPlayerPed(src)
  local coords = GetEntityCoords(ped)
  local players = QBCore.Functions.GetQBPlayers()
  for _, v in pairs(players) do
    if v.PlayerData.job.name == 'ambulance' and v.PlayerData.job.onduty then
      TriggerClientEvent('hospital:client:ambulanceAlert', v.PlayerData.source, coords, text)
    end
  end
end)

RegisterNetEvent('hospital:server:StabilizePlayer', function(playerId, isOldMan)
  local src = source
  local Patient = QBCore.Functions.GetPlayer(playerId)
  local oldMan = isOldMan or false
  if not Patient then return end
  Player(Patient.PlayerData.source).state:set('stabilized', true, true)
  TriggerClientEvent('ox_lib:notify', Patient.PlayerData.source, { type = 'info', description = 'You have been stabilized' })
end)

---@param id integer
RegisterNetEvent('hospital:server:LeaveBed', function(id)
  if GetInvokingResource() then return end
  TriggerClientEvent('hospital:client:SetBed', -1, "beds", id, false)
end)

---@param data PlayerStatus
RegisterNetEvent('hospital:server:SyncInjuries', function(data)
  if GetInvokingResource() then return end
  local src = source
  playerStatus[src] = data
end)

---@param data number[] weapon hashes
RegisterNetEvent('hospital:server:SetWeaponDamage', function(data)
  if GetInvokingResource() then return end
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  if not player then return end
  playerWeaponWounds[player.PlayerData.source] = data
end)

RegisterNetEvent('hospital:server:RestoreWeaponDamage', function()
  if GetInvokingResource() then return end
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  playerWeaponWounds[player.PlayerData.source] = nil
end)

---@param isDead boolean
RegisterNetEvent('hospital:server:SetDeathStatus', function(isDead)
  if GetInvokingResource() then return end
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  if not player then return end
  player.Functions.SetMetaData("isdead", isDead)
end)

---@param bool boolean
RegisterNetEvent('hospital:server:SetLaststandStatus', function(bool)
  if GetInvokingResource() then return end
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  if not player then return end
  player.Functions.SetMetaData("inlaststand", bool)
end)

---@param amount number
RegisterNetEvent('hospital:server:SetArmor', function(amount)
  if GetInvokingResource() then return end
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  if not player then return end
  player.Functions.SetMetaData("armor", amount)
end)

---@param playerId number
RegisterNetEvent('hospital:server:TreatWounds', function(playerId)
  if GetInvokingResource() then return end
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  local patient = QBCore.Functions.GetPlayer(playerId)
  if player.PlayerData.job.name ~= "ambulance" or not patient then return end

  player.Functions.RemoveItem('bandage', 1)
  TriggerClientEvent("hospital:client:HealInjuries", patient.PlayerData.source, "full")
end)

---@param playerId number
RegisterNetEvent('hospital:server:RevivePlayer', function(playerId)
  if GetInvokingResource() then return end
  local player = QBCore.Functions.GetPlayer(source)
  local patient = QBCore.Functions.GetPlayer(playerId)

  if not patient then return end
  player.Functions.RemoveItem('defib', 1)
  TriggerClientEvent('hospital:client:Revive', patient.PlayerData.source)
end)

RegisterNetEvent('hospital:server:SendDoctorAlert', function()
  if GetInvokingResource() then return end
  local src = source
  if doctorCalled then
    TriggerClientEvent('ox_lib:notify', src, { description = Lang:t('info.dr_needed'), type = 'info' })
    return
  end

  doctorCalled = true
  local players = QBCore.Functions.GetQBPlayers()
  for _, v in pairs(players) do
    if v.PlayerData.job.name == 'ambulance' and v.PlayerData.job.onduty then
      TriggerClientEvent('ox_lib:notify', src, { description = Lang:t('info.dr_needed'), type = 'info' })
    end
  end
  SetTimeout(Config.DocCooldown * 60000, function()
    doctorCalled = false
  end)
end)

---@param targetId number
RegisterNetEvent('hospital:server:UseDefib', function(targetId)
  if GetInvokingResource() then return end
  local src = source
  local target = QBCore.Functions.GetPlayer(targetId)
  if not target then return end

  local canHelp = lib.callback.await('hospital:client:canHelp', targetId)
  if not canHelp then
    TriggerClientEvent('ox_lib:notify', src, { description = Lang:t('error.cant_help'), type = 'error' })
    return
  end

  TriggerClientEvent('hospital:client:HelpPerson', src, targetId)
end)

RegisterNetEvent('hospital:server:resetHungerThirst', function()
  if GetInvokingResource() then return end
  local player = QBCore.Functions.GetPlayer(source)

  if not player then return end

  player.Functions.SetMetaData('hunger', 100)
  player.Functions.SetMetaData('thirst', 100)

  TriggerClientEvent('hud:client:UpdateNeeds', source, 100, 100)
end)

-- Callbacks

lib.callback.register('hospital:GetDoctors', function()
  local amount = 0
  local players = QBCore.Functions.GetQBPlayers()
  for _, v in pairs(players) do
    if v.PlayerData.job.name == 'ambulance' and v.PlayerData.job.onduty then
      amount += 1
    end
  end
  return amount
end)

---@param limbs BodyParts
---@return BodyParts
local function getDamagedBodyParts(limbs)
  local bodyParts = {}
  for bone, bodyPart in pairs(limbs) do
    if bodyPart.isDamaged then
      bodyParts[bone] = bodyPart
    end
  end
  return bodyParts
end

---@param playerId number
lib.callback.register('hospital:GetPlayerStatus', function(_, playerId)
  local playerSource = QBCore.Functions.GetPlayer(playerId).PlayerData.source

  ---@class PlayerDamage
  ---@field damagedBodyParts BodyParts
  ---@field bleedLevel number
  ---@field weaponWounds number[]

  ---@type PlayerDamage
  local damage = {
    damagedBodyParts = {},
    bleedLevel = 0,
    weaponWounds = {}
  }
  if not playerSource then
    return damage
  end

  local playerInjuries = playerStatus[playerSource]
  if playerInjuries then
    damage.bleedLevel = playerInjuries.isBleeding or 0
    damage.damagedBodyParts = getDamagedBodyParts(playerInjuries.limbs)
  end

  damage.weaponWounds = playerWeaponWounds[playerSource] or {}
  return damage
end)

-- Commands

lib.addCommand('911e', {
  help = Lang:t('info.ems_report'),
  params = {
    { name = 'message', help = Lang:t('info.message_sent'), type = 'string', optional = true },
  }
}, function(source, args)
  local message = args.message or Lang:t('info.civ_call')
  local ped = GetPlayerPed(source)
  local coords = GetEntityCoords(ped)
  local players = QBCore.Functions.GetQBPlayers()
  for _, v in pairs(players) do
    if v.PlayerData.job.name == 'ambulance' and v.PlayerData.job.onduty then
      TriggerClientEvent('hospital:client:ambulanceAlert', v.PlayerData.source, coords, message)
    end
  end
end)

---@param src number
---@param event string
local function triggerEventOnEmsPlayer(src, event)
  local player = QBCore.Functions.GetPlayer(src)
  if player.PlayerData.job.name ~= "ambulance" then
    TriggerClientEvent('ox_lib:notify', src, { description = Lang:t('error.not_ems'), type = 'error' })
    return
  end

  TriggerClientEvent(event, src)
end

lib.addCommand('status', {
  help = Lang:t('info.check_health'),
}, function(source)
  triggerEventOnEmsPlayer(source, 'hospital:client:CheckStatus')
end)

lib.addCommand('heal', {
  help = Lang:t('info.heal_player'),
}, function(source)
  triggerEventOnEmsPlayer(source, 'hospital:client:TreatWounds')
end)

lib.addCommand('revivep', {
  help = Lang:t('info.revive_player'),
}, function(source)
  triggerEventOnEmsPlayer(source, 'hospital:client:RevivePlayer')
end)

---Triggers the event on the player or src, if no target is specified
---@param src number playerId of the one triggering the event
---@param event string event name
---@param targetPlayerId? string playerId of the target of the event
local function triggerEventOnPlayer(src, event, targetPlayerId)
  if not targetPlayerId then
    TriggerClientEvent(event, src)
    return
  end

  local player = QBCore.Functions.GetPlayer(tonumber(targetPlayerId))

  if not player then
    TriggerClientEvent('ox_lib:notify', src, { description = Lang:t('error.not_online'), type = 'error' })
    return
  end

  TriggerClientEvent(event, player.PlayerData.source)
end

lib.addCommand('revive', {
  help = Lang:t('info.revive_player_a'),
  restricted = "qbox.admin",
  params = {
    { name = 'id', help = Lang:t('info.player_id'), type = 'playerId', optional = true },
  }
}, function(source, args)
  triggerEventOnPlayer(source, 'hospital:client:Revive', args.id)
end)

lib.addCommand('setpain', {
  help = Lang:t('info.pain_level'),
  restricted = "qbox.admin",
  params = {
    { name = 'id', help = Lang:t('info.player_id'), type = 'playerId', optional = true },
  }
}, function(source, args)
  triggerEventOnPlayer(source, 'hospital:client:SetPain', args.id)
end)

lib.addCommand('kill', {
  help = Lang:t('info.kill'),
  restricted = "qbox.admin",
  params = {
    { name = 'id', help = Lang:t('info.player_id'), type = 'playerId', optional = true },
  }
}, function(source, args)
  triggerEventOnPlayer(source, 'hospital:client:KillPlayer', args.id)
end)

lib.addCommand('aheal', {
  help = Lang:t('info.heal_player_a'),
  restricted = "qbox.admin",
  params = {
    { name = 'id', help = Lang:t('info.player_id'), type = 'playerId', optional = true },
  }
}, function(source, args)
  triggerEventOnPlayer(source, 'hospital:client:adminHeal', args.id)
end)

-- Items
---@param src number
---@param item table
---@param event string
local function triggerItemEventOnPlayer(src, item, event)
  local player = QBCore.Functions.GetPlayer(src)
  if player.Functions.GetItemByName(item.name) == nil then return end
  local removeItem = lib.callback.await(event, src)
  if not removeItem then return end
  player.Functions.RemoveItem(item.name, 1)
end

QBCore.Functions.CreateUseableItem("ifaks", function(source, item)
  triggerItemEventOnPlayer(source, item, 'hospital:client:UseIfaks')
end)

QBCore.Functions.CreateUseableItem("bandage", function(source, item)
  triggerItemEventOnPlayer(source, item, 'hospital:client:UseBandage')
end)

QBCore.Functions.CreateUseableItem("painkillers", function(source, item)
  triggerItemEventOnPlayer(source, item, 'hospital:client:UsePainkillers')
end)

QBCore.Functions.CreateUseableItem("defib", function(source, item)
  triggerItemEventOnPlayer(source, item, 'hospital:client:UseDefib')
end)

lib.callback.register('qb-ambulancejob:OpenLocker', function(source)
  local playerData = QBCore.Functions.GetPlayer(source).PlayerData
  if playerData.job.name ~= 'ambulance' then return false end

  exports.ox_inventory:RegisterStash(string.format('emslocker_%s', playerData.citizenid), 'EMS Locker', 50, 100000, playerData.citizenid, nil, coords)

  return true
end)

RegisterNetEvent('QBCore:Server:OnJobUpdate', function(source, newJob)
  if Doctors[source] and newJob.name ~= 'ambulance' then
    Doctors[source] = nil
    doctorsCount -= 1
    TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
    return
  end

  if newJob.name ~= 'ambulance' then return end
  if Doctors[source] and not newJob.onduty then
    Doctors[source] = nil
    doctorsCount -= 1
    TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
  end
  if not newJob.onduty then return end
  Doctors[source] = true
  doctorsCount += 1
  TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
end)

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
  local src = source
  local PlayerData = QBCore.Functions.GetPlayer(src).PlayerData
  local job = PlayerData.job

  if job.name ~= 'ambulance' then return end
  if not job.onduty then return end

  Doctors[src] = true
  doctorsCount += 1
  TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
end)

RegisterNetEvent('QBCore:Server:OnPlayerUnload', function(src)
  if Doctors[src] then
    Doctors[src] = nil
    doctorsCount -= 1
    TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
  end
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(data)
  local src = data.source
  local job = data.job

  if Doctors[src] then
    if job.name ~= 'ambulance' then
      Doctors[src] = nil
      doctorsCount -= 1
      TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
    elseif job.onduty then
      Doctors[src] = true
      doctorsCount += 1
      TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
    end
  else
    if job.name == 'ambulance' and job.onduty then
      Doctors[src] = true
      doctorsCount += 1
      TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
    end
  end
end)

AddEventHandler("playerDropped", function()
  local src = source
  if Doctors[src] then
    doctorsCount = doctorsCount - 1
    TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
    Doctors[src] = nil
  end
end)

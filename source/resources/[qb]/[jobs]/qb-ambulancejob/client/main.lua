QBCore = exports['qb-core']:GetCoreObject()

InBedDict = "anim@gangops@morgue@table@"
InBedAnim = "body_search"
IsInHospitalBed = false
IsBleeding = 0
BleedTickTimer, AdvanceBleedTimer = 0, 0
FadeOutTimer, BlackoutTimer = 0, 0
IsDead = false
HealAnimDict = "mini@cpr@char_a@cpr_str"
HealAnim = "cpr_pumpchest"
RespawnHoldTime = 5
DeadAnimDict = "dead"
DeadAnim = "dead_a"
DeathTime = 0
EmsNotified = false
CanLeaveBed = true
BedOccupying = nil
Laststand = {
  ReviveInterval = 360,
  MinimumRevive = 300,
}
InLaststand = false
LaststandTime = 0
LastStandDict = "dead"
LastStandAnim = "dead_a"
IsEscorted = false
OnPainKillers = false
DoctorCount = 0
PlayerData = {
  job = nil
}

---@type number
PlayerHealth = nil

---@class Injury
---@field part Bone body part
---@field severity integer higher numbers are worse injuries
---@field label string

---@type Injury[]
Injured = {}

---@type number[] weapon hashes
CurrentDamageList = {}

---@class BodyPart
---@field label string
---@field causeLimp boolean
---@field isDamaged boolean
---@field severity integer

---@alias BodyParts table<Bone, BodyPart>
---@type BodyParts
BodyParts = {
  ['HEAD'] = { label = Lang:t('body.head'), causeLimp = false, isDamaged = false, severity = 0 },
  ['NECK'] = { label = Lang:t('body.neck'), causeLimp = false, isDamaged = false, severity = 0 },
  ['SPINE'] = { label = Lang:t('body.spine'), causeLimp = true, isDamaged = false, severity = 0 },
  ['UPPER_BODY'] = { label = Lang:t('body.upper_body'), causeLimp = false, isDamaged = false, severity = 0 },
  ['LOWER_BODY'] = { label = Lang:t('body.lower_body'), causeLimp = true, isDamaged = false, severity = 0 },
  ['LARM'] = { label = Lang:t('body.left_arm'), causeLimp = false, isDamaged = false, severity = 0 },
  ['LHAND'] = { label = Lang:t('body.left_hand'), causeLimp = false, isDamaged = false, severity = 0 },
  ['LFINGER'] = { label = Lang:t('body.left_fingers'), causeLimp = false, isDamaged = false, severity = 0 },
  ['LLEG'] = { label = Lang:t('body.left_leg'), causeLimp = true, isDamaged = false, severity = 0 },
  ['LFOOT'] = { label = Lang:t('body.left_foot'), causeLimp = true, isDamaged = false, severity = 0 },
  ['RARM'] = { label = Lang:t('body.right_arm'), causeLimp = false, isDamaged = false, severity = 0 },
  ['RHAND'] = { label = Lang:t('body.right_hand'), causeLimp = false, isDamaged = false, severity = 0 },
  ['RFINGER'] = { label = Lang:t('body.right_fingers'), causeLimp = false, isDamaged = false, severity = 0 },
  ['RLEG'] = { label = Lang:t('body.right_leg'), causeLimp = true, isDamaged = false, severity = 0 },
  ['RFOOT'] = { label = Lang:t('body.right_foot'), causeLimp = true, isDamaged = false, severity = 0 },
}

RegisterNetEvent('QBCore:Player:SetPlayerData', function(data)
  if GetInvokingResource() then return end
  PlayerData = data
end)

---notify the player of damage to their body.
local function doLimbAlert()
  if IsDead or InLaststand or #Injured == 0 then return end

  local limbDamageMsg = ''
  if #Injured <= Config.AlertShowInfo then
    for k, v in pairs(Injured) do
      limbDamageMsg = limbDamageMsg .. Lang:t('info.pain_message', { limb = v.label, severity = Config.WoundStates[v.severity] })
      if k < #Injured then
        limbDamageMsg = limbDamageMsg .. " | "
      end
    end
  else
    limbDamageMsg = Lang:t('info.many_places')
  end
  lib.notify({ description = limbDamageMsg, type = 'error' })
end

---notify the player of bleeding to their body.
function SendBleedAlert()
  if IsDead or tonumber(IsBleeding) <= 0 then return end
  lib.notify({ title = Lang:t('info.bleed_alert', { bleedstate = Config.BleedingStates[tonumber(IsBleeding)].label }), type = 'info' })
end

---adds a bleed to the player and alerts them. Total bleed level maxes at 4.
---@param level 1|2|3|4 speed of the bleed
function ApplyBleed(level)
  if IsBleeding == 4 then return end
  IsBleeding = (IsBleeding + level >= 4) and 4 or (IsBleeding + level)
  SendBleedAlert()
end

---@return boolean isInjuryCausingLimp if injury causes a limp and is damaged.
local function isInjuryCausingLimp()
  for _, v in pairs(BodyParts) do
    if v.causeLimp and v.isDamaged then
      return true
    end
  end
  return false
end

---sets ped animation to limping and prevents running.
function MakePedLimp(ped)
  if not isInjuryCausingLimp() then return end
  lib.requestAnimSet("move_m@injured")
  SetPedMovementClipset(ped, "move_m@injured", 1)
  SetPlayerSprint(cache.playerId, false)
end

function ResetMajorInjuries()
  for _, v in pairs(BodyParts) do
    if v.isDamaged and v.severity <= 2 then
      v.isDamaged = false
      v.severity = 0
    end
  end

  for k, v in pairs(Injured) do
    if v.severity <= 2 then
      v.severity = 0
      table.remove(Injured, k)
    end
  end

  if IsBleeding <= 2 then
    IsBleeding = 0
    BleedTickTimer = 0
    AdvanceBleedTimer = 0
    FadeOutTimer = 0
    BlackoutTimer = 0
  end

  -- TODO: do we need to sync twice?
  TriggerServerEvent('hospital:server:SyncInjuries', {
    limbs = BodyParts,
    isBleeding = tonumber(IsBleeding)
  })

  MakePedLimp(cache.ped)
  doLimbAlert()
  SendBleedAlert()

  TriggerServerEvent('hospital:server:SyncInjuries', {
    limbs = BodyParts,
    isBleeding = tonumber(IsBleeding)
  })
end

function ResetAllInjuries()
  IsBleeding = 0
  BleedTickTimer = 0
  AdvanceBleedTimer = 0
  FadeOutTimer = 0
  BlackoutTimer = 0
  Injured = {}

  for _, v in pairs(BodyParts) do
    v.isDamaged = false
    v.severity = 0
  end

  -- TODO: do we need to sync twice?
  TriggerServerEvent('hospital:server:SyncInjuries', {
    limbs = BodyParts,
    isBleeding = tonumber(IsBleeding)
  })

  CurrentDamageList = {}
  TriggerServerEvent('hospital:server:SetWeaponDamage', CurrentDamageList)

  MakePedLimp(cache.ped)
  doLimbAlert()
  SendBleedAlert()

  TriggerServerEvent('hospital:server:SyncInjuries', {
    limbs = BodyParts,
    isBleeding = tonumber(IsBleeding)
  })
  TriggerServerEvent("hospital:server:resetHungerThirst")
end

---creates an injury on body part with random severity between 1 and maxSeverity.
---@param bodyPart BodyPart
---@param bone Bone
---@param maxSeverity number
function CreateInjury(bodyPart, bone, maxSeverity)
  if bodyPart.isDamaged then return end

  bodyPart.isDamaged = true
  bodyPart.severity = math.random(1, maxSeverity)
  Injured[#Injured + 1] = {
    part = bone,
    label = bodyPart.label,
    severity = bodyPart.severity
  }
end

-- Events

---notifies EMS of a injury at a location
---@param coords vector3
---@param text string
RegisterNetEvent('hospital:client:ambulanceAlert', function(coords, text)
  if GetInvokingResource() then return end
  local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
  local street1name = GetStreetNameFromHashKey(street1)
  local street2name = GetStreetNameFromHashKey(street2)
  lib.notify({ title = Lang:t('text.alert'), description = text .. ' | ' .. street1name .. ' ' .. street2name, type = 'info' })
  PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
  local transG = 250
  local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
  local blip2 = AddBlipForCoord(coords.x, coords.y, coords.z)
  local blipText = Lang:t('info.ems_alert', { text = text })
  SetBlipSprite(blip, 153)
  SetBlipSprite(blip2, 161)
  SetBlipColour(blip, 1)
  SetBlipColour(blip2, 1)
  SetBlipDisplay(blip, 4)
  SetBlipDisplay(blip2, 8)
  SetBlipAlpha(blip, transG)
  SetBlipAlpha(blip2, transG)
  SetBlipScale(blip, 0.8)
  SetBlipScale(blip2, 2.0)
  SetBlipAsShortRange(blip, false)
  SetBlipAsShortRange(blip2, false)
  PulseBlip(blip2)
  BeginTextCommandSetBlipName('STRING')
  AddTextComponentString(blipText)
  EndTextCommandSetBlipName(blip)
  while transG ~= 0 do
    Wait(720)
    transG -= 1
    SetBlipAlpha(blip, transG)
    SetBlipAlpha(blip2, transG)
    if transG == 0 then
      RemoveBlip(blip)
      return
    end
  end
end)

---Revives player, healing all injuries
---Intended to be called from client or server.
RegisterNetEvent('hospital:client:Revive', function()
  local ped = cache.ped

  if IsDead or InLaststand then
    local pos = GetEntityCoords(ped, true)
    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(ped), true, false)
    IsDead = false
    SetEntityInvincible(ped, false)
    EndLastStand()
  end

  if IsInHospitalBed then
    lib.requestAnimDict(InBedDict)
    TaskPlayAnim(ped, InBedDict, InBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
    SetEntityInvincible(ped, true)
    CanLeaveBed = true
  end

  TriggerServerEvent("hospital:server:RestoreWeaponDamage")
  SetEntityMaxHealth(ped, 200)
  SetEntityHealth(ped, 200)
  ClearPedBloodDamage(ped)
  SetPlayerSprint(cache.playerId, true)
  ResetAllInjuries()
  ResetPedMovementClipset(ped, 0.0)
  TriggerServerEvent('hud:server:RelieveStress', 100)
  TriggerServerEvent("hospital:server:SetDeathStatus", false)
  TriggerServerEvent("hospital:server:SetLaststandStatus", false)

  LocalPlayer.state:set('isDead', false, true)
  LocalPlayer.state:set('isDown', false, true)

  EmsNotified = false
  lib.notify({ description = Lang:t('info.healthy'), type = 'info' })
end)

---Creates random injuries on the player
RegisterNetEvent('hospital:client:SetPain', function()
  if GetInvokingResource() then return end
  ApplyBleed(math.random(1, 4))
  local bone = Config.Bones[24816]

  CreateInjury(BodyParts[bone], bone, 4)

  bone = Config.Bones[40269]
  CreateInjury(BodyParts[bone], bone, 4)

  TriggerServerEvent('hospital:server:SyncInjuries', {
    limbs = BodyParts,
    isBleeding = tonumber(IsBleeding)
  })
end)

RegisterNetEvent('hospital:client:KillPlayer', function()
  if GetInvokingResource() then return end
  SetEntityHealth(cache.ped, 0)
end)

---heals player wounds.
---@param type? "full"|any heals all wounds if full otherwise heals only major wounds.
RegisterNetEvent('hospital:client:HealInjuries', function(type)
  if GetInvokingResource() then return end
  if type == "full" then
    ResetAllInjuries()
  else
    ResetMajorInjuries()
  end
  TriggerServerEvent("hospital:server:RestoreWeaponDamage")

  lib.notify({ description = Lang:t('success.wounds_healed'), type = 'success' })
end)

---@param bedsKey "jailbeds"|"beds"
---@param id number
---@param isTaken boolean
RegisterNetEvent('hospital:client:SetBed', function(bedsKey, id, isTaken)
  if GetInvokingResource() then return end
  Config.Locations[bedsKey][id].taken = isTaken
end)

---sends player phone email with hospital bill.
---@param amount number
RegisterNetEvent('hospital:client:SendBillEmail', function(amount)
  if GetInvokingResource() then return end
  SetTimeout(math.random(2500, 4000), function()
    local charInfo = PlayerData.charinfo
    local gender = charInfo.gender == 1 and Lang:t('info.mrs') or Lang:t('info.mr')
    TriggerServerEvent('qb-phone:server:sendNewMail', {
      sender = Lang:t('mail.sender'),
      subject = Lang:t('mail.subject'),
      message = Lang:t('mail.message', { gender = gender, lastname = charInfo.lastname, costs = amount }),
      button = {}
    })
  end)
end)

RegisterNetEvent('hospital:client:adminHeal', function()
  if GetInvokingResource() then return end
  SetEntityHealth(cache.ped, 200)
  TriggerServerEvent("hospital:server:resetHungerThirst")
end)

-- Threads

---sets blips for stations on map
CreateThread(function()
  for _, station in pairs(Config.Locations.stations) do
    local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
    SetBlipSprite(blip, 61)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 25)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(station.label)
    EndTextCommandSetBlipName(blip)
  end
end)

CreateThread(function()
  while true do
    Wait((1000 * Config.MessageTimer))
    doLimbAlert()
  end
end)

function GetClosestPlayer()
  local coords = GetEntityCoords(cache.ped)
  return QBCore.Functions.GetClosestPlayer(coords)
end

RegisterNetEvent('hospital:client:SetDoctorCount', function(amount)
  DoctorCount = amount
end)

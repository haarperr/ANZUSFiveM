local playerArmor = nil

---returns true if player took damage in their upper body or if the weapon class is nothing.
---@param isArmorDamaged boolean
---@param bodypart string
---@param weapon number
---@return boolean
local function checkBodyHitOrWeakWeapon(isArmorDamaged, bodypart, weapon)
  return isArmorDamaged and (bodypart == 'SPINE' or bodypart == 'UPPER_BODY') or weapon == Config.WeaponClasses['NOTHING']
end

---gets the weapon class of the weapon that damaged the player.
---@param ped number player's ped
---@return integer|nil weaponClass as defined by config.lua, or nil if player hasn't been damaged.
local function getDamagingWeapon(ped)
  for k, v in pairs(Config.Weapons) do
  if HasPedBeenDamagedByWeapon(ped, k, 0) then
    return v
  end
  end
end

---health lost becomes a damaging event if a certain weapon was used or hp lost is above the force injury threshold.
---Otherwise, the probability of a damaging event goes up from 0 as the damageDone increases above the minimum threshold.
---@param damageDone number hitpoints lost
---@return boolean isDamagingEvent true if player should have disabilities from damage.
local function isDamagingEvent(damageDone, weapon)
  local luck = math.random(100)
  local multi = damageDone / Config.HealthDamage

  return luck < (Config.HealthDamage * multi) or (damageDone >= Config.ForceInjury or multi > Config.MaxInjuryChanceMulti or Config.ForceInjuryWeapons[weapon])
end

---Sets a ragdoll effect probablistically on the player's ped.
---@param ped number
---@param isArmored boolean
---@param chance number
---@param armor number
local function applyStaggerEffect(ped, isArmored, chance, armor)
  if not isArmored or armor > 0 or math.random(100) > math.ceil(chance) then return end
  SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
end

---applies a minor bleed if player has no armor and is hit in a critical area.
---also makes player stagger if hit in a certain body part.
---@param ped number
---@param bone Bone body part where player is damaged
---@param armor number
local function applyImmediateMinorEffects(ped, bone, armor)
  if Config.CriticalAreas[bone] and armor <= 0 then
     ApplyBleed(1)
  end

  local staggerArea = Config.StaggerAreas[bone]
  if not staggerArea then return end
  applyStaggerEffect(ped, staggerArea.armored, staggerArea.minor, armor)
end

---Applies bleed with probability based on armor and location hit. Also applies stagger effect.
---@param ped number
---@param bone Bone body part where player is damaged
---@param armor number
local function applyImmediateMajorEffects(ped, bone, armor)
  local criticalArea = Config.CriticalAreas[bone]
  if criticalArea then
    if armor > 0 and criticalArea.armored then
      if math.random(100) <= math.ceil(Config.MajorArmoredBleedChance) then
        ApplyBleed(1)
      end
    else
      ApplyBleed(1)
    end
  else
    if armor > 0 then
      if math.random(100) < (Config.MajorArmoredBleedChance) then
        ApplyBleed(1)
      end
    elseif math.random(100) < (Config.MajorArmoredBleedChance * 2) then
      ApplyBleed(1)
    end
  end

  local staggerArea = Config.StaggerAreas[bone]
  if not staggerArea then return end
  applyStaggerEffect(ped, staggerArea.armored, staggerArea.major, armor)
end

---Apply bleeds and staggers effects on damage taken, taking into account armor.
---@param ped number
---@param bone Bone
---@param weapon number
---@param damageDone number
local function applyImmediateEffects(ped, bone, weapon, damageDone)
  local armor = GetPedArmour(ped)
  if Config.MinorInjurWeapons[weapon] and damageDone < Config.DamageMinorToMajor then
    applyImmediateMinorEffects(ped, bone, armor)
  elseif Config.MajorInjurWeapons[weapon] or (Config.MinorInjurWeapons[weapon] and damageDone >= Config.DamageMinorToMajor) then
    applyImmediateMajorEffects(ped, bone, armor)
  end
end

---Increases severity of an injury
---@param bodyPart BodyPart
---@param bone Bone
local function upgradeInjury(bodyPart, bone)
  if bodyPart.severity >= 4 then return end

  bodyPart.severity += 1
  for _, injury in pairs(Injured) do
    if injury.part == bone then
      injury.severity = bodyPart.severity
    end
  end
end

---create/upgrade injury at bone.
---@param bone Bone
local function injureBodyPart(bone)
  local bodyPart = BodyParts[bone]
  if not bodyPart.isDamaged then
    CreateInjury(bodyPart, bone, 3)
  else
    upgradeInjury(bodyPart, bone)
  end
end

---Apply bleeds, injure the body part hit, make ped limp/stagger
---@param ped number
---@param boneId integer
---@param weapon number
---@param damageDone number
local function checkDamage(ped, boneId, weapon, damageDone)
  if not weapon then return end

  local bone = Config.Bones[boneId]
  if not bone or IsDead or InLaststand then return end

  applyImmediateEffects(ped, bone, weapon, damageDone)
  injureBodyPart(bone)

  TriggerServerEvent('hospital:server:SyncInjuries', {
    limbs = BodyParts,
    isBleeding = tonumber(IsBleeding)
  })

  MakePedLimp(ped)
end

---Apply damage to health and armor based off of damage done and weapon used.
---@param ped number
---@param damageDone number
---@param isArmorDamaged boolean
local function applyDamage(ped, damageDone, isArmorDamaged)
  local hit, bone = GetPedLastDamageBone(ped)
  local bodypart = Config.Bones[bone]
  local weapon = getDamagingWeapon(ped)

  if not hit or bodypart == 'NONE' or not weapon then return end

  if damageDone >= Config.HealthDamage then
    local isBodyHitOrWeakWeapon = checkBodyHitOrWeakWeapon(isArmorDamaged, bodypart, weapon)
    if isBodyHitOrWeakWeapon and isArmorDamaged then
      TriggerServerEvent("hospital:server:SetArmor", GetPedArmour(ped))
    elseif not isBodyHitOrWeakWeapon and isDamagingEvent(damageDone, weapon) then
      checkDamage(ped, bone, weapon, damageDone)
    end
  elseif Config.AlwaysBleedChanceWeapons[weapon]
    and math.random(100) < Config.AlwaysBleedChance
    and not checkBodyHitOrWeakWeapon(isArmorDamaged, bodypart, weapon) then
    ApplyBleed(1)
  end
end

---searches array for weapon hash
---@param hash number weapon hash
---@return boolean inDamageList if weapon hash is in the array
local function isInDamageList(hash)
  if not CurrentDamageList then return false end

  for _, v in pairs(CurrentDamageList) do
    if v == hash then
      return true
    end
  end

  return false
end

---Adds weapon hashes that damaged the ped that aren't already in the CurrentDamagedList and syncs to the server.
---@param ped number
local function findDamageCause(ped)
  local detected = false
  for hash, weapon in pairs(QBCore.Shared.Weapons) do
    if HasPedBeenDamagedByWeapon(ped, hash, 0) and not isInDamageList(hash) then
      detected = true
      TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0 },
        multiline = false,
        args = { Lang:t('info.status'), weapon.damagereason }
      })
      CurrentDamageList[#CurrentDamageList + 1] = hash
    end
  end
  if detected then
    TriggerServerEvent("hospital:server:SetWeaponDamage", CurrentDamageList)
  end
end

---If the player health and armor haven't already been set, initialize them.
---@param health number
---@param armor number
local function initHealthAndArmorIfNotSet(health, armor)
  if not PlayerHealth then
    PlayerHealth = health
  end

  if not playerArmor then
    playerArmor = armor
  end
end

---detects if player took damage, applies injuries, and updates health/armor values
---@param ped number
local function checkForDamage(ped)
  local health = GetEntityHealth(ped)
  local armor = GetPedArmour(ped)

  initHealthAndArmorIfNotSet(health, armor)

  local isArmorDamaged = (playerArmor ~= armor and armor < (playerArmor - Config.ArmorDamage) and armor > 0) -- Players armor was damaged
  local isHealthDamaged = (PlayerHealth ~= health) -- Players health was damaged

  if isArmorDamaged or isHealthDamaged then
    local damageDone = (PlayerHealth - health)
    applyDamage(ped, damageDone, isArmorDamaged)
    findDamageCause(ped)
    ClearEntityLastDamageEntity(ped)
  end

  PlayerHealth = health
  playerArmor = armor
end

---Checks the player for damage, applies injuries, and damage effects
CreateThread(function()
  while true do
    local ped = cache.ped
    checkForDamage(ped)
    ApplyDamageEffects(ped)
    Wait(100)
  end
end)
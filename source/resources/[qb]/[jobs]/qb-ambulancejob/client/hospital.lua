local listen = false
local bedObject = nil
local bedOccupyingData = nil
local cam = nil

---checks if bed is available and within 500 distance of pos
---@param pos vector3 position close to bed
---@param bed Bed
---@return boolean isAvailable if bed is available
local function isBedAvailable(pos, bed)
  if bed.taken then return false end
  if #(pos - vector3(bed.coords.x, bed.coords.y, bed.coords.z)) >= 500 then return false end
  return true
end

---Gets available bedId
---@param bedId? integer bedId to check. If not provided, checks all beds.
---@return integer|nil availableBedId index of available bed or nil if no bed available
local function getAvailableBed(bedId)
  local pos = GetEntityCoords(cache.ped)

  if bedId then
    return isBedAvailable(pos, Config.Locations.beds[bedId]) and bedId or nil
  end

  for index, bed in pairs(Config.Locations.beds) do
    if isBedAvailable(pos, bed) then
      return index
    end
  end
end

---Notifies doctors, and puts player in a hospital bed.
local function checkIn()
  if DoctorCount >= Config.MinimalDoctors then
    TriggerServerEvent("hospital:server:SendDoctorAlert")
    return
  end

  TriggerEvent('animations:client:EmoteCommandStart', { "notepad" })
  if lib.progressCircle({
        duration = 2000,
        position = 'bottom',
        label = Lang:t('progress.checking_in'),
        useWhileDead = false,
        canCancel = true,
        disable = {
          move = false,
          car = false,
          combat = true,
          mouse = false,
        },
        anim = {
          dict = HealAnimDict,
          clip = HealAnim,
        },
      })
  then
    TriggerEvent('animations:client:EmoteCommandStart', { "c" })
    local bedId = getAvailableBed()
    if not bedId then
      lib.notify({ description = Lang:t('error.beds_taken'), type = 'error' })
      return
    end

    TriggerServerEvent("hospital:server:SendToBed", bedId, true)
  else
    TriggerEvent('animations:client:EmoteCommandStart', { "c" })
    lib.notify({ description = Lang:t('error.canceled'), type = 'error' })
  end
end

---@return integer index of the closest bed to the player.
local function getClosestBed()
  local pos = GetEntityCoords(cache.ped, true)
  local closest = nil
  local minDist = nil
  for index, bed in pairs(Config.Locations.beds) do
    local bedDistance = #(pos - vector3(bed.coords.x, bed.coords.y, bed.coords.z))
    if not closest or bedDistance < minDist then
      closest = index
      minDist = bedDistance
    end
  end

  return closest
end

---Puts player in the closest hospital bed if available.
local function putPlayerInClosestBed()
  if IsInHospitalBed then return end
  local closestBed = getClosestBed()
  if getAvailableBed(closestBed) then
    TriggerServerEvent("hospital:server:SendToBed", closestBed, false)
  else
    lib.notify({ description = Lang:t('error.beds_taken'), type = 'error' })
  end
end

---allow players to press button to check in or get put in a bed
---@param variable "checkin"|"beds"
local function checkInControls(variable)
  listen = true
  repeat
    if IsControlJustPressed(0, 38) then
      exports['qb-core']:KeyPressed(38)
      if variable == "checkin" then
        checkIn()
        listen = false
      elseif variable == "beds" then
        putPlayerInClosestBed()
        listen = false
      end
    end
    Wait(0)
  until not listen
end

---Set up check-in and getting into beds using either target or zones
if Config.UseTarget then
  CreateThread(function()
    for k, v in pairs(Config.Locations.checking) do
      exports.ox_target:addBoxZone({
        name = "checking" .. k,
        coords = vec3(v.x, v.y, v.z),
        size = vec3(2, 1, 2),
        rotation = 18,
        debug = false,
        options = {
          {
            type = "client",
            onSelect = checkIn,
            icon = "fas fa-clipboard",
            label = Lang:t('text.check'),
            distance = 1.5,
          }
        }
      })
    end

    for k, v in pairs(Config.Locations.beds) do
      exports.ox_target:addBoxZone({
        name = "beds" .. k,
        coords = vec3(v.coords.x, v.coords.y, v.coords.z),
        size = vec3(1.7, 1.9, 2),
        rotation = v.coords.w,
        debug = false,
        options = {
          {
            type = "client",
            onSelect = putPlayerInClosestBed,
            icon = "fas fa-clipboard",
            label = Lang:t('text.bed'),
            distance = 1.5,
          }
        }
      })
    end
  end)
else
  CreateThread(function()
    for _, v in pairs(Config.Locations.checking) do
      local function enterCheckInZone()
        if DoctorCount >= Config.MinimalDoctors then
          lib.showTextUI(Lang:t('text.call_doc'))
          CreateThread(function()
            checkInControls("checkin")
          end)
        else
          lib.showTextUI(Lang:t('text.check_in'))
        end
      end

      local function outCheckInZone()
        listen = false
        lib.hideTextUI()
      end

      lib.zones.box({
        coords = vec3(v.x, v.y, v.z),
        size = vec3(2, 1, 2),
        rotation = 18,
        debug = false,
        onEnter = enterCheckInZone,
        onExit = outCheckInZone
      })
    end
    for _, v in pairs(Config.Locations.beds) do
      local function enterBedZone()
        lib.showTextUI(Lang:t('text.lie_bed'))
        CreateThread(function()
          checkInControls("beds")
        end)
      end

      local function outBedZone()
        listen = false
        lib.hideTextUI()
      end

      lib.zones.box({
        coords = vec3(v.coords.x, v.coords.y, v.coords.z),
        size = vec3(1.9, 2.1, 2),
        rotation = v.coords.w,
        debug = false,
        onEnter = enterBedZone,
        onExit = outBedZone
      })
    end
  end)
end

---plays animation to get out of bed and resets variables
local function leaveBed()
  local ped = cache.ped
  local getOutDict = 'switch@franklin@bed'
  local getOutAnim = 'sleep_getup_rubeyes'

  lib.requestAnimDict(getOutDict)
  FreezeEntityPosition(ped, false)
  SetEntityInvincible(ped, false)
  SetEntityHeading(ped, bedOccupyingData.coords.w + 90)
  TaskPlayAnim(ped, getOutDict, getOutAnim, 100.0, 1.0, -1, 8, -1, false, false, false)
  Wait(4000)
  ClearPedTasks(ped)
  TriggerServerEvent('hospital:server:LeaveBed', BedOccupying)
  FreezeEntityPosition(bedObject, true)
  RenderScriptCams(false, true, 200, true, true)
  DestroyCam(cam, false)

  BedOccupying = nil
  bedObject = nil
  bedOccupyingData = nil
  IsInHospitalBed = false

  if PlayerData.metadata.injail <= 0 then return end
  TriggerEvent("prison:client:Enter", PlayerData.metadata.injail)
end

---Shows leave bed text if the player can leave the bed, triggers leaving the bed if the right key is pressed.
local function givePlayerOptionToLeaveBed()
  lib.showTextUI(Lang:t('text.bed_out'))
  if not IsControlJustReleased(0, 38) then return end

  exports['qb-core']:KeyPressed(38)
  leaveBed()
  lib.hideTextUI()
end

---shows player option to press key to leave bed when available.
CreateThread(function()
  while true do
    if IsInHospitalBed and CanLeaveBed then
      givePlayerOptionToLeaveBed()
      Wait(0)
    else
      Wait(1000)
    end
  end
end)

---Teleports the player to lie down in bed and sets the player's camera.
local function setBedCam()
  IsInHospitalBed = true
  CanLeaveBed = false
  local player = cache.ped

  DoScreenFadeOut(1000)

  while not IsScreenFadedOut() do
    Wait(100)
  end

  if IsPedDeadOrDying(player) then
    local pos = GetEntityCoords(player, true)
    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
  end

  bedObject = GetClosestObjectOfType(bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z, 1.0, bedOccupyingData.model, false, false, false)
  FreezeEntityPosition(bedObject, true)

  SetEntityCoords(player, bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z + 0.02)
  Wait(500)
  FreezeEntityPosition(player, true)

  lib.requestAnimDict(InBedDict)

  TaskPlayAnim(player, InBedDict, InBedAnim, 8.0, 1.0, -1, 1, 0, false, false, false)
  SetEntityHeading(player, bedOccupyingData.coords.w)

  cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
  SetCamActive(cam, true)
  RenderScriptCams(true, false, 1, true, true)
  AttachCamToPedBone(cam, player, 31085, 0, 1.0, 1.0, true)
  SetCamFov(cam, 90.0)
  local heading = GetEntityHeading(player)
  heading = (heading > 180) and heading - 180 or heading + 180
  SetCamRot(cam, -45.0, 0.0, heading, 2)

  DoScreenFadeIn(1000)

  Wait(1000)
  FreezeEntityPosition(player, true)
end

---Puts the player in bed
---@param id number the map key of the bed
---@param bed Bed
---@param isRevive boolean if true, heals the player
RegisterNetEvent('hospital:client:SendToBed', function(id, bed, isRevive)
  if GetInvokingResource() then return end
  BedOccupying = id
  bedOccupyingData = bed
  setBedCam()
  CreateThread(function()
    Wait(5)
    if isRevive then
      lib.notify({ description = Lang:t('success.being_helped'), type = 'success' })
      Wait(Config.AIHealTimer * 1000)
      TriggerEvent("hospital:client:Revive")
    else
      CanLeaveBed = true
    end
  end)
end)

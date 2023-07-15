local check = false
local zones = {}

---show patient's treatment menu.
---@param status string[]
local function showTreatmentMenu(status)
  local statusMenu = {}
  for i = 1, #status do
    statusMenu[i] = {
      title = status[i],
      event = "hospital:client:TreatWounds",
    }
  end

  lib.registerContext({
    id = 'ambulance_status_context_menu',
    title = Lang:t('menu.status'),
    options = statusMenu
  })
  lib.showContext('ambulance_status_context_menu')
end

---Convert wounded body part data to a human readable form
---@param damagedBodyParts BodyParts
---@return string[]
local function getPatientStatus(damagedBodyParts)
  local status = {}
  for _, bodyPart in pairs(damagedBodyParts) do
    status[#status + 1] = bodyPart.label .. " (" .. Config.WoundStates[bodyPart.severity] .. ")"
  end
  return status
end

---Check status of nearest player and show treatment menu.
---Intended to be invoked by client or server.
RegisterNetEvent('hospital:client:CheckStatus', function()
  local player, distance = GetClosestPlayer()
  if player == -1 or distance > 5.0 then
    lib.notify({ description = Lang:t('error.no_player'), type = 'error' })
    return
  end
  local playerId = GetPlayerServerId(player)

  ---@param damage PlayerDamage
  local damage = lib.callback.await('hospital:GetPlayerStatus', false, playerId)
  if not damage or (damage.bleedLevel == 0 and #damage.damagedBodyParts == 0 and #damage.weaponWounds == 0) then
    lib.notify({ description = Lang:t('success.healthy_player'), type = 'success' })
    return
  end

  for _, hash in pairs(damage.weaponWounds) do
    TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0 },
      multiline = false,
      args = { Lang:t('info.status'), QBCore.Shared.Weapons[hash].damagereason }
    })
  end

  if damage.bleedLevel > 0 then
    TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0 },
      multiline = false,
      args = { Lang:t('info.status'), Lang:t('info.is_status', { status = Config.BleedingStates[damage.bleedLevel].label }) }
    })
  end

  local status = getPatientStatus(damage.damagedBodyParts)
  showTreatmentMenu(status)
end)

---Use defibrillator (defib) on nearest player to revive them.
---Intended to be invoked by client or server.
RegisterNetEvent('hospital:client:RevivePlayer', function()
  if not QBCore.Functions.HasItem('defib') then
    lib.notify({ description = Lang:t('error.no_defib'), type = 'error' })
    return
  end

  local player, distance = GetClosestPlayer()
  if player == -1 or distance >= 5.0 then
    lib.notify({ description = Lang:t('error.no_player'), type = 'error' })
    return
  end

  if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        label = Lang:t('progress.revive'),
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
    StopAnimTask(cache.ped, HealAnimDict, "exit", 1.0)
    lib.notify({ description = Lang:t('success.revived'), type = 'success' })
    TriggerServerEvent("hospital:server:RevivePlayer", GetPlayerServerId(player))
  else
    StopAnimTask(cache.ped, HealAnimDict, "exit", 1.0)
    lib.notify({ description = Lang:t('error.canceled'), type = 'error' })
  end
end)

---Use bandage on nearest player to treat their wounds.
---Intended to be invoked by client or server.
RegisterNetEvent('hospital:client:TreatWounds', function()
  if not QBCore.Functions.HasItem('bandage') then
    lib.notify({ description = Lang:t('error.no_bandage'), type = 'error' })
    return
  end

  local player, distance = GetClosestPlayer()
  if player == -1 or distance >= 5.0 then
    lib.notify({ description = Lang:t('error.no_player'), type = 'error' })
    return
  end

  if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        label = Lang:t('progress.healing'),
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
    StopAnimTask(cache.ped, HealAnimDict, "exit", 1.0)
    lib.notify({ description = Lang:t('success.helped_player'), type = 'success' })
    TriggerServerEvent("hospital:server:TreatWounds", GetPlayerServerId(player))
  else
    StopAnimTask(cache.ped, HealAnimDict, "exit", 1.0)
    lib.notify({ description = Lang:t('error.canceled'), type = 'error' })
  end
end)

---calls a function when the player presses a key
---@param cb function to call when key is pressed
local function emsControls(cb)
  CreateThread(function()
    check = true
    while check do
      if IsControlJustPressed(0, 38) then
        exports['qb-core']:KeyPressed(38)
        cb()
      end
      Wait(0)
    end
  end)
end

---Opens the hospital stash.
local function openStash()
  if PlayerData.job.name ~= 'ambulance' then return end
  if not PlayerData.job.onduty then return end
  local success = lib.callback.await('qb-ambulancejob:OpenLocker', false)

  if not success then
    return lib.notify({
      type = 'error',
      title = 'Emergency Medical Services',
      description = 'Unable to open your locker at this time'
    })
  end

  exports.ox_inventory:openInventory('stash', string.format('emslocker_%s', PlayerData.citizenid))
end

---Teleports the player with a fade in/out effect
---@param coords vector4
local function teleportPlayerWithFade(coords)
  local ped = cache.ped
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do
    Wait(10)
  end

  SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, false)
  SetEntityHeading(ped, coords.w)

  Wait(100)

  DoScreenFadeIn(1000)
end

---Teleports the player to main elevator
local function teleportToMainElevator()
  teleportPlayerWithFade(Config.Locations.main[1])
end

---Teleports the player to roof elevator
local function teleportToRoofElevator()
  teleportPlayerWithFade(Config.Locations.roof[1])
end

---Teleports the player to the lower elevator
local function teleportToLowerElevator()
  teleportPlayerWithFade(Config.Locations.lower[1])
end

---Toggles the on duty status of the player.
local function toggleDuty()
  TriggerServerEvent("QBCore:ToggleDuty")
  TriggerServerEvent("police:server:UpdateBlips")
end

local dutyZ = {}
local repairZones = {}

local function setupInit()
  for k, v in pairs(Config.Locations.duty) do
    dutyZ[#dutyZ + 1] = exports.ox_target:addBoxZone({
      name = "duty" .. k,
      coords = vec3(v.x, v.y, v.z),
      size = vec3(1.5, 1, 2),
      rotation = 71,
      debug = false,
      options = {
        {
          type = "client",
          onSelect = toggleDuty,
          icon = "fa fa-clipboard",
          label = Lang:t('text.duty'),
          distance = 2,
        }
      }
    })
  end

  for k, v in pairs(Config.Locations.repair) do
    repairZones[#repairZones + 1] = lib.zones.box({
      name = "emsrepair" .. k,
      coords = v.coords,
      size = v.size,
      rotation = v.rotation,
      onEnter = function()
        lib.addRadialItem({
          id = 'repair_station_ems',
          label = 'Repair',
          icon = 'box-open',
          onSelect = function()
            TriggerEvent('jim-mechanic:client:Police:Menu')
          end
        })
      end,
      onExit = function()
        lib.removeRadialItem('repair_station_ems')
      end,
    })
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  local data = QBCore.Functions.GetPlayerData()
  if data.job.name == 'ambulance' then
    setupInit()
  end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerData.job = JobInfo

  if JobInfo.name ~= 'ambulance' then
    if #dutyZ == 0 then goto skip end
    for _, v in pairs(dutyZ) do
      exports.ox_target:removeZone(v)
    end
    ::skip::
    dutyZ = {}

    if #repairZones == 0 then goto skip2 end
    for _, v in pairs(repairZones) do
      v:remove()
    end

    ::skip2::
    repairZones = {}

    return
  end


  setupInit()
end)

---Sets up duty toggle, stash, and elevator interactions using either target or zones.
CreateThread(function()
  for k, v in pairs(Config.Locations.stash) do
    lib.zones.poly({
      name = "emsstash" .. k,
      points = v.points,
      thickness = v.thickness,
      onEnter = function()
        if PlayerData.job.name ~= 'ambulance' then return end
        if not PlayerData.job.onduty then return end
        lib.addRadialItem({
          id = 'ems_locker',
          label = 'Locker',
          icon = 'box-open',
          onSelect = function()
            openStash()
          end
        })
      end,
      onExit = function()
        lib.removeRadialItem('ems_locker')
      end,
    })
  end
  for k, v in pairs(Config.Locations.repair_zone) do
    zones[#zones + 1] = lib.zones.poly({
      name = "emsrepair" .. k,
      points = v.points,
      thickness = v.thickness,
      onEnter = function()
        if PlayerData.job.name ~= 'ambulance' then return end
        if not PlayerData.job.onduty then return end
        lib.addRadialItem({
          id = 'ems_repairzone',
          label = 'Repair',
          icon = 'box-open',
          onSelect = function()
            TriggerEvent('jim-mechanic:client:Police:Menu')
          end
        })
      end,
      onExit = function()
        lib.removeRadialItem('ems_repairzone')
      end,
    })
  end


  exports.ox_target:addBoxZone({
    name = "roof1",
    coords = Config.Locations.roof[1],
    size = vec3(1, 2, 2),
    rotation = -20,
    debug = false,
    options = {
      {
        type = "client",
        onSelect = teleportToMainElevator,
        icon = "fas fa-hand-point-up",
        label = Lang:t('text.el_main'),
        distance = 1.5
      }
    }
  })
  exports.ox_target:addBoxZone({
    name = "main1",
    coords = Config.Locations.main[1],
    size = vec3(2, 1, 2),
    rotation = -20,
    debug = false,
    options = {
      {
        type = "client",
        onSelect = teleportToRoofElevator,
        icon = "fas fa-hand-point-up",
        label = Lang:t('text.el_roof'),
        distance = 1.5
      },
      {
        type = "client",
        onSelect = teleportToLowerElevator,
        icon = "fas fa-hand-point-up",
        label = Lang:t('text.el_down'),
        distance = 1.5
      }
    }
  })


  exports.ox_target:addBoxZone({
    name = "main1",
    coords = Config.Locations.lower[1],
    size = vec3(2, 1, 2),
    rotation = -20,
    debug = false,
    options = {
      {
        type = "client",
        onSelect = teleportToMainElevator,
        icon = "fas fa-hand-point-up",
        label = Lang:t('text.el_main'),
        distance = 1.5
      },
    }
  })
end)

RegisterNetEvent('hospital:client:StabilizePlayer', function()
  local hasItem = exports.ox_inventory:Search('count', 'tourniquet')
  if hasItem == 0 then return QBCore.Functions.Notify(Lang:t('error.no_tourniquet'), "error") end

  local _, ped = lib.getClosestPlayer(GetEntityCoords(cache.ped))
  if not ped then return QBCore.Functions.Notify(Lang:t('error.no_player'), "error") end

  local playerId = GetPlayerServerId(ped)
  local success = lib.progressCircle({
    duration = 5000,
    label = Lang:t('progress.stabilize'),
    position = 'bottom',
    disable = {
      combat = true,
      move = true,
    },
    anim = {
      dict = HealAnimDict,
      clip = HealAnim,
      flag = 16,
    }
  })

  if not success then return end

  QBCore.Functions.Notify(Lang:t('success.stabilized'), 'success')
  TriggerServerEvent("hospital:server:StabilizePlayer", playerId)
end)

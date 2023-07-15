QBCore = exports['qb-core']:GetCoreObject()

local prisonPeds = {}
local playSiren = false

-- Job Stuff
local curWorking = false
local jobTasks = 0
local curJob = nil
-- (Cooking)
local cooking = false
-- (Toilets)
local toilets = {}
-- (Cleaning)
-- (Electrical)
-- (Empty Garbage)
local garbagebag
local searched = {} -- Table used to store barrel ID's in
local trashCan
-- (Prisoner)
local whatJob = nil
local hasFinger = false
local opp
local fightJob = false
local onCooldown = false
local curRunning = false
-- (BrainStorm!!!!!!!!!!!!)
-- (Prison Gangs)
local gangRep = 0
local gang = nil

-- (Recreational Activities)
-- Baseball
local ball
local isPlaying = false
local hasBall = false
local ballObj
local ballID = 0
-- Basketball
local ballBasket
local isPlayingBasket = false
local hasBasketBall = false
local ballBasketObj
local ballBasketID = 0


-- (For Jailing People)
local isJailed = false
local pauseTime = false
local time = 0

-- (For Drug Making)
local startTime = 0
local finishedTime = nil
local curMixing = false
local baking = false
local onDrug = false
local drugTime = 300000

-- (For Prison Breaks)
-- local powerOutage = false

local UseQBClothing = true

if GetResourceState('fivem-appearance') ~= 'missing' then UseQBClothing = false end

-- Functions
local function SpawnPeds()
  for k, v in pairs(Config.NPCLocations) do
    QBCore.Functions.LoadModel(v.model)
    local ped = CreatePed(5, v.model, v.coords.x, v.coords.y, v.coords.z, v.heading, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    if v.headVar ~= nil then
      SetPedComponentVariation(ped, 2, 1, 1, 1)
      SetPedComponentVariation(ped, 0, v.headVar, v.headVar, v.headVar)
    end
    SetModelAsNoLongerNeeded(v.model)

    if v.scenario ~= nil then
      TaskStartScenarioInPlace(ped, v.scenario, 0, false)
    end

    if v.event2 ~= nil then
      exports['qb-target']:AddBoxZone('Prison-' .. k, v.coords, 1.0, 1.0, {
        name = 'Prison-' .. k,
        heading = v.heading,
        minZ = v.coords.z,
        maxZ = v.coords.z + 2.0,
      }, {
        options = {
          {
            icon = v.icon,
            label = v.label,
            canInteract = function(entity)
              if gang == v.gang then
                return true
              end
              return false
            end,
            action = function(entity)
              TriggerEvent(v.event, v.gang)
            end,
          },
          {
            event = 'gl-prison:turnInJob',
            icon = v.icon,
            label = "I've Finished!",
            canInteract = function(entity)
              if gang == v.gang then
                return true
              end
              return false
            end,
          },
          {
            icon = v.icon,
            label = v.label2,
            canInteract = function(entity)
              if gang == v.gang then
                return true
              end
              return false
            end,
            action = function(entity)
              TriggerEvent(v.event2, v.gang)
            end,
          },
          {
            num = 1,
            icon = v.icon,
            canInteract = function(entity)
              if gang ~= v.gang then
                return true
              end
              return false
            end,
            action = function(entity)
              TriggerEvent('gl-prison:joinPrisonGang', v.gang)
            end,
            label = 'Align with ' .. v.gang,
          },
        },
        distance = 1.5
      })
    else
      local opts = {
        {
          event = v.event,
          icon = v.icon,
          label = v.label,
        },
      }

      if k ~= 'CommissaryPed' then
        opts[#opts + 1] = {
          event = 'gl-prison:turnInJob',
          icon = v.icon,
          label = "I've Finished!",
          canInteract = function(entity)
            if curJob == k then
              return true
            end
            return false
          end,
        }
      end

      exports['qb-target']:AddBoxZone('Prison-' .. k, v.coords, 1.0, 1.0, {
        name = 'Prison-' .. k,
        heading = v.heading,
        minZ = v.coords.z,
        maxZ = v.coords.z + 2.0,
      }, {
        options = opts,
        distance = 1.5
      })
    end
    prisonPeds['Prison-' .. k] = ped
  end
end

local function RemovePeds()
  for k, v in pairs(Config.NPCLocations) do
    if DoesEntityExist(prisonPeds['Prison-' .. k]) then
      DeleteEntity(prisonPeds['Prison-' .. k])
      exports['qb-target']:RemoveZone('Prison-' .. k)
    end
  end
end

local function usedDrug()
  onDrug = true
  while onDrug do
    Wait(0)
    SetWeaponDamageModifierThisFrame(`WEAPON_UNARMED`, 1.0) -- Increase Melee
  end
end

local function drugTimer()
  while onDrug do
    drugTime = drugTime - 1000
    if drugTime <= 0 then
      onDrug = false
      AnimpostfxStopAll()
      drugTime = 120000
    end
    Wait(1000)
  end
end

local function ApplyClothes(PlayerData)
  Wait(1000)
  local ped = PlayerPedId()
  if DoesEntityExist(ped) then
    CreateThread(function()
      SetPedArmour(ped, 0)
      ClearPedBloodDamage(ped)
      ResetPedVisibleDamage(ped)
      ClearPedLastWeaponDamage(ped)
      ResetPedMovementClipset(ped, 0)
      local gender = PlayerData.charinfo.gender
      if gender == 0 then
        TriggerEvent('qb-clothing:client:loadOutfit', Config.Uniforms.male)
      else
        TriggerEvent('qb-clothing:client:loadOutfit', Config.Uniforms.female)
      end
    end)
  end
end

local function sendToJailLoaded(timeLeft)
  local ped = PlayerPedId()
  time = timeLeft
  QBCore.Functions.Notify("You're in jail for " .. time .. " months..", "error")
  TriggerServerEvent("prison:server:SetJailStatus", time)
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do
    Citizen.Wait(100)
  end
  FreezeEntityPosition(ped, false)
  SetEntityCoords(ped, Config.CellLocation.x, Config.CellLocation.y, Config.CellLocation.z)
  SetEntityHeading(ped, Config.CellHeading)
  TriggerServerEvent("InteractSound_SV:PlayOnSource", "jail", 0.5)
  DoScreenFadeIn(1000)
  isJailed = true
end

local function unJail()
  TriggerServerEvent("InteractSound_SV:PlayOnSource", "cellcall", 0.5)
  isJailed = false
  time = 0

  -- Reset Job Stuff
  curJob = nil
  jobTasks = 0
  if UseQBClothing then
    TriggerServerEvent("qb-clothes:loadPlayerSkin")
  else
    TriggerEvent("fivem-appearance:client:reloadSkin")
  end
  TriggerServerEvent("prison:server:SetJailStatus", time)
  TriggerServerEvent('prison:server:GiveJailItems', false)

  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do
    Citizen.Wait(10)
  end
  Wait(500)
  local ped = PlayerPedId()
  SetEntityCoords(ped, Config.SetFreeLoc.x, Config.SetFreeLoc.y, Config.SetFreeLoc.z)
  QBCore.Functions.Notify('You have been set free, stay out of trouble!', 'success', 5000)
  finishedTime = nil
  Wait(500)
  DoScreenFadeIn(1000)
end

RegisterNetEvent('prison:client:leaveJail', function(data)
  unJail()
end)

local function getGangRep()
  QBCore.Functions.TriggerCallback("gl-prison:getGangAffil", function(cb)
    gangInfo = table.unpack(cb)
    if gangInfo ~= nil then
      gang = gangInfo.gang
      gangRep = gangInfo.reputation
    end
  end)
  Wait(1000)
end

local function beginWork(job)
  curJob = job
  jobTasks = 0
  if curJob == 'Cook' then
    QBCore.Functions.Notify('Grab some Ingredients from the Fridge and cook up some meals for me, the worse the better!', 'primary', 10000)
  end

  if curJob == 'Clean' then
    QBCore.Functions.Notify('Head into the Infirmary and clean up the mess.', 'primary', 10000)
    TriggerEvent('gl-prison:spawnDaPoop')
  end

  if curJob == 'Electrical' then
    QBCore.Functions.Notify('Help me out by fixing up the other boxes around the Prison, should be 10.', 'primary', 10000)
    TriggerEvent('gl-prison:electricalBoxes')
  end

  if curJob == 'Trash' then
    QBCore.Functions.Notify('Collect the trash out of the barrels in the yard and bring them to me.', 'primary', 10000)
    TriggerEvent('gl-prison:barrelTask')
  end

  if curJob == 'Toilet' then
    QBCore.Functions.Notify('Clean some of the prison toilets for me would ya pal.', 'primary', 10000)
  end

  if curJob == 'Prisoner' then
    if gangRep == 0 then
      getGangRep()
    end
    whatJob = Config.IllegalStuff[math.random(#Config.IllegalStuff)]
    gangRep = gangRep - Config.RepCostForTask
    QBCore.Functions.Notify(whatJob.message, 'primary', 10000)
    if whatJob.additionalEvent ~= nil then
      TriggerEvent(whatJob.additionalEvent, whatJob.oppModel, whatJob.spawnCoords, whatJob.killorwound)
    else
      exports['qb-target']:AddBoxZone('IllegalStuff', vector3(whatJob.coords.x, whatJob.coords.y, whatJob.coords.z), whatJob.boxW, whatJob.boxL, {
        name = 'IllegalStuff',
        heading = whatJob.heading,
        debugPoly = Config.Debug,
        minZ = whatJob.coords.z,
        maxZ = whatJob.coords.z + 1
      }, {
        options = {
          {
            event = "gl-prison:prisonJobInteract",
            icon = whatJob.icon,
            label = 'Interact',
          },
        },
        distance = 1.5
      })
    end
  end
end

local function getBasketBall()
  CreateThread(function()
    while isPlayingBasket do
      Wait(0)
      if hasBasketBall then
        if IsControlJustReleased(0, 38) then
          hasBasketBall = false
          local hash = 'prop_bskball_01'
          local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -1.0))
          QBCore.Functions.LoadModel(hash)
          ballBasketObj = CreateObjectNoOffset(hash, x, y, z, true, false)
          ballBasketID = NetworkGetNetworkIdFromEntity(ballBasketObj)
          SetModelAsNoLongerNeeded(hash)
          AttachEntityToEntity(ballBasketObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
          local forwardVector = GetEntityForwardVector(PlayerPedId())
          local force = 35.0
          local animDict = "amb@world_human_cheering@male_a"
          local anim = "base"
          ClearPedTasks(PlayerPedId())
          QBCore.Functions.RequestAnimDict(animDict)
          TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
          Wait(700)
          ClearPedTasks(PlayerPedId())
          DetachEntity(ballBasketObj)
          ApplyForceToEntity(ballBasketObj, 1, forwardVector.x * force, forwardVector.y * force + 5.0, forwardVector.z + 15, 0, 0, 0, 0, false, true, true, false, true)
          TriggerServerEvent('gl-prison:syncBasketBall', ballBasketID)
          isPlayingBasket = true
        end
      else
        local ballCoords = GetEntityCoords(ballBasket)
        DrawMarker(20, ballCoords.x, ballCoords.y, ballCoords.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 228, 71, 12, 80, true, true, 0, true)
        local dst = #(GetEntityCoords(ballBasket) - GetEntityCoords(PlayerPedId()))
        if dst < 1 then
          hasBasketBall = true
          QBCore.Functions.Notify('You have the ball! Throw it with E', 'primary', 10000)
          TriggerServerEvent('gl-prison:sendDeleteBasketBall', ballBasketID)
        end
      end
    end
  end)
end

local function oppSpawned(whatDo)
  CreateThread(function()
    while true do
      Wait(5000)
      if not curWorking then
        break
      end
      if DoesEntityExist(opp) then
        local oppHP = GetEntityHealth(opp)
        if whatDo == 'kill' then
          if oppHP <= 100 then
            jobTasks = 20
            break
          end
        elseif whatDo == 'wound' then
          if oppHP > 140 and oppHP < 200 then
            ClearPedTasks(opp)
            TaskReactAndFleePed(prisonPed, PlayerPedId())
            jobTasks = 20
            break
          end
        end
      else
        break
      end
    end
  end)
end

local function getBall()
  CreateThread(function()
    while isPlaying do
      Wait(0)
      if hasBall then
        if IsControlJustReleased(0, 38) then
          hasBall = false
          local hash = 'prop_tennis_ball'
          local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -1.0))
          QBCore.Functions.LoadModel(hash)
          ballObj = CreateObjectNoOffset(hash, x, y, z, true, false)
          ballID = NetworkGetNetworkIdFromEntity(ballObj)
          SetModelAsNoLongerNeeded(hash)
          AttachEntityToEntity(ballObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
          local forwardVector = GetEntityForwardVector(PlayerPedId())
          local force = 50.0
          local animDict = "melee@unarmed@streamed_variations"
          local anim = "plyr_takedown_front_slap"
          ClearPedTasks(PlayerPedId())
          QBCore.Functions.RequestAnimDict(animDict)
          TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
          Wait(500)
          DetachEntity(ballObj)
          ApplyForceToEntity(ballObj, 1, forwardVector.x * force, forwardVector.y * force + 5.0, forwardVector.z, 0, 0, 0, 0, false, true, true, false, true)
          TriggerServerEvent('gl-prison:syncBall', ballID)
          isPlaying = true
          --getBall()
        end
      else
        local ballCoords = GetEntityCoords(ball)
        DrawMarker(20, ballCoords.x, ballCoords.y, ballCoords.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 228, 71, 12, 80, true, true, 0, true)
        local dst = #(GetEntityCoords(ball) - GetEntityCoords(PlayerPedId()))
        if dst < 1 then
          hasBall = true
          QBCore.Functions.Notify('You have the ball! Throw it with E', 'primary', 10000)
          TriggerServerEvent('gl-prison:sendDeleteBall', ballID)
        end
      end
    end
  end)
end

local function doCooldown()
  if not curRunning then
    curRunning = true
    onCooldown = true
    local cdTimer = Config.IllegalCooldown
    CreateThread(function()
      while onCooldown do
        Wait(10000)
        cdTimer = cdTimer - 10000
        if cdTimer <= 0 then
          onCooldown = false
          curRunning = false
        end
      end
    end)
  end
end

-- local function PrisonBreak()
--     if isJailed then
--         if not powerOutage then
--             TriggerServerEvent('gl-prison:PrisonBreakAlarm')
--         end
--         TriggerServerEvent('prison:server:SetJailStatus', 0)
--         TriggerServerEvent('prison:server:GiveJailItems', true)
--         isJailed = false
--     end
-- end

-- local function PrisonHackGate(id)
--     QBCore.Functions.Progressbar("hack_gate", 'Connecting Device', math.random(5000, 10000), false, true, {
--         disableMovement = true,
--         disableCarMovement = true,
--         disableMouse = false,
--         disableCombat = true,
--     }, {
--         animDict = "anim@gangops@facility@servers@",
--         anim = "hotwire",
--         flags = 49,
--     }, {}, {}, function() -- Done
--         StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
--         Config.PrisonGateHackMiniGame(id)
--     end, function() -- Cancel
--         StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
--         QBCore.Functions.Notify('Connection Canceled', "error")
--     end)
-- end

-- local function BlowUpPower(id, coords)
--     CreateThread(function()
--         SetPtfxAssetNextCall("core")
--         local smoke = StartParticleFxLoopedAtCoord("exp_air_blimp", coords, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
--         SetParticleFxLoopedAlpha(smoke, 0.8)
--         SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
--         AddExplosion(coords, 9, 0.0, true, false, 3.0)
--         TriggerServerEvent('gl-prison:SetPower', id, true)
--         for k, v in pairs(Config.Gates) do
--             Config.SetDoorLock(v.doorid, false)
--         end
--         for k, v in pairs(Config.Switches) do
--             Config.SetDoorLock(v.doorid, false)
--         end
--         TriggerServerEvent('gl-prison:setBlackout')
--         SetTimeout(Config.PowerOutageTimer * 60000, function()
--             for k, v in pairs(Config.Gates) do
--                 if not v.hacked then
--                     Config.SetDoorLock(v.doorid, true)
--                 end
--             end
--             for k, v in pairs(Config.Switches) do
--                 if not v.state then
--                     Config.SetDoorLock(v.doorid, true)
--                 end
--             end
--         end)
--     end)
-- end

-- local function ExplosiveEffect(id)
--     local ped = PlayerPedId()
--     QBCore.Functions.RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
--     Wait(1500)
--     QBCore.Functions.Notify("Take Cover!!", "success")
--     TriggerServerEvent("gl-prison:ExplosiveEffect", Config.Power[id].ptfx_coords)
--     Wait(500)
--     TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
--     TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
--     Wait(25000)
--     ClearPedTasks(ped)
--     Wait(2000)
--     BlowUpPower(id, Config.Power[id].ptfx_coords)
-- end

-- local function PlantExplosive(id)
--     TriggerServerEvent('gl-prison:RemoveExplosive', Config.Power[id].item)
--     QBCore.Functions.RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
--     QBCore.Functions.LoadModel("hei_p_m_bag_var22_arm_s")
--     RequestNamedPtfxAsset("scr_ornate_heist")
--     while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
--     local ped = PlayerPedId()
--     if math.random(1, 100) <= 65 and not QBCore.Functions.IsWearingGloves() then
--         TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(ped))
--     end
--     SetEntityHeading(ped, Config.Power[id].anim_coords.w)
--     local pos = Config.Power[id].anim_coords.xyz
--     Wait(100)
--     local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
--     local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
--     local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
--     SetEntityCollision(bag, false, true)
--     local x, y, z = table.unpack(GetEntityCoords(ped))
--     local charge = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)
--     SetEntityCollision(charge, false, true)
--     AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
--     NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
--     NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
--     SetPedComponentVariation(ped, 5, 0, 0, 0)
--     NetworkStartSynchronisedScene(bagscene)
--     Wait(5000)
--     DetachEntity(charge, 1, 1)
--     FreezeEntityPosition(charge, true)
--     DeleteObject(bag)
--     NetworkStopSynchronisedScene(bagscene)
--     ExplosiveEffect(id)
--     CreateThread(function()
--         Wait(15000)
--         DeleteEntity(charge)
--     end)
-- end

-- Called to add the Barrels ID to a table
local function addToSet(set, key)
  set[key] = true
end

-- Called to check if the Barrels exists in the set table
local function tableHasKey(table, key)
  return table[key] ~= nil
end

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  QBCore.Functions.GetPlayerData(function(PlayerData)
    PlayerJob = PlayerData.job
    if PlayerData.metadata["injail"] > 0 then
      ApplyClothes(PlayerData)
      sendToJailLoaded(PlayerData.metadata["injail"])
    end
  end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  isJailed = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerJob = JobInfo
end)

-- Main Thread
CreateThread(function()
  -- Prison Zone
  local PrisonZone = PolyZone:Create(Config.PrisonZone, {
    name = "PrisonZone",
    minZ = Config.PrisonZoneMinZ,
    maxZ = Config.PrisonZoneMaxZ,
    debugGrid = false,
    debugPoly = Config.Debug,
    gridDivisions = 25
  })

  -- Prison Zone Triggers
  PrisonZone:onPlayerInOut(function(isPointInside)
    if isPointInside then
      SpawnPeds()
    else
      RemovePeds()
      -- PrisonBreak()
    end
  end)

  -- Prison Targets
  exports['qb-target']:AddBoxZone("PoliceAlarm", vector3(1771.74, 2491.82, 49.67), 1, 5, {
    name = "PoliceAlarm",
    heading = 120,
    debugPoly = Config.Debug,
    minZ = 48,
    maxZ = 50
  }, {
    options =
    {
      {
        type = "server",
        event = "gl-prison:ToggleAlarm",
        icon = 'fas fa-hand-paper',
        label = 'Trigger Alarm',
        job = "lspd",
      },
    },
    distance = 1.5
  })

  exports['qb-target']:AddBoxZone("PrisonFridge", vector3(1784.60, 2564.86, 44.67), 1, 1.7, {
    name = "PrisonFridge",
    heading = 0,
    debugPoly = Config.Debug,
    minZ = 44.67,
    maxZ = 47.17,
  }, {
    options =
    {
      {
        event = "gl-prison:grabIngredients",
        icon = 'fas fa-hand-paper',
        label = 'Take Ingredients',
      },
    },
    distance = 1.5
  })

  exports['qb-target']:AddBoxZone("PrisonGrill", vector3(1780.85, 2565.03, 44.67), 1, 1.5, {
    name = "PrisonGrill",
    heading = 0,
    minZ = 44.67,
    maxZ = 45.87
  }, {
    options =
    {
      {
        event = "gl-prison:cookFood",
        icon = 'fas fa-hand-paper',
        label = 'Cook',
      },
    },
    distance = 1.5
  })

  exports['qb-target']:AddBoxZone("PrisonFood", vector3(1780.95, 2559.95, 45.67), 0.5, 3.9, {
    name = "PrisonFood",
    heading = 0,
    debugPoly = Config.Debug,
    minZ = 45.67,
    maxZ = 46.37,
  }, {
    options = {
      {
        event = "gl-prison:getFood",
        icon = 'fas fa-hand-paper',
        label = 'Grab some Food',
      },
    },
    distance = 1.5
  })

  exports['qb-target']:AddBoxZone("PrisonDrinks", vector3(1778.02, 2560.23, 45.67), 1, 1.3, {
    name = "PrisonDrinks",
    heading = 0,
    debugPoly = Config.Debug,
    minZ = 45.67,
    maxZ = 46.67
  }, {
    options = {
      {
        event = "gl-prison:getDrink",
        icon = 'fas fa-hand-paper',
        label = 'Grab a Drink',
      },
    },
    distance = 1.5
  })

  exports['qb-target']:AddTargetModel('prop_big_shit_01', {
    options =
    {
      {
        event = "gl-prison:pickUpPoop",
        icon = 'fas fa-hand-paper',
        label = 'Grab The Shit',
      },

    },
    distance = 1.5
  })

  for k, v in pairs(Config.Toilets) do
    exports['qb-target']:AddBoxZone("Toilets" .. k, v.coords, 1.0, 0.5, {
      name = "Toilets" .. k,
      heading = v.heading,
      debugPoly = Config.Debug,
      minZ = v.coords.z,
      maxZ = v.coords.z + 1.0
    }, {
      options =
      {
        {
          event = "gl-prison:mixDrugs",
          icon = 'fas fa-hand-paper',
          label = 'Do some Mixin',
        },
        {
          canInteract = function(entity)
            if curJob == 'Toilet' and not toilets[k] then
              return true
            end
            return false
          end,
          action = function(entity)
            TriggerEvent('gl-prison:useToilet', k)
          end,
          icon = v.icon,
          label = 'Clean',
        },
      },
      distance = 1.5
    })
  end

  exports['qb-target']:AddBoxZone("DrugOven", vector3(1782.71, 2564.89, 44.67), 1.2, 2.0, {
    name = "DrugOven",
    heading = 0,
    minZ = 44.67,
    maxZ = 46.67
  }, {
    options =
    {
      {
        event = "gl-prison:bakeDrug",
        icon = 'fas fa-hand-paper',
        label = 'Place',
      },
      {
        event = "gl-prison:removeFinishedDrug",
        icon = 'fas fa-hand-paper',
        label = 'Remove',
      },
    },
    distance = 1.5
  })

  for k, v in pairs(Config.Stashes) do
    exports['qb-target']:AddBoxZone("PrisonStash-" .. k, v.coords, v.length, v.width, {
      name = "PrisonStash-" .. k,
      heading = v.heading,
      minZ = v.coords.z,
      maxZ = v.coords.z + v.height,
    }, {
      options = {
        {
          action = function()
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "PrisonStash-" .. k, {
              maxweight = v.maxweight,
              slots = v.slots,
            })
            TriggerEvent("inventory:client:SetCurrentStash", "PrisonStash-" .. k)
          end,
          icon = v.icon,
          label = 'Open',
        },
      },
      distance = 1.5
    })
  end

  for k, v in pairs(Config.Phones) do
    exports['qb-target']:AddBoxZone("PrisonPhone" .. k, v.coords, 0.5, 0.5, {
      name = "PrisonPhone" .. k,
      debugPoly = Config.Debug,
      heading = v.heading,
      minZ = v.coords.z,
      maxZ = v.coords.z + 1
    }, {
      options =
      {
        {
          icon = v.icon_leave,
          label = 'Leave',
          canInteract = function(entity)
            if isJailed and time > 0 then return false else return true end
          end,
          action = function(entity)
            unJail()
          end,
        },
        {
          icon = v.icon_time,
          label = 'Check Time',
          canInteract = function(entity)
            if isJailed and time < 0 then return true else return false end
          end,
          action = function(entity)
            QBCore.Functions.Notify("You still have " .. time .. " months left", "info")
          end,
        },
      },
      distance = 1.5
    })
  end

  -- for k, v in pairs(Config.Gates) do
  --     exports['qb-target']:AddBoxZone("PrisonGates-" .. k, v.coords, v.length, v.width, {
  --         name = "PrisonGates-" .. k,
  --         heading = v.heading,
  --         debugPoly = Config.Debug,
  --         minZ = v.coords.z,
  --         maxZ = v.coords.z + v.height,
  --     },{
  --         options = {
  --             {
  --                 icon = v.icon,
  --                 item = v.item,
  --                 label = v.label,
  --                 canInteract = function()
  --                     return not powerOutage and not v.hacked
  --                 end,
  --                 action = function()
  --                     PrisonHackGate(k)
  --                 end
  --             }
  --         },
  --         distance = 1.0,
  --     })
  -- end

  -- for k, v in pairs(Config.Power) do
  --     exports['qb-target']:AddBoxZone("PrisonPower-" .. k, v.coords, v.length, v.width, {
  --         name = k,
  --         heading = v.heading,
  --         debugPoly = Config.Debug,
  --         minZ = v.coords.z,
  --         maxZ = v.coords.z + v.height,
  --     },{
  --         options = {
  --             {
  --                 icon = v.icon,
  --                 item = v.item,
  --                 label = v.label,
  --                 canInteract = function()
  --                     return not v.blownup
  --                 end,
  --                 action = function()
  --                     PlantExplosive(k)
  --                 end
  --             }
  --         },
  --         distance = 1.0,
  --     })
  -- end

  -- for k, v in pairs(Config.Switches) do
  --     exports['qb-target']:AddBoxZone("PrisonSwitches-" .. k, v.coords, v.length, v.width, {
  --         name = k,
  --         heading = v.heading,
  --         debugPoly = Config.Debug,
  --         minZ = v.coords.z,
  --         maxZ = v.coords.z + v.height,
  --     },{
  --         options = {
  --             {
  --                 icon = 'fa-solid fa-plug-circle-exclamation',
  --                 label = 'Turn Off Switch',
  --                 canInteract = function()
  --                     return not powerOutage and v.state
  --                 end,
  --                 action = function()
  --                     Config.SetDoorLock(v.doorid, false)
  --                     TriggerServerEvent('gl-prison:SetSwitch', k, false)
  --                 end
  --             },
  --             {
  --                 icon = 'fa-solid fa-plug-circle-bolt',
  --                 label = 'Turn On Switch',
  --                 canInteract = function()
  --                     return not powerOutage and not v.state
  --                 end,
  --                 action = function()
  --                     Config.SetDoorLock(v.doorid, true)
  --                     TriggerServerEvent('gl-prison:SetSwitch', k, true)
  --                 end
  --             }
  --         },
  --         distance = 1.0,
  --     })
  -- end
  while true do
    Wait(7)
    if time > 0 and isJailed and not pauseTime then
      Wait(1000 * 60)
      time = time - 1
      if time <= 0 then
        time = 0
        QBCore.Functions.Notify('Your time is up! Check yourself out at the visitors center', "success", 10000)
        if Config.EnableAutoLeave then unJail() end
      else
        QBCore.Functions.Notify(time .. " Months left", 'primary', 5000)
      end
      TriggerServerEvent("prison:server:SetJailStatus", time)
    else
      Wait(5000)
    end
  end
end)

-- Drugs
RegisterNetEvent('gl-prison:beginCook', function()
  if not curWorking then
    curWorking = true
    beginWork('Cook')
  else
    curWorking = false
  end
end)

RegisterNetEvent('gl-prison:mixDrugs', function()
  if not curMixing then
    TriggerServerEvent('gl-prison:checkDrugIngredients')
  end
end)

RegisterNetEvent('gl-prison:doTheMixing', function()
  local ped = PlayerPedId()
  QBCore.Functions.RequestAnimDict('amb@medic@standing@kneel@base')
  TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
  QBCore.Functions.Progressbar("mix_drugs", "Mixing Drugs", 30000, false, false, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = true,
    disableCombat = true,
  }, {
    animDict = "anim@gangops@facility@servers@bodysearch@",
    anim = "player_search",
    flags = 48,
  }, {}, {}, function()
    StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
    StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
  end)
end)

RegisterNetEvent('gl-prison:doTheBaking', function()
  baking = true
  QBCore.Functions.Notify("You've set a Timer for 2 Hours", 'primary', 10000)
  startTime = GetGameTimer()
  local mathStuff = (Config.DryTime * 60000) * 60
  finishedTime = startTime + mathStuff
end)

RegisterNetEvent('gl-prison:bakeDrug', function()
  if not baking then
    TriggerServerEvent('gl-prison:bakeDrugs')
  end
end)

RegisterNetEvent('gl-prison:removeFinishedDrug', function()
  if baking then
    local curTime = GetGameTimer()
    local timeLeft = finishedTime - curTime
    local timeInMinutes = timeLeft / 60000
    QBCore.Functions.Notify("Looks like " .. QBCore.Shared.Round(timeInMinutes, 0) .. " minutes left", 'primary', 10000)
    if curTime >= finishedTime then
      curMixing = false
      baking = false
      TriggerServerEvent('gl-prison:drugReady')
      startTime = 0
      finishedTime = nil
    end
  end
end)

-- Kitchen Events --
RegisterNetEvent('gl-prison:grabIngredients', function()
  if curJob == 'Cook' or curJob == 'Prisoner' then
    TriggerServerEvent('gl-prison:checkIngredients')
  else
    QBCore.Functions.Notify("Get Out of my Kitchen if you ain't working", 'error', 10000)
  end
end)

RegisterNetEvent('gl-prison:getFood', function()
  local foodItems = {}
  for k, v in pairs(Config.FoodStuffs) do
    foodItems[#foodItems + 1] = {
      title = 'Grab a ',
      description = v.label,
      onSelect = function()
        TriggerEvent('gl-prison:takeItem', { item = v.databasename })
      end
    }
  end
  lib.registerContext({
    id = 'food_Items',
    title = 'Food Menu',
    options = foodItems
  })
  lib.showContext('food_Items')
  --exports['qb-menu']:openMenu(foodItems)
end)

RegisterNetEvent('gl-prison:openCommissary', function()
  local comItems = {}
  for k, v in pairs(Config.Commissary) do
    comItems[#comItems + 1] = {
      title = 'Only ' .. v.cost .. ' for a',
      description = v.label,
      onSelect = function()
        TriggerEvent('gl-prison:takeItemComm', { item = v.databasename, cost = v.cost, curr = v.currency })
      end
    }
  end
  lib.registerContext({
    id = 'com_Items',
    title = 'Menu',
    options = comItems
  })
  lib.showContext('com_Items')
  -- exports['qb-menu']:openMenu(comItems)
end)

RegisterNetEvent('gl-prison:takeItemComm', function(data)
  TriggerServerEvent('gl-prison:buyFromCom', data.item, data.cost, data.curr)
end)

RegisterNetEvent('gl-prison:takeItem', function(data)
  TriggerServerEvent('gl-prison:tryTakeItem', data.item)
end)

RegisterNetEvent('gl-prison:getDrink', function()
  local drinkItems = {}
  for k, v in pairs(Config.DrinkStuffs) do
    drinkItems[#drinkItems + 1] = {
      title = 'Grab a ',
      description = v.label,
      onSelect = function()
        TriggerEvent('gl-prison:takeItem', { item = v.databasename })
      end
    }
  end
  lib.registerContext({
    id = 'drink_Items',
    title = 'Menu',
    options = drinkItems
  })
  lib.showContext('drink_Items')
  --exports['qb-menu']:openMenu(drinkItems)
end)

RegisterNetEvent('gl-prison:cookFood', function()
  if curJob == "Cook" then
    local cookWhat = {}
    for k, v in pairs(Config.CookingStuff) do
      cookWhat[#cookWhat + 1] = {
        title = 'Cook A Meal',
        description = v.Label,
        onSelect = function()
          TriggerEvent('gl-prison:checkCanCook', {
            item = v.Product,
            ingredientCost = v.IngredientCost,
            time = v.Time
          })
        end
      }
    end
    lib.registerContext({
      id = 'cook_What',
      title = 'Menu',
      options = cookWhat
    })
    lib.showContext('cook_What')
    --exports['qb-menu']:openMenu(cookWhat)
  end
end)

RegisterNetEvent('gl-prison:checkCanCook', function(data)
  if cooking then
    QBCore.Functions.Notify('Wait awhile before cooking again.', 'error', 10000)
  else
    cooking = true
    TriggerServerEvent('gl-prison:checkCanCook', data.item, data.time, data.ingredientCost)
    Wait(data.time)
    cooking = false
  end
end)

RegisterNetEvent('gl-prison:beginCookFood', function(time, cost)
  local ped = PlayerPedId()
  QBCore.Functions.Progressbar("cook_food", "Cooking Food", time, false, false, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = true,
    disableCombat = true,
  }, {
    task = "PROP_HUMAN_BBQ"
  }, {}, {}, function()
    ClearPedTasks(ped)
    jobTasks = jobTasks + cost
  end)
end)

-- Cleaning Events --
RegisterNetEvent('gl-prison:beginClean', function()
  if not curWorking then
    curWorking = true
    beginWork('Clean')
  else
    curWorking = false
  end
end)

RegisterNetEvent('gl-prison:spawnDaPoop', function()
  local radius = 5.0
  local poopLimit = 0
  while poopLimit < 11 do
    poopLimit = poopLimit + 1
    local x = 1766.03 + math.random(-radius, radius)
    local y = 2595.12 + math.random(-radius, radius)
    poop = CreateObject('prop_big_shit_01', x, y, 45.73, false, false, false)
    PlaceObjectOnGroundProperly(poop)
    FreezeEntityPosition(poop, true)
    Wait(100)
  end
end)

RegisterNetEvent('gl-prison:pickUpPoop', function()
  local ped = PlayerPedId()
  local pedCoords = GetEntityCoords(ped)
  QBCore.Functions.RequestAnimDict('amb@medic@standing@kneel@base')
  TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
  QBCore.Functions.Progressbar("pickup_poop", "Picking Up Poop", 24000, false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = true,
    disableCombat = true,
  }, {
    animDict = "anim@gangops@facility@servers@bodysearch@",
    anim = "player_search",
    flags = 48,
  }, {}, {}, function()
    local objectId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0, `prop_big_shit_01`, false)
    StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
    StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
    jobTasks = jobTasks + 2
    DeleteEntity(objectId)
    local ranChance = math.random(1, 100)
    if ranChance <= Config.SteroidChance then
      TriggerServerEvent('gl-prison:tryTakeItem', 'steroid')
    end
  end, function()
    local objectId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0, `prop_big_shit_01`, false)
    StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
    StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
  end)
end)

-- Eletrical Stuff --
RegisterNetEvent('gl-prison:beginElectrical', function()
  if not curWorking then
    curWorking = true
    beginWork('Electrical')
  else
    curWorking = false
  end
end)

RegisterNetEvent('gl-prison:electricalBoxes', function()
  for k, v in pairs(Config.ElectricalBoxes) do
    exports['qb-target']:AddBoxZone(k, v.coords, 1, 2, {
      name = k,
      heading = v.heading,
      debugPoly = Config.Debug,
      minZ = v.coords.z,
      maxZ = v.coords.z + 1
    }, {
      options =
      {
        {
          event = "gl-prison:useElectricalBox",
          icon = v.icon,
          label = 'Fix',
        },
      },
      distance = 1.5
    })
  end
end)

RegisterNetEvent('gl-prison:useElectricalBox', function()
  local ped = PlayerPedId()
  local pedCoords = GetEntityCoords(ped)
  for k, v in pairs(Config.ElectricalBoxes) do
    local dst = #(pedCoords - v.coords)
    if dst < 2 then
      QBCore.Functions.Progressbar("fixing_electrical", "Fixing Electrical Box", 48000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true,
      }, {
        task = "WORLD_HUMAN_WELDING"
      }, {}, {}, function()
        exports['qb-target']:RemoveZone(k)
        ClearPedTasks(ped)
        SetCurrentPedWeapon(ped, `WEAPON_UNARME`, true)
        jobTasks = jobTasks + 2
        local ranChance = math.random(1, 100)
        if ranChance <= Config.TinfoilChance then
          TriggerServerEvent('gl-prison:tryTakeItem', 'tinfoil')
        end
      end)
    end
  end
end)

-- Empty Garbage --
RegisterNetEvent('gl-prison:beginTrash', function()
  if not curWorking then
    curWorking = true
    beginWork('Trash')
  else
    curWorking = false
  end
end)

RegisterNetEvent('gl-prison:barrelTask', function()
  exports['qb-target']:AddTargetModel('prop_barrel_03d', {
    options = {
      {
        event = "gl-prison:emptyBarrel",
        icon = "fas fa-hand-paper",
        label = "Empty",
      },
    },
    distance = 2.5
  })

  QBCore.Functions.LoadModel('prop_bin_08open')
  trashCan = CreateObject('prop_bin_08open', 1718.88, 2567.78, 45.73, false, false, false)
  while not DoesEntityExist(trashCan) do
    Wait(1)
  end
  PlaceObjectOnGroundProperly(trashCan)
  SetModelAsNoLongerNeeded('prop_bin_08open')
  FreezeEntityPosition(trashCan, true)
  exports['qb-target']:AddEntityZone(trashCan, trashCan, {
    name = trashCan,
    debugPoly = Config.Debug,
  }, {
    options = {
      {
        event = "gl-prison:turnInTrash",
        icon = 'fas fa-trash',
        label = 'Dump Trash',
      },
    },
    distance = 1.5
  })
end)

RegisterNetEvent('gl-prison:turnInTrash', function()
  if DoesEntityExist(garbagebag) then
    DetachEntity(garbagebag)
    DeleteEntity(garbagebag)
    jobTasks = jobTasks + 5
    QBCore.Functions.Notify('Good work! Go find some more trash', 'success', 5000)
  end
end)

RegisterNetEvent('gl-prison:emptyBarrel', function()
  local ped = PlayerPedId()
  local pedCoords = GetEntityCoords(ped)
  local objectId = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 5.0, `prop_barrel_03d`, false)
  local alreadySearched = tableHasKey(searched, objectId)
  QBCore.Functions.Progressbar("emptying_barrel", "Emptying Barrel", 30000, false, false, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = true,
    disableCombat = true,
  }, {
    task = "PROP_HUMAN_BUM_BIN"
  }, {}, {}, function()
    ClearPedTasksImmediately(ped)
    if alreadySearched then
      QBCore.Functions.Notify('Nothing in this barrel', 'error', 10000)
    else
      if DoesEntityExist(garbagebag) then
        QBCore.Functions.Notify('You cannot carry anymore bags', 'error', 10000)
      else
        jobTasks = jobTasks + 5
        addToSet(searched, objectId)
        garbagebag = CreateObject(`prop_cs_street_binbag_01`, 0, 0, 0, true, true, true)                                                -- creates object
        AttachEntityToEntity(garbagebag, ped, GetPedBoneIndex(ped, 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
        local doMath = math.random(1, 100)
        if doMath < Config.RandomTrashChance then
          local item = Config.RandomTrashReward[math.random(#Config.RandomTrashReward)]
          TriggerServerEvent('gl-prison:tryTakeItem', item)
        end
      end
    end
  end)
end)

-- Clean Toilets --
RegisterNetEvent('gl-prison:beginToilet', function()
  if not curWorking then
    curWorking = true
    beginWork('Toilet')
  else
    curWorking = false
  end
end)

RegisterNetEvent('gl-prison:useToilet', function(id)
  local ped = PlayerPedId()
  QBCore.Functions.RequestAnimDict('amb@medic@standing@kneel@base')
  TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
  QBCore.Functions.Progressbar("use_toilet", "Cleaning Toilet", 24000, false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = true,
    disableCombat = true,
  }, {
    animDict = "anim@gangops@facility@servers@bodysearch@",
    anim = "player_search",
    flags = 48,
  }, {}, {}, function()
    StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
    StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
    toilets[id] = true
    jobTasks = jobTasks + 2
    QBCore.Functions.Notify("Looks nice and clean", "success")
  end, function()
    StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
    StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
    QBCore.Functions.Notify("Canceled Cleaning Toilet", "error")
  end)
end)

-- Prisoner Tasks
RegisterNetEvent('gl-prison:prisonerTasks', function(currentgang)
  if gang == nil then
    getGangRep()
  end

  if not curWorking and gang == currentgang then
    if not onCooldown then
      curWorking = true
      beginWork('Prisoner')
      doCooldown()
    else
      QBCore.Functions.Notify('Come back later I will have more for you to do.', 'primary', 10000)
    end
  else
    QBCore.Functions.Notify('Tryna get shanked? I only put out work for the homies.', 'primary', 10000)
    curWorking = false
  end
end)

RegisterNetEvent('gl-prison:prisonJobInteract', function()
  TriggerServerEvent('gl-prison:prisonerJob', whatJob.ingredient, whatJob.amount)
end)

RegisterNetEvent('gl-prison:prisonJobDoThing', function()
  if curWorking then
    local ped = PlayerPedId()
    QBCore.Functions.RequestAnimDict('amb@medic@standing@kneel@base')
    TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
    QBCore.Functions.Progressbar("doing_illegalstuff", "Doing Illegal Stuff", 24000, false, false, {
      disableMovement = true,
      disableCarMovement = true,
      disableMouse = true,
      disableCombat = true,
    }, {
      animDict = "anim@gangops@facility@servers@bodysearch@",
      anim = "player_search",
      flags = 48,
    }, {}, {}, function()
      exports['qb-target']:RemoveZone('IllegalStuff')
      StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
      StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
      TriggerServerEvent('gl-prison:tryTakeItem', whatJob.requirement)
      jobTasks = 20
      curWorking = false
    end)
  end
end)

-- Doctor Stuff
RegisterNetEvent('gl-prison:useDoctor', function()
  local PlayerId = PlayerPedId()
  QBCore.Functions.Notify('You have been moved to a bed for Treatment.', 'primary', 10000)
  SetEntityCoords(PlayerId, 1761.87, 2591.6, 46.66)
  QBCore.Functions.RequestAnimDict('anim@gangops@morgue@table@')
  TaskPlayAnim(PlayerId, 'anim@gangops@morgue@table@', 'body_search', 8.0, -8.0, -1, 1, 0, false, false, false)
  SetEntityHeading(PlayerId, 266.96)
  Wait(20000)
  TriggerEvent("hospital:client:HealInjuries", "full")
  ClearPedTasks(PlayerId)
  QBCore.Functions.Notify('You are good now, stop getting in trouble.', 'primary', 10000)
end)

-- Alarm Stuff
RegisterNetEvent('gl-prison:breakOutAlarm', function(toggle)
  if toggle then
    QBCore.Functions.Notify('Prison Break In Progress', 'primary', 10000)
    local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")

    RefreshInterior(alarmIpl)
    EnableInteriorProp(alarmIpl, "prison_alarm")

    CreateThread(function()
      while not PrepareAlarm("PRISON_ALARMS") do
        Wait(100)
      end
      StartAlarm("PRISON_ALARMS", true)
    end)
  else
    local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")

    RefreshInterior(alarmIpl)
    DisableInteriorProp(alarmIpl, "prison_alarm")

    CreateThread(function()
      while not PrepareAlarm("PRISON_ALARMS") do
        Wait(100)
      end
      StopAllAlarms(true)
    end)
  end
end)

-- Turn in Job (For All)
RegisterNetEvent('gl-prison:turnInJob', function()
  if curJob ~= nil then
    if curJob == 'Prisoner' then
      if jobTasks == 20 then
        if fightJob then
          curJob = nil
          curWorking = false
          TriggerServerEvent('gl-prison:checkPrisonerJob', nil, whatJob.minAmount, whatJob.maxAmount, gangRep)
        else
          TriggerServerEvent('gl-prison:checkPrisonerJob', whatJob.requirement, whatJob.minAmount, whatJob.maxAmount, gangRep)
          curJob = nil
          curWorking = false
        end
      elseif fightJob and jobTasks == 0 then
        curWorking = false
      end
    elseif curJob == 'Trash' and jobTasks >= 20 then
      if DoesEntityExist(trashCan) then
        DeleteEntity(trashCan)
      end
      if DoesEntityExist(garbagebag) then
        DetachEntity(garbagebag)
        DeleteEntity(garbagebag)
      end
      TriggerServerEvent('gl-prison:turnInJob', curJob) -- Add reward here
      TriggerEvent('gl-prison:reduceJailTime')
      curJob = nil
      curWorking = false
    elseif curJob == 'Toilet' and jobTasks >= 20 then
      TriggerServerEvent('gl-prison:turnInJob', curJob) -- Add reward here
      QBCore.Functions.Notify("Yeah I knew you could do it didn't doubt you for a minute.", 'primary', 10000)
      TriggerEvent('gl-prison:reduceJailTime')
      curJob = nil
      curWorking = false
      toilets = {}
    elseif jobTasks >= 20 then
      TriggerServerEvent('gl-prison:turnInJob', curJob) -- Add reward here
      QBCore.Functions.Notify("Yeah I knew you could do it didn't doubt you for a minute.", 'primary', 10000)
      TriggerEvent('gl-prison:reduceJailTime')
      curJob = nil
      curWorking = false
    elseif curJob ~= nil then
      QBCore.Functions.Notify('Not done with current Job ' .. jobTasks .. '/20', 'primary', 10000)
    end
  end
end)

-- Prison Gang Stuff
RegisterNetEvent('gl-prison:updateGangRep', function(updateRep)
  gangRep = gangRep + updateRep
  TriggerServerEvent('gl-prison:updatePrisonRep', gangRep)
end)

RegisterNetEvent('gl-prison:joinPrisonGang', function(newgang)
  getGangRep()
  if gang == nil then
    TriggerServerEvent('gl-prison:joinPrisonGang', newgang)
    QBCore.Functions.Notify("Yo playa welcome to the " .. newgang, 'primary', 10000)
  else
    QBCore.Functions.Notify("You're already in a gang fool", 'primary', 10000)
  end
end)

RegisterNetEvent('gl-prison:openGangShop', function(currentgangshop)
  if gang == nil then
    getGangRep()
    if currentgangshop == gang then
      local gangShop = {}
      for k, v in pairs(Config.GangShops[gang]) do
        gangShop[#gangShop + 1] = {
          title = 'Trade ' .. v.Cost .. ' ' .. v.Currency .. ' for ',
          description = v.Label,
          onSelect = function()
            TriggerEvent('gl-prison:tradeForItem', {
              item = v.Item,
              rep = v.Minrep,
              cost = v.Cost
            })
          end
        }
      end
      lib.registerContext({
        id = 'gang_Shop',
        title = 'Menu',
        options = gangShop
      })
      lib.showContext('gang_Shop')
      --exports['qb-menu']:openMenu(gangShop)
    end
  elseif currentgangshop == gang then
    local gangShop = {}
    for k, v in pairs(Config.GangShops[gang]) do
      gangShop[#gangShop + 1] = {
        title = 'Trade ' .. v.Cost .. ' ' .. v.Currency .. ' for ',
        description = v.Label,
        onSelect = function()
          TriggerEvent('gl-prison:tradeForItem', {
            item = v.Item,
            rep = v.Minrep,
            cost = v.Cost
          })
        end
      }
    end
    lib.registerContext({
      id = 'gang_Shop',
      title = 'Menu',
      options = gangShop
    })
    lib.showContext('gang_Shop')
    -- exports['qb-menu']:openMenu(gangShop)
  else
    QBCore.Functions.Notify('I don\'t know you fool', 'error', 10000)
  end
end)

RegisterNetEvent('gl-prison:tradeForItem', function(data)
  if gangRep >= data.rep then
    TriggerServerEvent('gl-prison:checkTrade', data.item, data.cost)
  else
    QBCore.Functions.Notify("We ain't that cool man", 'error', 10000)
  end
end)

RegisterNetEvent('gl-prison:spawnOpp', function(model, coords, whatDo)
  fightJob = true
  QBCore.Functions.LoadModel(model)
  opp = CreatePed(5, model, coords, heading, 1, 0)
  SetModelAsNoLongerNeeded(model)
  TaskWanderStandard(opp, 10.0, 10)
  oppSpawned(whatDo)
end)

RegisterNetEvent('gl-prison:checkItemBed', function()
  searchChance = 15
  for k, v in pairs(Config.BedLocations) do
    exports['qb-target']:AddBoxZone(k, v.coords, 2, 1, {
      name = k,
      heading = v.heading,
      minZ = v.coords.z,
      maxZ = v.coords.z + 1
    }, {
      options = {
        {
          event = "gl-prison:searchBed",
          icon = v.icon,
          label = 'Search',
        },
      },
      distance = 1.5
    })
  end
end)

RegisterNetEvent('gl-prison:searchBed', function()
  local ped = PlayerPedId()
  local pedCoords = GetEntityCoords(ped)
  QBCore.Functions.Progressbar("searching_bed", "Searching Bed", 30000, false, false, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = true,
    disableCombat = true,
  }, {
    task = 'PROP_HUMAN_BUM_BIN'
  }, {}, {}, function()
    ClearPedTasksImmediately(ped)
    if jobTasks == 0 then
      local doMath = math.random(1, 100)
      if doMath <= searchChance then
        TriggerServerEvent('gl-prison:foundBedItem', whatJob.requirement, whatJob.amount)
        jobTasks = 20
      else
        searchChance = searchChance + 15
        QBCore.Functions.Notify("Nothing here.", 'primary', 10000)
      end

      for k, v in pairs(Config.BedLocations) do
        local dst = #(pedCoords - v.coords)
        if dst < 2 then
          exports['qb-target']:RemoveZone(k)
        end
      end
    end
  end)
end)

-- Recreational Stuff
RegisterCommand('throw', function()
  TriggerEvent('gl-prison:throwBall')
end)

RegisterCommand('join', function()
  isPlaying = true
  QBCore.Functions.Notify('You joined the game', 'primary', 10000)
  getBall()
end)

RegisterCommand('leave', function()
  isPlaying = false
  hasBall = false
  QBCore.Functions.Notify('You quit playing.', 'primary', 10000)
end)

RegisterNetEvent('gl-prison:throwBall', function()
  local ped = PlayerPedId()
  hasBall = false
  local hash = 'prop_tennis_ball'
  local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, -1.0))
  QBCore.Functions.LoadModel(hash)
  ballObj = CreateObjectNoOffset(hash, x, y, z, true, false)
  ballID = NetworkGetNetworkIdFromEntity(ballObj)
  SetModelAsNoLongerNeeded(hash)
  AttachEntityToEntity(ballObj, ped, GetPedBoneIndex(ped, 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
  local forwardVector = GetEntityForwardVector(ped)
  local force = 50.0
  local animDict = "melee@unarmed@streamed_variations"
  local anim = "plyr_takedown_front_slap"
  ClearPedTasks(ped)
  QBCore.Functions.RequestAnimDict(animDict)
  TaskPlayAnim(ped, animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
  Wait(500)
  DetachEntity(ballObj)
  ApplyForceToEntity(ballObj, 1, forwardVector.x * force, forwardVector.y * force + 5.0, forwardVector.z, 0, 0, 0, 0, false, true, true, false, true)
  TriggerServerEvent('gl-prison:syncBall', ballID)
  isPlaying = true
  getBall()
end)

RegisterNetEvent('gl-prison:syncBall', function(ballID)
  ball = NetworkGetEntityFromNetworkId(ballID)
  hasBall = false
end)

RegisterNetEvent('gl-prison:deleteBall', function()
  DeleteEntity(ball)
end)

RegisterNetEvent('gl-prison:teachRec', function()
  QBCore.Functions.Notify('/throw to throw the ball against the wall', 'primary', 10000)
  Wait(10000)
  QBCore.Functions.Notify('/join to join any game in progress', 'primary', 10000)
  Wait(10000)
  QBCore.Functions.Notify('/leave to leave the game', 'primary', 10000)
  Wait(10000)
  QBCore.Functions.Notify('Goal is to throw the ball at the wall, then catch it before it goes out. E to throw a caught ball.', 'primary', 10000)
end)

-- Basketball Stuff
RegisterCommand('basketball', function()
  TriggerEvent('gl-prison:throwBasketBall')
end)

RegisterCommand('joinbasketball', function()
  isPlayingBasket = true
  QBCore.Functions.Notify('You joined the game', 'primary', 10000)
  getBasketBall()
end)

RegisterCommand('leavebasketball', function()
  isPlayingBasket = false
  hasBasketBall = false
  QBCore.Functions.Notify('You quit playing.', 'primary', 10000)
end)

RegisterNetEvent('gl-prison:throwBasketBall', function()
  hasBasketBall = false
  local hash = 'prop_bskball_01'
  local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -1.0))
  QBCore.Functions.LoadModel(hash)
  ballBasketObj = CreateObjectNoOffset(hash, x, y, z, true, false)
  ballBasketID = NetworkGetNetworkIdFromEntity(ballBasketObj)
  SetModelAsNoLongerNeeded(hash)
  AttachEntityToEntity(ballBasketObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
  local forwardVector = GetEntityForwardVector(PlayerPedId())
  local force = 35.0
  local animDict = "amb@world_human_cheering@male_a"
  local anim = "base"
  ClearPedTasks(PlayerPedId())
  QBCore.Functions.RequestAnimDict(animDict)
  TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
  Wait(700)
  ClearPedTasks(PlayerPedId())
  DetachEntity(ballBasketObj)
  ApplyForceToEntity(ballBasketObj, 1, forwardVector.x * force, forwardVector.y * force + 5.0, forwardVector.z + 15, 0, 0, 0, 0, false, true, true, false, true)
  TriggerServerEvent('gl-prison:syncBasketBall', ballBasketID)
  isPlayingBasket = true
  getBasketBall()
end)

RegisterNetEvent('gl-prison:syncBasketBall', function(ballBasketID)
  ballBasket = NetworkGetEntityFromNetworkId(ballBasketID)
  hasBasketBall = false
end)

RegisterNetEvent('gl-prison:deleteBasketBall', function()
  DeleteEntity(ballBasket)
end)

-- Throwing Drugs out of Prison
RegisterNetEvent('gl-prison:throwFullBag', function()
  local ped = PlayerPedId()
  local hash = 'hei_prop_hei_paper_bag'
  local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, -1.0))
  QBCore.Functions.LoadModel(hash)
  local tossedDrugs = CreateObjectNoOffset(hash, x, y, z, true, false)
  local drugID = NetworkGetNetworkIdFromEntity(tossedDrugs)

  SetModelAsNoLongerNeeded(hash)
  AttachEntityToEntity(tossedDrugs, ped, GetPedBoneIndex(ped, 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
  local forwardVector = GetEntityForwardVector(ped)
  local force = 45.0
  local animDict = "amb@world_human_cheering@male_a"
  local anim = "base"
  ClearPedTasks(ped)
  QBCore.Functions.RequestAnimDict(animDict)
  TaskPlayAnim(ped, animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
  Wait(700)
  ClearPedTasks(ped)
  DetachEntity(tossedDrugs)
  ApplyForceToEntity(tossedDrugs, 1, forwardVector.x * force, forwardVector.y * force, forwardVector.z + 30, 0, 0, 0, 0, false, true, true, false, true)
  TriggerServerEvent('gl-prison:syncTossedDrug', drugID)
end)

RegisterNetEvent('gl-prison:syncTossedDrug', function(drugID)
  local entID = NetworkGetEntityFromNetworkId(drugID)
  local ped = PlayerPedId()
  local pedCoords = GetEntityCoords(ped)
  local dst = #(GetEntityCoords(entID) - pedCoords)
  if dst < 100 then
    Wait(5000)
    exports['qb-target']:AddEntityZone(entID, entID, {
      name = entID,
      debugPoly = Config.Debug,
      useZ = true
    }, {
      options = {
        {
          event = 'gl-prison:openDrugBag',
          icon = 'fas fa-hand-paper',
          label = 'Open Bag',
        },
      },
      distance = 1.5
    })
  end
end)

RegisterNetEvent('gl-prison:openDrugBag', function()
  local ped = PlayerPedId()
  local pedCoords = GetEntityCoords(ped)
  local closestObject = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0, `hei_prop_hei_paper_bag`, false)
  local objCoords = GetEntityCoords(closestObject)
  local drugID = NetworkGetNetworkIdFromEntity(closestObject)
  QBCore.Functions.RequestAnimDict('amb@medic@standing@kneel@base')
  TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
  QBCore.Functions.Progressbar("open_drugbag", "Opening Drug Bag", 5000, false, false, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = true,
    disableCombat = true,
  }, {
    animDict = "anim@gangops@facility@servers@bodysearch@",
    anim = "player_search",
    flags = 48,
  }, {}, {}, function()
    StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
    StopAnimTask(ped, "amb@medic@standing@kneel@base", "base", 1.0)
    TriggerServerEvent('gl-prison:openedDrugBag', drugID)
  end)
end)

RegisterNetEvent('gl-prison:deleteDrugBag', function(bagID)
  local entID = NetworkGetEntityFromNetworkId(bagID)
  if DoesEntityExist(entID) then
    DeleteEntity(entID)
  end
end)

-- Jail Stuff
RegisterNetEvent('gl-prison:reduceJailTime', function()
  if Config.EnableTimeReduction then
    if time > 15 then
      time = time - Config.TimeReductionHigh
      QBCore.Functions.Notify("Your jail time has been reduced by " .. Config.TimeReductionHigh .. " months..", "success")
    else
      time = time - Config.TimeReductionLow
      QBCore.Functions.Notify("Your jail time has been reduced by " .. Config.TimeReductionLow .. " months..", "success")
    end
    TriggerServerEvent("prison:server:SetJailStatus", time)
  end
end)

RegisterNetEvent('prison:client:Enter', function(jailTime)
  QBCore.Functions.Notify("You're in jail for " .. jailTime .. " months..", "error")
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do
    Wait(100)
  end
  time = jailTime
  local ped = PlayerPedId()
  local PlayerData = QBCore.Functions.GetPlayerData()
  SetEntityCoords(ped, Config.MugshotTP.x, Config.MugshotTP.y, Config.MugshotTP.z)
  SetEntityHeading(ped, Config.MugshotH)
  FreezeEntityPosition(ped, true)
  TriggerServerEvent("prison:server:SetJailStatus", time)
  TriggerServerEvent("prison:server:SaveJailItems", time)
  exports.scully_emotemenu:playEmoteByCommand('mugshot')
  DoScreenFadeIn(1000)
  Wait(10000)
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do
    Wait(10)
  end
  exports.scully_emotemenu:cancelEmote()
  FreezeEntityPosition(ped, false)
  SetEntityCoords(ped, Config.CellLocation.x, Config.CellLocation.y, Config.CellLocation.z)
  SetEntityHeading(ped, Config.CellHeading)
  TriggerServerEvent("InteractSound_SV:PlayOnSource", "jail", 0.5)
  ApplyClothes(PlayerData)
  isJailed = true
  DoScreenFadeIn(1000)
end)

-- On Sangria
RegisterNetEvent('gl-prison:onSangria', function()
  local ped = PlayerPedId()
  RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
  while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
    Citizen.Wait(0)
  end
  SetPedCanRagdoll(ped, true)
  ShakeGameplayCam('DRUNK_SHAKE', 2.80)
  SetTimecycleModifier("Drunk")
  SetPedMovementClipset(ped, "MOVE_M@DRUNK@VERYDRUNK", 1)
  SetPedMotionBlur(ped, true)
  SetPedIsDrunk(ped, true)
  Wait(1500)
  SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false)
  Wait(13500)
  SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false)
  Wait(120500)
  ClearTimecycleModifier()
  ResetScenarioTypesEnabled()
  ResetPedMovementClipset(ped, 0)
  SetPedIsDrunk(ped, false)
  SetPedMotionBlur(ped, false)
  AnimpostfxStopAll()
  ShakeGameplayCam('DRUNK_SHAKE', 0.0)
end)

RegisterNetEvent('gl-prison:onMud', function()
  local ped = PlayerPedId()
  QBCore.Functions.RequestAnimDict("amb@world_human_aa_smoke@male@idle_a")
  TaskPlayAnim(ped, "amb@world_human_aa_smoke@male@idle_a", "idle_c", 8.0, -8.0, -1, 1, 0, false, false, false)
  Wait(6000)
  ClearPedTasks(ped)
  AnimpostfxPlay("rampage", 1, false)
  Wait(25000)
  AnimpostfxStopAll()
  Wait(35000)
  AnimpostfxPlay("rampage", 1, false)
  Wait(60000)
  AnimpostfxStopAll()
  usedDrug()
  drugTimer()
end)

-- Prison Break Stuff
RegisterNetEvent('gl-prison:ExplosiveEffect', function(coords)
  RequestNamedPtfxAsset("scr_ornate_heist")
  while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
  SetPtfxAssetNextCall("scr_ornate_heist")
  local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
  Wait(27500)
  StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('gl-prison:SetGate', function(id, state)
  Config.Gates[id].hacked = state
end)

RegisterNetEvent('gl-prison:SetPower', function(id, state)
  powerOutage = state
  Config.Power[id].blownup = state
end)

RegisterNetEvent('gl-prison:SetSwitch', function(id, state)
  Config.Switches[id].state = state
end)

---Pause or unpause current jail time
---@param bool boolean
RegisterNetEvent('gl-prison:PauseTime', function(bool)
  pauseTime = bool
end)

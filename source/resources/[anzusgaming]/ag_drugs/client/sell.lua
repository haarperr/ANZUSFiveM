local QBCore = exports['qb-core']:GetCoreObject()
local cornerselling = false
local hasTarget = false
local lastPed = {}
local stealingPed = nil
local stealData = {}
local availableDrugs = {}
local currentOfferDrug = nil
local zoneMade = false
local targetStealingPed = nil
local targetPedSale = nil
local optionNamesTargetPed = nil

local function TooFarAway()
  lib.notify({ type = 'error', description = locale("too_far_away") })
  cornerselling = false
  hasTarget = false
  availableDrugs = {}
end

local function PoliceCall()
  if Config.CornerSelling.chances.police_notify <= math.random(1, 100) then
    exports['ps-dispatch']:DrugSale()
  end
end

local function RobberyPed()
  targetStealingPed = NetworkGetNetworkIdFromEntity(stealingPed)
  local options = {
    {
      name = 'stealingped',
      icon = 'fas fa-magnifying-glass',
      label = locale("search_ped"),
      onSelect = function()
        local player = cache.ped
        lib.requestAnimDict("pickup_object", 200)
        TaskPlayAnim(player, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(player)
        TriggerServerEvent('ag_drugs:server:giveStealItems', stealData.drugType, stealData.amount)
        stealingPed = nil
        stealData = {}
        exports.ox_target:removeEntity(targetStealingPed, 'stealingped')
      end,
      canInteract = function()
        if IsEntityDead(stealingPed) then
          return true
        end
      end
    }
  }
  exports.ox_target:addEntity(targetStealingPed, options)
  CreateThread(function()
    while stealingPed do
      local playerPed = cache.ped
      local pos = GetEntityCoords(playerPed)
      local pedpos = GetEntityCoords(stealingPed)
      local dist = #(pos - pedpos)
      if dist > 100 then
        stealingPed = nil
        stealData = {}
        exports.ox_target:removeEntity(targetStealingPed, 'stealingped')
        break
      end
      Wait(0)
    end
  end)
end

local function SellToPed(ped)
  hasTarget = true

  for i = 1, #lastPed, 1 do
    if lastPed[i] == ped then
      hasTarget = false
      return
    end
  end

  local successChance = math.random(1, 100)
  local scamChance = math.random(1, 100)
  local getRobbed = math.random(1, 100)
  if successChance <= Config.CornerSelling.chances.success then
    hasTarget = false
    return
  end

  local drugType = math.random(1, #availableDrugs)
  local bagAmount = math.random(1, availableDrugs[drugType].amount)
  if bagAmount > 15 then bagAmount = math.random(9, 15) end

  currentOfferDrug = availableDrugs[drugType]

  local ddata = Config.CornerSelling.prices[currentOfferDrug.item]
  local randomPrice = math.random(ddata.min, ddata.max) * bagAmount
  if scamChance <= Config.CornerSelling.chances.scam then randomPrice = math.random(3, 10) * bagAmount end

  SetEntityAsNoLongerNeeded(ped)
  ClearPedTasks(ped)

  local coords = GetEntityCoords(cache.ped, true)
  local pedCoords = GetEntityCoords(ped)
  local pedDist = #(coords - pedCoords)
  TaskGoStraightToCoord(ped, coords.x, coords.y, coords.z, getRobbed <= Config.CornerSelling.chances.robbery and 15.0 or 1.2, -1, 0.0, 0.0)

  while pedDist > 1.5 do
    coords = GetEntityCoords(cache.ped, true)
    pedCoords = GetEntityCoords(ped)
    TaskGoStraightToCoord(ped, coords.x, coords.y, coords.z, getRobbed <= Config.CornerSelling.chances.robbery and 15.0 or 1.2, -1, 0.0, 0.0)
    pedDist = #(coords - pedCoords)
    Wait(100)
  end

  TaskLookAtEntity(ped, cache.ped, 5500.0, 2048, 3)
  TaskTurnPedToFaceEntity(ped, cache.ped, 5500)
  TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)

  if not hasTarget then return end

  while pedDist < 1.5 and not IsPedDeadOrDying(ped, false) do
    local coords2 = GetEntityCoords(cache.ped, true)
    local pedCoords2 = GetEntityCoords(ped)
    local pedDist2 = #(coords2 - pedCoords2)
    if getRobbed <= Config.CornerSelling.chances.robbery then
      TriggerServerEvent('ag_drugs:server:robCornerDrugs', drugType, bagAmount)
      lib.notify({ type = 'error', description = locale("has_been_robbed", bagAmount, currentOfferDrug.label) })
      stealingPed = ped
      stealData = {
        item = currentOfferDrug.item,
        drugType = drugType,
        amount = bagAmount,
      }
      hasTarget = false
      local moveTo = GetEntityCoords(cache.ped)
      local moveToCoords = vec3(moveTo.x + math.random(100, 500), moveTo.y + math.random(100, 500), moveTo.z)
      ClearPedTasksImmediately(ped)
      TaskGoStraightToCoord(ped, moveToCoords.x, moveToCoords.y, moveToCoords.z, 15.0, -1, 0.0, 0.0)
      lastPed[#lastPed + 1] = ped
      RobberyPed()
      break
    else
      if pedDist2 < 1.5 and cornerselling then
        if not zoneMade then
          zoneMade = true
          targetPedSale = NetworkGetNetworkIdFromEntity(ped)
          optionNamesTargetPed = { 'selldrugs', 'declineoffer' }
          local options = {
            {
              name = 'selldrugs',
              icon = 'fas fa-hand-holding-dollar',
              label = locale("target_drug_offer", bagAmount, currentOfferDrug.label, randomPrice),
              onSelect = function()
                TriggerServerEvent('ag_drugs:server:sellCornerDrugs', drugType, bagAmount, randomPrice)
                hasTarget = false
                lib.requestAnimDict("gestures@f@standing@casual", 200)
                TaskPlayAnim(cache.ped, "gestures@f@standing@casual", "gesture_point", 3.0, 3.0, -1, 49, 0, false, false, false)
                Wait(650)
                ClearPedTasks(cache.ped)
                SetPedKeepTask(ped, false)
                SetEntityAsNoLongerNeeded(ped)
                ClearPedTasksImmediately(ped)
                lastPed[#lastPed + 1] = ped
                exports.ox_target:removeEntity(targetPedSale, optionNamesTargetPed)
                PoliceCall()
              end,
            },
            {
              name = 'declineoffer',
              icon = 'fas fa-x',
              label = locale('decline_offer'),
              onSelect = function()
                lib.notify({ type = 'error', description = locale("offer_declined") })
                hasTarget = false
                SetPedKeepTask(ped, false)
                SetEntityAsNoLongerNeeded(ped)
                ClearPedTasksImmediately(ped)
                lastPed[#lastPed + 1] = ped
                exports.ox_target:removeEntity(targetPedSale, optionNamesTargetPed)
              end,
            },
          }
          exports.ox_target:addEntity(targetPedSale, options)
        end
      else
        zoneMade = false
        exports.ox_target:removeEntity(targetPedSale, optionNamesTargetPed)

        hasTarget = false
        SetPedKeepTask(ped, false)
        SetEntityAsNoLongerNeeded(ped)
        ClearPedTasksImmediately(ped)
        lastPed[#lastPed + 1] = ped
        break
      end
    end
    Wait(0)
  end
  Wait(math.random(4000, 7000))
end

local function ToggleSelling()
  if cornerselling then
    stealingPed = nil
    stealData = {}
    cornerselling = false
    return lib.notify({ type = 'success', description = locale("stopped_selling_drugs") })
  end

  cornerselling = true
  lib.notify({ type = 'success', description = locale("started_selling_drugs") })
  local startLocation = GetEntityCoords(cache.ped)
  CreateThread(function()
    while cornerselling do
      local player = cache.ped
      local coords = GetEntityCoords(player)
      if not hasTarget then
        local PlayerPeds = {}
        if next(PlayerPeds) == nil then
          for _, activePlayer in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(activePlayer)
            PlayerPeds[#PlayerPeds + 1] = ped
          end
        end
        local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
        if closestDistance < 15.0 and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed, false) and GetPedType(closestPed) ~= 28 then
          SellToPed(closestPed)
        end
      end
      local startDist = #(startLocation - coords)
      if startDist > 10 then
        TooFarAway()
      end
      Wait(0)
    end
  end)
end

-- Events
RegisterNetEvent('ag_drugs:client:cornerselling', function()
  if exports.ag_misc:getDuty('leo') < Config.CornerSelling.minimum_police then
    return lib.notify({
      type = 'error',
      description = locale("not_enough_police", Config.CornerSelling.minimum_police)
    })
  end

  local result = lib.callback.await('ag_drugs:server:getAvailableDrugs', false)

  if not result then
    lib.notify({ type = 'error', description = locale("has_no_drugs") })
    return
  end

  availableDrugs = result
  ToggleSelling()
end)

RegisterNetEvent('ag_drugs:client:refreshAvailableDrugs', function(items)
  availableDrugs = items
  if availableDrugs or #availableDrugs > 0 then return end

  lib.notify({ type = 'error', description = locale("no_drugs_left") })
  cornerselling = false
end)

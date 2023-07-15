local ObjectList = {}

local addIngreidents = {}
local smokeEffects = {}

local zones = {}
local busy = false

local function grabBarrel(barrelIndex)
  TriggerServerEvent('ag_drugs:giveBarrel', barrelIndex)
  exports['ps-dispatch']:SuspiciousPerson()
end

local function getRandomKeys()
  local result = {}
  for i = 1, 4 do
    local rand = math.random(1, #Config.Keys)
    result[#result + 1] = Config.Keys[rand]
    table.remove(Config.Keys, rand)
  end

  return result
end

local function SmokeEffectWhenCooking(labIndex)
  if not HasNamedPtfxAssetLoaded("core") then
    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
      Wait(1)
    end
  end

  for k = 1, #Config.meth.labs[labIndex].smokeLocations do
    local loc = Config.meth.labs[labIndex].smokeLocations[k]
    UseParticleFxAsset("core")
    local effect = StartParticleFxLoopedAtCoord("ent_amb_smoke_foundry", loc.x, loc.y, loc.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    smokeEffects[#smokeEffects + 1] = effect
  end

  SetTimeout(2 * 60 * 1000, function()
    for k = 1, #smokeEffects do
      StopParticleFxLooped(smokeEffects[k], 0)
    end
  end)
end

local function AddIngriedentTolab(ingredientName, labName, labIndex, ingredientIndex)
  local ped = cache.ped
  local pos = GetEntityCoords(ped)
  local ProgressbarTime = 8000

  lib.callback('ag_drugs:isLabBlownUp', false, function(data)
    if data then return lib.notify({ type = 'error', description = locale('lab_toasty') }) end

    if ingredientName ~= 'finish' or not QBCore.Functions.HasItem(ingredientName) then
      return lib.notify({ type = 'error', description = locale('issue_found') })
    end

    if ingredientName == 'finish' then
      ProgressbarTime = 30000
      SmokeEffectWhenCooking(labIndex)
    end

    local success = lib.progressCircle({
      duration = ProgressbarTime,
      label = locale('ingrediant_working'),
      disable = {
        move = true,
        combat = true,
        car = true
      },
      anim = {
        dict = "amb@prop_human_bum_bin@idle_b",
        clip = "idle_d",
        flag = 50
      }
    })

    if not success then return lib.notify({ type = 'error', description = locale('issue_found') }) end

    success = lib.skillCheck({ 'easy', 'medium' }, getRandomKeys())

    if not success or math.random(1, 100) == 1 then
      if not success and math.random(1, 100) > 30 then return lib.notify({ type = 'warning', description = locale('fuck_up_didnt_blowup') }) end
      AddExplosion(pos.x, pos.y, pos.z, 49, 20.0, true, false, 2.0)
      lib.notify({ type = 'error', description = locale('fucked_up') })
      TriggerServerEvent("ag_drugs:adjustIngredientsToMeth", "blown", labName, ingredientName, labIndex, ingredientIndex)
      return exports["ps-dispatch"]:Explosion()
    end

    if ingredientName ~= 'finish' then
      TriggerServerEvent("ag_drugs:adjustIngredientsToMeth", "add", labName, ingredientName, labIndex, ingredientIndex)
      return lib.notify({ type = 'success', description = locale('next_ingredient') })
    end

    lib.callback("ag_drugs:labRunsThisRestart", false, function(data)
      local labsBlowUpChancce = data * 20
      if math.random(0, 100) > labsBlowUpChancce then
        return TriggerServerEvent("ag_drugs:finishedMethLab", labName, labIndex)
      end

      AddExplosion(pos.x, pos.y, pos.z, 49, 20.0, true, false, 2.0)
      lib.notify({ type = 'error', description = locale('lab_exhausted') })
      exports["ps-dispatch"]:Explosion()
    end, labIndex)
  end, { labindex = labIndex })
end

local function fillBottles()
  if busy then return end
  busy = true
  local count = exports.ox_inventory:Search('count', 'empty_bottle')

  if count < 20 then
    busy = false
    return lib.notify({ type = 'error', description = locale('missing_something') })
  end

  count = exports.ox_inventory:Search('count', 'open_barrel_methylamine')

  if count == 0 then
    busy = false
    return lib.notify({ type = 'error', description = locale('missing_something') })
  end

  local success = lib.progressCircle({
    duration = 20000,
    label = locale('empty_barrel'),
    disable = {
      move = true,
      car = true,
      combat = true
    },
    canCancel = true,
    anim = {
      dict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
      clip = "plant_floor",
      flags = 16
    }
  })

  if not success then
    busy = false
    return lib.notify({ type = 'error', description = locale('issue_found') })
  end
  busy = false
  TriggerServerEvent("ag_drugs:giveFullBottles")
end

local function onLoad()
  lib.requestModel(`prop_barrel_01a`, 200)
  lib.callback("ag_drugs:getRandomBarrelLocation", false, function(data)
    for index, value in ipairs(data) do
      zones[index] = exports.ox_target:addSphereZone({
        coords = value,
        radius = 0.9,
        debug = true,
        options = {
          {
            onSelect = function()
              grabBarrel(index)
            end,
            icon = "fas fa-people-carry-box",
            label = "Grab Barrel"
          },
        }
      })
    end
  end)

  for k = 1, #Config.meth.labs do
    local labName = Config.meth.labs[k].labName
    for v = 1, #Config.meth.labs[k] do
      local currentLab = Config.meth.labs[k][v]
      if currentLab.polyzone == 'box' then
        exports['qb-target']:AddBoxZone(currentLab.name .. "-" .. labName, currentLab.coords, currentLab.length, currentLab.width, {
          name = currentLab.name .. "-" .. labName,
          heading = currentLab.heading,
          debugPoly = false,
          minZ = currentLab.minZ,
          maxZ = currentLab.maxZ
        }, {
          options = {
            {
              action = function()
                AddIngriedentTolab(currentLab.name, labName, k, v)
              end,

              type = "client",
              icon = 'fas fa-hand-paper',
              label = currentLab.localName,
            },
          },
          distance = currentLab.distance
        })
      elseif currentLab.polyzone == 'circle' then
        exports['qb-target']:AddCircleZone(currentLab.name .. "-" .. labName, currentLab.coords, currentLab.circleRadius, {
          name = currentLab.name .. "-" .. labName,
          debugPoly = false,
        }, {
          options = {
            {
              action = function()
                AddIngriedentTolab(currentLab.name, labName, k, v)
              end,
              type = "client",
              icon = "fas fa-people-carry-box",
              label = currentLab.localName,
            },
          },
          distance = currentLab.distance
        })
      end
    end
  end

  RequestModel(Config.meth.barrel_ped.model)
  while not HasModelLoaded(Config.meth.barrel_ped.model) do Wait(10) end
  local ped = CreatePed(0, Config.meth.barrel_ped.model, Config.meth.barrel_ped.coords.x, Config.meth.barrel_ped.coords.y, Config.meth.barrel_ped.coords.z - 1.0,
    Config.meth.barrel_ped.coords.w, false, false)
  TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
  FreezeEntityPosition(ped, true)
  SetEntityInvincible(ped, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  exports.ox_target:addLocalEntity(ped, {
    {
      label = 'Fill Bottles',
      icon = 'fas fa-bottle-water',
      onSelect = fillBottles,
      items = { empty_bottle = 20, open_barrel_methylamine = 1 }
    }
  })
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  onLoad()
end)

local function GetClosestMethObject()
  local pos = GetEntityCoords(cache.ped, true)
  local current = nil
  local dist = nil

  for id, data in pairs(ObjectList) do
    local dist2 = #(pos - ObjectList[id].coords)
    if current then
      if dist2 < dist then
        current = id
        dist = dist2
      end
    else
      dist = dist2
      current = id
    end
  end
  return current, dist
end

local function createMeth()
  local ped = cache.ped
  local pos = GetEntityCoords(ped)
  if not ingreidents.ephedrine and not ingreidents.acetone and not addIngreidents.coughsyrup and not ingreidents.batteryacid then
    QBCore.Functions.Notify("Seems like you are missing something... You kinda fucked up", "error")
    lib.notify({ type = 'error', description = locale('missing_something_fucked_up') })
    Wait(2000)
    return AddExplosion(pos.x, pos.y, pos.z, 0, 4.0, true, false, 2.0)
  end

  local success = lib.progressCircle({
    duration = 30000,
    label = locale('creating_meth'),
    disable = {
      move = true,
      car = true,
      combat = true
    },
    anim = {
      dict = "amb@prop_human_bum_bin@idle_b",
      clip = "idle_d",
      flags = 50
    }
  })

  if not success then
    return lib.notify({ type = 'error', description = locale("issue_found") })
  end

  lib.notify({ type = 'success', description = locale("nice_work") })
  TriggerServerEvent('ag_drugs:createdMeth', addIngreidents)
  addIngreidents = {}
end

local function AddIngriedentToTable(ingredient)
  local ped = cache.ped
  local pos = GetEntityCoords(ped)

  local count = exports.ox_inventory:Search('count', ingredient)

  if count == 0 then return lib.notify({ type = 'error', description = locale('missing_something') }) end

  local success = lib.progressCircle({
    duration = 8000,
    label = locale('add_ingredient'),
    disable = {
      move = true,
      car = true,
      combat = true
    },
    anim = {
      dict = "amb@prop_human_bum_bin@idle_b",
      clip = "idle_d",
      flags = 50
    }
  })

  success = lib.skillCheck({ 'easy', 'medium' }, getRandomKeys())

  if success then
    TriggerServerEvent("ag_drugs:removeIngreident", ingredient)
  end

  if not success or math.random(1, 100) == 1 then
    if not success and math.random(1, 100) > 30 then return lib.notify({ type = 'warning', description = locale('fuck_up_didnt_blowup') }) end
    AddExplosion(pos.x, pos.y, pos.z, 49, 20.0, true, false, 2.0)
    lib.notify({ type = 'error', description = locale('fucked_up') })
    TriggerServerEvent("ag_drugs:adjustIngredientsToMeth", "blown", labName, ingredientName, labIndex, ingredientIndex)
    return exports["ps-dispatch"]:Explosion()
  end

  QBCore.Functions.Notify('Good work. Onto the next ingredient', 'success', 1000)
  addIngreidents[ingredient] = true
  return lib.notify({ type = 'success', description = locale('next_ingredient') })
end

local function deleteObject()
  local objectId, dist = GetClosestMethObject()
  if dist > 5.0 then return end

  local success = lib.progressCircle({
    duration = 2500,
    label = locale('remove_object'),
    disable = {
      move = true,
      car = true,
      combat = true
    },
    anim = {
      dict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
      clip = "plant_floor",
      flags = 16
    }
  })

  if not success then return lib.notify({ type = 'error', description = locale('issue_found') }) end

  TriggerServerEvent("ag_drugs:deleteObject", objectId)
end

RegisterNetEvent('ag-meth:client:removeObject', function(objectId)
  NetworkRequestControlOfEntity(ObjectList[objectId].object)
  DeleteObject(ObjectList[objectId].object)
  ObjectList[objectId] = nil
  exports['qb-target']:RemoveZone('methtable' .. objectId)
end)

RegisterNetEvent('ag-meth:client:spawnObject', function(objectId)
  local coords = GetEntityCoords(cache.ped)
  local heading = GetEntityHeading(cache.ped)
  local forward = GetEntityForwardVector(cache.ped)
  local x, y, z = table.unpack(coords + forward * 0.8)
  local spawnedObj = CreateObject(Config.meth.objects.methtable.model, x, y, z, true, false, false)
  PlaceObjectOnGroundProperly(spawnedObj)
  SetEntityHeading(spawnedObj, heading)
  FreezeEntityPosition(spawnedObj, Config.meth.objects.methtable.freeze)
  ObjectList[objectId] = {
    id = objectId,
    object = spawnedObj,
    coords = vector3(x, y, z - 0.3),
  }

  exports['qb-target']:AddBoxZone('methtable' .. objectId, ObjectList[objectId].coords, 2.2, 1, {
    name = "methtable" .. objectId,
    heading = heading + 90,
    debugPoly = false,
    minZ = ObjectList[objectId].coords.z - 1,
    maxZ = ObjectList[objectId].coords.z + 1,
  }, {
    options = {
      {
        action = function()
          deleteObject()
        end,
        label = "Collect Table",
        icon = 'fas fa-ellipsis',
        canInteract = function()
          if addIngreidents['ephedrine'] or addIngreidents['acetone'] or addIngreidents['coughsyrup'] or addIngreidents['batteryacid'] then return false end
          return true
        end,
      },
      {
        action = function()
          createMeth()
        end,
        label = "Create Meth",
        icon = 'fas fa-kitchen-set',
        canInteract = function()
          if addIngreidents['ephedrine'] and addIngreidents['acetone'] and addIngreidents['coughsyrup'] and addIngreidents['batteryacid'] then return true end
          return false
        end,
      },
      {
        action = function()
          AddIngriedentToTable('ephedrine')
        end,
        label = "Add Ephedrine",
        item = 'ephedrine',
        icon = 'fas fa-plus',
        canInteract = function()
          if addIngreidents['ephedrine'] then return false end
          return true
        end,
      },
      {
        action = function()
          AddIngriedentToTable('acetone')
        end,
        label = "Add Acetone",
        item = 'acetone',
        icon = 'fas fa-plus',
        canInteract = function()
          if addIngreidents['acetone'] then return false end
          return true
        end,
      },
      {
        action = function()
          AddIngriedentToTable('coughsyrup')
        end,
        label = "Add Cough Syrup",
        item = 'coughsyrup',
        icon = 'fas fa-plus',
        canInteract = function()
          if addIngreidents['coughsyrup'] then return false end
          return true
        end,
      },
      {
        action = function()
          AddIngriedentToTable('batteryacid')
        end,
        label = "Add Battery Acid",
        item = 'batteryacid',
        icon = 'fas fa-plus',
        canInteract = function()
          if addIngreidents['batteryacid'] then return false end
          return true
        end,
      },
    },
    distance = 2.5,
  })
end)

RegisterNetEvent('ag_drugs:client:removeBarrelZone', function(index)
  if not zones[index] then return end
  exports.ox_target:removeZone(zones[index])
  zones[index] = nil
end)

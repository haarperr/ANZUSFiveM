local WeedPlants = {}
local inRange = false
local nearestPlant = nil
local isSpawned = false
local currentPlantId = 0
local showingDetail = false

PlacedPlantsCount = 0

CurrentObj = nil

local function burnWeedPlants(id, loc)
  ProgressBar("destroy-plant", id, loc, nil)
end

local function getTables()
  lib.callback(GetCurrentResourceName() .. ':server:getTables', false, function(data)
    WeedPlants = data
    for k, v in ipairs(WeedPlants) do
      v.textH = vector3(v.coords[1], v.coords[2], v.coords[3] + 1.5) --health status text
      v.textP = vector3(v.coords[1], v.coords[2], v.coords[3] + 1.7) --progress status text
      v.textN = vector3(v.coords[1], v.coords[2], v.coords[3] + 1.9) --label status text
    end
    isSpawned = true
  end)
end

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
  getTables()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  isSpawned = false
  if not WeedPlants then return end

  for _, v in pairs(WeedPlants) do
    DeleteEntity(v.obj)
    v.obj = nil
  end
end)


AddEventHandler('onResourceStop', function(resource)
  if GetCurrentResourceName() ~= resource then return end
  if not WeedPlants then return end

  for _, v in pairs(WeedPlants) do
    DeleteEntity(v.obj)
  end
end)

AddEventHandler('onResourceStart', function(resource)
  if (GetCurrentResourceName() ~= resource) then return end
  if isSpawned then return end

  Wait(1000)
  getTables()
end)


---@param id number
local function openOptions(id)
  currentPlantId = id
  nearestPlant = id
  CurrentObj = WeedPlants[id].obj

  SetNuiFocus(true, true)

  if showingDetail then return end

  showingDetail = true
  SendNUIMessage({
    action = "show",
    Label = WeedPlants[id].label,
    Progress = WeedPlants[id].progress,
    Health = WeedPlants[id].health,
    State = WeedPlants[id].state,
    Water = WeedPlants[id].water,
    ShowOptions = true,
    DestroyOptions = Config.DestroyOptions,
  })
end

RegisterNetEvent(GetCurrentResourceName() .. ":client:checkClosestPlant", function(data)
  if not WeedPlants then return end

  local index = 0
  for k, v in ipairs(WeedPlants) do
    if v.obj == data.entity then
      index = k
    end
  end

  if index == 0 then
    return lib.notify({ type = 'error', description = Config.Locale["invalid_plant"] })
  end

  openOptions(index)
end)

RegisterNUICallback("FocusOff", function(data, cb)
  SetNuiFocus(false, false)
  showingDetail = false
end)

local function giveInsecticide()
  local pos = GetEntityCoords(cache.ped)

  local count = exports.ox_inventory:Search('count', Config.Items["insecticide"])

  if not count or count == 0 then return lib.notify({ type = 'error', description = Config.Locale["no_insecticide"] }) end

  if not currentPlantId and #(pos - WeedPlants[currentPlantId].coords) > 2.5 then
    return lib.notify({ type = 'error', description = Config.Locale["no_plant_nearby"] })
  end

  local plantID = currentPlantId
  local plantLoc = WeedPlants[currentPlantId].coords
  ProgressBar("giving-insecticide", plantID, plantLoc, nil)
  lib.progressCircle({

  })
end

local function giveWater()
  local pos = GetEntityCoords(cache.ped)

  local count = exports.ox_inventory:Search('count', Config.Items["water"])

  if not count or count == 0 then return lib.notify({ type = 'error', description = Config.Locale["no_water"] }) end

  if not currentPlantId or #(pos - WeedPlants[currentPlantId].coords) > 2.5 then return lib.notify({ type = 'error', description = Config.Locale["no_plant_nearby"] }) end

  local plantID = currentPlantId
  local plantLoc = WeedPlants[currentPlantId].coords
  ProgressBar("giving-water", plantID, plantLoc, nil)
end

RegisterNUICallback("OptionHandler", function(data, cb)
  if showingDetail then
    SendNUIMessage({
      action = "hide",
    })
    SetNuiFocus(false, false)
    showingDetail = false
  end

  if data.action == "harvest-option" then
    if WeedPlants[currentPlantId].progress < 100 then return lib.notify({ type = 'error', description = Config.Locale["plant_not_ready"] }) end
    HarvestWeed(currentPlantId, CurrentObj)
  elseif data.action == "insecticide-option" then
    giveInsecticide()
  elseif data.action == "destroy-option" then
    burnWeedPlants(currentPlantId, WeedPlants[currentPlantId].coords)
  elseif data.action == "water-option" then
    giveWater()
  end
end)


--TODO Check if being called, if not remove
RegisterNetEvent(GetCurrentResourceName() .. ":client:Harvest", function(data)
  if WeedPlants[data.id].progress >= 100 then
    HarvestWeed(data.id, data.obj)
  else
    ShowNotification(Config.Locale["plant_not_ready"], "error")
  end
end)

--TODO Check if being called, if not remove
RegisterNetEvent(GetCurrentResourceName() .. ":client:Destroy", function(data)
  burnWeedPlants(data.id, WeedPlants[data.id].coords)
end)


--TODO: Move out of thread, change into zones?
--Also check logic
CreateThread(function()
  while true do
    Wait(7)
    if isSpawned and WeedPlants then
      inRange = false
      local ped = cache.ped
      local pos = GetEntityCoords(ped)
      for k, v in ipairs(WeedPlants) do
        local dist = #(pos - v.coords)

        if dist <= 150.0 then
          if v.obj == nil then
            for _, b in pairs(Config.Stages) do
              if v.progress >= b.min and v.progress <= b.max then
                local obj = CreateObject(joaat(b.model), v.coords.x, v.coords.y, v.coords.z + b.offset, false, false, false)
                FreezeEntityPosition(obj, true)
                v.obj = obj
              end
            end
          end
        else
          if v.obj then
            DeleteEntity(v.obj)
            v.obj = nil
          end
        end

        if Config.CanBurnPlants then
          if v.obj and IsEntityOnFire(v.obj) and v.IsBurning == nil then
            v.IsBurning = true
            burnWeedPlants(k, v.coords)
          end
        end
      end
    end

    if not inRange then
      Wait(500)
    end
  end
end)

function HarvestWeed(id, obj)
  local loc = WeedPlants[id].coords

  lib.callback(GetCurrentResourceName() .. ':server:getPlayerMetadata', false, function(rep)
    if rep < Config.RequiredRep then return lib.notify({ type = 'error', description = Config.Locale["need_rep_harvest"] }) end

    ProgressBar("harvest", id, loc, obj)
  end)
end

RegisterNetEvent(GetCurrentResourceName() .. ':client:placeWeedPlant', function(seed, label)
  checkPlantingSurface(seed, label)
end)

RegisterNetEvent(GetCurrentResourceName() .. ':client:addWeedPlant', function(data)
  local plant = data
  if #(GetEntityCoords(cache.ped) - data.coords) <= 150.0 then
    local obj = CreateObject(joaat(Config.Stages[1].model), data.coords.x, data.coords.y, data.coords.z + Config.Stages[1].offset, false, false, false)
    FreezeEntityPosition(obj, true)
    plant.obj = obj
  end
  table.insert(WeedPlants, plant)
end)

RegisterNetEvent(GetCurrentResourceName() .. ':client:updatePlantStatus', function(data)
  for k, v in ipairs(WeedPlants) do
    v.health = data[k].health
    v.progress = data[k].progress
    v.water = data[k].water

    if v.state == Config.HarvestingState then goto skip end

    for _, b in pairs(Config.Stages) do
      if v.progress >= b.min and v.progress <= b.max and v.state ~= b.state then
        DeleteEntity(v.obj)
        local obj = CreateObject(joaat(b.model), v.coords.x, v.coords.y, v.coords.z + b.offset, false, false, false)
        FreezeEntityPosition(obj, true)
        v.obj = obj
      end
    end
    v.state = data[k].state
    ::skip::
  end
end)

RegisterNetEvent(GetCurrentResourceName() .. ':client:updatePlantHealth', function(coords, data)
  for _, v in ipairs(WeedPlants) do
    if v.coords == coords then
      v.health = data.health
      break
    end
  end
end)

RegisterNetEvent(GetCurrentResourceName() .. ':client:updatePlantWater', function(coords, data)
  for _, v in ipairs(WeedPlants) do
    if v.coords == coords then
      v.water = data.water
      break
    end
  end
end)

RegisterNetEvent(GetCurrentResourceName() .. ':client:deleteWeedPlant', function(plantID, action)
  if not WeedPlants[plantID] then return end

  DeleteEntity(WeedPlants[plantID].obj)
  table.remove(WeedPlants, plantID)
  if nearestPlant == plantID then
    nearestPlant = nil
  end
end)

function checkPlantingSurface(seed, label)
  if PlacedPlantsCount >= Config.MaxPlantsOut then
    return lib.notify({ type = 'error', description = 'You cannot place any more plants' })
  end

  local ped = cache.ped
  local coordA = GetEntityCoords(ped)
  local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, -3.0)
  local testRay = StartExpensiveSynchronousShapeTestLosProbe(coordA, coordB, 17, ped, 7)
  local _, hit, endCoords, surfaceNormal, materialHash, _ = GetShapeTestResultIncludingMaterial(testRay)
  if Config.ShowSoilHash then
    print("Soil-Hash : ", materialHash)
  end

  if not hit then return lib.notify({ type = 'error', description = Config.Locale["no_surface_notify"] }) end

  materialHash = tostring(materialHash)
  if Config.Soil[materialHash] == nil then
    return lib.notify({ type = 'error', description = Config.Locale["not_suitable_soil"] })
  end

  if surfaceNormal.z < 0.7 then
    return lib.notify({ type = 'error', description = Config.Locale["slant_surface_notify"] })
  end

  local soil_nature = Config.Soil[materialHash].ph
  local item = nil

  if soil_nature == "acidic" then
    item = Config.Items["acidic_soil_item"]
  elseif soil_nature == "basic" then
    item = Config.Items["alkaline_soil_item"]
  end

  local result = item == nil and true or false
  if item ~= nil then
    local count = exports.ox_inventory:Search('count', item)
    if count >= 1 then result = true end
  end

  if result or soil_nature == "neutral" then
    return ProgressBarPlant(endCoords, materialHash, seed, label)
  end

  if soil_nature == "acidic" then
    lib.notify({ type = 'error', description = Config.Locale["soil_acidity_notify"] })
  elseif soil_nature == "basic" then
    lib.notify({ type = 'error', description = Config.Locale["soil_alkaline_notify"] })
  end
end

-- Function to find hash of thing you are fucking looking at
-- CreateThread(function()
--   while true do
--     local ped = cache.ped
--     local a = GetEntityCoords(ped)
--     local b = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, -3.0)
--     local testRay = StartExpensiveSynchronousShapeTestLosProbe(a, b, 17, ped, 7)
--     local _, _, _, _, materialHash, _ = GetShapeTestResultIncludingMaterial(testRay)
    
--     print(materialHash)
--     Wait(1000)
--   end
-- end)
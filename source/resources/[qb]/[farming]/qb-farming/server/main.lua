QBCore = exports['qb-core']:GetCoreObject()

WeedPlants = {}

CreateThread(function()
  Wait(100)
  local LoadJson = json.decode(LoadResourceFile(GetCurrentResourceName(), 'plants.json'))
  for k, v in ipairs(LoadJson) do
    v.coords = vector3(v.coords['x'], v.coords['y'], v.coords['z'])
  end
  WeedPlants = LoadJson
end)

lib.callback.register(GetCurrentResourceName() .. ':server:getTables', function()
  return WeedPlants
end)

lib.callback.register(GetCurrentResourceName() .. ':server:getPlayerMetadata', function(source)
  local Player = QBCore.Functions.GetPlayer(source)
  return Player.PlayerData.metadata.farmingrep or 0
end)

RegisterServerEvent(GetCurrentResourceName() .. ':server:addWeedPlant', function(loc, soilHash, seed, label)
  local src = source
  local item = nil
  if Config.Soil[soilHash].ph == "acidic" then
    item = Config.Items["acidic_soil_item"]
  elseif Config.Soil[soilHash].ph == "basic" then
    item = Config.Items["alkaline_soil_item"]
  end

  if Config.Soil[soilHash].ph == "neutral" or exports.ox_inventory:RemoveItem(src, item, 1) then
    if exports.ox_inventory:RemoveItem(src, seed, 1) then
      local plantInfo = {}
      plantInfo.coords = loc
      plantInfo.soil = soilHash
      plantInfo.state = Config.Stages[1].stage
      plantInfo.progress = 0
      plantInfo.health = 100
      plantInfo.seed = seed
      plantInfo.label = label
      plantInfo.water = Config.StartingWaterLevel

      table.insert(WeedPlants, plantInfo)
      StorePlantsTable()
      TriggerClientEvent(GetCurrentResourceName() .. ':client:addWeedPlant', -1, plantInfo)
    end
  end
end)

RegisterServerEvent(GetCurrentResourceName() .. ':server:deleteWeedPlant', function(id, loc, action)
  if not WeedPlants[id] then return end
  if WeedPlants[id].coords == loc then
    table.remove(WeedPlants, id)
    StorePlantsTable()
    return TriggerClientEvent(GetCurrentResourceName() .. ':client:deleteWeedPlant', -1, id, action)
  end

  for k, v in ipairs(WeedPlants) do
    if v.coords == loc then
      table.remove(WeedPlants, k)
      StorePlantsTable()
      TriggerClientEvent(GetCurrentResourceName() .. ':client:deleteWeedPlant', -1, k, action)
      break
    end
  end
end)

RegisterServerEvent(GetCurrentResourceName() .. ":server:removeInsecticide", function()
  local src = source
  local success = exports.ox_inventory:RemoveItem(src, Config.Items["insecticide"], 1)

  if not success then return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'You don\'t have any insecticide' }) end
end)

RegisterServerEvent(GetCurrentResourceName() .. ':server:updateWeedPlantHealth', function(id, loc)
  local returnData = {}

  if not WeedPlants[id] then return end

  if WeedPlants[id].coords == loc then
    WeedPlants[id].health = WeedPlants[id].health + Config.InsecticideEffect
    if WeedPlants[id].health > 100 then
      WeedPlants[id].health = 100
    end
    returnData.health = WeedPlants[id].health
    StorePlantsTable()
    return TriggerClientEvent(GetCurrentResourceName() .. ':client:updatePlantHealth', -1, WeedPlants[id].coords, returnData)
  end

  for k, v in ipairs(WeedPlants) do
    if v.coords == loc then
      WeedPlants[k].health = WeedPlants[k].health + Config.InsecticideEffect
      if WeedPlants[k].health > 100 then
        WeedPlants[k].health = 100
      end
      returnData.health = WeedPlants[k].health
      StorePlantsTable()
      TriggerClientEvent(GetCurrentResourceName() .. ':client:updatePlantHealth', -1, WeedPlants[k].coords, returnData)
      break
    end
  end
end)

RegisterServerEvent(GetCurrentResourceName() .. ':server:updateWeedPlantWater', function(id, loc)
  local returnData = {}
  if not WeedPlants[id] then return end
  if WeedPlants[id].coords == loc then
    WeedPlants[id].water = WeedPlants[id].water + Config.WaterIncreaseLevel
    if WeedPlants[id].water > 100 then
      WeedPlants[id].water = 100
    end
    returnData.water = WeedPlants[id].water
    StorePlantsTable()
    return TriggerClientEvent(GetCurrentResourceName() .. ':client:updatePlantWater', -1, WeedPlants[id].coords, returnData)
  end

  for k, v in ipairs(WeedPlants) do
    if v.coords == loc then
      WeedPlants[k].water = WeedPlants[k].water + Config.WaterIncreaseLevel
      if WeedPlants[k].water > 100 then
        WeedPlants[k].water = 100
      end
      returnData.health = WeedPlants[k].health
      StorePlantsTable()
      TriggerClientEvent(GetCurrentResourceName() .. ':client:updatePlantWater', -1, WeedPlants[k].coords, returnData)
      break
    end
  end
end)

CreateThread(function()
  for k, v in pairs(Config.Seed) do
    QBCore.Functions.CreateUseableItem(k, function(source, item)
      local src = source
      local Player = QBCore.Functions.GetPlayer(src)
      if Player.PlayerData.metadata.farmingrep < Config.RequiredRep then
        return TriggerClientEvent('ox_lib:notify', src,
          { type = 'error', description = Config.Locale["need_reputation"] })
      end
      TriggerClientEvent(GetCurrentResourceName() .. ':client:placeWeedPlant', src, k, v.label)
    end)
  end
end)

CreateThread(function()
  while true do
    Wait(60000 * Config.CycleTime)
    local returnData = {}
    if WeedPlants then
      for k, v in ipairs(WeedPlants) do
        local data1 = {}
        if v.health > 0 then
          if math.random(1, 100) <= Config.InfectionProbability then
            v.health = v.health - Config.InsecticideEffect
            if v.health < 0 then
              v.health = 0
            end
          end

          if math.random(1, 100) <= Config.WaterProbability then
            v.water = v.water - Config.WaterDepletion
            if v.water < 0 then
              v.water = 0
            end
          end

          if v.water == 0 then
            v.health = v.health - Config.WaterEffect
            if v.health < 0 then
              v.health = 0
            end
          end

          data1.health = v.health
        else
          table.remove(WeedPlants, k)
          StorePlantsTable()
          --TODO Look into, tf calling all clients?
          TriggerClientEvent(GetCurrentResourceName() .. ':client:deleteWeedPlant', -1, k, "plant-dead")
        end

        if v.state ~= "Harvesting" then
          v.progress = math.floor(v.progress + Config.ProgressPerCycle * (Config.Soil[v.soil].fertility))
          if v.progress > 100 then
            v.progress = 100
            v.state = Config.HarvestingState
          end
          if v.state ~= Config.HarvestingState then
            for _, b in pairs(Config.Stages) do
              if v.progress >= b.min and v.progress <= b.max then
                v.state = b.state
              end
            end
          end
        end
        data1.progress = v.progress
        data1.state = v.state
        data1.water = v.water
        --TODO Does this need an exact id if not switch to alt (#+1)
        table.insert(returnData, data1)
      end
      StorePlantsTable()
      TriggerClientEvent(GetCurrentResourceName() .. ':client:updatePlantStatus', -1, returnData)
    end
  end
end)

function StorePlantsTable()
  SaveResourceFile(GetCurrentResourceName(), "plants.json", json.encode(WeedPlants), -1)
end

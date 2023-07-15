function ShowNotification(msg, type)
  if Config.QBCoreNotify then
    QBCore.Functions.Notify(msg, type)
  elseif Config.okokNotify then
    exports['okokNotify']:Alert(Config.OkOkNotifyTitle, msg, 5000, type)
  elseif Config.pNotify then
    exports.pNotify:SendNotification({ text = msg, type = type, layout = Config.pNotifyLayout, timeout = 5000 })
  end
end

CreateThread(function()
  local Plants = {}

  for k, v in pairs(Config.Stages) do
    table.insert(Plants, v.model)
  end
  if Config.EnableTargetExports then
    exports[Config.Target]:AddTargetModel(Plants, {
      options = {
        {
          type = "client",
          event = GetCurrentResourceName() .. ":client:checkClosestPlant",
          icon = "fas fa-cannabis",
          label = "Check Plant",
        },
      },
      distance = 2.5
    })
  end
end)


function ProgressBar(type, id, coords, obj) -- do not change these parameters
  if type == "giving-water" then
    local success = lib.progressCircle({
      duration = 2000,
      position = 'bottom',
      canCancel = true,
      disable = {
        move = true,
        car = true,
        combat = true
      },
      anim = {
        dict = 'pickup_object',
        clip = 'putdown_low',
        flag = 49
      }
    })

    if not success then return end
    --TODO change to ox
    TriggerServerEvent(GetCurrentResourceName() .. ":server:removeItem", Config.Items["water"]) -- do not touch this
    TriggerServerEvent(GetCurrentResourceName() .. ":server:updateWeedPlantWater", id, coords)  -- do not touch this

    PlacedPlantsCount -= 1
  elseif type == "destroy-plant" then
    local success = lib.progressCircle({
      duration = 2000,
      position = 'bottom',
      canCancel = true,
      disable = {
        move = true,
        car = true,
        combat = true
      },
      anim = {
        dict = 'weapons@first_person@aim_rng@generic@projectile@thermal_charge@',
        clip = 'plant_floor',
        flag = 49
      }
    })

    if not success then return end

    TriggerServerEvent(GetCurrentResourceName() .. ":server:deleteWeedPlant", id, coords) -- do not touch this
    PlacedPlantsCount -= 1
  elseif type == "giving-insecticide" then
    local success = lib.progressCircle({
      duration = 2000,
      position = 'bottom',
      canCancel = true,
      disable = {
        move = true,
        car = true,
        combat = true
      },
      anim = {
        dict = 'pickup_object',
        clip = 'putdown_low',
        flag = 49
      }
    })

    if not success then return end
    TriggerServerEvent(GetCurrentResourceName() .. ":server:removeItem", Config.Items["insecticide"]) -- do not touch this
    TriggerServerEvent(GetCurrentResourceName() .. ":server:updateWeedPlantHealth", id, coords)       -- do not touch this
  elseif type == "harvest" then
    local success = lib.progressCircle({
      duration = 2000,
      position = 'bottom',
      canCancel = true,
      disable = {
        move = true,
        car = true,
        combat = true
      },
      anim = {
        scenario = "WORLD_HUMAN_GARDENER_PLANT"
      }
    })

    if not success then return end

    if DoesEntityExist(obj) then
      TriggerServerEvent(GetCurrentResourceName() .. ":server:harvestWeed", id, coords) -- do not touch this
      CurrentObj = nil                                                                  -- do not touch this
      PlacedPlantsCount -= 1
    end
  end
end

function ProgressBarPlant(a, b, c, d) -- do not change the parameters
  local success = lib.progressCircle({
    duration = 8000,
    position = 'bottom',
    canCancel = true,
    disable = {
      move = true,
      car = true,
      combat = true
    },
    anim = {
      scenario = "WORLD_HUMAN_GARDENER_PLANT"
    }
  })

  if not success then return end
  TriggerServerEvent(GetCurrentResourceName() .. ":server:addWeedPlant", a, b, c, d) -- do not touch this
  PlacedPlantsCount += 1
end

---@param key number
local function grabCashStack(key)
  local ped = cache.ped
  local pedCoords, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
  local animDict = 'anim@scripted@heist@ig1_table_grab@cash@male@'

  local stackModel = `h4_prop_h4_cash_stack_01a`
  local bagModel = `hei_p_m_bag_var22_arm_s`
  lib.requestAnimDict(animDict)
  lib.requestModel(stackModel)
  lib.requestModel(bagModel)


  local bag = CreateObject(bagModel, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)
  local sceneObject = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 3.0, stackModel, false, false, false)
  NetworkRequestControlOfEntity(sceneObject)
  local scenePos = GetEntityCoords(sceneObject)
  local sceneRot = GetEntityRotation(sceneObject)

  local animations = {
    { 'enter',     'enter_bag' },
    { 'grab',      'grab_bag',     'grab_cash' },
    { 'grab_idle', 'grab_idle_bag' },
    { 'exit',      'exit_bag' },
  }

  local scenes = {}

  for i = 1, #animations do
    scenes[i] = NetworkCreateSynchronisedScene(scenePos.x, scenePos.y, scenePos.z, sceneRot.x, sceneRot.y, sceneRot.z, 2, true, false, 1065353216, 0, 1.0)
    NetworkAddPedToSynchronisedScene(ped, scenes[i], animDict, animations[i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(bag, scenes[i], animDict, animations[i][2], 1.0, -1.0, 1148846080)
    if i == 2 then
      if stackModel == -180074230 then
        NetworkAddEntityToSynchronisedScene(sceneObject, scenes[i], animDict, 'grab_gold', 1.0, -1.0, 1148846080)
      else
        NetworkAddEntityToSynchronisedScene(sceneObject, scenes[i], animDict, 'grab_cash', 1.0, -1.0, 1148846080)
      end
    end
  end

  NetworkStartSynchronisedScene(scenes[1])
  Wait(GetAnimDuration(animDict, 'enter') * 1000)
  NetworkStartSynchronisedScene(scenes[2])
  Wait(GetAnimDuration(animDict, 'grab') * 1000)
  TriggerServerEvent('ag_fleeca:server:deleteCashStack', { key = key })
  TriggerServerEvent('ag_fleeca:server:rewardItem', { type = 'cashstack', key = key })
  NetworkStartSynchronisedScene(scenes[4])
  Wait(GetAnimDuration(animDict, 'exit') * 1000)

  DeleteObject(bag)
  ClearPedTasks(ped)
end

---@param key number
function CreateStackTarget(key)
  local config = Config.Banks[key].cash

  exports.ox_target:addSphereZone({
    coords = vec3(config.coords.x, config.coords.y, config.coords.z),
    radius = 0.5,
    debug = false,
    options = {
      {
        label = locale('grab_cash'),
        icon = 'fa-solid fa-sack-dollar',
        canInteract = function(_, distance)
          if GlobalState.fleecaData.cooldown and GlobalState.fleecaData.allowedBank ~= key then return false end
          return distance < 2.0 and not Config.Banks[key].cash.busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_fleeca:server:setCashStackBusy', { key = key, bool = true })
          grabCashStack(key)
        end
      }
    }
  })
end

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_fleeca:client:setCashStackBusy', function(data)
  Config.Banks[data.key].cash.busy = data.bool
end)

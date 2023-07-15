local animations = {
  { 'intro', 'bag_intro' },
  { 'grab',  'bag_grab', 'cart_cash_dissapear' },
  { 'exit',  'bag_exit' }
}

---@param key number
local function grabTrolly(key)
  local config = Config.Banks[key].trolly
  local trollyModel = config.model
  local grabModel = config.grab

  local pedCoords = GetEntityCoords(cache.ped)
  local animDict = 'anim@heists@ornate_bank@grab_cash'

  lib.requestAnimDict(animDict)
  lib.requestModel(`hei_p_m_bag_var22_arm_s`)
  local sceneObject = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0, trollyModel, false, false, false)
  local scenePos = GetEntityCoords(sceneObject)
  local sceneRot = GetEntityRotation(sceneObject)

  if key and key <= 4 then NetworkRegisterEntityAsNetworked(sceneObject) end

  local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)

  NetworkRequestControlOfEntity(sceneObject)
  while not NetworkHasControlOfEntity(sceneObject) do
    Wait(1)
  end

  local scenes = {}

  for i = 1, #animations do
    scenes[i] = NetworkCreateSynchronisedScene(scenePos.x, scenePos.y, scenePos.z, sceneRot.x, sceneRot.y, sceneRot.z, 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(cache.ped, scenes[i], animDict, animations[i][1], 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scenes[i], animDict, animations[i][2], 4.0, -8.0, 1)
    if i == 2 then
      NetworkAddEntityToSynchronisedScene(sceneObject, scenes[i], animDict, "cart_cash_dissapear", 4.0, -8.0, 1)
    end
  end

  NetworkStartSynchronisedScene(scenes[1])
  Wait(1750)

  local ped = cache.ped
  local pedCoords = GetEntityCoords(ped)

  lib.requestModel(`ch_prop_gold_bar_01a`)
  local object = CreateObject(grabModel, pedCoords.x, pedCoords.y, pedCoords.z, true, false, false)

  FreezeEntityPosition(object, true)
  SetEntityInvincible(object, true)
  SetEntityNoCollisionEntity(object, ped)
  SetEntityVisible(object, false, false)
  AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
  local startedGrabbing = GetGameTimer()

  CreateThread(function()
    while GetGameTimer() - startedGrabbing < 37000 do
      Wait(1)
      DisableControlAction(0, 73, true)
      if HasAnimEventFired(ped, `CASH_APPEAR`) then
        if not IsEntityVisible(object) then
          SetEntityVisible(object, true, false)
        end
      end
      if HasAnimEventFired(ped, `RELEASE_CASH_DESTROY`) then
        if IsEntityVisible(object) then
          SetEntityVisible(object, false, false)
        end
      end
    end
    DeleteObject(object)
  end)

  NetworkStartSynchronisedScene(scenes[2])
  Wait(37000)
  NetworkStartSynchronisedScene(scenes[3])
  TriggerServerEvent('ag_fleeca:server:deleteTrolly', { key = key })
  TriggerServerEvent('ag_fleeca:server:rewardItem', { type = 'trolly', key = key })
  Wait(2000)
  DeleteObject(bag)
  ClearPedTasks(ped)
end

---@param key number
function CreateTrollyTarget(key)
  local config = Config.Banks[key].trolly

  exports.ox_target:addSphereZone({
    coords = vec3(config.coords.x, config.coords.y, config.coords.z),
    radius = 0.7,
    debug = false,
    options = {
      {
        label = locale('grab_trolly'),
        icon = 'fa-solid fa-sack-dollar',
        canInteract = function(_, distance)
          if GlobalState.fleecaData.cooldown and GlobalState.fleecaData.allowedBank ~= key then return false end
          return distance < 2.0 and not Config.Banks[key].trolly.busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_fleeca:server:setTrollyBusy', { key = key, bool = true })
          grabTrolly(key)
        end
      }
    }
  })
end

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_fleeca:client:setTrollyBusy', function(data)
  Config.Banks[data.key].trolly.busy = data.bool
end)

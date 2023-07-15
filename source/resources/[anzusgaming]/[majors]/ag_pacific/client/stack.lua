local GrabCash = {
  objects = {
    `hei_p_m_bag_var22_arm_s`
  },
  animations = {
    { 'enter',     'enter_bag' },
    { 'grab',      'grab_bag',     'grab_cash' },
    { 'grab_idle', 'grab_idle_bag' },
    { 'exit',      'exit_bag' },
  },
  scenes = {}
}

local function grabStack(key)
  local config = Config.Bank.stack[key]
  LocalPlayer.state:set("invBusy", true, true)
  TriggerEvent('ox_inventory:disarm')

  local ped = cache.ped
  local pedCoords = GetEntityCoords(ped)
  local animDict = 'anim@scripted@heist@ig1_table_grab@cash@male@'
  if config.hash == -180074230 then
    animDict = 'anim@scripted@heist@ig1_table_grab@gold@male@'
  end

  lib.requestAnimDict(animDict)
  lib.requestModel(`hei_p_m_bag_var22_arm_s`)

  local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)
  local sceneObject = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 3.0, config.hash, false, false, false)

  local scenePos = GetEntityCoords(sceneObject)
  local sceneRot = GetEntityRotation(sceneObject)

  for i = 1, #GrabCash.animations do
    GrabCash.scenes[i] = NetworkCreateSynchronisedScene(scenePos.x, scenePos.y, scenePos.z, sceneRot.x, sceneRot.y, sceneRot.z, 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, GrabCash.scenes[i], animDict, GrabCash.animations[i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(bag, GrabCash.scenes[i], animDict, GrabCash.animations[i][2], 1.0, -1.0, 1148846080)
    if i == 2 then
      if config.hash == -180074230 then
        NetworkAddEntityToSynchronisedScene(sceneObject, GrabCash.scenes[i], animDict, 'grab_gold', 1.0, -1.0, 1148846080)
      else
        NetworkAddEntityToSynchronisedScene(sceneObject, GrabCash.scenes[i], animDict, GrabCash.animations[i][3], 1.0, -1.0, 1148846080)
      end
    end
  end

  NetworkStartSynchronisedScene(GrabCash.scenes[1])
  Wait(GetAnimDuration(animDict, 'enter') * 1000)
  NetworkStartSynchronisedScene(GrabCash.scenes[2])
  Wait(GetAnimDuration(animDict, 'grab') * 1000 - 3000)

  NetworkStartSynchronisedScene(GrabCash.scenes[4])
  Wait(GetAnimDuration(animDict, 'exit') * 1000)
  ClearPedTasks(cache.ped)

  DeleteObject(bag)
  ClearAreaOfObjects(pedCoords.x, pedCoords.y, pedCoords.z, 1.5, 0)

  TriggerServerEvent('ag_pacific:server:getReward', { key = 'stack', index = config.type, number = key })

  LocalPlayer.state:set("invBusy", false, true)
end

function SetupStackZone(key)
  local config = Config.Bank.stack[key]

  lib.requestModel(config.hash)
  exports.ox_target:addSphereZone({
    coords = config.coords,
    radius = 0.5,
    options = {
      {
        label = locale('grab', config.type),
        canInteract = function()
          return not Config.Bank.stack[key].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          AlertPolice()
          TriggerServerEvent('ag_pacific:server:setBusy', { type = 'stack', key = key, bool = true })
          grabStack(key)
        end
      }
    }
  })
end

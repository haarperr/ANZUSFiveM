local TrollyAnimation = {
  objects = {
    `hei_p_m_bag_var22_arm_s`
  },
  animations = {
    { 'intro', 'bag_intro' },
    { 'grab',  'bag_grab', 'cart_cash_dissapear' },
    { 'exit',  'bag_exit' }
  },
  scenes = {},
  scenesObjects = {}
}

local function grabTrolly(key)
  local config = Config.Bank.trolly[key]
  LocalPlayer.state:set("invBusy", true, true)
  TriggerEvent('ox_inventory:disarm')

  local grabModel = nil
  if config.hash == `ch_prop_diamond_trolly_01c` then
    grabModel = `ch_prop_vault_dimaondbox_01a`
  elseif config.hash == `ch_prop_gold_trolly_01a` then
    grabModel = `ch_prop_gold_bar_01a`
  elseif config.hash == `imp_prop_impexp_coke_trolly` then
    grabModel = `prop_coke_block_half_a`
  else
    grabModel = `hei_prop_heist_cash_pile`
  end

  local pedCoords = GetEntityCoords(cache.ped)
  local animDict = 'anim@heists@ornate_bank@grab_cash'

  lib.requestAnimDict(animDict)
  lib.requestModel(`hei_p_m_bag_var22_arm_s`)
  local sceneObject = GetClosestObjectOfType(config.coords.x, config.coords.y, config.coords.z, 2.0, config.hash, false, false, false)
  local scenePos = GetEntityCoords(sceneObject)
  local sceneRot = GetEntityRotation(sceneObject)

  if key and key <= 4 then NetworkRegisterEntityAsNetworked(sceneObject) end

  local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)

  NetworkRequestControlOfEntity(sceneObject)
  while not NetworkHasControlOfEntity(sceneObject) do
    Wait(1)
  end

  for i = 1, #TrollyAnimation.animations do
    TrollyAnimation.scenes[i] = NetworkCreateSynchronisedScene(scenePos.x, scenePos.y, scenePos.z, sceneRot.x, sceneRot.y, sceneRot.z, 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(cache.ped, TrollyAnimation.scenes[i], animDict, TrollyAnimation.animations[i][1], 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, TrollyAnimation.scenes[i], animDict, TrollyAnimation.animations[i][2], 4.0, -8.0, 1)
    if i == 2 then
      NetworkAddEntityToSynchronisedScene(sceneObject, TrollyAnimation.scenes[i], animDict, "cart_cash_dissapear", 4.0, -8.0, 1)
    end
  end

  NetworkStartSynchronisedScene(TrollyAnimation.scenes[1])
  Wait(1750)
  lib.requestModel(grabModel)
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

  NetworkStartSynchronisedScene(TrollyAnimation.scenes[2])
  Wait(37000)
  NetworkStartSynchronisedScene(TrollyAnimation.scenes[3])
  Wait(2000)
  DeleteObject(bag)
  ClearPedTasks(ped)
  LocalPlayer.state:set("invBusy", false, true)
  ClearAreaOfObjects(pedCoords.x, pedCoords.y, pedCoords.z, 1, 0)
  TriggerServerEvent('ag_pacific:server:getReward', { key = 'trolly', index = config.type, number = key })
end

function SetupTrollyZone(key)
  local config = Config.Bank.trolly[key]

  exports.ox_target:addBoxZone({
    coords = vec3(config.coords.x, config.coords.y, config.coords.z),
    size = vec3(1, 0.65, 1.2),
    rotation = config.coords.w,
    options = {
      {
        label = locale('grab', config.type),
        icon = 'fa-solid fa-hands',
        canInteract = function()
          return not Config.Bank.trolly[key].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_pacific:server:setTrollyBusy', { key = key, bool = true })
          grabTrolly(key)
        end
      }
    },
  })
end

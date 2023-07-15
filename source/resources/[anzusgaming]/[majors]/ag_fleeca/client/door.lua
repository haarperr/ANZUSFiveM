local zones = {}

local function placeThermite(key, entity)
  TriggerServerEvent('ag_fleeca:server:setDoorBusy', { key = key, bool = true })
  local config = Config.Banks[key].door

  exports['ps-ui']:Scrambler(function(success)
    if success then
      TriggerServerEvent('ag_fleeca:server:removeItem', 'thermite')
      TriggerEvent('ox_inventory:disarm')
      local entityHeading = GetEntityHeading(entity)
      SetEntityHeading(cache.ped, entityHeading)
      local ped = cache.ped
      local pedCoords = GetEntityCoords(ped)
      local door = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0, config.model, false, false, false)
      local pos = GetOffsetFromEntityInWorldCoords(door, 1.5, -0.05, -0.2)
      local ptfx = GetOffsetFromEntityInWorldCoords(door, 1.85, -1.0, -0.2)
      local rot = GetEntityRotation(door)

      FreezeEntityPosition(ped, true)
      local animDict = 'anim@heists@ornate_bank@thermal_charge'

      if not rot then
        rot = vec3(GetEntityRotation(cache.ped))
      end

      lib.requestAnimDict(animDict)
      lib.requestModel(`hei_p_m_bag_var22_arm_s`)
      lib.requestModel(`hei_prop_heist_thermite`)

      local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)
      SetEntityCollision(bag, false, true)
      local scene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 2, false, false, 1065353216, 0, 1.3)
      NetworkAddPedToSynchronisedScene(ped, scene, animDict, 'thermal_charge', 1.5, -4.0, 1, 16, 1148846080, 0)
      NetworkAddEntityToSynchronisedScene(bag, scene, animDict, 'bag_thermal_charge', 4.0, -8.0, 1)

      NetworkStartSynchronisedScene(scene)
      Wait(1500)
      local plantObject = CreateObject(`hei_prop_heist_thermite`, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)
      NetworkRequestControlOfEntity(plantObject)

      repeat
        Wait(0)
      until NetworkHasControlOfEntity(plantObject)

      SetEntityCollision(plantObject, false, true)
      AttachEntityToEntity(plantObject, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0.0, 0.0, 200.0, true, true, false, true, 1, true)

      Wait(4000)
      DeleteObject(bag)
      DetachEntity(plantObject, true, true)
      FreezeEntityPosition(plantObject, true)

      StartPlayerTeleport(cache.ped, pedCoords.x, pedCoords.y, pedCoords.z, 0.0, false, true, true)
      TriggerServerEvent('ag_fleeca:server:syncPtfx', ptfx)
      LocalPlayer.state:set("invBusy", false, true)
      TaskPlayAnim(ped, animDict, "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, false, false, false)
      TaskPlayAnim(ped, animDict, "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, false, false, false)
      FreezeEntityPosition(ped, false)
      Wait(2000)
      ClearPedTasks(ped)
      Wait(11000)
      DeleteObject(plantObject)
      ClearAreaOfObjects(pedCoords.x, pedCoords.y, pedCoords.z, 1, 0)
      TriggerServerEvent('ag_fleeca:server:openDoor', { key = key, bool = true })
      lib.notify({ type = 'success', description = locale('success_thermite') })
    else
      lib.notify({ type = 'error', description = locale('failed_thermite') })
      TriggerServerEvent('ag_fleeca:server:setDoorBusy', { key = key, bool = false })
    end
  end, "runes", 15, 0)
end

function CreateDoorZone(key)
  local config = Config.Banks[key].door

  zones[#zones + 1] = exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    distance = 1,
    options = {
      {
        name = ('ag_fleeca:%s_door'):format(key),
        label = locale('use_thermite'),
        icon = 'fa-solid fa-fire',
        items = 'thermite',
        canInteract = function()
          if GlobalState.fleecaData.cooldown and GlobalState.fleecaData.allowedBank ~= key then return false end
          return not Config.Banks[key].door.busy
        end,
        onSelect = function(data)
          if not IsEnoughPoliceAvailable() then return end
          placeThermite(key, data.entity)
        end,
        distance = 1
      }
    },
  })
end

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_fleeca:client:setDoorBusy', function(data)
  Config.Banks[data.key].door.busy = data.bool
end)

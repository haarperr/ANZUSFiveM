local function placeThermite(index, entity)
  local config = Config.Artgallery.door[index]

  exports['ps-ui']:Scrambler(function(success)
    if success then
      TriggerServerEvent('ag_artgallery:server:removeItem', 'thermite')
      TriggerEvent('ox_inventory:disarm')
      local entityHeading = GetEntityHeading(entity)
      SetEntityHeading(cache.ped, entityHeading)
      local ped = cache.ped
      local pedCoords = GetEntityCoords(ped)
      local door = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0, config.model, false, false, false)

      FreezeEntityPosition(ped, true)
      local animDict = 'anim@heists@ornate_bank@thermal_charge'

      local rot = vec3(GetEntityRotation(cache.ped))

      lib.requestAnimDict(animDict)
      lib.requestModel(`hei_p_m_bag_var22_arm_s`)
      lib.requestModel(`hei_prop_heist_thermite`)

      local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)
      SetEntityCollision(bag, false, true)
      local scene = NetworkCreateSynchronisedScene(config.scene.animation.x, config.scene.animation.y, config.scene.animation.z, rot.x, rot.y, rot.z, 2, false, false, 1065353216, 0,
        1.3)
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
      TriggerServerEvent('ag_fleeca:server:syncPtfx', config.scene.ptfx)
      LocalPlayer.state:set("invBusy", false, true)
      TaskPlayAnim(ped, animDict, "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, false, false, false)
      TaskPlayAnim(ped, animDict, "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, false, false, false)
      FreezeEntityPosition(ped, false)
      Wait(2000)
      ClearPedTasks(ped)
      Wait(11000)
      DeleteObject(plantObject)
      ClearAreaOfObjects(pedCoords.x, pedCoords.y, pedCoords.z, 1, 0)
      TriggerServerEvent('ag_artgallery:server:openDoor', { key = 'door', index = index, bool = true })

      lib.notify({ type = 'success', description = locale('success_thermite') })
    else
      lib.notify({ type = 'error', description = locale('failed_thermite') })
      TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'door', index = index, bool = false })
    end
  end, "runes", 15, 0)
end

function SetupDoorZone(index)
  local config = Config.Artgallery.door[index]

  exports.ox_target:addBoxZone({
    coords = config.zone.coords,
    size = config.zone.size,
    rotation = config.zone.rotation,
    options = {
      {
        label = locale('use_thermite'),
        icon = 'fa-solid fa-fire',
        items = 'thermite',
        canInteract = function()
          return not Config.Artgallery.door[index].busy
        end,
        onSelect = function(data)
          if not IsEnoughPoliceAvailable() then return end
          AlertPolice()
          TriggerServerEvent('ag_artgallery:server:setBusy', { key = 'door', index = index, bool = true })
          placeThermite(index, data.entity)
        end,
        distance = 2
      }
    },
  })
end

local function plantThermite(key)
  LocalPlayer.state:set("invBusy", true, true)
  local config = Config.Bank.gate[key]

  exports['ps-ui']:Scrambler(function(success)
    if success then
      TriggerServerEvent('ag_fleeca:server:removeItem', 'thermite')
      TriggerEvent('ox_inventory:disarm')
      local entityHeading = GetEntityHeading(entity)
      SetEntityHeading(cache.ped, entityHeading)
      local ped = cache.ped
      local pedCoords = GetEntityCoords(ped)
      local door = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 2.0, -1735710, false, false, false)

      local pos = config.scene.coords
      local ptfx = config.scene.ptfx
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
      TriggerServerEvent('ag_pacific:server:syncPtfx', ptfx)
      TaskPlayAnim(ped, animDict, "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, false, false, false)
      TaskPlayAnim(ped, animDict, "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, false, false, false)
      FreezeEntityPosition(ped, false)
      Wait(2000)
      ClearPedTasks(ped)
      Wait(11000)
      DeleteObject(plantObject)
      ClearAreaOfObjects(pedCoords.x, pedCoords.y, pedCoords.z, 1, 0)

      lib.notify({ type = 'warning', description = locale('success_plant'), duration = 2500 })
      LocalPlayer.state:set("invBusy", false, true)
      Wait(5000)
      AddExplosion(pedCoords.x, pedCoords.y, pedCoords.z, 2, 0.25, true, false, 1)
    else
      LocalPlayer.state:set("invBusy", false, true)
      lib.notify({ type = 'error', description = locale('failed_thermite') })
      TriggerServerEvent('ag_pacific:server:setBusy', { type = 'gate', key = key, bool = false })
    end
  end, "runes", 15, 0)
end

function SetupGateZone(key)
  local config = Config.Bank.gate[key]

  exports.ox_target:addBoxZone({
    coords = config.zone.coords,
    size = config.zone.size,
    rotation = config.zone.rotation,
    options = {
      {
        label = locale('blow_door'),
        icon = 'fa-solid fa-explosion',
        item = 'thermite',
        canInteract = function()
          return not Config.Bank.gate[key].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          AlertPolice()
          TriggerServerEvent('ag_pacific:server:setBusy', { type = 'gate', key = key, bool = true })
          plantThermite(key)
        end,
      }
    }
  })
end

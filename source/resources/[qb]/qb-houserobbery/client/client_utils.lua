local Cfg = require 'shared.config_utils'

lib.callback.register("rob-utils:client:getNearbyVehicle", function(vehicleplate)
    local nearbyVehicles = lib.getNearbyVehicles(GetEntityCoords(cache.ped), 10.0, true)
    for _, v in pairs(nearbyVehicles) do
        local plate = GetVehicleNumberPlateText(v.vehicle)
        if plate == vehicleplate then
            return NetworkGetNetworkIdFromEntity(v.vehicle)
        end
    end
    return false
end)


lib.callback.register("rob-utils:client:attachItem", function(netid, item)
    local vehicle = NetworkGetEntityFromNetworkId(netid)
    local vehmodel = GetEntityModel(vehicle)
    local modelname = GetDisplayNameFromVehicleModel(vehmodel):lower()
    if vehicle and DoesEntityExist(vehicle) then
        local itemSetting = Cfg.item[item]
        if Cfg.veh_setting[modelname] and Cfg.veh_setting[modelname][item] then
            itemSetting = Cfg.veh_setting[modelname][item]
        end
        local model = lib.requestModel(itemSetting.propname)
        if model then
            local trunkBoneIndex = GetEntityBoneIndexByName(vehicle, itemSetting.bone)
            local trunkPos = GetWorldPositionOfEntityBone(vehicle, trunkBoneIndex)
            local pos = vec3(trunkPos.x + itemSetting.position.x, trunkPos.y + itemSetting.position.y,
                trunkPos.z + itemSetting.position.z)
            local obj = CreateObject(model, pos.x, pos.y, pos.z, true, false, false)
            FreezeEntityPosition(obj, true)
            local rotation = itemSetting.rotation and vec3(itemSetting.rotation.x, itemSetting.rotation.y,
                itemSetting.rotation.z) or vec3(0.0, 0.0, 0.0)
            AttachEntityToEntity(obj, vehicle, trunkBoneIndex, itemSetting.position.x, itemSetting.position.y,
                itemSetting.position.z, rotation.x, rotation.y, rotation.z, false, false, false, false, 2, true)
            SetEntityCoordsNoOffset(obj, pos.x, pos.y, pos.z, true, true, true)
            SetEntityAsMissionEntity(obj, true, true)
            SetModelAsNoLongerNeeded(model)
            return NetworkGetNetworkIdFromEntity(obj)
        end
    end
    return false
end)

if Config.Debug then
    RegisterCommand('spawnobject', function(source, args, rawCommand)
        if not Config.Debug then return end
        local objectName = args[1] or "prop_bench_01a"
        local playerPed = PlayerPedId()
        local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0, 1.0, 0)

        local model = joaat(objectName)
        lib.requestModel(model, 5000)

        local object = CreateObject(model, offset.x, offset.y, offset.z, true, false, false)

        local objectPositionData = exports.object_gizmo:useGizmo(object)

        print(json.encode(objectPositionData, { indent = true }))
    end, false)

    local Inside = false
    local Shell = nil
    local CurrentCoords = nil
    local coords = vector3(1170.1, -1330.26, 34.78 + 30.0)

    RegisterCommand("test_shell", function(source, args, rawCommand)
        if not Config.Debug then return end
        CurrentCoords = GetEntityCoords(cache.ped)
        local mod = args[1] or "shell_v16mid"
        local model = lib.requestModel(mod)
        FreezeEntityPosition(cache.ped, true)
        local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, false)
        FreezeEntityPosition(obj, true)
        SetEntityCoords(cache.ped, coords.x, coords.y, coords.z + 1.5, true, true, true, false)
        FreezeEntityPosition(cache.ped, false)
        Shell = obj
    end, false)

    RegisterCommand("remove_shell", function()
        if not Config.Debug then return end
        if Shell then
            SetEntityCoords(cache.ped, CurrentCoords.x, CurrentCoords.y, CurrentCoords.z, true, true, true, false)
            DeleteEntity(Shell)
            Shell = nil
            CurrentCoords = nil
        end
    end, false)

    RegisterCommand("getoffset", function(source, args, rawCommand)
        if not Config.Debug then return end
        local x = args[1]:gsub(",", "")
        local y = args[2]:gsub(",", "")
        local z = args[3]:gsub(",", "")
        local w
        if args[4] then
            w = args[4]:gsub(",", "")
        end
        if not DoesEntityExist(Shell) then
            return print("Not exist")
        end
        local coord, shellcoords = vector3(x - 0.0, y - 0.0, z - 3.0), GetEntityCoords(Shell)
        local offset = coord - shellcoords
        -- coords = GetEntityCoords(Shell)
        -- local offset = vec3(x - coords.x, y - coords.y, z - coords.z - 1.0)
        if w then
            lib.setClipboard(string.format("%s, %s, %s, %s", offset.x, offset.y, offset.z, w))
        else
            lib.setClipboard(string.format("%s, %s, %s", offset.x, offset.y, offset.z))
        end
    end, false)

    RegisterCommand("unlockhouse", function()
        if not Config.Debug then
            return
        end
        local a = true
        if a then
            lib.callback.await("qb-houserobbery:server:setHouseState", false, TempHouseID)
        end
    end, false)
end

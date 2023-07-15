local QBCore = exports['qb-core']:GetCoreObject()

-- Variables

local Player = {}
local PlayerData = {}
local Objects = {}
local Spikes = {}
local AllObjects = {}
local Bombs = {}

local objectId, speedzones, currentbomb, ghostobj, ghostrot, pedcoords= nil

local inarminganim = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()

    TriggerServerEvent('r14-obj:server:loadObjects')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

------ draw text functions ---------

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function DrawText2D(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function LoadAnimDict(animdict)
    while not HasAnimDictLoaded(animdict) do
        Wait(0)
        RequestAnimDict(animdict)
    end
    return(animdict)
end

----------- place cast functions -----------------


function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function PlaceCast()
    local distance = 10.0
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}

	local a, hit, hitcoords, _, entity = GetShapeTestResult(StartExpensiveSynchronousShapeTestLosProbe(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, ped, 0))
	return hit , hitcoords, entity
end

function GhostObject(type, coords, entity)
    if not ghostobj then
        pedcoords = GetEntityCoords(ped)
        ghostrot = vector3(0.0, 0.0, GetGameplayCamRot())
        ghostoff = 0.0

        if Config.Objects[type].rotation then
            ghostrot = vector3(Config.Objects[type].rotation.x, Config.Objects[type].rotation.y, ghostrot.z)
        end

        if Config.Objects[type].ghostoff then
            ghostoff = Config.Objects[type].ghostoff
        end

        ghostobj = CreateObject(Config.Objects[type].model, coords.x, coords.y, coords.z + ghostoff, false, true, false)

        SetEntityCollision(ghostobj, false, false)
        SetEntityAlpha(ghostobj, 100, true)
        SetEntityRotation(ghostobj, ghostrot, 1, true)
        FreezeEntityPosition(ghostobj, Config.Objects[type].freeze)
        if Config.Objects[type].color then
            SetObjectTextureVariation(ghostobj, math.random(0, 15))
        end

    else
        SetEntityCoords(ghostobj, coords.x, coords.y, coords.z + ghostoff, false, false, false, false)

        StopEntityFire(ghostobj)

        if IsDisabledControlPressed(0, 16, true) or IsDisabledControlPressed(1, 16, true) or IsDisabledControlPressed(2, 16, true) then
            ghostrot = vector3(ghostrot.x, ghostrot.y, ghostrot.z + 10)
            SetEntityRotation(ghostobj, ghostrot, 1, true)
        end

        if IsDisabledControlPressed(0, 17, true) or IsDisabledControlPressed(1, 17, true) or IsDisabledControlPressed(2, 17, true) then
            ghostrot = vector3(ghostrot.x, ghostrot.y, ghostrot.z - 10)
            SetEntityRotation(ghostobj, ghostrot, 1, true)
        end

        if (IsEntityAVehicle(entity) or IsEntityAPed(entity)) or #(coords - pedcoords) > Config.MaxDist then
            SetEntityDrawOutline(ghostobj, true)
            SetEntityDrawOutlineColor(255, 0, 0, 200)
            cannotplace = true
        else
            SetEntityDrawOutline(ghostobj, false)
            cannotplace = false
        end
    end
end

--------- function that allows inventory objects to drop contents -------------

local function dropItems(objectId)
    QBCore.Functions.TriggerCallback('qb-inventory:server:GetStashItems', function(StashItems)
        if #StashItems ~= 0 then
            coords = GetEntityCoords(PlayerPedId())
            TriggerServerEvent('inventory:server:CreateDrop', StashItems, coords)
        end
    end, Objects[objectId].object .. objectId)
    TriggerServerEvent('qb-inventory:server:SaveStashItems', Objects[objectId].object .. objectId, nil)
end

-------- bomb related functions -----------

local function OnHackDone(success)
    if success then
        TriggerEvent('mhacking:hide')
        TriggerServerEvent('r14-obj:server:diffuseBomb', currentbomb)
    else
		TriggerEvent('mhacking:hide')
        TriggerServerEvent('r14-obj:server:modifyTimer', currentbomb, 0.3)
        QBCore.Functions.Notify("The panel flashes red and timer drops by a third!", 'error')
	end
end

local function IsBombArmed(entity)
    local networkid = NetworkGetNetworkIdFromEntity(entity)
    if Bombs[networkid] and Bombs[networkid].status == 'armed' then
        return true
    else
        return false
    end
end

local function IsBombDiffusable(entity)
    local networkid = NetworkGetNetworkIdFromEntity(entity)
    if Bombs[networkid] and Bombs[networkid].status == 'diffusable' then
        return true
    else
        return false
    end
end

local function IsBombDiffused(entity)
    local networkid = NetworkGetNetworkIdFromEntity(entity)
    if Bombs[networkid] and Bombs[networkid].status == 'diffused' then
        return true
    else
        return false
    end
end

local function IsWireIntact(entity, color)
    local networkid = NetworkGetNetworkIdFromEntity(entity)
    if Bombs[networkid] and Bombs[networkid].intact[color] ~= false then
        return true
    else
        return false
    end
end

local function checkAnim()
    CreateThread(function()
        while inarminganim do
            Wait(100)
            if not IsNuiFocused() then
                Wait(500)
                if not IsNuiFocused() then
                    TriggerEvent('animations:client:EmoteCommandStart', {'c'})
                    inarminganim = false
                end
            end
        end
    end)
end

---------- spike strip functions -----------------

local function PlaySpikeThrow()
    CreateThread(function()
        local ped = PlayerPedId()
        local scene = NetworkCreateSynchronisedScene(GetEntityCoords(ped), GetEntityRotation(ped, 2), 2, false, false, 1065353216, 0, 1.0)
        LoadAnimDict("amb@medic@standing@kneel@enter")
        NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, "amb@medic@standing@kneel@enter", "enter", 8.0, -8.0, 3341, 16, 1148846080, 0)

        NetworkStartSynchronisedScene(scene)

        while not IsSynchronizedSceneRunning(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) do
            Wait(0)
        end

        SetSynchronizedSceneRate(NetworkConvertSynchronisedSceneToSynchronizedScene(scene), 3.0)

        while GetSynchronizedScenePhase(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) < 0.14 do
            Wait(0)
        end

        NetworkStopSynchronisedScene(scene)
    end)
end

local function PlaySpikeAnim(obj)
    PlayEntityAnim(obj, "P_Stinger_S_Deploy", LoadAnimDict("p_ld_stinger_s"), 1000.0, false, true, 0, 0.0, 0)
    while not IsEntityPlayingAnim(obj, "p_ld_stinger_s", "P_Stinger_S_Deploy", 3) do
        Wait(0)
    end
    SetEntityVisible(obj, true)
    while IsEntityPlayingAnim(obj, "p_ld_stinger_s", "P_Stinger_S_Deploy", 3) and GetEntityAnimCurrentTime(obj, "p_ld_stinger_s", "P_Stinger_S_Deploy") <= 0.99 do
        Wait(0)
    end
    PlayEntityAnim(obj, "p_stinger_s_idle_deployed", LoadAnimDict("p_ld_stinger_s"), 1000.0, false, true, 0, 0.99, 0)
end

----------- command events --------------

RegisterNetEvent('r14-obj:client:adminclear', function()
    lib.registerContext({
        id = 'admin_menu',
        title = 'Admin Menu',
        options = {
            {
                title = 'View User Placed Objects',
                    event = 'r14-obj:client:clearcommand',
                    args = {
                        admin = true,
                    }
            },
            {
                title = 'View User Placed Objects',
                    event = 'r14-obj:client:clearcommand',
                    args = {
                        admin = true,
                    }
            },
            {
                title = 'View User Placed Spikes',
                    event = 'r14-obj:client:clearcommand',
                    args = {
                        spike = true,
                        admin = true,
                    }
            },
            {
                title = 'Clear All Objects [CAUTION]',
                    event = 'r14-obj:client:adminconfirm',
                    args = {
                        choice = 'objects',
                    }
            },
            {
                title = 'Clear All Spikes [CAUTION]',
                    event = 'r14-obj:client:adminconfirm',
                    args = {
                        choice = 'spike strips',
                        event = 'r14-objects:server:adminclearspikes',
                    }
            },
            {
                title = "Close (ESC)",
                    event = 'lib.hideContext(onExit)',
            },
        }
    })
    lib.showContext('admin_menu')
end)




RegisterNetEvent('r14-obj:client:adminconfirm', function(data)
    lib.registerContext({
        id = 'adm_confirm',
        title = ("Please confirm you wish to clear all %s on map."):format(data.choice),
        options = {
            {
                title = ('Clear all %s on the map.'):format(data.choice),
                    isServer = true,
                    event = 'r14-obj:server:adminclear',
                    args = {
                        choice = data.choice,
                    }
            },
            {
                title = "Close (ESC)",
                    event = 'lib.hideContext(onExit)',
            },
        }
    })
    lib.showContext('adm_confirm')
end)

RegisterNetEvent('r14-obj:client:clearcommand', function(data)

    local menuhead = "Spawned Objects"
    local PlayerData = QBCore.Functions.GetPlayerData()

    if data.spikes then menuheader = "Spawned Spikes" end

    local objectMenu = {
        {
            title = menuhead,
            --isMenuHeader = true,
        }
    }

    if data.spike then
        for k, v in pairs(Spikes) do
            if v.cid == PlayerData.citizenid or data.admin then
                local dist = #(GetEntityCoords(ped) - v.coords)
                dist = string.format("%.2f", dist)
                objectMenu[#objectMenu+1] = {
                    title = ('Spike Strip (%s meters away)'):format(dist),
                        event = 'r14-obj:client:commandremove',
                        args = {
                            spike = true,
                            objectId = k,
                            netid = v.netid,
                            admin = data.admin,
                            spike = true,
                        }
                }
            end
        end
    else
        for k, v in pairs(Objects) do
            if v.cid == PlayerData.citizenid or data.admin then
                local label = Config.Objects[v.object].label
                local dist = #(GetEntityCoords(ped) - v.coords)
                dist = string.format("%.2f", dist)

                objectMenu[#objectMenu+1] = {
                    title = ('%s (%s meters away)'):format(label, dist),
                        event = 'r14-obj:client:commandremove',
                        args = {
                            objectId = k,
                            netid = v.netid,
                            admin = data.admin,
                        }
                }
            end
        end
    end

    objectMenu[#objectMenu+1] = {
        title = "Close (ESC)",
        params = {
            event = "lib.hideContext(onExit)"
        }

    }
    lib.registerContext({
        id = 'object_Menu',
        title ='Menu',
        options = objectMenu
    })
    lib.showContext('object_Menu')
    --exports['qb-menu']:openMenu(objectMenu)
end)

RegisterNetEvent('r14-obj:client:commandremove', function(data)
    if not data.spike then
        TriggerServerEvent('r14-obj:server:deleteObject', data.netid, data.objectId)
        Wait(200)
        TriggerEvent('r14-obj:client:clearcommand', data)
    else
        TriggerServerEvent('r14-obj:server:deleteSpike', data.netid, data.objectId)
        Wait(200)
        TriggerEvent('r14-obj:client:clearcommand', data)
    end

    if not data.admin then TriggerServerEvent('r14-obj:server:logRemoval', data.objectId) end
end)

---------------- spawn object command -----------------------

RegisterCommand("object", function(source, args)
    local type = args[1]

    if not Config.Objects[type] then QBCore.Functions.Notify("Object does not exist.") return end

    TriggerEvent('r14-obj:client:spawnobj', type, command)

end, 'admin')


----------------- primary object spawning events ----------------------

RegisterNetEvent('r14-obj:client:spawnobj', function(type, command)
    local placelaser = true
    local player = PlayerId()

    if GetEntitySpeed(ped) > 2.0 then QBCore.Functions.Notify("Slow down before doing that, bruh!", "error") return end

    if IsPedInAnyVehicle(ped) or IsPedSwimming(ped) then QBCore.Functions.Notify("You are in a vehicle.", "error") return end

    if type == "spikestrip" then
        TriggerEvent('r14-obj:client:castplaceobj', type)
        return
    end

    SetPlayerControl(player, true, true)

    CreateThread(function()
        while placelaser do
            Wait(0)

            DisableAllControlActions()
            EnableControlAction(1, 1, true)
            EnableControlAction(1, 2, true)
            DisableControlAction(0, 200, true)
            DisableControlAction(1, 200, true)
            DisableControlAction(2, 200, true)

            local hit, coords, entity = PlaceCast()

            GhostObject(type, coords, entity)

            DrawText2D(0.83, 1.44, 1.0, 1.0, 0.6, "~r~LEFT CLICK~w~ TO PLACE, ~r~SCROLL~w~ TO ROTATE, ~r~RIGHT CLICK~w~ TO CANCEL", 255, 255, 255, 255)

            if IsDisabledControlJustReleased(0, 200) or IsDisabledControlJustReleased(1, 25) then
                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                DeleteEntity(ghostobj)
                ghostobj = nil
                ghostrot = nil
                return
            end

            if IsDisabledControlJustReleased(0, 38) or IsDisabledControlJustReleased(0, 24) then
                if hit and not cannotplace then
                    local norm = (norm(coords - pedcoords) / 2) + pedcoords
                    placelaser = false
                    DeleteEntity(ghostobj)

                    TaskTurnPedToFaceCoord(ped, coords.x, coords.y, coords.z, 1000)
                    Wait(700)

                    if Config.Objects[type].zoffset then
                        coords = vector3(coords.x, coords.y, coords.z - Config.Objects[type].zoffset)
                    end

                    TriggerEvent('r14-obj:client:castplaceobj', type, coords, ghostrot, command)

                    ghostobj = nil
                    ghostrot = nil
                elseif cannotplace then
                    QBCore.Functions.Notify("Cannot place object here.", "error")
                else
                    QBCore.Functions.Notify("Unable to place object, no coords found.", "error")
                end
            end
        end
    end)
end)


RegisterNetEvent('r14-obj:client:castplaceobj', function(type, coords, rotation, command)
    local animdict = 'anim@narcotics@trash'
    local anim = 'drop_front'
    local flags = 16
    local time = 1200

    if type == 'spikestrip' then
        animdict, anim, flags = nil time = 300
        PlaySpikeThrow()
    end

    QBCore.Functions.Progressbar("spawn_object", "Placing object...", time, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = animdict,
        anim = anim,
        flags = flags,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)

        data = {}

        data.type = type
        data.coords = coords
        data.rotation = rotation
        data.cid = QBCore.Functions.GetPlayerData().citizenid
        data.command = command

        if type == "spikestrip" then
            data.coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
            data.rotation = vector3(0.0, 0.0, GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player))))
            _, data.groundz = GetGroundZFor_3dCoord(data.coords.x, data.coords.y, data.coords.z, true)
        end

        if Config.Objects[type].speedzone then
            data.speedzone = AddRoadNodeSpeedZone(data.coords.x, data.coords.y, data.coords.z, 20.0, Config.Objects[data.type].speedlimit, false)
            if Config.Objects[data.type].speedlimit == 0 then
                if not Config.Objects[data.type].hidespeed then
                    QBCore.Functions.Notify("Local traffic has been ordered to stop.")
                end
            end
        end

        TriggerEvent('r14-obj:client:createObject', data, command)

    end, function() -- Cancel
        if type == 'spikestrip' then
            StopAnimTask(PlayerPedId(), "amb@medic@standing@kneel@enter", "enter", 1.0)
        else
            StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        end
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('r14-obj:client:createObject', function(data, command)
    RequestModel(Config.Objects[data.type].model)

    while not HasModelLoaded(Config.Objects[data.type].model) do
        Wait(10)
        RequestModel(Config.Objects[data.type].model)
    end

    local obj = CreateObject(Config.Objects[data.type].model, data.coords, true, true, false)

    data.netid = NetworkGetNetworkIdFromEntity(obj)

    ActivatePhysics(obj)
    FreezeEntityPosition(obj, Config.Objects[data.type].freeze)
    SetNetworkIdExistsOnAllMachines(netid, true)
    SetNetworkIdCanMigrate(data.netid, false)
    SetEntityRotation(obj, data.rotation, 1, true)
    SetEntityAsMissionEntity(data.entity, true, true)

    if not command then
        TriggerServerEvent("r14-objects:server:removeItem", data, 1)
    end

    if data.type == 'spikestrip' then
       PlaceObjectOnGroundProperly(obj)
       SetEntityVisible(obj, false)
       PlaySpikeAnim(obj)
    end

    TriggerServerEvent('r14-obj:server:getObjectId', data)
end)

RegisterNetEvent('r14-obj:client:syncObject', function(data)
    Wait(500)

    if not AllObjects[data.objectId] then

        AllObjects[data.objectId] = {
            objectId = data.objectId,
            type = data.type,
            coords = data.coords,
            rotation = data.rotation,
            cid = data.cid,
            groundz = data.groundz,
            netid = data.netid,
            speedzone = data.speedzone,
        }
    end

    if data.type == 'spikestrip' then
        local _, _, heading = table.unpack(data.rotation)

        TriggerServerEvent('r14-obj:server:SyncSpikes', data)

        if not Spikes[data.objectId] then
            Spikes[data.objectId] = {
                netid = data.netid,
                object = 'spikestrip',
                cid = data.cid,
                coords = data.coords,
                spikezone = BoxZone:Create(data.coords, 3.7, 0.6, {
                    name=tostring(data.netid)..'spike',
                    debugPoly= Config.DebugSpikes,
                    minZ= data.groundz - 0.5,
                    maxZ= data.groundz + 0.5,
                    heading = heading,

                }),
                zone = BoxZone:Create(data.coords, 20.0, 20.0, {
                    name = tostring(data.netid),
                    debugPoly = Config.DebugSpikes,
                    heading = heading,
                    minZ= data.groundz - 10,
                    maxZ= data.groundz + 10,

                }),
            }
        end

        exports.ox_target:addEntity(data.netid, {
                {
                    type = "client",
                    event = 'r14-obj:client:deleteSpike',
                    icon = "fas fa-box-open",
                    label = "Pick Up Spike Strip",
                    job = {
	                    ["lspd"] = 0,
                        ["bcso"] = 0,
	                    ["mechanic"] = 0,
                        ["iaa"] = 0,
                    },
                    cid = data.cid,
                    speedzone = data.speedzone,
                    entity= entity,
                    netid = data.netid,
                    objectId = data.objectId,
                    distance = 3.0
                },
        })
    else

        TriggerServerEvent('r14-obj:server:SyncObjects', data)

        if not Objects[data.objectId] then
            Objects[data.objectId] = {
                netid = data.netid,
                object = data.type,
                cid = data.cid,
                coords = data.coords,
                speedzone = data.speedzone,
            }
        end

        if data.type == 'medbag' then
            exports.ox_target:addEntity(data.netid, {
                    {
                        type = "client",
                        event = 'r14-obj:client:deleteObject',
                        icon = "fas fa-medkit",
                        label = "Pick Up Medical Bag",
                        cid = data.cid,
                        job = {
	                        ["lspd"] = 0,
                            ["bcso"] = 0,
	                        ["ambulance"] = 0,
                            ["iaa"] = 0,
                        },
                        netid = data.netid,
                        entity= entity,
                        objectId = data.objectId,
                        distance = 1.5
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:medbag',
                        icon = "fas fa-band-aid",
                        label = "Get Bandage",
                        give = "bandage",
                        distance = 1.5
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:medbag',
                        icon = "fas fa-capsules",
                        label = "Get Painkiller",
                        give = "painkillers",
                        distance = 1.5
                    },
            })
        elseif data.type == 'cooler' then
            exports.ox_target:addEntity(data.netid, {
                    {
                        type = "client",
                        event = 'r14-obj:client:deleteObject',
                        icon = "fas fa-box-open",
                        label = "Pick Up Cooler",
                        citizenid = data.cid,
                        speedzone = data.speedzone,
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
                        distance = 1.5
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:openinventory',
                        icon = "fas fa-snowflake",
                        label = "Open Cooler",
                        object = data.type,
                        netid = data.netid,
                        objectId = data.objectId,
                        distance = 1.5
                    },
            })
        elseif data.type == 'miniradio' or data.type == 'cdplayer' or data.type == 'boombox' then
            exports.ox_target:addEntity(data.netid, {
                    {
                        type = "client",
                        event = 'r14-obj:client:deleteObject',
                        icon = "fas fa-box-open",
                        label = ("Pick Up %s"):format(Config.Objects[data.type].label),
                        citizenid = data.cid,
                        speedzone = data.speedzone,
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
                        distance = 1.5
                    },
                    {
                        type = "client",
                        event = 'qb-djbooth:client:playMusic',
                        icon = "fa-solid fa-music",
                        label = "Play Music",
                        object = data.type,
                        netid = data.netid,
                        objectId = data.objectId,
                        distance = 1.5
                    },
            })
        elseif data.type == 'bomb' then
            exports.ox_target:addEntity(data.netid, {
                    {
                        type = "client",
                        event = 'r14-obj:client:armBomb',
                        icon = "fa-solid fa-bomb",
                        label = "Arm Bomb",
                        citizenid = data.cid,
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
                        cid = data.cid,
			            canInteract = function(entity)
				            if not IsBombArmed(entity) and not IsBombDiffusable(entity) and not IsBombDiffused(entity) then
					            return true
				            end
                        end,
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:deleteObject',
                        icon = "fas fa-box-open",
                        label = "Pickup Bomb",
                        citizenid = data.cid,
                        netid = data.netid,
                        speedzone = data.speedzone,
                        entity = entity,
                        objectId = data.objectId,
			            canInteract = function(entity)
				            if not IsBombArmed(entity) and not IsBombDiffusable(entity) and not IsBombDiffused(entity) then
					            return true
				            end
                        end,
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:deleteObject',
                        icon = "fas fa-box-open",
                        label = "Dispose of Bomb",
                        broken = true,
                        netid = data.netid,
                        speedzone = data.speedzone,
                        entity = entity,
                        objectId = data.objectId,
			            canInteract = function(entity)
				            if IsBombDiffused(entity) then
					            return true
				            end
                        end,
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:diffuseBomb',
                        icon = "fa-solid fa-mobile-screen-button",
                        label = "Run Diffusal Program",
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
			            canInteract = function(entity)
				            if IsBombDiffusable(entity) then
					            return true
				            end
                        end,
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:enterCode',
                        icon = "fa-solid fa-hashtag",
                        label = "Enter Disarm Code",
                        netid = data.netid,
                        entity = entity,
                        code = '',
                        objectId = data.objectId,
			            canInteract = function(entity)
				            if IsBombArmed(entity) then
					            return true
				            end
                        end,
                    },
                    {
                        type = "server",
                        event = 'r14-obj:server:CheckTimer',
                        icon = "fa-solid fa-stopwatch",
                        label = "Check Timer",
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
			            canInteract = function(entity)
				            if IsBombArmed(entity) or IsBombDiffusable(entity) then
					            return true
				            end
                        end,
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:cutWire',
                        icon = "fa-solid fa-scissors",
                        label = "Cut Blue Wire",
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
                        color = 'blue',
			            canInteract = function(entity)
				            if IsBombArmed(entity) and not IsBombDiffusable(entity) and IsWireIntact(entity, 'blue') then
					            return true
				            end
                        end,
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:cutWire',
                        icon = "fa-solid fa-scissors",
                        label = "Cut Red Wire",
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
                        color = 'red',
			            canInteract = function(entity)
				            if IsBombArmed(entity) and not IsBombDiffusable(entity) and IsWireIntact(entity, 'red') then
					            return true
				            end
                        end,
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:cutWire',
                        icon = "fa-solid fa-scissors",
                        label = "Cut Green Wire",
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
                        color = 'green',
			            canInteract = function(entity)
				            if IsBombArmed(entity) and not IsBombDiffusable(entity) and IsWireIntact(entity, 'green') then
					            return true
				            end
                        end,
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:cutWire',
                        icon = "fa-solid fa-scissors",
                        label = "Cut Yellow Wire",
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
                        color = 'yellow',
			            canInteract = function(entity)
				            if IsBombArmed(entity) and not IsBombDiffusable(entity) and IsWireIntact(entity, 'yellow') then
					            return true
				            end
                        end,
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:cutWire',
                        icon = "fa-solid fa-scissors",
                        label = "Cut Purple Wire",
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
                        color = 'purple',
			            canInteract = function(entity)
				            if IsBombArmed(entity) and not IsBombDiffusable(entity) and IsWireIntact(entity, 'purple') then
					            return true
				            end
                        end,
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:cutWire',
                        icon = "fa-solid fa-scissors",
                        label = "Cut Pink Wire",
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
                        color = 'pink',
			            canInteract = function(entity)
				            if IsBombArmed(entity) and not IsBombDiffusable(entity) and IsWireIntact(entity, 'pink') then
					            return true
				            end
                        end,
                    },
            })
        elseif data.type == 'foldingchair' or data.type == 'foldingchair2' then
            exports.ox_target:addEntity(data.netid, {
                    {
                        event = "qb-Sit:Sit",
                        icon = "fas fa-chair",
                        label = "Sit Down",
				        entity = entity,
                        distance = 1.5
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:deleteObject',
                        icon = "fas fa-box-open",
                        label = "Pick Up Chair",
                        citizenid = data.cid,
                        netid = data.netid,
                        entity = entity,
                        objectId = data.objectId,
                        distance = 1.5
                    },
            })
        elseif data.type == 'bbq' then
            exports.ox_target:addEntity(data.netid, {
                    {
                        type = "client",
                        event = 'r14-obj:client:deleteObject',
                        icon = "fas fa-box-open",
                        label = ("Pick Up %s"):format(Config.Objects[data.type].label),
                        cid = data.cid,
                        netid = data.netid,
                        objectId = data.objectId,
                        speedzone = data.speedzone,
                        entity = entity,
                        distance = 2.0
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:grill',
                        icon = "fa-solid fa-fire",
                        label = "Grill Burger",
                        get = 'burger',
                        object = data.type,
                        netid = data.netid,
                        objectId = data.objectId,
                        distance = 2.0
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:grill',
                        icon = "fa-solid fa-fire",
                        label = "Grill Hotdog",
                        get = 'hotdog',
                        object = data.type,
                        netid = data.netid,
                        objectId = data.objectId,
                        distance = 2.0
                    },
                    {
                        type = "client",
                        event = 'r14-obj:client:openinventory',
                        icon = "fa-solid fa-burger",
                        label = "Grab Food",
                        object = data.type,
                        netid = data.netid,
                        objectId = data.objectId,
                        distance = 2.0
                    },
            })
        else
            exports.ox_target:addEntity(data.netid, {
                    {
                        type = "client",
                        event = 'r14-obj:client:deleteObject',
                        icon = "fas fa-box-open",
                        label = ("Pick Up %s"):format(Config.Objects[data.type].label),
                        cid = data.cid,
                        netid = data.netid,
                        objectId = data.objectId,
                        speedzone = data.speedzone,
                        entity = entity,
                        distance = 2.0
                    },
                })
        end
    end
end)

----------------- primary delete object events ----------------------

RegisterNetEvent('r14-obj:client:grill', function(data)
    if data.get == 'burger' then
        QBCore.Functions.TriggerCallback('r14-obj:grillburger', function(HasItems)
            if HasItems then
                local coords = GetEntityCoords(NetworkGetEntityFromNetworkId(data.netid))
                TaskTurnPedToFaceCoord(ped, coords.x, coords.y, coords.z, 1000)
                Wait(1000)
                TriggerEvent('animations:client:EmoteCommandStart', {'bbq'})
                QBCore.Functions.Progressbar("pickup_sla", "Grilling out.", 12000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerServerEvent('QBCore:Server:RemoveItem', "burger_raw", 1)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "americancheese", 1)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "burger_bun", 1)
                    TriggerServerEvent('QBCore:Server:AddItem', "burger", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger"], "add")
                    TriggerEvent('animations:client:EmoteCommandStart', {'c'})
                    SetCurrentPedWeapon(ped, `weapon_unarmed`, true)
                end, function()
                    TriggerEvent('animations:client:EmoteCommandStart', {'c'})
                    SetCurrentPedWeapon(ped, `weapon_unarmed`, true)
                end)
            else
                QBCore.Functions.Notify("Might want to find a store.", "error")
            end
        end)
    elseif data.get == 'hotdog' then
        QBCore.Functions.TriggerCallback('r14-obj:grillhotdog', function(HasItems)
            if HasItems then
                local coords = GetEntityCoords(NetworkGetEntityFromNetworkId(data.netid))
                TaskTurnPedToFaceCoord(ped, coords.x, coords.y, coords.z, 1000)
                Wait(1000)
                TriggerEvent('animations:client:EmoteCommandStart', {'bbq'})
                QBCore.Functions.Progressbar("pickup_sla", "Grilling out.", 12000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerServerEvent('QBCore:Server:RemoveItem', "coldweiner", 1)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "hotdogbun", 1)
                    TriggerServerEvent('QBCore:Server:AddItem', "hotdog", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["hotdog"], "add")
                    TriggerEvent('animations:client:EmoteCommandStart', {'c'})
                    SetCurrentPedWeapon(ped, `weapon_unarmed`, true)
                end, function()
                    TriggerEvent('animations:client:EmoteCommandStart', {'c'})
                    SetCurrentPedWeapon(ped, `weapon_unarmed`, true)
                end)
            else
                QBCore.Functions.Notify("Might want to find a store.", "error")
            end
        end)
    end
end)

RegisterNetEvent('r14-obj:client:deleteObject', function(data)
    if Config.Objects[Objects[data.objectId].object].policeItem and LocalPlayer.state.job.type ~= 'leo' then
        QBCore.Functions.Notify('You are not a police officer', 'error')
        return
    end
    QBCore.Functions.Progressbar("remove_object", "Picking up object..", 1500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
        anim = "plant_floor",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)

        if Objects[data.objectId] then
            if Config.Objects[Objects[data.objectId].object].inventory then
                dropItems(data.objectId) -- this function drops the items onto the ground if picked up
            end
            if not data.broken then
                TriggerServerEvent("r14-objects:server:addItem", Objects[data.objectId].object, 1, data)
                TriggerServerEvent('r14-obj:server:deleteObject', data.netid, data.objectId)
            else
                TriggerServerEvent("r14-objects:server:addItem", Config.Objects[Objects[data.objectId].object].broken, 1, data)
                TriggerServerEvent('r14-obj:server:deleteObject', data.netid, data.objectId)
            end
        else
            for k, v in pairs(Config.Objects) do
                if GetEntityModel(data.entity) == v.model then
                    TriggerServerEvent("r14-objects:server:addItem", k, 1, data)
                    SetEntityAsMissionEntity(data.entity, true, true)
                    exports.ox_target:removeEntity(data.netid)
                    DeleteEntity(data.entity)
                end
            end
        end
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
    end)
end)

RegisterNetEvent('r14-obj:client:removeObject', function(netid, objectId)
    if Objects[objectId] and Objects[objectId].speedzone then RemoveRoadNodeSpeedZone(Objects[objectId].speedzone) end -- delete speedzone

    exports.ox_target:removeEntity(netid)
    NetworkRequestControlOfEntity(NetworkGetEntityFromNetworkId(netid))
    DeleteObject(NetworkGetEntityFromNetworkId(netid))
    Objects[objectId] = nil
    AllObjects[objectId] = nil
end)


RegisterNetEvent('r14-obj:client:deleteSpike', function(data)
    QBCore.Functions.Progressbar("remove_object", "Picking up spikestrip..", 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
        anim = "plant_floor",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)

        if Spikes[data.objectId] then
            QBCore.Functions.Notify("Local traffic allowed to resume.")
            TriggerServerEvent("r14-objects:server:addItem", 'spikestrip', 1, data)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["spikestrip"], "add")
            TriggerServerEvent('r14-obj:server:deleteSpike', data.netid, data.objectId)
        else
            TriggerServerEvent("r14-objects:server:addItem", 'spikestrip', 1, data)
            SetEntityAsMissionEntity(data.entity, true, true)
            exports.ox_target:removeEntity(data.netid)
            DeleteEntity(data.entity)
        end
    end, function() -- Cancel
        StopAnimTask(ped, "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('r14-obj:client:removeSpike', function(netid, objectId)
    RemoveRoadNodeSpeedZone(Spikes[objectId].speedzone)
    NetworkRequestControlOfEntity(NetworkGetEntityFromNetworkId(netid))
    DeleteObject(NetworkGetEntityFromNetworkId(netid))
    exports.ox_target:removeEntity(netid)
    Spikes[objectId].zone:destroy()
    Spikes[objectId].spikezone:destroy()
    Spikes[objectId] = nil
    AllObjects[objectId] = nil
end)

----------------------- item specific events -----------------------

-------------- bomb events -------------------

RegisterNetEvent('r14-obj:client:armBomb', function(data)

    TriggerEvent('animations:client:EmoteCommandStart', {'medic2'})

    inarminganim = true
    checkAnim()

    lib.registerContext({
        id = 'wire_menu',
        title = 'Set Arming Wire',
        options = {
            {
                title = "Blue Wire",
                    event = 'r14-obj:client:setCode',
                    args = {
                        color = 'blue',
                        objectId = data.objectId,
                        code = '',
                    }
            },
            {
                title = "Red Wire",
                    event = 'r14-obj:client:setCode',
                    args = {
                        color = 'red',
                        objectId = data.objectId,
                        code = '',
                    }
            },
            {
                title = "Green Wire",
                    event = 'r14-obj:client:setCode',
                    args = {
                        color = 'green',
                        objectId = data.objectId,
                        code = '',
                    }
            },
            {
                title = "Yellow Wire",
                    event = 'r14-obj:client:setCode',
                    args = {
                        color = 'yellow',
                        objectId = data.objectId,
                        code = '',
                    }
            },
            {
                title = "Purple Wire",
                    event = 'r14-obj:client:setCode',
                    args = {
                        color = 'purple',
                        objectId = data.objectId,
                        code = '',
                    }
            },
            {
                title = "Pink Wire",
                    event = 'r14-obj:client:setCode',
                    args = {
                        color = 'pink',
                        objectId = data.objectId,
                        code = '',
                    }
            },
            {
                title = "Close (ESC)",
                    event = 'lib.hideContext(onExit)',
            },
        }
    })

    lib.showContext('wire_menu')
end)

RegisterNetEvent('r14-obj:client:setCode', function(data)
    local displaycode = data.code
    local codelength = #displaycode

    if codelength < 6 then
        local missing = 6 - codelength
        for i = 1, missing do
            displaycode = displaycode..'*'
        end

        local keypadMenu = {
            {
                title = "Set Six Digit Code ["..displaycode.."]",
                --isMenuHeader = true
            }
        }

        for i = 1, 9 do
            keypadMenu[#keypadMenu+1] = {
                title = i,
                    event = 'r14-obj:client:setCode',
                    args = {
                        color = data.color,
                        code = data.code..i,
                        objectId = data.objectId
                    }
            }
        end

        keypadMenu[#keypadMenu+1] = {
            title = "Close (ESC)",
                event = "lib.hideContext(onExit)"

        }

        lib.registerContext({
            id = 'keypad_Menu',
            title ='KeyPad Menu',
            options = keypadMenu
        })
        lib.showContext('keypad_Menu')
        --exports['qb-menu']:openMenu(keypadMenu)

    elseif codelength == 6 then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = false,
            args = {"Code Entered:", data.code}
        })
        TriggerEvent('r14-obj:client:setTime', data)
    end
end)

RegisterNetEvent('r14-obj:client:enterCode', function(data)
    local displaycode = data.code
    local codelength = #displaycode

    if codelength < 6 then
        local missing = 6 - codelength
        for i = 1, missing do
            displaycode = displaycode..'*'
        end

        local keypadMenu = {
            {
                title = "Enter Six Digit Code ["..displaycode.."]",
               -- isMenuHeader = true
            }
        }

        for i = 1, 9 do
            keypadMenu[#keypadMenu+1] = {
                title = i,
                    event = 'r14-obj:client:enterCode',
                    args = {
                        color = data.color,
                        code = data.code..i,
                        objectId = data.objectId,
                        netid = data.netid,
                    }
            }
        end

        keypadMenu[#keypadMenu+1] = {
            title = "Close (ESC)",
                event = "lib.hideContext(onExit)"

        }
                lib.registerContext({
            id = 'keypad_Menu',
            title ='KeyPad Menu',
            options = keypadMenu
        })
        lib.showContext('keypad_Menu')
        --exports['qb-menu']:openMenu(keypadMenu)

    elseif codelength == 6 then
        if data.code == Bombs[data.netid].code then
            TriggerServerEvent('r14-obj:server:disarmBomb', data)
        else
           TriggerServerEvent('r14-obj:server:modifyTimer', data.objectId, 0.3)
           QBCore.Functions.Notify("The panel flashes red and timer drops by a third!", 'error')
        end
    end
end)

RegisterNetEvent('r14-obj:client:setTime', function(data)

    local input = lib.inputDialog('Timer', {
        { type = "number", label = "Time (minutes)", default = 0 }
    })

    if not input then
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
        inarminganim = false
        return
    end
    local time = input[1]

    if not time then
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
        inarminganim = false
        return
    end

    if tonumber(time) <= 0 then
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
        inarminganim = false
        return
    end


    TriggerServerEvent('r14-obj:server:armBomb', data.objectId, (tonumber(time) * 60), data.color, data.code)
    TriggerEvent('animations:client:EmoteCommandStart', {'c'})
    inarminganim = false
end)

RegisterNetEvent('r14-obj:client:detonateBomb', function(data)
    TriggerEvent('r14-obj:client:syncBomb', data.objectId, 'detonate')
end)

RegisterNetEvent('r14-obj:client:diffuseBomb', function(data)
    currentbomb = data.objectId
    TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start", math.random(6, 7), math.random(12, 15), OnHackDone)
end)

RegisterNetEvent('r14-obj:client:cutWire', function(data)
    if Bombs[data.netid].intact[data.color] then
        QBCore.Functions.Progressbar("remove_object", "Cutting wire...", 1500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@medic@standing@tendtodead@base",
            anim = "base",
            flags = 1,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "amb@medic@standing@tendtodead@base", "base", 1.0)
            if data.color == Bombs[data.netid].wire then
                TriggerServerEvent('r14-obj:server:CorrectWire', data.objectId)
            else
                TriggerServerEvent('r14-obj:server:modifyTimer', data.objectId, 0.5, data.color)
                QBCore.Functions.Notify("The panel flashes red and timer drops by half!", 'error')
            end
        end, function() -- Cancel
            StopAnimTask(ped, "amb@medic@standing@tendtodead@base", "base", 1.0)
            QBCore.Functions.Notify("Canceled..", "error")
        end)
    else
        QBCore.Functions.Notify("This wire has already been cut!", "error")
    end
end)

RegisterNetEvent('r14-obj:client:syncBomb', function(objectId, event, wire, code)

    if not Objects[objectId] then return end -- prevents multiple secondary explosion commands being sent causing a nil error when it finds an empty slot in the objects table

    local networkid = Objects[objectId].netid
    if event == 'arm' then
        Bombs[networkid] = {
            status = 'armed',
            wire = wire,
            code = code,
            intact = {
                ["red"] = true,
                ["blue"] = true,
                ["green"] = true,
                ["yellow"] = true,
                ["purple"] = true,
                ["pink"] = true,
            },
        }
    elseif event == 'diffusable' then
        Bombs[networkid].status = 'diffusable'
    elseif event == 'cutwire' then
        Bombs[networkid].intact[wire] = false
    elseif event == 'disarm' then
        Bombs[networkid].status = nil
    elseif event == 'diffuse' then
        Bombs[networkid].status = 'diffused'
    elseif event == 'detonate' then
        AddExplosion(Objects[objectId].coords.x, Objects[objectId].coords.y, Objects[objectId].coords.z, 49, 60.0, true, false, true) -- flag 49, incendiary explosion, you can change this if you want a less firery bomb
        TriggerServerEvent('r14-obj:server:deleteObject', Objects[objectId].netid, objectId)
    end
end)

----------------- inventory items event --------------------

RegisterNetEvent('r14-obj:client:openinventory', function(data) -- event to open cooler inventory, this inventory is unique to the objectid, not the cooler itself
    TriggerServerEvent("inventory:server:OpenInventory", "stash", data.object .. data.objectId, {
        maxweight = 100000,
        slots = 20,
    })
    TriggerEvent("inventory:client:SetCurrentStash", data.object .. data.objectId)
end)

------------------- med bag item event -------------------------

RegisterNetEvent('r14-obj:client:medbag', function(data) -- function for medbag to give items, recieves item to give from the target data
    QBCore.Functions.Progressbar("remove_object", "Getting "..data.give.."...", 1500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
        anim = "plant_floor",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
        TriggerServerEvent("QBCore:Server:AddItem", data.give, 1)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[data.give], "add")
    end, function() -- Cancel
        StopAnimTask(ped, "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

------------- Threads -------------------------------

-- this thread reduces the amount of times we fetch ped, it fetches playerpedid once per second to catch refreshed skins, etc

CreateThread(function()
	while true do
		ped = PlayerPedId()
        Wait(1000)
	end
end)



-- this thread tracks the player if they enter a spikestrips polyzone

CreateThread(function()
    local vehicle = nil
    local dz = nil

    while true do
        if LocalPlayer.state.isLoggedIn then

            if IsPedInAnyVehicle(ped) then
                if not vehicle then
                    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local minDimension, _ = GetModelDimensions(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), true))) -- this native calculates the dimensions of the vehicle so we can find the bottom of the tires
                    dz = tonumber(minDimension.z)
                end

                pos = GetEntityCoords(vehicle)

                for k, v in pairs(Spikes) do
                    if v.zone and v.zone:isPointInside(pos) then
                        local tires = { -- this table contains all the tire id's known
                            {bone = "wheel_lf", index = 0},
                            {bone = "wheel_rf", index = 1},
                            {bone = "wheel_lm", index = 2},
                            {bone = "wheel_rm", index = 3},
                            {bone = "wheel_lm1", index = 2},
                            {bone = "wheel_rm1", index = 3},
                            {bone = "wheel_lm2", index = 99},
                            {bone = "wheel_rm2", index = 101},
                            {bone = "wheel_lr", index = 4},
                            {bone = "wheel_rr", index = 5},
                        }

                        for a = 1, #tires do

                            if GetEntityBoneIndexByName(vehicle, tires[a].bone) ~= -1 then

                                local speed = GetEntitySpeed(vehicle) * 2.236936
                                local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
                                local tireoffx, tireoffy = tirePos.x - pos.x, tirePos.y - pos.y
                                local tireoff = GetOffsetFromEntityInWorldCoords(vehicle, tireoff, tireoffy, dz + .2)
                                tireoff = vector3(tirePos.x, tirePos.y, tireoff.z)

                                if Config.DebugSpikes then DrawMarker(28, tirePos.x, tirePos.y, tireoff.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.30, 0.30, 0.30, 197, 197, 197, 200, false, false, 2, nil, nil, false) end

                                if tirePos ~= vector3(0.00, 0.00, 0.00) then

                                    if v.spikezone:isPointInside(tireoff) and speed > 1 then
                                        if not IsVehicleTyreBurst(vehicle, tires[a].index, true) then
                                            SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else
                vehicle = nil
            end
        end
        Wait(0)
    end
end)


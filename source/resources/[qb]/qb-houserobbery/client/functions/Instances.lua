local LootObject = require 'client.functions.LootHandle'.LootObject
local Utils = require 'client.functions.Utils'
local IsWearingShoes, Notify, StartDebugging = Utils.IsWearingShoes, Utils.Notify, Utils.StartDebugging
IsInside = false
ShellData = {}

function RefreshIPL(iplname)
    if iplname == "GTAOHouseHi1Object" then
        GTAOHouseHi1 = exports['bob74_ipl']:GetGTAOHouseHi1Object()
        RefreshInterior(GTAOHouseHi1.interiorId)
    elseif iplname == "GTAOHouseLow1" then
        GTAOHouseLow1 = exports['bob74_ipl']:GetGTAOHouseLow1Object()
        RefreshInterior(GTAOHouseLow1.interiorId)
    end
end

function IsPlayerMoved()
    local ped = cache.ped
    local UsingWeapon = cache.weapon
    local isshooting = IsPedShooting(ped)
    local prevPos = GetEntityCoords(ped)
    local prevRot = GetEntityRotation(ped, 2)
    Wait(100) -- Wait a short period of time to allow for movement
    local currPos = GetEntityCoords(ped)
    local currRot = GetEntityRotation(ped, 2)
    local distanceMoved = Vdist2(prevPos.x, prevPos.y, prevPos.z, currPos.x, currPos.y, currPos.z)
    local angleRotated = math.abs(prevRot.z - currRot.z)
    local isstealth = GetPedStealthMovement(ped) == 1
    if distanceMoved > 0 or angleRotated > 0 or NetworkIsPlayerTalking(cache.ped) then
        local initchance = 4
        if isstealth then
            initchance -= 1
        end
        if not IsWearingShoes() then
            initchance -= 3
        end
        if not IsWearingShoes() and isstealth then
            initchance -= 1
        end
        if IsPedRunning(ped) then
            initchance += 5
        end
        return initchance
    elseif isshooting then
        return 100
    else
        return -2
    end
end



function StartNoiseChecking(houseid)
    if not HouseData[houseid].spawnguard then return end
    if HouseData[houseid].guardAwake then return end
    local chance = 0
    SendNUIMessage({
        action = 'open-progress',
        data = {
            value = true
        }
    })
    CreateThread(function ()
        while IsInside and not HouseData[houseid].guardAwake do
            local noise = IsPlayerMoved()
            chance = chance + noise
            if chance < 0 then
                chance = 0
            end
            if chance >= 99 then
                chance = 100
            end
            if chance >= 100 then
                SendNUIMessage({
                    action = 'open-progress',
                    data = {
                        value = false
                    }
                })
                TriggerServerEvent('qb-houserobbery:server:wokeGuard', houseid)
                Notify('Alert', "The guard woke up!", 'error')
                break;
            else
                SendNUIMessage({
                    action = 'progress',
                    data = {
                        val = chance
                    }
                })
            end
            Wait(1)
        end
    end)
end


RegisterNetEvent("qb-houserobbery:client:setrelationship", function (groups, houseid)
    if not groups or next(groups) == nil then return end
    local housedata = HouseData[houseid]
    if not housedata then return end

end)

---@param house any
function EnterHouse(house)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(50) end
    UpdateConfig()
    local houseData = lib.callback.await("qb-houserobbery:server:getHouseConfig", false,house)
    local ConfigNumber = houseData and houseData.number
    if not house or not ConfigNumber then
        DoScreenFadeIn(50)
        return Notify("Not Found","There is some error", "error")
    end
    
    exports["Renewed-Weaponscarry"]:toggleProps()
    TriggerServerEvent("qb-houserobbery:server:setRoutingBucket", house)
    local housetype = Config.HouseLocation[ConfigNumber].type
    if housetype == "shell" then
        if ShellData and ShellData.entity then
            if not ShellData.entity then return end
            DeleteObject(ShellData.entity)
            if not ShellData.furnitures then return end
            for _, v in pairs(ShellData.furnitures) do
                DeleteObject(v.entity)
            end
        end
        local cfg = Config.HouseLocation[ConfigNumber].config
        lib.requestModel(cfg.shell)
        local coords = Config.HouseLocation[ConfigNumber].coords
        local obj = CreateObject(joaat(cfg.shell), coords.x, coords.y,
                                 coords.z + 25.0, false, true, false)
        DebugConsole("Creating shell")
        ShellData.entity = obj
        ShellData.furnitures = {}
        FreezeEntityPosition(obj, true)
        for _, v in pairs(cfg.furnitures) do
            lib.requestModel(v.hashname)
            local offset = v.position
            local furniture = CreateObject(joaat(v.hashname),
                                           coords.x + offset.x,
                                           coords.y + offset.y,
                                           coords.z + 30.0 + offset.z, false,
                                           true, false)
            SetEntityRotation(furniture, v.rotation.x, v.rotation.y,
                              v.rotation.z, 0, false)
            if v.forceOnGround then
                PlaceObjectOnGroundProperly(furniture)
            end
            FreezeEntityPosition(furniture, true)
            ShellData.furnitures[#ShellData.furnitures + 1] = {
                entity = furniture
            }
            DebugConsole(string.format("Creating furniture: %s", furniture))
        end
        local exitCoords = vec3(coords.x + cfg.exit.x, coords.y + cfg.exit.y,
                                coords.z + 30.0 + cfg.exit.z - 0.99)
        SetEntityCoords(PlayerPedId(), exitCoords.x, exitCoords.y, exitCoords.z,
                        true, false, false, false)
        SetEntityHeading(PlayerPedId(), cfg.exit.w)
        SetupHouseTarget(house)
        local humans = Config.HouseLocation[ConfigNumber].config.guards.human
        local dog = Config.HouseLocation[ConfigNumber].config.guards.dog
        local shellcoords = GetEntityCoords(ShellData.entity)
        if houseData.spawnguard and next(houseData.guards) == nil then
            if humans and next(humans) then
                for k in pairs(humans) do
                    local coordsConfig = humans[k].coords
                    local spawnCoords = vector4(coordsConfig.x + shellcoords.x , coordsConfig.y + shellcoords.y  , shellcoords.z + coordsConfig.z - 1.0, coordsConfig.w)
                    local res = lib.callback.await("qb-houserobbery:server:registerguard", false, house, spawnCoords, "human", k)
                end
            end
        else
        end
        if houseData.spawndog and not houseData.dogs then
            DebugConsole("Creating dog")
            local spawnCoords = vector4(dog.coords.x + shellcoords.x , dog.coords.y  + shellcoords.y , shellcoords.z - dog.coords.z - 1.0, dog.coords.w)
            local res = lib.callback.await("qb-houserobbery:server:registerguard", false, house, spawnCoords, "dog")
            if res then
                TriggerServerEvent("qb-houserobbery:server:setDogTime", house)
                repeat
                    houseData = lib.callback.await("qb-houserobbery:server:getHouseConfig", false,house)
                    Wait(100)
                    DebugConsole("Waiting for dog")
                until houseData.dogs.time
                SendNUIMessage({
                    action = 'timer',
                    data = {
                        timer = houseData.dogs.time,
                        init = GlobalState.HouseRobberyCurrentTimeStamp
                    }
                })
            end
        elseif houseData.dogs?.netid then
            local dogmodel = NetworkGetEntityFromNetworkId(houseData.dogs.netid)
            if dogmodel and DoesEntityExist(dogmodel) and not IsPedDeadOrDying(dogmodel, true) then
                SendNUIMessage({
                    action = 'timer',
                    data = {
                        timer = houseData.dogs.time,
                        init = GlobalState.HouseRobberyCurrentTimeStamp
                    }
                })
            end
        end
        CurrentHouseID = house
        IsInside = true
        DoScreenFadeIn(1000)
        StartDebugging()
    elseif housetype == "ipl" then
        CurrentHouseID = house
        local interiorCoords = Config.HouseLocation[ConfigNumber].config.exit
        FreezeEntityPosition(PlayerPedId(), true)
        IsInside = true
        SetEntityCoords(PlayerPedId(), interiorCoords.x, interiorCoords.y,
                        interiorCoords.z, true, false, false, false)
        SetEntityHeading(PlayerPedId(), interiorCoords.w)

        local humans = Config.HouseLocation[ConfigNumber].config.guards.human
        local dog = Config.HouseLocation[ConfigNumber].config.guards.dog
    
        if houseData.spawnguard and next(houseData.guards) == nil then
            DebugConsole("Creating Human")
            if humans and next(humans) then
                for k in pairs(humans) do
                    local spawnCoords = humans[k].coords
                    local res = lib.callback.await("qb-houserobbery:server:registerguard", false, house, spawnCoords, "human", k)
                end
            end
        else
        end
        if houseData.spawndog and not houseData.dogs then
            DebugConsole("Creating dog")
            local spawnCoords = dog.coords
            local res = lib.callback.await("qb-houserobbery:server:registerguard", false, house, spawnCoords, "dog")
            if res then
                TriggerServerEvent("qb-houserobbery:server:setDogTime", house)
                repeat
                    houseData = HouseData[house]
                    Wait(100)
                    DebugConsole("Waiting for dog")
                until houseData.dogs.time
                SendNUIMessage({
                    action = 'timer',
                    data = {
                        timer = houseData.dogs.time,
                        init = GlobalState.HouseRobberyCurrentTimeStamp
                    }
                })
            end
        elseif houseData.dogs?.netid then
            local dogmodel = NetworkGetEntityFromNetworkId(houseData.dogs.netid)
            if dogmodel and DoesEntityExist(dogmodel) and not IsPedDeadOrDying(dogmodel, true) then
                SendNUIMessage({
                    action = 'timer',
                    data = {
                        timer = houseData.dogs.time,
                        init = GlobalState.HouseRobberyCurrentTimeStamp
                    }
                })
            end
        end
        StartNoiseChecking(house)
        RefreshIPL(Config.HouseLocation[ConfigNumber].config.ipl)
        SetupHouseTarget(house)
        FreezeEntityPosition(PlayerPedId(), false)
        DoScreenFadeIn(500)
    end
    local wait = (houseData.dogs or houseData?.guards ~= nil) and 1000 or 10
    Wait(wait)
    CheckGuardsAnim(house)
    IsTarget(house)
    exports["Renewed-Weaponscarry"]:toggleProps()
    exports["Renewed-Weaponscarry"]:refreshProps()
end

local SendAlert = require "shared.hack".alert


function LeaveHouse(house)
    if not IsInside then return end
    local exit
    for i = 1, #Config.HouseLocation do
        if Config.HouseLocation[i].id == house then
            exit = Config.HouseLocation[i].coords
        end
    end
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
    exports["Renewed-Weaponscarry"]:toggleProps()
    TriggerServerEvent("qb-houserobbery:server:resetRoutingBucket", house)
    if not HouseData[house].alerted then
        SendAlert("", house, true)
    end
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), exit.x, exit.y, exit.z, true, false, true,
                    false)
    SetEntityHeading(PlayerPedId(), exit.w)
    FreezeEntityPosition(PlayerPedId(), false)
    if CreatedZones[1] then
        for i = 1, #CreatedZones do
            if type(CreatedZones[i]) == "table" then
                CreatedZones[i]:remove()
            elseif type(CreatedZones[i]) == "number" then
                exports.ox_target:removeZone(CreatedZones[i])
            end
        end
        table.wipe(CreatedZones)
    end
    if EntityZones[1] then
        for i = 1, #EntityZones do
            if EntityZones[i].zone then
                exports.ox_target:removeZone(EntityZones[i].data)
            else
                exports.ox_target:removeLocalEntity(EntityZones[i].entity,
                                                    EntityZones[i].name)
                if EntityZones[i].spawned then
                    DeleteObject(EntityZones[i].entity)
                    DebugConsole(string.format("Removing object: %s", EntityZones[i].entity))
                    if DoesEntityExist(EntityZones[i].entity) then
                        DeleteEntity(EntityZones[i].entity)
                        DebugConsole(string.format("Failed..., Removing entity: %s", EntityZones[i].entity))
                    end
                end
            end
        end
        table.wipe(EntityZones)
    end
    if ShellData and ShellData.entity then
        DeleteObject(ShellData.entity)
        if not ShellData.furnitures then return end
        for _, v in pairs(ShellData.furnitures) do
            DeleteObject(v.entity)
            DebugConsole(string.format("Remove object (furniture): %s", v.entity))
        end
        table.wipe(ShellData)
    end
    table.wipe(SingleLootZones)
    SendNUIMessage({
        action = 'open-progress',
        data = {
            value = false
        }
    })
    IsInside = false
    CurrentHouseID = nil
    SendNUIMessage({
      action = "stop-time"
    })
    exports["Renewed-Weaponscarry"]:toggleProps()
    SetTimeout(1000, function ()
        exports["Renewed-Weaponscarry"]:refreshProps()
    end)
    DoScreenFadeIn(500)
end

local IsDead = Utils.IsDead

function IsTarget(houseid)
    local target = lib.callback.await("qb-houserobbery:server:getTarget", false, houseid)
    local player = GetPlayerServerId(PlayerId())
    if target and target == player then
        local house = HouseData[houseid]
        if house and house.dogs?.netid then
            CreateThread(function ()
                local dog = NetworkGetEntityFromNetworkId(house.dogs.netid)
                ---@type number
                local confignumber = house.number
                local dogconfig = Config.HouseLocation[confignumber].config.guards.dog
                local animdict = lib.requestAnimDict(dogconfig.anim.animdict)
                if not animdict then return end
                local angleThreshold = 30.0
                local ispassed = false
                FreezeEntityPosition(dog, false)
                while IsInside and target == player and not house?.guardAwake and not house?.dogs?.treated do
                    house = HouseData[houseid]
                    if IsDead() then
                        break;
                    end
                    if house?.dogs.treated then
                        break;
                    end
                    if dog and DoesEntityExist(dog) and not IsPedDeadOrDying(dog, true) then
                        local isnearby = false
                        local DogCoords = GetEntityCoords(dog)
                        local PedCoords = GetEntityCoords(cache.ped)
                        local dist = #(DogCoords - PedCoords)
                        local iswalking = false
                        if dist <= 3.5 and not ispassed then
                            ispassed = true
                        end
                        local entityForwardVector = GetEntityForwardVector(dog)
                        local entityToPedVector = PedCoords - DogCoords
                        entityForwardVector = entityForwardVector / #(entityForwardVector)
                        entityToPedVector = entityToPedVector / #(entityToPedVector)
                        local dotProduct = entityForwardVector.x * entityToPedVector.x + entityForwardVector.y * entityToPedVector.y + entityForwardVector.z * entityToPedVector.z
                        local angle = math.deg(math.acos(dotProduct))
                        local isHeadingTowardsPed = angle <= angleThreshold
                        local maxDistance = 2.0
                        if dist >= maxDistance and ispassed and not isnearby then
                            local direction = (PedCoords - DogCoords)
                            local normalizdDirection = direction / dist
                            local targetPos = PedCoords - normalizdDirection * maxDistance
                            if not iswalking then
                                iswalking = true
                                TaskGoStraightToCoord(dog, targetPos.x, targetPos.y, targetPos.z, 3.0, -1, 0.0, 0.0)
                            end
                        elseif dist <= maxDistance then
                            isnearby = true
                            iswalking = false
                            if not isHeadingTowardsPed then
                                TaskTurnPedToFaceEntity(dog, cache.ped, -1)
                            else
                                TaskPlayAnim(dog, animdict, dogconfig.anim.animation, 8.0, 8.0, -1, 1, 1.0, false, false, false)
                            end
                        end
                    else
                        break
                    end
                    Wait(1000)
                end
            end)
        end
    else
    end
end

RegisterNetEvent("qb-houserobbery:client:targetted", function ()
    if not IsInside or not CurrentHouseID then return end
    -- if police being targetted then it will return
    if Config.Police[PlayerData.job.name] and PlayerData.job?.onduty then return end
    local houseconfig = HouseData[CurrentHouseID]
    local targetchanged = false
    if not houseconfig then return end
    local aliveguards = {}
    local dog = NetworkGetEntityFromNetworkId(houseconfig?.dogs?.netid)
    local angleThreshold = 30.0
    local serverid = GetPlayerServerId(PlayerId())

    local dogconfig = Config.HouseLocation[houseconfig.number].config?.guards?.dog
    local pos = GetEntityCoords(cache.ped)
    CreateThread(function ()
        while IsInside and not IsDead()  do
            pos = GetEntityCoords(cache.ped)
            houseconfig = HouseData[CurrentHouseID]
            if houseconfig.target ~= serverid then
                targetchanged = true
                break
            end
            Wait(1000)
        end
    end)
    if dog and DoesEntityExist(dog) and not IsPedDeadOrDying(dog, true) then
        if not dogconfig then
            print("No dog config?")
        end
        local animdict = lib.requestAnimDict(dogconfig.anim.animdict)

        CreateThread(function ()
            while IsInside and not IsPedDeadOrDying(dog, true) and not targetchanged do
                if not houseconfig.dogs.treated and not houseconfig?.guardAwake then
                 if not dogconfig then
                    break
                 end
                 if IsDead() then
                    break
                 end
                 local isnearby = false
                 local DogCoords = GetEntityCoords(dog)
                 local PedCoords = GetEntityCoords(cache.ped)
                 local dist = #(DogCoords - PedCoords)
                 local iswalking = false
              
                 local entityForwardVector = GetEntityForwardVector(dog)
                 local entityToPedVector = PedCoords - DogCoords
                 entityForwardVector = entityForwardVector / #(entityForwardVector)
                 entityToPedVector = entityToPedVector / #(entityToPedVector)
                 local dotProduct = entityForwardVector.x * entityToPedVector.x + entityForwardVector.y * entityToPedVector.y + entityForwardVector.z * entityToPedVector.z
                 local angle = math.deg(math.acos(dotProduct))
                 local isHeadingTowardsPed = angle <= angleThreshold
                 local maxDistance = 2.0
                 if dist >= maxDistance and not isnearby then
                     local direction = (PedCoords - DogCoords)
                     local normalizdDirection = direction / dist
                     local targetPos = PedCoords - normalizdDirection * maxDistance
                     if not iswalking then
                         iswalking = true
                         TaskGoStraightToCoord(dog, targetPos.x, targetPos.y, targetPos.z, 3.0, -1, 0.0, 0.0)
                     end
                 elseif dist <= maxDistance then
                     isnearby = true
                     iswalking = false
                     if not isHeadingTowardsPed then
                         TaskTurnPedToFaceEntity(dog, cache.ped, -1)
                     else
                         TaskPlayAnim(dog, animdict, dogconfig.anim.animation, 8.0, 8.0, -1, 1, 1.0, false, false, false)
                     end
                 end
                else
                    break
                end
                Wait(1000)
            end
        end)
    end
    if houseconfig.guards and next(houseconfig.guards) ~= nil then
        for _, v in pairs(houseconfig.guards) do
            local guard = NetworkGetEntityFromNetworkId(v.netid)
            if guard and DoesEntityExist(guard) and not IsPedDeadOrDying(guard, true) then
                aliveguards[#aliveguards+1] = guard
            end
        end
    end
    if next(aliveguards) ~= nil then
   
        for _, v in ipairs(aliveguards) do
            CreateThread(function ()
                local iswalking = false
                while IsInside and not IsDead() and not IsPedDeadOrDying(v, true) and not targetchanged do
                    local isnearby = false
                    local pedPos = GetEntityCoords(v)
                    local dist = #(pos - pedPos)
                    if dist >= 3.0 and not isnearby and not iswalking then
                        iswalking = true
                        TaskGoStraightToCoord(v, pos.x,pos.y, pos.z, 3.0, -1, 0.0, 3.0)
                    else
                        iswalking = false
                        isnearby = true
                    end
                    Wait(1000)
                end
            end)
        end
    end
end)


RegisterNetEvent("qb-houserobbery:client:wokeGuard", function (houseid)
    local SendAlert = require "shared.hack".alert
    local houseData = HouseData[houseid]
    if not houseData then return end
    local dog = houseData.dogs
    local guards = houseData.guards
    local _, peds = AddRelationshipGroup("HouseRobbery" .. houseid)
    local _, players = AddRelationshipGroup("players" .. cache.ped)
    local target = lib.callback.await("qb-houserobbery:server:getTarget", false, houseid)
    local playerID = GetPlayerServerId(PlayerId())
    SetRelationshipBetweenGroups(0, peds, peds)
    SetRelationshipBetweenGroups(5, peds, players)
    SetRelationshipBetweenGroups(5, players, peds)
    SetPedRelationshipGroupHash(cache.ped, players)
    if dog then
        SendNUIMessage({
            action = "stop-time"
        })
        local ped = NetworkGetEntityFromNetworkId(dog.netid)
        if ped and DoesEntityExist(ped) then
            SetBlockingOfNonTemporaryEvents(ped, false)
            SetPedRelationshipGroupHash(ped, peds)
            FreezeEntityPosition(ped, false)
            TaskTurnPedToFaceEntity(ped, cache.ped, -1)
            SetBlockingOfNonTemporaryEvents(ped, false)
            SetPedRelationshipGroupHash(ped, peds)
            FreezeEntityPosition(ped, false)
            TaskCombatPed(ped, cache.ped, 0, 16)
            SetPedCombatRange(ped, 0)
            SetPedCombatAbility(ped, 100)
            SetPedCombatAttributes(ped, 46, true)
            SetPedCombatAttributes(ped, 5, true)
            SetPedFiringPattern(ped, 0xC6EE6B4C)
        end
    end
    if guards and next(guards) ~= nil then
        SendNUIMessage({
            action = "open-progress",
            data = {
                value = false
            }
        })
        for _, v in pairs(guards) do
            local ped = NetworkGetEntityFromNetworkId(v.netid)
            if ped and DoesEntityExist(ped) then
                ClearPedTasks(ped)
                TaskTurnPedToFaceEntity(ped, cache.ped, -1)
                SetBlockingOfNonTemporaryEvents(ped, false)
                SetPedRelationshipGroupHash(ped, peds)
                FreezeEntityPosition(ped, false)
                TaskCombatPed(ped, cache.ped, 0, 16)
                SetPedCombatRange(ped, 0)
                SetPedCombatAbility(ped, 100)
                SetPedCombatAttributes(ped, 46, true)
                SetPedCombatAttributes(ped, 5, true)
                SetPedFiringPattern(ped, 0xC6EE6B4C)
            end
        end
    end
    SendAlert("", houseid, true)
end)

function CheckGuardsAnim(houseid)
    local housedata = HouseData[houseid]
    local houseconfig = Config.HouseLocation[housedata.number]
    local isawake = false
    if not housedata then return end
    if housedata.guards and next(housedata?.guards) ~= nil then
        local guards = housedata.guards
        if not housedata.guardAwake then 
            StartNoiseChecking(houseid)
            for k, v in pairs(guards) do
                local ped = NetworkGetEntityFromNetworkId(v.netid)
                -- set ped blocking non temporary events
                SetBlockingOfNonTemporaryEvents(ped, true)
                local pedconfig = houseconfig.config.guards.human[k]
                if ped and DoesEntityExist(ped) then
                    lib.requestAnimDict(pedconfig.anim.animdict)
                    if not IsEntityPlayingAnim(ped, pedconfig.anim.animdict, pedconfig.anim.animation, 3) then
                        TaskPlayAnim(ped, pedconfig.anim.animdict, pedconfig.anim.animation, 8.0, 8.0, -1, 1, 0, false, false, false)
                    end
                end
            end
        else
            isawake = true
        end
    end
    if housedata.dogs and next(housedata?.dogs) ~= nil then
        if not housedata.guardAwake then
            local dogs = housedata.dogs
            local dogConfig = houseconfig.config.guards.dog 
            local entity = NetworkGetEntityFromNetworkId(dogs.netid)
            SetBlockingOfNonTemporaryEvents(entity, true)
            if entity and DoesEntityExist(entity) then
                if not dogs.treated then
                    lib.requestAnimDict(dogConfig.anim.animdict)
                    if not IsEntityPlayingAnim(entity, dogConfig.anim.animdict, dogConfig.anim.animation, 3) then
                        TaskPlayAnim(entity, dogConfig.anim.animdict, dogConfig.anim.animation, 8.0, 8.0, -1, 1, 0, false, false, false)
                    end
                else
                    local animdict = dogConfig.treatedanim.animdict
                    local animation = dogConfig.treatedanim.animation
                    lib.requestAnimDict(animdict)
                    if not IsEntityPlayingAnim(entity, animdict, animation, 3) then
                        TaskPlayAnim(
							entity,
							animdict,
							animation,
							8.0,
							8.0,
							-1,
							1,
							1.0,
							true,
							true,
							true
						)
                    end
                    
                end
            end
        else
            isawake = true
        end
    end
    if isawake then
        if not Config.Police[PlayerData.job.name] then
            local guards = housedata and housedata.guards
            local dogs = housedata and housedata.dogs
            local _, peds = AddRelationshipGroup("HouseRobbery" .. houseid)
            local _, players = AddRelationshipGroup("players" .. cache.ped)
            SetRelationshipBetweenGroups(0, peds, peds)
            SetRelationshipBetweenGroups(5, peds, players)
            SetRelationshipBetweenGroups(5, players, peds)
            SetPedRelationshipGroupHash(cache.ped, players)
            if guards and next(guards) ~= nil then
                for _, v in pairs(guards) do
                    local ped = NetworkGetEntityFromNetworkId(v.netid)
                    if ped and DoesEntityExist(ped) then
                        -- ClearPedTasks(ped)
                        -- TaskTurnPedToFaceEntity(ped, cache.ped, -1)
                        SetBlockingOfNonTemporaryEvents(ped, false)
                        SetPedRelationshipGroupHash(ped, peds)
                        FreezeEntityPosition(ped, false)
                        TaskCombatPed(ped, cache.ped, 0, 16)
                        SetPedCombatRange(ped, 0)
                        SetPedCombatAbility(ped, 100)
                        SetPedCombatAttributes(ped, 46, true)
                        SetPedCombatAttributes(ped, 5, true)
                        SetPedFiringPattern(ped, 0xC6EE6B4C)
                    end
                end
            end
            if dogs and next(dogs) ~= nil then
                local ped = NetworkGetEntityFromNetworkId(dogs.netid)
                if ped and DoesEntityExist(ped) then
                    -- ClearPedTasks(ped)
                    -- TaskTurnPedToFaceEntity(ped, cache.ped, -1)
                    SetBlockingOfNonTemporaryEvents(ped, false)
                    SetPedRelationshipGroupHash(ped, peds)
                    FreezeEntityPosition(ped, false)
                    -- TaskCombatPed(ped, cache.ped, 0, 16)
                    SetPedCombatRange(ped, 0)
                    SetPedCombatAbility(ped, 100)
                    SetPedCombatAttributes(ped, 46, true)
                    SetPedCombatAttributes(ped, 5, true)
                end
            end
        end
    end
end

function RefreshInside()
    if not IsInside or not CurrentHouseID then return end
    local housedata = lib.callback.await("qb-houserobbery:server:getHouseConfig", false, CurrentHouseID)
    local cfg = housedata.number and Config.HouseLocation[housedata.number]
    local loots = housedata.loots
    if cfg.type == "ipl" then
        if #EntityZones == 0 then return print('entity zone = 0') end
        for i = 1, #EntityZones do
            if not EntityZones[i].spawned then
                exports.ox_target:removeLocalEntity(EntityZones[i].entity,
                                                    EntityZones[i].name)
            end
        end
        for i = 1, #cfg.config.loot do
            local curdata = cfg.config.loot[i].data
            if cfg.config.loot[i].isobject then
                local obj = GetClosestObjectOfType(curdata.coords.x,
                                                   curdata.coords.y,
                                                   curdata.coords.z, 1.0,
                                                   joaat(curdata.name), false,
                                                   false, false)

                if loots[i].islooted and DoesEntityExist(obj) then
                    Wait(50)
                    SetEntityAsMissionEntity(obj, true, true)
                    DeleteEntity(obj)
                    if DoesEntityExist(obj) then
                        print("Unable to delete entity: ", obj)
                    end
                elseif not loots[i].islooted and obj and not loots[i]?.items then
                    local options = {
                        {
                            name = CurrentHouseID .. obj,
                            icon = curdata.icon or "fas fa-hand",
                            label = curdata.label or "Unknown",
                            onSelect = function()
                                if exports["Renewed-Weaponscarry"]:isCarryingObject() then
                                    return Notify(nil, "You can't do that...","error")
                                end
                                LootObject(obj, CurrentHouseID, i)
                            end,
                            distance = 1.5
                        }
                    }
                    EntityZones[#EntityZones + 1] = {
                        name = CurrentHouseID .. obj,
                        entity = obj
                    }
                    exports.ox_target:addLocalEntity(obj, options)
                end
            else
                if loots[i].islooted then
                    for k, v in pairs(SingleLootZones) do
                        if v.key == i then
                            if v.id then
                                exports.ox_target:removeZone(v.id)
                            end
                            SingleLootZones[k] = nil
                            break;
                        end
                    end
                end
            end
        end
    elseif cfg.type == "shell" then
        if not EntityZones or next(EntityZones) == nil then return end
        for k, v in pairs(EntityZones) do
            local lt = v.id and loots[v.id]
            if lt and lt.islooted then
                DeleteEntity(v.entity)
                table.wipe(EntityZones[k])
            end
        end
    end
end

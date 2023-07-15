GlobalState.HouseRobberyTimeState = "unset"
GlobalState.HouseRobberyCurrentTimeStamp = nil

HouseTable = {}
IsReady = false

local LootHandle = require 'server.functions.LootHandle'
local SetLootState, ResetAllStash, GenerateLoots = LootHandle.SetLootState, LootHandle.ResetAllStash,  LootHandle.GenerateLoots
local Utils = require 'server.functions.Utils'
local GenerateBucketNumber,FindConfig, SpawnChance, TimeCheck, RandomTimestamp, ResetHouseState = Utils.GenerateBucketNumber,Utils.FindConfig, Utils.SpawnChance, Utils.TimeCheck, Utils.RandomTimestamp, Utils.ResetHouseState



lib.callback.register("qb-houserobbery:server:setLootState", function(source, house, id, state)
   return SetLootState(source, house, id ,state)
end)

lib.callback.register("qb-houserobbery:server:getHousesConfig", function(source)
    return HouseTable
end)

lib.callback.register("qb-houserobbery:server:getConfig", function(source)
    return Config.HouseLocation
end)

lib.callback.register("qb-houserobbery:server:isconfigready", function(source)
    return IsReady
end)

lib.callback.register("qb-houserobbery:server:getHouseConfig", function(source, houseid)
    if not HouseTable or next(HouseTable) == nil then return end
    if not HouseTable[houseid] then return end
    return HouseTable[houseid]
end)

lib.callback.register("qb-houserobbery:server:setHouseState", function(source, houseid)
    local housedata = HouseTable
    local house = housedata[houseid]
    if housedata and house and house.locked then
        house.locked = false
        house.cooldown = true
        HouseTable = housedata
        TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
        ResetHouseState(houseid, false)
    end
    return true
end)

local function ResetCars()
    if not HouseTable then return end
    for _, house in pairs(HouseTable) do
        if house.cars and house.cars[1] then
            for _, netid in ipairs(house.cars) do
                local entity = NetworkGetEntityFromNetworkId(netid)
                if entity and DoesEntityExist(entity) then
                    DebugConsole(("Deleting entity: %s"):format(netid))
                    DeleteEntity(entity)
                    if DoesEntityExist(entity) then
                        DebugConsole(("Failed to delete entity: %s"):format(netid))
                    end
                end
            end
        end
    end
end

local function DeleteAllEntities()
    local data = HouseTable
    if not data then return end
    for k in pairs(data) do
        local house = data[k]
        if house.guards and next(house.guards) ~= nil then
            for _, v in pairs(house.guards) do
                
                local entity = NetworkGetEntityFromNetworkId(v.netid)
                if entity and DoesEntityExist(entity) then
                    print("Deleting entity: ", v.netid, " ", entity)
                    DeleteEntity(entity)
                end
            end
        end
        if house.dogs and next(house.dogs) ~= nil then
            local entity = NetworkGetEntityFromNetworkId(house.dogs.netid)
            if entity and DoesEntityExist(entity) then
                print("Deleting entity: ", house.dogs.netid, " ", entity)
                DeleteEntity(entity)
            end
        end
    end
end

local function Setup()
    ResetCars()
    ResetAllStash()
    DeleteAllEntities()
    HouseTable = {}
    local Data = {}
    local temptData = {}
    local DataLength = 0
    local function GenerateUniqueStash()
        return QBCore.Shared.RandomStr(2):upper() .. QBCore.Shared.RandomInt(4)
    end
    DebugConsole("Start Loop...")
    local test = false
    for housenumber, house in pairs(Config.HouseLocation) do
        local loots = {}
        local housetype = house.type
        house.id = GenerateUniqueStash()
        house.config = lib.table.deepclone(house.config)
        repeat
            local BucketNumber = GenerateBucketNumber()
            if not temptData[BucketNumber] then
                house.bucket = BucketNumber
                temptData[BucketNumber] = BucketNumber
                InitRouting(house.id, BucketNumber)
            else
                DebugConsole("Repeating HouseBucket " .. housenumber)
            end

        until house.bucket
        if house.config.loot then
            for sid, loot in ipairs(house.config.loot) do
                loots[sid] = GenerateLoots(loot, housetype)
            end
        end
        Data[house.id] = {
            coords = house.coords,
            type = house.type,
            number = housenumber,
            locked = true,
            guardAwake = false,
            dogAwake = false,
            dog = {
                treated = false
            },
            guards = {},
            loots = loots
        }
        DataLength += 1
    end
    HouseTable = Data
    IsReady = true
    if Config.Debug and DataLength <= 100 then
        QBCore.Debug(Data)
    end
    DebugConsole("Finish Loop, Data Generated: " .. DataLength)
    TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
    TriggerClientEvent('qb-houserobbery:client:configready', -1, true)
    return true
end


---@param type "night" | "day"
function TimeCycle(type)
    local data = HouseTable
    for k, v in pairs(data) do
        -- Make sure it doesn't change current robbery progress (unlocked house)
        if v.locked and not v.cooldown then
            local oldguardstate = v.spawnguard
            v.cars = {}
            v.spawnguard = SpawnChance(type)
            v.spawndog = SpawnChance(type)
            -- v.spawnguard = true
            -- v.spawndog = false
            if v.spawnguard and oldguardstate ~= v.spawnguard then
                local config = Config.HouseLocation[FindConfig(k)]
                if config.carspot and config.carspot.model and config.carspot.coords then
                    local carmodel = config.carspot.model[math.random(#config.carspot.model)]
                    local coords = config.carspot.coords
                    local CreateAutoMobile = joaat('CREATE_AUTOMOBILE')
                    local car = Citizen.InvokeNative(CreateAutoMobile, joaat(carmodel), coords, true, false)
                    local netID = NetworkGetNetworkIdFromEntity(car)
                    v.cars[#v.cars+1] = netID
                    local checks = 0
                    while not DoesEntityExist(car) do
                        if checks >= 20 then 
                            DebugConsole("Car not found")
                            break end
                        Wait(10)
                    end
                end
            elseif not v.spawnguard and oldguardstate ~= v.spawnguard then
                if v.cars and v.cars[1] then
                    for _, netid in ipairs(v.cars) do
                        local entity = NetworkGetEntityFromNetworkId(netid)
                        if entity and entity ~= 0 then
                            DeleteEntity(entity)
                        end
                    end
                    table.wipe(v.cars)
                end
            end
        end
    end
    HouseTable = data
    DebugConsole(string.format("Time: %s", type))
    TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
end

RegisterNetEvent("qb-houserobbery:server:setRoutingBucket", function(house)
    local src = source
    if not src or not house then return end
    SetRouting(src, house)
end)

local ChangeTarget = require "server.functions.EntityHandler".ChangeTarget

RegisterNetEvent('qb-houserobbery:server:resetRoutingBucket', function (house)
    local src = source
    if not src or not house then return end
    ResetRouting(src, house)
    if HouseTable[house]?.target == src then
        local newtarget = ChangeTarget(house)
        if newtarget then
            TriggerClientEvent("qb-houserobbery:client:targetted", newtarget)
        end
    end
end)

RegisterNetEvent('qb-houserobbery:server:treatDog', function (houseid)
    local src = source
    local item = ox_inventory:Search(src, "count", "treat")
    if item and item > 0 then
        ox_inventory:RemoveItem(src, "treat", 1)
    else
        return
    end
    if not src or src == 0 then return end
    local data = HouseTable
    local config = data[houseid]
    if not config then 
    DebugConsole("No config found")    
    return end
    config.dogs.treated = true
    HouseTable = data
    TriggerClientEvent('qb-houserobbery:client:setconfig', -1)
end)



---comment
---@param source number
---@param houseid string
---@param coords vector4
---@param spawntype "dog" | "human"
---@param key? number
lib.callback.register("qb-houserobbery:server:registerguard", function (source, houseid, coords, spawntype, key)
    if not houseid or not coords or not spawntype then return end
	local GData = HouseTable
	local house = GData[houseid]
	local config = Config.HouseLocation[1]
    local SpawnGuard = Utils.SpawnGuard
    local SpawnDog = Utils.SpawnDog
	if spawntype == "dog" then
		local model = config.config.guards.dog.model
		local animdict = config.config.guards.dog.anim.animdict
		local animname = config.config.guards.dog.anim.animation
        local netid = SpawnDog(model, coords, animdict, animname, houseid)
        SetEntityRouting(netid, houseid)
		house.dogs = {
            netid = netid,
            treated = false
        }
	elseif spawntype == "human" then
        local guardConfig = config.config.guards.human[key]
        if not guardConfig then return end
        local model = guardConfig.model
        local animdict = guardConfig.anim.animdict
        local animname = guardConfig.anim.animation
        if not house.guards then house.guards = {} end
        if key then
            local netid = SpawnGuard(model, coords, houseid,animdict, animname)
            SetEntityRouting(netid, houseid)
            house.guards[key] = {
                netid = netid,
            }
        end
	end
    HouseTable = GData    
    TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
    return true
end)

RegisterNetEvent("qb-houserobbery:server:registerAlert", function (houseid)
    if not houseid then return end
    local data = HouseTable
    local house = data[houseid]
    if not house or house.alerted then return end
    house.alerted = true
    HouseTable = data
    TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
end)

RegisterNetEvent('qb-houserobbery:server:wokeGuard', function (houseid)
    local data = HouseTable
    local house = data[houseid]

    if not house then return end
    if house?.guardAwake then return end
    house.guardAwake = true
    local players = GetPlayersInHouse(houseid)

    if players and next(players) ~= nil then
        for _, player in ipairs(players) do
            TriggerClientEvent("qb-houserobbery:client:wokeGuard", player, houseid)
        end
    end
    HouseTable = data
    DebugConsole("Woke guard")
    TriggerClientEvent('qb-houserobbery:client:setconfig', -1)
    if house.target then
        TriggerClientEvent("qb-houserobbery:client:targetted", house.target)
    end
end)


local ChangeTarget = require "server.functions.EntityHandler".ChangeTarget

RegisterNetEvent("qb-houserobbery:server:switchtarget", function (houseid)
    local src = source
    local HouseData = HouseTable[houseid]
    if not HouseData then return end
    local istarget = src and src == HouseData?.target
    if not istarget then return end
    local newtarget = ChangeTarget(houseid)
    if not newtarget then return
        print("No new target")
    end
    TriggerClientEvent("qb-houserobbery:client:targetted", newtarget)
end)

RegisterNetEvent("qb-houserobbery:server:resetHouse", function (id)
    local HouseData = HouseTable
    local house = HouseData[id]
    if house then
        house.locked = true
        HouseTable = HouseData
        TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
        -- atleast wait 1 hour before resetting
        Wait(1000 * 60 * 60 * 1)
        ResetHouseState(id, true)
    end
end)

AddEventHandler('onServerResourceStart', function(resource)
    if resource ~= cache.resource then return end
    Wait(100)
    Setup()
    TimeCheck()
end)

RegisterNetEvent("qb-houserobbery:server:setDogTime", function (houseid)
    local data = HouseTable
    local housedata = data[houseid]
    if not housedata then return end
    if housedata.dogs.time then return end
    local time, int = RandomTimestamp()
    housedata.dogs.time = time
    HouseTable = data
    Wait(100)
    TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
    CreateThread(function ()
        Wait(int * 1000)
        data = HouseTable
        housedata = data[houseid]
        local entity = NetworkGetEntityFromNetworkId(housedata.dogs.netid)
        if not entity then return end
        if not housedata then return end
        housedata.dogs.time = nil
        if housedata?.guardAwake then return end
        if housedata?.dogs.treated or Entity(entity).state.treated then return end
        TriggerEvent("qb-houserobbery:server:wokeGuard", houseid)
    end)

end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        CreateThread(function()
            Wait(40000)
            local data = HouseTable
            for _, v in pairs(data) do
                for _, loot in pairs(v.loots) do
                   if loot.generated then
                        exports.ox_inventory:Clearinventory(loot.id)
                   end
                end
            end
        end)
    end
end)

lib.callback.register('qb-houserobbery:server:removeItem', function(source, itemname, metadata)
    if exports.ox_inventory:Search(source, 'count', itemname, metadata) then
        exports.ox_inventory:RemoveItem(source, itemname, 1)
    end
end)

QBCore.Functions.CreateUseableItem("treat", function(source, info)
    TriggerClientEvent('qb-houserobbery:client:useTreat', source)
end)



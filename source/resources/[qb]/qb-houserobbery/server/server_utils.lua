local Vehicles = {}
local Cfg = require 'shared.config_utils'


local function GetItemKey()
    local item = Cfg.item
    local key = {}
    for k, v in pairs(item) do
        key[k] = true
    end
    return key
end

local function IsVehBan(netid)
    local vehicle = NetworkGetEntityFromNetworkId(netid)
    local model = GetEntityModel(vehicle)
    for _, v in pairs(Cfg.banned_vehicle) do
        if joaat(v) == model then
            return true
        end
    end
    return false
end

local function AddEntityToVehicle(source, plate, netid, item)
    if IsVehBan(netid) then return end
    if not Vehicles[plate] then
        Vehicles[plate] = {}
    end
    if Vehicles[plate][item] then
        local netids = lib.callback.await("rob-utils:client:attachItem", source, netid, item)
        if netids then
            Vehicles[plate][item].count = Vehicles[plate][item].count + 1
            Vehicles[plate][item].netids[#Vehicles[plate][item].netids + 1] = netids
        end
    else
        Vehicles[plate][item] = {
            count = 0,
            netids = {}
        }
        local netids = lib.callback.await("rob-utils:client:attachItem", source, netid, item)
        if netids then
            Vehicles[plate][item].count = Vehicles[plate][item].count + 1
            Vehicles[plate][item].netids[#Vehicles[plate][item].netids + 1] = netids
        end
    end
end

local function RemoveEntityFromVehicle(source, plate, item)
    if not Vehicles[plate] then return end
    if not Vehicles[plate][item] then return end
    if Vehicles[plate][item].count == 0 then return end
    local netid = Vehicles[plate][item].netids[#Vehicles[plate][item].netids]
    local obj = NetworkGetEntityFromNetworkId(netid)
    if obj and DoesEntityExist(obj) then
        DeleteEntity(obj)
        Vehicles[plate][item].count = Vehicles[plate][item].count - 1
        Vehicles[plate][item].netids[#Vehicles[plate][item].netids] = nil
    end
end

local hookid = exports.ox_inventory:registerHook("swapItems", function(payload)
    if payload.action == "move" or "swap" then
        local source = payload.source
        local totype = payload.toType
        if source then
            if totype == "player" then
                local plate = payload.fromInventory:gsub("trunk", "")
                RemoveEntityFromVehicle(source, plate, payload.fromSlot.name)
            elseif totype == "trunk" then
                local plate = payload.toInventory:gsub("trunk", "")
                local car = lib.callback.await("rob-utils:client:getNearbyVehicle", source, plate)
                if IsVehBan(car) then return false end
                AddEntityToVehicle(source, plate, car, payload.fromSlot.name)
            end
        end
    end
    return true
end, {
    print           = true,
    itemFilter      = GetItemKey(),
    inventoryFilter = {
        '^glove[%w]+',
        '^trunk[%w]+',
    }
})


AddEventHandler("onResourceStop", function(res)
    if res ~= GetCurrentResourceName() then return end
    exports.ox_inventory:removeHooks(hookid)
    if not next(Vehicles) then return end
    for plate, v in pairs(Vehicles) do
        for _, v2 in pairs(v) do
            for i = 1, v2.count do
                local netid = v2.netids[i]
                local props = NetworkGetEntityFromNetworkId(netid)
                if DoesEntityExist(props) then
                    DeleteEntity(props)
                end
            end
        end
    end
end)

AddEventHandler("entityRemoved", function(entity)
    local plate = GetVehicleNumberPlateText(entity)
    if not plate then return end
    if not Vehicles[plate] then return end
    for _, v in pairs(Vehicles[plate]) do
        for i = 1, v.count do
            local netid = v.netids[i]
            local props = NetworkGetEntityFromNetworkId(netid)
            if DoesEntityExist(props) then
                DeleteEntity(props)
            end
        end
    end
    Vehicles[plate] = nil
end)

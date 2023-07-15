local QBCore = exports['qb-core']:GetCoreObject()

local Objects = {}
local Spikes = {}
local Bombs = {}

local function CreateObjectId()
    local objectId = math.random(10000, 99999)
    while Objects[objectId] do
        objectId = math.random(10000, 99999)
    end
    return objectId
end

RegisterNetEvent('r14-obj:server:getObjectId', function(data)
    data.objectId = CreateObjectId()
    TriggerClientEvent("r14-obj:client:syncObject", -1, data)
end)

RegisterNetEvent('r14-obj:server:SyncObjects', function(data)
    Objects[data.objectId] = {
        type = data.type,
        netid = data.netid,
        coords = data.coords,
        rotation = data.rotation,
        cid = data.cid,
        groundz = data.groundz,
        speedzone = data.speedzone,
    }
end)

RegisterNetEvent('r14-obj:server:SyncSpikes', function(data)
    Spikes[data.objectId] = {
        type = data.type,
        netid = data.netid,
        coords = data.coords,
        rotation = data.rotation,
        cid = data.cid,
        groundz = data.groundz,
        speedzone = data.speedzone,
    }
end)

RegisterNetEvent('r14-obj:server:deleteObject', function(netid, objectId)
    Objects[objectId] = nil
    if Bombs[objectId] then
        Bombs[objectId] = nil
    end
    TriggerClientEvent('r14-obj:client:removeObject', -1, netid, objectId)
end)

RegisterNetEvent('r14-obj:server:deleteSpike', function(netid, objectId)
    Spikes[objectId] = {}
    TriggerClientEvent('r14-obj:client:removeSpike', -1, netid, objectId)
end)

RegisterNetEvent('r14-obj:server:loadObjects', function()
    if Spikes then
        for k, v in pairs(Spikes) do
            data = v
            data.objectId = k
            TriggerClientEvent("r14-obj:client:syncObject", -1, data)
        end
    end
    if Objects then
        for k, v in pairs(Objects) do
            data = v
            data.objectId = k
            TriggerClientEvent("r14-obj:client:syncObject", -1, data)
        end
    end
end)

local objectData = {}

RegisterNetEvent('r14-objects:server:removeItem', function (data, amount)
    if not data.netid then return end

    if objectData[data.netid] then return end

    if not Config.Objects[data.type] then return end

    exports.ox_inventory:RemoveItem(source, data.type, amount)
    objectData[data.netid] = true
end)

RegisterNetEvent('r14-objects:server:addItem', function (item, amount, data)
    if not data.netid then return end

    if not objectData[data.netid] then return end

    if item == 'spikestrip' and Spikes[data.objectId] then goto skip end

    if not Objects[data.objectId] then return end

    :: skip ::

    exports.ox_inventory:AddItem(source, item, amount)
    objectData[data.netid] = nil
end)

------------------------- bomb events -------------------------

RegisterNetEvent('r14-obj:server:armBomb', function(objectId, timer, color, code)
    local time = os.time() + timer

    Bombs[objectId] = {
        time = time,
        color = color,
        code = code,
        coords = Objects[objectId].coords,
    },

        TriggerClientEvent('r14-obj:client:syncBomb', -1, objectId, 'arm', color, code)

end)

RegisterNetEvent('r14-obj:server:modifyTimer', function(objectId, fraction, color)
    local timereduction = math.floor((Bombs[objectId].time - os.time()) * fraction)
    Bombs[objectId].time = Bombs[objectId].time - timereduction
    if color then
        TriggerClientEvent('r14-obj:client:syncBomb', -1, objectId, 'cutwire', color)
    end
end)

RegisterNetEvent('r14-obj:server:CheckTimer', function(data)
    local src = source
    local remaining = Bombs[data.objectId].time - os.time()
    local notifytext = ''

    if remaining > 59 then
        minutes = math.floor(remaining / 60)
        seconds = remaining % 60
        if seconds < 10 then
            notifytext = ('%s:0%s remaining'):format(minutes, seconds)
        else
            notifytext = ('%s:%s remaining'):format(minutes, seconds)
        end
    else
        notifytext = ('%s seconds remaining'):format(remaining)
    end

    TriggerClientEvent('QBCore:Notify', src, notifytext)
end)

RegisterNetEvent('r14-obj:server:disarmBomb', function(data)
    Bombs[data.objectId] = nil
    TriggerClientEvent('r14-obj:client:syncBomb', -1, data.objectId, 'disarm')
end)

RegisterNetEvent('r14-obj:server:diffuseBomb', function(objectId)
    Bombs[objectId] = nil
    TriggerClientEvent('r14-obj:client:syncBomb', -1, objectId, 'diffuse')
end)

RegisterNetEvent('r14-obj:server:CorrectWire', function(objectId)
    TriggerClientEvent('r14-obj:client:syncBomb', -1, objectId, 'diffusable')
end)

RegisterNetEvent('r14-obj:server:secondaryexplosions', function(objectId, detcoords)
    for k, v in pairs(Objects) do
        if v.type == 'bomb' and objectId ~= k and #(detcoords - v.coords) < 5 then
            Wait(200)
            TriggerClientEvent('r14-obj:client:syncBomb', -1, k, 'detonate')
            TriggerEvent('r14-obj:server:deleteObject', Objects[k].netid, k)
            TriggerEvent('r14-obj:server:secondaryexplosions', v.coords)
        end
    end
end)

---------------------------- commands -----------------------------
-- these commands allow you to clear objects

QBCore.Commands.Add('clearspikes', '[OOC] Open menu to clear scuffed spike strips (This is logged).', {}, true, function(source, args)
    local src = source
    local data = {}
    data.spikes = true

    TriggerClientEvent('r14-obj:client:clearcommand', src, data)
end)

QBCore.Commands.Add('clearobjects', '[OOC] Open menu to clear scuffed objects (This is logged).', {}, true, function(source, args)
    local src = source
    local data = {}

    TriggerClientEvent('r14-obj:client:clearcommand', src, data)
end)

QBCore.Commands.Add('adminobjectsmenu', '[OOC] Manage objects from admin menu.', {}, false, function(source, args)
    local src = source

    TriggerClientEvent('r14-obj:client:adminclear', src)
end, 'admin')

------------------------ command events ------------------------

RegisterNetEvent('r14-obj:server:logRemoval', function(objectId)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(src).PlayerData

    if Config.AdminAlert then
        local Players = QBCore.Functions.GetPlayers()
        local name = PlayerData.charinfo.firstname .. ' ' .. PlayerData.charinfo.lastname
        for k, v in pairs(Players) do
            if QBCore.Functions.HasPermission(v, 'admin') then
                if QBCore.Functions.IsOptin(v) then
                    TriggerClientEvent('chat:addMessage', v, {
                        color = { 255, 215, 0 },
                        multiline = true,
                        args = { 'Admin Log:', ('%s (%s) used /clearspikes'):format(name, src) }
                    })
                end
            end
        end
    end
end)

RegisterNetEvent('r14-obj:server:adminclear', function(data)
    print(data.choice)

    if data.choice == 'spike strips' then
        for k, v in pairs(Spikes) do
            TriggerClientEvent('r14-obj:client:removeSpike', -1, v.netid, k)
            Spikes[k] = nil
        end
    else
        for k, v in pairs(Objects) do
            print(v.type)

            if Config.Objects[v.type].inventory then
                TriggerEvent('qb-log:server:CreateLog', 'lostitems', 'Items lost in object clear.', 'red', 'Items located in stash ' .. v.type .. k, false)
            end

            TriggerClientEvent('r14-obj:client:removeObject', -1, v.netid, k)

            Objects[k] = nil
        end
    end
end)

-------------- create usable items --------------------------
-- this for loop goes through the Config.Objects list and creates usable items
-- unless you specify that it is not usable

for k, v in pairs(Config.Objects) do
    if not v.noitem then
        QBCore.Functions.CreateUseableItem(k, function(source, item)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            TriggerClientEvent('r14-obj:client:spawnobj', src, k)
        end)
    end
end

----------------- grill callbacks -------------------------

QBCore.Functions.CreateCallback('r14-obj:grillburger', function(source, cb)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)

    if ply.Functions.GetItemByName("burger_raw") ~= nil and ply.Functions.GetItemByName("burger_bun") ~= nil and ply.Functions.GetItemByName("americancheese") ~= nil then
        cb(true)
    end

    cb(false)
end)

QBCore.Functions.CreateCallback('r14-obj:grillhotdog', function(source, cb)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)

    if ply.Functions.GetItemByName("coldweiner") ~= nil and ply.Functions.GetItemByName("hotdogbun") ~= nil then
        cb(true)
    end

    cb(false)
end)

---------------- bomb thread ------------------------------
-- this thread manages active bombs, keeping track of their remainingtime, playing beeps for players
-- nearby, and detonating them when they reach the timer

CreateThread(function()
    while true do
        Wait(1000)
        if Bombs ~= {} then
            local time = os.time()

            for k, v in pairs(Bombs) do
                local remaining = v.time - time
                if remaining > 60 then
                    if remaining % 2 == 0 then
                        TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, Objects[k].coords, 20.0, 'beep', 0.2)
                    end
                else
                    TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, Objects[k].coords, 20.0, 'beep', 0.2)
                end

                if time >= v.time then
                    TriggerClientEvent('r14-obj:client:syncBomb', -1, k, 'detonate')
                    Bombs[k] = nil

                    TriggerEvent('r14-obj:server:secondaryexplosions', k, v.coords)
                end
            end
        end
    end
end)

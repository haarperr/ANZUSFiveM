local QBCore = exports['qb-core']:GetCoreObject()
-- Needs checks
-- Events

RegisterNetEvent('qb-recycle:server:getItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for _ = 1, math.random(1, Config.MaxItemsReceived), 1 do
        local randItem = Config.ItemTable[math.random(1, #Config.ItemTable)]
        local amount = math.random(Config.MinItemReceivedQty, Config.MaxItemReceivedQty)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add')
        Wait(25)
    end

    for i = 1, #Config.ChanceItem, 1 do
        local item = Config.ChanceItem[i]
        local chance = math.random(1, 100)
        if chance < 6 then
            Player.Functions.AddItem(item, 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
        end
    end

    local luck = math.random(1, 50)
    local odd = math.random(1, 50)
    if luck == odd then
        local random = 1
        Player.Functions.AddItem(Config.LuckyItem, random)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.LuckyItem], 'add')
    end
end)

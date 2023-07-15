ItemList = {}

CreateThread(function()
    local GetCurrentTime = require 'server.functions.Utils'.GetCurrentTime
    while true do
        GlobalState.HouseRobberyCurrentTimeStamp = GetCurrentTime()
        Wait(1000)
    end
end)

CreateThread(function()
    Wait(1500)
    local list = require('shared.hack').items
    for item, v in pairs(list) do
        DebugConsole("Registering Hack Item for " .. item)
        QBCore.Functions.CreateUseableItem(item, function(source, info)
            TriggerClientEvent("qb-houserobbery:client:useHackItem", source, info.name)
        end)
    end
end)

AddEventHandler("onServerResourceStart", function(resourcename)
    if resourcename ~= "ox_inventory" or resourcename ~= GetCurrentResourceName() then return end
    local GetItemData = require 'server.functions.LootHandle'.GetItemData
    GetItemData()
end)

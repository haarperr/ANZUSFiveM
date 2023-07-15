local QBCore = exports['qb-core']:GetCoreObject()
local ESX = nil

-- food prep function

-- give options for different recipes
RegisterNetEvent('solos-food:client:preparefood', function(data)
    local hasitems = true
    local itemname = nil
    for k, v in pairs(config.recipes) do
        if k == data.food then
            for i, a in pairs(v.ingredients) do
                itemname = v.label
                if QBCore then
                    local cnt = exports.ox_inventory:GetItemCount(tostring(a.ingredient))

                    if cnt < a.amount then
                        hasitems = false
                    end
                elseif ESX then
                    local Player = ESX.GetPlayerData()

                    if ESX.SearchInventory(a.ingredient, a.amount) < a.amount then
                        hasitems = false
                    end
                end
            end
        end
    end

    Wait(1)
    if hasitems then
        TriggerEvent('solos-food:client:progress', data.food, itemname, data.animdict, data.anim, data.flags, data.scenario, data.prop)
        TriggerEvent('solos-food:client:success')
    else
        TriggerEvent('solos-food:client:itemserror')
    end
end)

RegisterNetEvent('solos-food:client:progress', function(item, itemname, animdict, animation, animflags, scenario, prop)
    if scenario then
        TaskStartScenarioInPlace(PlayerPedId(), scenario, 0, true)
    end
    QBCore.Functions.Progressbar("spawn_object", ("Making " .. itemname .. "..."), config.preptime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = animdict,
        anim = animation,
        flags = animflags,
    }, {}, {}, function() -- Done
        ClearPedTasksImmediately(PlayerPedId())
        local playercoords = GetEntityCoords(PlayerPedId())
        local object = GetClosestObjectOfType(playercoords, 2.0, GetHashKey(prop), false, false, false)

        if DoesEntityExist(object) then
            SetEntityAsMissionEntity(object, false, false)
            DeleteObject(object)
        end
        --remove items
        for k, v in pairs(config.recipes) do
            if k == item then
                for i, ingredient in pairs(v.ingredients) do
                    TriggerServerEvent('solos-food:server:itemremove', ingredient.ingredient, ingredient.amount, true)
                end
            end
        end

        --give item
        TriggerServerEvent('solos-food:server:itemadd', item, 1)
    end, function() --cancel
        ClearPedTasksImmediately(PlayerPedId())
        local playercoords = GetEntityCoords(PlayerPedId())
        local object = GetClosestObjectOfType(playercoords, 2.0, GetHashKey(prop), false, false, false)
        if DoesEntityExist(object) then
            SetEntityAsMissionEntity(object, false, false)
            DeleteObject(object)
        end
    end)
end)

RegisterNetEvent('solos-food:client:Eat', function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', { "eat" })
    QBCore.Functions.Progressbar("eat_something", 'Eating ' .. itemName, 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', { "c" })
        TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + config.EatItems[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
    end)
end)

local job = nil

AddStateBagChangeHandler('job', ('player:%s'):format(cache.serverId), function(_, _, value)
    if not value then return end
    if job == value then return end
    job = value

    SetupDeliveryZones(job.name)
end)

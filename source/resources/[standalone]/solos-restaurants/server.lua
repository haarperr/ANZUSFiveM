local QBCore = exports['qb-core']:GetCoreObject()

local charges = {}

-- Need to look into later, this needs some security checks
RegisterNetEvent('solos-food:server:itemadd', function(item, amount)
    local src = source

    exports.ox_inventory:AddItem(src, item, amount)
end)

-- remove item
RegisterNetEvent('solos-food:server:itemremove', function(item, amount)
    local src = source
    exports.ox_inventory:RemoveItem(src, item, amount)
end)

-- Need to look into later, this needs some security checks
RegisterNetEvent('solos-cashier:server:addmoney', function(moneytype, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney(tostring(moneytype), amount)
end)

--Trays

CreateThread(function()
    for _, v in pairs(config.trays) do
        local stash = {
            id = v.id,
            label = v.name,
            slots = 10,
            weight = 100000,
        }

        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight)
    end

    for k, v in pairs(config.storages) do
        local stash = {
            id = v.id,
            label = k,
            slots = 100,
            weight = 4000000,
        }

        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight)
    end
end)

RegisterNetEvent('solos-cashier:server:chargecustomer', function(input, registerid, receipt)
    local id = source

    local charge = { input = input, register = registerid, id = id, receipt = receipt }
    table.insert(charges, charge)
end)

RegisterNetEvent('solos-food:server:pay', function(moneytype, name)
    local src = source
    for i, v in pairs(charges) do
        if v.register == name then
            TriggerClientEvent('solos-food:client:bill', src, moneytype, v.input, v.id)
            table.remove(charges, i)
        end
    end
end)

RegisterNetEvent('solos-cashier:server:sendreceipt', function(id)
    local Player = QBCore.Functions.GetPlayer(id)
    Player.Functions.AddItem('receipt', 1)
end)

RegisterNetEvent('solos-food:server:billcustomer', function(id, amount)
    local playerid = GetPlayerIdentifier(id, 0)
    local Player = QBCore.Functions.GetPlayer(playerid)
    local src = QBCore.Functions.GetPlayer(source)

    Player.Functions.RemoveMoney('bank', amount)
    exports['qb-management']:AddMoney(src.PlayerData.job.name, amount)
end)

RegisterNetEvent('solos-food:server:society', function(id, amount)
    local Player = QBCore.Functions.GetPlayer(id)
    local job = Player.PlayerData.job.name
    exports['qb-management']:AddMoney(job, amount)
end)

RegisterNetEvent('solos-cashier:server:societyremove', function(amount)
    local Player = QBCore.Functions.GetPlayer(source)
    local job = Player.PlayerData.job.name
    exports['qb-management']:RemoveMoney(job, amount)
end)

RegisterNetEvent('solos-cashier:server:getbalances', function(moneytype, amount, id, receipt)
    local src = source
    local bankbalance = nil
    local cashbalance = nil
    local Player = QBCore.Functions.GetPlayer(src)
    local bank = Player.PlayerData.money.bank
    local cash = Player.PlayerData.money.cash
    bankbalance = bank
    cashbalance = cash
    TriggerClientEvent('solos-cashier:client:bankbalance', src, bankbalance, cashbalance, moneytype, amount, id, receipt)
end)

--notify another client

RegisterNetEvent('solos-food:server:paymentdeclined', function(id)
    TriggerClientEvent('solos-food:client:paymentdeclined', id)
end)

--qbcore invoice

RegisterNetEvent('solos-cashier:server:qbinvoice', function(id, amount)
    local biller = QBCore.Functions.GetPlayer(source)
    local billed = QBCore.Functions.GetPlayer(tonumber(id))
    local amount = tonumber(amount)

    if billed ~= nil then
        if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
            if amount and amount > 0 then
                MySQL.insert(
                    'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',
                    { billed.PlayerData.citizenid, amount, biller.PlayerData.job.name,
                        biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid })
                TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
                TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
                TriggerEvent('solos-cashier:server:sendreceipt', source)
            else
                TriggerClientEvent('solos-cashier:client:invalidamount', source)
            end
        else
            TriggerClientEvent('solos-cashier:client:invalidself', source)
        end
    else
        TriggerClientEvent('solos-cashier:client:playeroffline', source)
    end
end)

---@param source any
---@param data {index: string, ingredient: string, total: number}
lib.callback.register('solos-restaurants:orderIngredient', function(source, data)
    local money = exports.ox_inventory:Search(source, 'count', 'money')
    local conf = config.delivery[data.index].items[data.ingredient]

    local cost = conf.price * (conf.total - data.total)
    if money == 0 or cost > money then
        return false
    end

    config.delivery[data.index].items[data.ingredient].total = data.total

    exports.ox_inventory:RemoveItem(source, 'money', cost)

    TriggerClientEvent('solos-restaurants:client:receiveIngredientUpdate', -1, data)
    return true
end)

RegisterNetEvent('solos-restaurants:server:pickupCrate', function(index, ingredient, amount)
    local src = source
    if not index or not ingredient then return end

    exports.ox_inventory:AddItem(src, 'crate', 1, { description = ('A crate containing %s(s)'):format(ingredient), ingredient = ingredient, store = index, amount = amount })
end)

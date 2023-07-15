local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('solos-food:client:itemserror', function()
    QBCore.Functions.Notify("You don't have the required items", "error")
end)

RegisterNetEvent('solos-food:client:success', function()
    QBCore.Functions.Notify("Success", "success")
end)

--money
RegisterNetEvent('solos-food:client:bankerror', function()
    QBCore.Functions.Notify('You do not have enough money in your bank', 'error')
end)

RegisterNetEvent('solos-food:client:casherror', function()
    QBCore.Functions.Notify('You do not have enough cash on you', 'error')
end)

RegisterNetEvent('solos-food:client:bankpaid', function(amount)
    QBCore.Functions.Notify('Paid: $' .. amount, 'success')
end)

RegisterNetEvent('solos-food:client:paymentdeclined', function()
    QBCore.Functions.Notify('Payment declined', 'error')
end)

--invoice (QB)
RegisterNetEvent('solos-food:client:invalidamount', function()
    QBCore.Functions.Notify('Must Be A Valid Amount Above 0', 'error')
end)

RegisterNetEvent('solos-food:client:invalidself', function()
    QBCore.Functions.Notify('You Cannot Bill Yourself', 'error')
end)

RegisterNetEvent('solos-food:client:playeroffline', function()
    QBCore.Functions.Notify('Player Not Online', 'error')
end)

--registers
RegisterNetEvent('solos-cashier:client:dutyerror', function()
    QBCore.Functions.Notify('You must be on duty to do this', "error")
end)

RegisterNetEvent('solos-cashier:client:dutyerror2', function()
    QBCore.Functions.Notify('You can\'t be on duty for this', "error")
end)

--receipts
RegisterNetEvent('solos-cashier:client:moneydeposited', function(amount)
    QBCore.Functions.Notify('Deposited: $' .. amount, 'success')
end)

RegisterNetEvent('solos-cashier:client:receipterror', function()
    QBCore.Functions.Notify('You don\'t have any receipts', 'error')
end)

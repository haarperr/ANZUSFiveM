QBCore = {}
QBCore.PlayerData = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.ClientCallbacks = {}
QBCore.ServerCallbacks = {}
IsLoggedIn = false

exports('GetCoreObject', function()
    return QBCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('__cfx_export_es_extended_getSharedObject', function(setCB)
    setCB(function()
        return QBCore
    end)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("bigbankwindow", vector3(247.67, 223.63, 106.29), 0.4, 3, {
        name = "bigbankwindow",
        heading = 340,
        --debugPoly=true,
        minZ = 106.29,
        maxZ = 107.69,
    }, {
        options = {
            {
                type = "server",
                event = "qb-core:server:collectPayslip",
                icon = "far fa-clipboard",
                label = "Collect Payslip",
            },
        },
        distance = 2.5,
    })
end)
--- Recommends a player
--- Author: mk3ext#6044

local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('recommend', function()
    local input = lib.inputDialog('Recommend Player', {
        { type = "number", label = "Player ID", default = 1 },
        { type = "input",  label = "Reason",    placeholder = 'Great guy, amazing roleplay' },
    })

    if not input then return end
    local playerId = tonumber(input[1])
    local reason = input[2]
    if not playerId or not reason then return end

    local player = GetPlayerFromServerId(playerId)
    if player == -1 then return QBCore.Functions.Notify(Locale.not_online, 'error') end

    TriggerServerEvent('ag_misc:server:RecommendPlayer', playerId, reason)
end, false)

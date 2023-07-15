--- Recommends a player
--- Author: mk3ext#6044

---Recommend Player from Client
---@param playerId number
---@param reason string
RegisterNetEvent('ag_misc:server:RecommendPlayer', function(playerId, reason)
    if type(playerId) ~= "number" or type(reason) ~= "string" then return end

    local src = source
    local senderData = QBCore.Functions.GetPlayer(src).PlayerData
    local recommendData = QBCore.Functions.GetPlayer(playerId).PlayerData

    local embed = { {
        title = 'Player Recommendation',
        color = '0153255',
        description = '> Sender: ' .. senderData.citizenid .. '\n> Recommends: ' .. recommendData.citizenid .. '\n> Reason: ' .. reason,
        footer = {
            text = os.date('%c'),
        }
    } }

    PerformHttpRequest(Config.Webhooks.RecommendPlayer, function(err, text, headers)
        end, "POST", json.encode({ embeds = embed }),
        { ["Content-Type"] = "application/json" }
    )

    QBCore.Functions.Notify(src, Locale.sent_recommendation, 'success')
end)

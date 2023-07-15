if Config.Framework.Active ~= 1 then return end



ESX = exports.es_extended:getSharedObject()
Framework = ESX

function UpdatePlayerCooords(identifier, coords)
    local playersTable = 'users'
    return MySQL.query.await([[
        UPDATE `]] .. playersTable .. [[`
        SET position = ?
        WHERE identifier = ?
    ]], {
        json.encode(coords),
        identifier
    })
end

function GetOfflinePlayerName(identifier)
    local playersTable = 'users'
    local result = MySQL.query.await([[
        SELECT firstname, lastname
        FROM `]] .. playersTable .. [[`
        WHERE identifier = ?
    ]], {identifier})
    return result[1] and result[1].firstname .. ' ' .. result[1].lastname or "Unknown"
end
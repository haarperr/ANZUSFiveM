if Config.Framework.Active ~= 3 then return end



CustomFramework = exports[Config.Framework.Name][Config.Framework.Export]()
Framework = {
    --Soon 
}

function UpdatePlayerCooords(identifier, coords)
    local playersTable = 'players'
    return MySQL.query([[
        UPDATE `]] .. playersTable .. [[`
        SET position = ?
        WHERE citizenid = ?
    ]], {
        json.encode(coords),
        identifier
    })
end

function GetOfflinePlayerName(identifier)
    local playersTable = 'players'
    local result = MySQL.query.await([[
        SELECT 
            JSON_VALUE(charinfo, '$.firstname') AS firstname,
            JSON_VALUE(charinfo, '$.lastname') AS lastname
        FROM `]] .. playersTable .. [[`
        WHERE identifier = ?
    ]], {identifier})
    return result[1] and result[1].firstname .. ' ' .. result[1].lastname or "Unknown"
end

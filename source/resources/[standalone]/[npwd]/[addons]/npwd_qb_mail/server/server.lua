local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("npwd:qb-mail:getMail", function()
    local src         = source
    local Player      = QBCore.Functions.GetPlayer(src)
    local mailResults = MySQL.query.await(
    'SELECT `citizenid`, `sender`, `subject`, `message`, `read`, `mailid`, `date`, `button` FROM character_mails WHERE citizenid = ? ORDER BY date DESC',
        { Player.PlayerData.citizenid })

    for i = 1, #mailResults do
        if mailResults[i].button ~= nil and #mailResults[i].button == 2 then -- qb-phone used replace button with "" when its used, so checking if thats the length then setting to nil for ui
            mailResults[i].button = nil
        end
        if mailResults[i].button ~= nil then
            mailResults[i].button = json.decode(mailResults[i].button)
        end
    end

    TriggerClientEvent('npwd:qb-mail:sendMail', src, mailResults)
end)

RegisterNetEvent('npwd:qb-mail:updateRead', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.update('UPDATE character_mails SET `read` = 1 WHERE mailid = ? AND citizenid = ?', { data, Player.PlayerData.citizenid })
end)

RegisterNetEvent('npwd:qb-mail:deleteMail', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('DELETE FROM character_mails WHERE mailid = ? AND citizenid = ?', { data, Player.PlayerData.citizenid })
    TriggerClientEvent('npwd:qb-mail:mailDeleted', src, result)
end)

RegisterNetEvent('npwd:qb-mail:updateButton', function(id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.update.await('UPDATE character_mails SET `button` = NULL WHERE mailid = ? AND citizenid = ?', { id, Player.PlayerData.citizenid })
    TriggerClientEvent('npwd:qb-mail:buttonUpdated', src, result)
end)


--stuff from qb-phone

local function GenerateMailId()
    return math.random(111111, 999999)
end

RegisterNetEvent('qb-phone:server:sendNewMail', function(mailData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local mailid = GenerateMailId()
    if mailData.button == nil then
        MySQL.insert('INSERT INTO character_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)',
            { Player.PlayerData.citizenid, mailData.sender, mailData.subject, mailData.message, mailid, 0 })
    else
        MySQL.insert('INSERT INTO character_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)',
            { Player.PlayerData.citizenid, mailData.sender, mailData.subject, mailData.message, mailid, 0, json.encode(mailData.button) })
    end
    local newMail = {
        sender = mailData.sender,
        subject = mailData.subject,
        message = mailData.message,
        mailid = mailid,
        button = mailData.button,
        read = 0,
        date = os.time() * 1000
    }
    TriggerClientEvent('npwd:qb-mail:newMail', src, newMail)
end)

RegisterNetEvent('qb-phone:server:sendNewMailToOffline', function(citizenid, mailData)
    local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if Player then
        local src = Player.PlayerData.source
        local mailid = GenerateMailId()
        if mailData.button == nil or not next(mailData.button) then
            MySQL.insert('INSERT INTO character_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)',
                { Player.PlayerData.citizenid, mailData.sender, mailData.subject, mailData.message, mailid, 0 })
        else
            MySQL.insert('INSERT INTO character_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)',
                { Player.PlayerData.citizenid, mailData.sender, mailData.subject, mailData.message, mailid, 0, json.encode(mailData.button) })
        end
        local newMail = {
            sender = mailData.sender,
            subject = mailData.subject,
            message = mailData.message,
            mailid = mailid,
            button = mailData.button,
            read = 0,
            date = os.time() * 1000
        }
        TriggerClientEvent('npwd:qb-mail:newMail', src, newMail)
    else
        if mailData.button == nil then
            MySQL.insert('INSERT INTO character_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)',
                { citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0 })
        else
            MySQL.insert('INSERT INTO character_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)',
                { citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0, json.encode(mailData.button) })
        end
    end
end)

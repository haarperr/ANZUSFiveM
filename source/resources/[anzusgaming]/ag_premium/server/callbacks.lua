local db = require 'server.db'

-- Callback to get the players premium status
lib.callback.register('ag_premium:isPlayerPremium', function(source, premiumType)
    local source = source
    if not premiumType then return false end

    local Player = QBCore.Functions.GetPlayer(source)

    if premiumType == 'plate' then
        return Player.PlayerData.premium >= ConfigServer.PlatePremiumLevel
    elseif premiumType == 'phone' then
        return Player.PlayerData.premium >= ConfigServer.PhonePremiumLevel
    end

    return false
end)

-- Callback to the players vehicles
lib.callback.register('ag_premium:getPlayerVehicles', function(source)
    local source = source

    -- Get the players citizen id
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return {} end

    -- Get the players vehicles from the database
    local vehicles = db.getPlayerVehicles(Player.PlayerData.citizenid)

    -- Go through and add the vehicle name to each vehicle
    local data = AG.GetVehicleData()
    for i=1,#vehicles do
        local vehicle = vehicles[i]
        vehicle.name = data[vehicle.model].name
    end

    return vehicles
end)

-- Server callback to change a plate
lib.callback.register('ag_premium:changePlate', function(source, data)
    local source = source

    -- Get the players citizen id
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    local id = Player.PlayerData.citizenid

    -- Ensure the data is valid
    if
        (not data or #data ~= 2)
        or
        (not data[1] or not data[2])
        or
        (type(data[1]) ~= 'string' or type(data[2]) ~= 'string')
        or
        (data[1] == data[2])
    then return false end

    -- Ensure the plate is valid, basic check
    local oldPlate, newPlate = data[1]:upper(), data[2]:upper()
    if #newPlate < Config.MinPlateLength or #newPlate > Config.MaxPlateLength then return false end

    -- Go through the plate filter and ensure it passes
    for i=1,#ConfigServer.Filter do
        if string.find(newPlate, ConfigServer.Filter[i]) then return false end
    end

    -- Ensure the plate is not already in use
    if db.doesPlateExist(plate) then return false end

    -- Check the original plate is valid
    if not db.doesPlateExist(oldPlate) then return false end

    local success = db.updateVehiclePlate(oldPlate, newPlate, id)
    if success then
        ConfigServer.Log(string.format("%s (%s) has changed their plate from %s to %s", Player.PlayerData.name, id, oldPlate, newPlate))
    else
        ConfigServer.Log(string.format("%s (%s) has failed to change their plate from %s to %s", Player.PlayerData.name, id, oldPlate, newPlate))
    end
    return success
end)

-- Server callback to change a phone number
lib.callback.register('ag_premium:changeNumber', function(source, data)
    local source = source

    -- Get the players citizen id
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    local id = Player.PlayerData.citizenid

    -- Ensure the data is valid
    if
        (not data or #data ~= 2)
        or
        (not data[1] or not data[2])
        or
        (type(data[1]) ~= 'string' or type(data[2]) ~= 'string')
        or
        (data[1] == data[2])
    then return false end

    -- Ensure the number is valid, basic check
    local oldNumber, newNumber = data[1], data[2]
    if #newNumber < Config.MinNumberLength or #newNumber > Config.MaxNumberLength then return false end

    -- Check that the phone number only contains numbers
    if tonumber(newNumber) == nil then return false end

    -- Add the (222) prefix to both numbers
    oldNumber = '(222) ' .. oldNumber
    newNumber = '(222) ' .. newNumber

    -- Ensure the number is not already in use
    if db.isNumberInUse(newNumber) then return false end

    local success = db.updatePlayerNumber(oldNumber, newNumber, id)
    if success then
        -- Update the players phone number in the cache
        Player.Functions.SetPlayerData('phone_number', newNumber)

        -- Reload the players phone
        exports.npwd:unloadPlayer(source)
        exports.npwd:newPlayer({
            source = source,
            phoneNumber = newNumber,
            identifier = Player.PlayerData.citizenid,
            firstname = Player.PlayerData.charinfo.firstname,
            lastname = Player.PlayerData.charinfo.lastname
        })

        ConfigServer.Log(string.format("%s (%s) has changed their phone number from %s to %s", Player.PlayerData.name, id, oldNumber, newNumber))
    else
        ConfigServer.Log(string.format("%s (%s) has failed to change their phone number from %s to %s", Player.PlayerData.name, id, oldNumber, newNumber))
    end
    return success
end)
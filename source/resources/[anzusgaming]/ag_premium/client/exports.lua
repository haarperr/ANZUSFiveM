local function openCustomPlateMenu()

    -- Check if the player is premium
    lib.callback('ag_premium:isPlayerPremium', false, function(isPremium)
        if not isPremium then QBCore.Functions.Notify(Locale.not_premium, 'error') return end

        -- Get the players current vehicles from the database
        lib.callback('ag_premium:getPlayerVehicles', false, function(vehicles)
            local plates = {}
            for i=1,#vehicles do
                plates[#plates+1] = {value=vehicles[i].plate, label=string.format('%s - %s', vehicles[i].plate, vehicles[i].name)}
            end

            if #plates == 0 then
                QBCore.Functions.Notify(Locale.no_vehicles, 'error')
                return
            end

            local data = lib.inputDialog(Locale.title,
            {
                {type='select', label=Locale.select_plate, options=plates},
                {type='input', label=Locale.new_plate, placeholder=Locale.new_plate_placeholder, description=Locale.new_plate_description},
            })

            -- Ensure the data is valid
            if not data or #data ~= 2 then return end
            if not data[1] then QBCore.Functions.Notify(Locale.invalid_current_plate, 'error') return end
            if not data[2] then QBCore.Functions.Notify(Locale.invalid_new_plate, 'error') return end
            if data[1] == data[2] then QBCore.Functions.Notify(Locale.same_plate, 'error') return end

            -- Ensure the plate is valid, basic check, will get validated by the server as well for security
            local oldPlate = data[1]:upper()
            local newPlate = data[2]:upper()
            if #newPlate < Config.MinPlateLength or #newPlate > Config.MaxPlateLength then
                QBCore.Functions.Notify(Locale.invalid_plate_length, 'error')
                return
            end

            -- Ensure the plate only contains characters in the Config.ValidPlateCharacters table
            for i=1,#newPlate do
                local char = newPlate:sub(i,i)

                -- If the character is not in the table, notify the player and return
                local valid = false
                for i=1,#Config.ValidPlateCharacters do
                    local validChar = Config.ValidPlateCharacters[i]
                    if char == validChar then
                        valid = true
                        break
                    end
                end
                if not valid then QBCore.Functions.Notify(Locale.invalid_plate_characters, 'error') return end
            end

            -- Trigger the server callback to change the plate and notify the player of the result
            lib.callback('ag_premium:changePlate', false, function(success)
                if success then
                    QBCore.Functions.Notify(string.format(Locale.success, oldPlate, newPlate), 'success')
                else
                    QBCore.Functions.Notify(Locale.unsuccessful, 'error')
                end
            end, data)
        end)
    end, 'plate')
end

local function openCustomPhoneMenu()

    -- Check if the player is premium
    lib.callback('ag_premium:isPlayerPremium', false, function(isPremium)
        if not isPremium then QBCore.Functions.Notify(Locale.not_premium, 'error') return end

        -- Get the players current phone number and remove '(222) ' from the number
        local currentPhoneNumber = QBCore.Functions.GetPlayerData().phone_number
        currentPhoneNumber = currentPhoneNumber:sub(7)

        local data = lib.inputDialog(Locale.phoneTitle,
        {
            {type='input', label=Locale.current_number, default=currentPhoneNumber, disabled=true, description=Locale.current_number_description},
            {type='input', label=Locale.new_number, placeholder=currentPhoneNumber, description=Locale.new_number_description},
        })

        -- Ensure the data is valid
        if not data or #data ~= 2 then return end
        if not data[1] then QBCore.Functions.Notify(Locale.error, 'error') return end
        if not data[2] then QBCore.Functions.Notify(Locale.invalid_new_number, 'error') return end
        if data[1] == data[2] then QBCore.Functions.Notify(Locale.same_number, 'error') return end

        -- Ensure the number is valid, basic check, will get validated by the server as well for security
        local oldNumber = data[1]
        local newNumber = data[2]
        if #newNumber < Config.MinNumberLength or #newNumber > Config.MaxNumberLength then QBCore.Functions.Notify(Locale.invalid_number_length, 'error') return end

        -- Ensure the number only contains numbers
        for i=1,#newNumber do
            local char = newNumber:sub(i,i)
            if not tonumber(char) then QBCore.Functions.Notify(Locale.invalid_number_characters, 'error') return end
        end

        -- Trigger the server callback to change the number and notify the player of the result
        lib.callback('ag_premium:changeNumber', false, function(success)
            if success then
                QBCore.Functions.Notify(string.format(Locale.numberSuccess, oldNumber, newNumber), 'success')
            else
                QBCore.Functions.Notify(Locale.numberUnsuccessful, 'error')
            end
        end, data)
    end, 'phone')
end

exports('openCustomPlateMenu', openCustomPlateMenu)
exports('openCustomPhoneMenu', openCustomPhoneMenu)


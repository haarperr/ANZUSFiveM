RegisterNetEvent('qb-carboosting:server:CrushVehicle', function()
    local src = source
    local ped = GetPlayerPed(src)
    local veh = GetVehiclePedIsIn(ped, false)
    local Player = Framework.Functions.GetPlayer(src)
    if not Player or veh == 0 then return end

    if Player.PlayerData.job.type == 'leo' then
        local model = Framework.Shared.VehicleHashes[GetEntityModel(veh)].model
        local plate = GetVehicleNumberPlateText(veh)
        MySQL.query('DELETE FROM character_vehicles WHERE vehicle = ? AND plate = ? and vinscratched = 1', { model, plate })

        -- Log
        if Shared.Debug then print("^3[qb-carboosting] ^5Deleted VIN Scratch Vehicle (Vehicle Crush) Model: " .. model .. " Plate: " .. plate .. "^7") end
        TriggerEvent("qb-log:server:CreateLog", "carboosting", "Vehicle Delete", "red",
            "**" .. Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
            "* | id: *" .. src .. "*) Crushed VIN Vehicle, Model: " .. model .. " Plate: " .. plate)
    else
        TriggerClientEvent(Shared.CoreObject .. ':Notify', src, Translations.error['for_police'], 'error', 2500)
    end
end)

Framework.Functions.CreateCallback('qb-carboosting:server:CanCrushVehicle', function(source, cb)
    local ped = GetPlayerPed(source)
    local veh = GetVehiclePedIsIn(ped, false)
    local Player = Framework.Functions.GetPlayer(source)
    if veh == 0 or not Player.PlayerData.job.type == 'leo' then
        cb(false)
        return
    end                                                                              -- Player.PlayerData.job.type == 'leo'
    local model = Framework.Shared.VehicleHashes[GetEntityModel(veh)].model
    local plate = GetVehicleNumberPlateText(veh)
    local result = MySQL.scalar.await('SELECT vinscratched FROM character_vehicles WHERE vehicle = ? AND plate = ?', { model, plate })
    if result == 1 then cb(true) else cb(false) end
end)

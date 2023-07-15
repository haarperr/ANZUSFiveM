local QBCore = exports["qb-core"]:GetCoreObject()

local function findVehFromPlateAndLocate(plate)
    local res = lib.callback.await('npwd:ag_garage:trackVehicle', 500, { plate = plate })
    SetNewWaypoint(res.x, res.y)

    return res ~= nil and true or false
end

RegisterNUICallback("npwd:ag_garage:getVehicles", function(_, cb)
    TriggerServerEvent("npwd:ag_garage:getVehicles")
    RegisterNetEvent("npwd:ag_garage:sendVehicles", function(vehicles)
        for _, v in pairs(vehicles) do
            local type = GetVehicleClassFromName(v.model)
            if type == 15 or type == 16 then
                v.type = "aircraft"
            elseif type == 14 then
                v.type = "boat"
            elseif type == 13 or type == 8 then
                v.type = "bike"
            else
                v.type = "car"
            end
        end

        cb({ status = "ok", data = vehicles })
    end)
end)

RegisterNUICallback("npwd:ag_garage:requestWaypoint", function(data, cb)
    local plate = data.plate
    if findVehFromPlateAndLocate(plate) then
        lib.notify({ type = 'success', title = 'Lojack', description = 'We have found your vehicle, it has been marked on your GPS' })
    else
        lib.notify({ type = 'error', title = 'Lojack', description = 'We are unable to locate your vehicle' })
    end
    cb({})
end)

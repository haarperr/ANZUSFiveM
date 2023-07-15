local MySQL = MySQL
local QBCore = exports['qb-core']:GetCoreObject()

---@param source any
---@param data {plate: string}
lib.callback.register('npwd:ag_garage:trackVehicle', function(source, data)
    local vehicle = AG.GetVehicles()
    local coords = nil
    for i = 1, #vehicle, 1 do
        local v = vehicle[i]
        if v.plate == data.plate then
            coords = GetEntityCoords(v.entity)
            break
        end
    end

    return coords
end)

RegisterNetEvent("npwd:ag_garage:getVehicles", function()
    local src          = source
    local Player       = QBCore.Functions.GetPlayer(src)
    local garageresult = MySQL.query.await('SELECT * FROM character_vehicles WHERE owner = ?', { Player.PlayerData.citizenid })

    if garageresult[1] ~= nil then
        for _, v in pairs(garageresult) do
            v.vehicle = 'Unknown'
            v.brand = 'Vehicle'

            if not v.out then
                v.state = "garaged"
            else
                v.state = "out"
                -- elseif v.state == 2 then
                -- 	v.state = "impounded"
                -- 	-- elseif v.state == 3 then -- add new state for seized vehicles
                -- 	-- 	v.state = "seized"
            end

            if v.garage == 'impound' then
                v.state = 'impounded'
            end

            local vehicleData = AG.GetVehicleData(v.model)
            v.vehicle = vehicleData.name
            v.brand = vehicleData.make
        end

        TriggerClientEvent('npwd:ag_garage:sendVehicles', src, garageresult)
    end
end)

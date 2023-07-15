local QBCore = exports['qb-core']:GetCoreObject()
local washingVehicle = false
local washPoly = {}

RegisterNetEvent('qb-carwash:client:washCar', function()
    washingVehicle = true
    QBCore.Functions.Progressbar('search_cabin', 'Vehicle is being washed ..', math.random(4000, 8000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        SetVehicleDirtLevel(cache.vehicle, 0.0)
        SetVehicleUndriveable(cache.vehicle, false)
        WashDecalsFromVehicle(cache.vehicle, 1.0)
        washingVehicle = false
    end, function() -- Cancel
        QBCore.Functions.Notify('Washing canceled ..', 'error')
        washingVehicle = false
    end)
end)

function onEnterCarWash(self)
    lib.showTextUI('[E] - Wash Vehicle ($20)')
end

function onExitCarWash(self)
    lib.hideTextUI()
end

function insideCarWash(self)
    local PlayerPed = PlayerPedId()
    local PedVehicle = GetVehiclePedIsIn(PlayerPed, false)
    local Driver = GetPedInVehicleSeat(PedVehicle, -1)
    local dirtLevel = GetVehicleDirtLevel(PedVehicle)
    if Driver == PlayerPed and not washingVehicle then
        if IsControlJustPressed(0, 38) then
            if dirtLevel > Config.DirtLevel then
                TriggerServerEvent('qb-carwash:server:washCar')
            else
                QBCore.Functions.Notify("Vehicle is not dirty", 'error')
            end
        end
    end
end

CreateThread(function()
    for k, v in pairs(Config.CarWash) do
        washPoly[#washPoly+1] = lib.zones.box({
            coords = v['poly'].coords,
            size = vec3(v['poly'].length, v['poly'].width, 5),
            rotation = v['poly'].heading,
            debug = false,
            inside = insideCarWash,
            onEnter = onEnterCarWash,
            onExit = onExitCarWash
        })
    end
end)

CreateThread(function()
    for k in pairs(Config.CarWash) do
        local coords = Config.CarWash[k]["poly"]["coords"]
        local carWash = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(carWash, 100)
        SetBlipDisplay(carWash, 4)
        SetBlipScale(carWash, 0.75)
        SetBlipAsShortRange(carWash, true)
        SetBlipColour(carWash, 37)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.CarWash[k]['label'])
        EndTextCommandSetBlipName(carWash)
    end
end)

---@param model any
---@param coords vector4
local function createNPC(model, coords)
    lib.requestModel(model, 500)
    local ped = CreatePed(5, model, coords.x, coords.y, coords.z, coords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
    return ped
end

local function getClosestLocation(locations)
    local closestDistance = -1
    local closestIndex = -1
    local closestLocation = nil
    local plyCoords = GetEntityCoords(cache.ped)
    for i, v in ipairs(locations) do
        local location = vector3(v.x, v.y, v.z)
        local distance = #(plyCoords - location)
        if (closestDistance == -1 or closestDistance > distance) then
            closestDistance = distance
            closestIndex = i
            closestLocation = v
        end
    end
    return closestIndex, closestDistance, closestLocation
end

lib.callback.register('ag_rental:ClosestParkingspot', function()
    local freeParkingSpots = {}

    for i = 1, #Config.Rental.land.spawn, 1 do
        local spot = Config.Rental.land.spawn[i]
        local veh = lib.getClosestVehicle(vec3(spot.x, spot.y, spot.z), 2, false)
        if veh ~= nil then goto skip end
        freeParkingSpots[#freeParkingSpots + 1] = spot

        ::skip::
    end
    local _, _, location = getClosestLocation(freeParkingSpots)

    if location == nil then return false end
    return location
end)

local function openMenu()
    lib.registerContext({
        id = 'rental_menu',
        title = 'Rental Options',
        options = GlobalState.rentalLand or {}
    })


    lib.showContext('rental_menu')
end

local function returnVehicle()
    local papers = exports.ox_inventory:Search('slots', 'rentalpapers')
    local vehicle = lib.getClosestVehicle(GetEntityCoords(cache.ped), 10, false)
    if not vehicle then return lib.notify({ type = 'error', description = 'There are no vehicles nearby' }) end
    local lastPlate = GetVehicleNumberPlateText(vehicle)
    local canReturn = nil
    for _, v in pairs(papers) do
        if v.metadata.plate == lastPlate and v.metadata.renter == cache.serverId then
            canReturn = { vehicle = NetworkGetNetworkIdFromEntity(vehicle), slot = v.slot }
        end
    end
    if not canReturn then return lib.notify({ type = 'error', description = 'You do not have any rental papers for vehicles nearby' }) end

    TriggerServerEvent('ag_rental:ReturnVehicle', canReturn)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    for k, value in pairs(Config.Rental) do
        local blip = AddBlipForCoord(value.blip.coords.x, value.blip.coords.y, value.blip.coords.z)
        SetBlipSprite(blip, value.blip.id)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.60)
        SetBlipColour(blip, value.blip.colour)
        SetBlipAsShortRange(blip, true)
        AddTextEntry(k, value.blip.title)
        BeginTextCommandSetBlipName(k)
        EndTextCommandSetBlipName(blip)
    end

    local ped = createNPC(`a_m_y_business_03`, vec4(109.9739, -1088.61, 28.302, 345.64))

    exports.ox_target:addLocalEntity({ ped }, {
        {
            name = 'agrental',
            icon = 'fa-solid fa-road',
            label = 'Open Menu',
            onSelect = function()
                openMenu()
            end
        },
        {
            name = 'agrental',
            icon = 'fa-solid fa-road',
            label = 'Return Vehicle',
            onSelect = function()
                returnVehicle()
            end
        }
    })
end)

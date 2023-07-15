local crushingZone = vector3(2396.68, 3111.36, 48.13)
local crushingZoneRadius = 10.0
local inZone = false

-- Area Zone
local CrushZone = CircleZone:Create(crushingZone, crushingZoneRadius, {
    name = "boosting_crushing",
    debugPoly = false
})

--- Removes the VIN scratched vehicle from the character_vehicles database
--- @return nil
local crushVehicle = function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then return end

    if GetPedInVehicleSeat(veh, -1) ~= ped then
        Framework.Functions.Notify(Translations.error['only_driver'], 'error', 2500)
        return
    end

    Framework.Functions.TriggerCallback('qb-carboosting:server:CanCrushVehicle', function(result)
        if result then
            Framework.Functions.Progressbar("crush_boosting", Translations.info['progressbar_crushing'], 8000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerServerEvent('qb-carboosting:server:CrushVehicle')
                TaskLeaveVehicle(ped, veh, 0)
                Wait(1500)
                Framework.Functions.DeleteVehicle(veh)
            end, function() -- Cancel
                Framework.Functions.Notify(Translations.error['canceled'], "error", 3500)
            end)
        else
            Framework.Functions.Notify(Translations.error['cannot_crush'], 'error', 2500)
        end
    end)
end

CrushZone:onPlayerInOut(function(isPointInside, point)
    if not isLoggedIn or not PlayerData.job or PlayerData.job.name ~= 'police' or GetVehiclePedIsIn(PlayerPedId(), false) == 0 then return end -- PlayerData.job.type ~= 'leo'
    if isPointInside then
        inZone = true
        exports[Shared.Framework]:DrawText(Translations.info['crush_vehicle'], 'left')
        -- E to start crushing vehicle
        CreateThread(function()
            while inZone do
                if IsControlJustPressed(0, 38) then
                    crushVehicle()
                    exports[Shared.Framework]:KeyPressed(38)
                    return
                end
                Wait(3)
            end
        end)
    else
        inZone = false
        exports[Shared.Framework]:HideText()
    end
end)

-- Police Blip
CreateThread(function()
    while PlayerData.job == nil do Wait(10) end
    if PlayerData.job.name == "lspd" then -- PlayerData.job.type == 'leo'
        local blip = AddBlipForCoord(crushingZone.x, crushingZone.y, crushingZone.z)
        SetBlipSprite(blip, 380)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Vehicle Crush")
        EndTextCommandSetBlipName(blip)
    end
end)

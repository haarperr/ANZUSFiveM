local lastTackle = 0
local tackleAnimation = {"swimming@first_person@diving", "dive_run_fwd_-45_loop", 4.2, 4.2, 48}

RegisterKeyMapping("tackle", "[Interaction] Tackle Players/NPCs~", "KEYBOARD", "E")

-- When triggered, tackle nearby players/NPCs.
local function TackleNearbyPlayers()
    local ped = PlayerPedId()

    if lastTackle < GetGameTimer() and IsPedSprinting(ped) and not IsPedSittingInAnyVehicle(ped) then
        lastTackle = GetGameTimer() + 5800 -- 5.8 seconds.

        -- Load animation dictionary.
        RequestAnimDict(tackleAnimation[1])
        while not HasAnimDictLoaded(tackleAnimation[1]) do
            Citizen.Wait(0) -- Wait until animation dictionary is loaded.
        end

        -- Play animation for ped.
        TaskPlayAnim(ped, tackleAnimation[1], tackleAnimation[2], tackleAnimation[3], tackleAnimation[4], -1, tackleAnimation[5], 0, 0, 0, 0)

        -- Clear the ped's secondary task.
        Wait(645)
        ClearPedSecondaryTask(ped)

        -- Ragdoll self and nearby players/NPCs.
        SetPedToRagdoll(ped, 850, 850, 0, 1, 1, 0)
        TriggerServerEvent("Tackle:Server:TackleNearbyPlayers")
    end
end

RegisterCommand("tackle", TackleNearbyPlayers, false)

RegisterNetEvent('Tackle:Client:GetTackled', function()
    local ped = PlayerPedId()
    SetPedToRagdoll(ped, 3900, 3900, 0, 1, 1, 0)
end)
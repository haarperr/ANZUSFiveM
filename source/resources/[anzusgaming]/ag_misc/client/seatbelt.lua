local seatbeltOn = false
local harnessOn = false
local handbrake = 0
local newvehicleBodyHealth = 0
local currentvehicleBodyHealth = 0
local frameBodyChange = 0
local lastFrameVehiclespeed = 0
local lastFrameVehiclespeed2 = 0
local thisFrameVehicleSpeed = 0
local tick = 0
local damagedone = false
local modifierDensity = true
local lastVehicle = nil
local veloc

local function EjectFromVehicle()
    local coords = GetOffsetFromEntityInWorldCoords(cache.vehicle, 1.0, 0.0, 1.0)
    SetEntityCoords(cache.ped, coords.x, coords.y, coords.z)
    Wait(1)
    SetPedToRagdoll(cache.ped, 5511, 5511, 0, 0, 0, 0)
    SetEntityVelocity(cache.ped, veloc.x * 4, veloc.y * 4, veloc.z * 4)
    local ejectspeed = math.ceil(GetEntitySpeed(cache.ped) * 8)
    if IsPedWearingHelmet(cache.ped) and IsThisModelABicycle(GetEntityModel(cache.vehicle)) then
        local damageAmount = GetEntityHealth(cache.ped) - 1
        if damageAmount > ejectspeed then
            damageAmount = ejectspeed
        end

        SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) - damageAmount)

        return
    end
    SetEntityHealth(cache.ped, (GetEntityHealth(cache.ped) - ejectspeed))
end

local function ResetHandBrake()
    if handbrake <= 0 then return end
    handbrake -= 1
end

local function HasHarness()
    return harnessOn
end

exports('HasHarness', HasHarness)

local function ToggleSeatbelt()
    seatbeltOn = not seatbeltOn
    SeatBeltLoop()
    TriggerEvent('seatbelt:client:ToggleSeatbelt')
    TriggerServerEvent('InteractSound_SV:PlayOnSource', seatbeltOn and 'carbuckle' or 'carunbuckle', 0.25)
end

exports('ToggleSeatbelt', ToggleSeatbelt)

local function ToggleHarness()
    harnessOn = not harnessOn
    if not harnessOn then return end
    ToggleSeatbelt()
end

exports('ToggleHarness', ToggleHarness)

function SeatBeltLoop()
  CreateThread(function()
    local sleep = 0
      while true do
        sleep = 0
        if seatbeltOn or harnessOn then
          DisableControlAction(0, 75, true)
          DisableControlAction(27, 75, true)
        end
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
          seatbeltOn = false
          harnessOn = false
          TriggerEvent("seatbelt:client:ToggleSeatbelt")
          break
        end
        if not seatbeltOn and not harnessOn then break end
        Wait(sleep)
      end
  end)
end

lib.addKeybind({
  name = 'ag_misc-seatbelt',
  description = 'Toggle seatbelt',
  defaultKey = 'b',
  onPressed = function()
    if not cache.vehicle or IsPauseMenuActive() then return end
    local class = GetVehicleClass(cache.vehicle)
    if class == 8 or class == 13 or class == 14 then return end
    ToggleSeatbelt()
  end,
})

CreateThread(function()
    while true do
        Wait(0)
        if cache.vehicle and cache.vehicle ~= false and cache.vehicle ~= 0 then
            SetPedHelmet(cache.ped, false)
            lastVehicle = cache.vehicle
            if GetVehicleEngineHealth(cache.vehicle) < 0.0 then
                SetVehicleEngineHealth(cache.vehicle, 0.0)
            end
            if (GetVehicleHandbrake(cache.vehicle) or (GetVehicleSteeringAngle(cache.vehicle)) > 25.0 or (GetVehicleSteeringAngle(cache.vehicle)) < -25.0) then
                if handbrake == 0 then
                    handbrake = 100
                    ResetHandBrake()
                else
                    handbrake = 100
                end
            end

            thisFrameVehicleSpeed = GetEntitySpeed(cache.vehicle) * 3.6
            currentvehicleBodyHealth = GetVehicleBodyHealth(cache.vehicle)
            if currentvehicleBodyHealth == 1000 and frameBodyChange ~= 0 then
                frameBodyChange = 0
            end
            if frameBodyChange ~= 0 then
                if lastFrameVehiclespeed > 110 and thisFrameVehicleSpeed < (lastFrameVehiclespeed * 0.75) and not damagedone then
                    if frameBodyChange > 18.0 then
                        if not seatbeltOn and not IsThisModelABike(cache.vehicle) then
                            if math.random(math.ceil(lastFrameVehiclespeed)) > 60 then
                                if not harnessOn then
                                    EjectFromVehicle()
                                else
                                    ToggleHarness()
                                end
                            end
                        elseif (seatbeltOn or harnessOn) and not IsThisModelABike(cache.vehicle) then
                            if lastFrameVehiclespeed > 150 then
                                if math.random(math.ceil(lastFrameVehiclespeed)) > 150 then
                                    if not harnessOn then
                                        EjectFromVehicle()
                                    else
                                        ToggleHarness()
                                    end
                                end
                            end
                        end
                    else
                        if not seatbeltOn and not IsThisModelABike(cache.vehicle) then
                            if math.random(math.ceil(lastFrameVehiclespeed)) > 60 then
                                if not harnessOn then
                                    EjectFromVehicle()
                                else
                                    ToggleHarness()
                                end
                            end
                        elseif (seatbeltOn or harnessOn) and not IsThisModelABike(cache.vehicle) then
                            if lastFrameVehiclespeed > 120 then
                                if math.random(math.ceil(lastFrameVehiclespeed)) > 200 then
                                    if not harnessOn then
                                        EjectFromVehicle()
                                    else
                                        ToggleHarness()
                                    end
                                end
                            end
                        end
                    end
                    damagedone = true
                    SetVehicleEngineOn(cache.vehicle, false, true, true)
                end
                if currentvehicleBodyHealth < 350.0 and not damagedone then
                    damagedone = true
                    SetVehicleEngineOn(cache.vehicle, false, true, true)
                    Wait(1000)
                end
            end
            if lastFrameVehiclespeed < 100 then
                Wait(100)
                tick = 0
            end
            frameBodyChange = newvehicleBodyHealth - currentvehicleBodyHealth
            if tick > 0 then
                tick -= 1
                if tick == 1 then
                    lastFrameVehiclespeed = GetEntitySpeed(cache.vehicle) * 3.6
                end
            else
                if damagedone then
                    damagedone = false
                    frameBodyChange = 0
                    lastFrameVehiclespeed = GetEntitySpeed(cache.vehicle) * 3.6
                end
                lastFrameVehiclespeed2 = GetEntitySpeed(cache.vehicle) * 3.6
                if lastFrameVehiclespeed2 > lastFrameVehiclespeed then
                    lastFrameVehiclespeed = GetEntitySpeed(cache.vehicle) * 3.6
                end
                if lastFrameVehiclespeed2 < lastFrameVehiclespeed then
                    tick = 25
                end

            end
            if tick < 0 then
                tick = 0
            end
            newvehicleBodyHealth = GetVehicleBodyHealth(cache.vehicle)
            if not modifierDensity then
                modifierDensity = true
            end
            veloc = GetEntityVelocity(cache.vehicle)
        else
            if lastVehicle then
                SetPedHelmet(cache.ped, true)
                Wait(200)
                newvehicleBodyHealth = GetVehicleBodyHealth(lastVehicle)
                if not damagedone and newvehicleBodyHealth < currentvehicleBodyHealth then
                    damagedone = true
                    SetVehicleEngineOn(lastVehicle, false, true, true)
                    Wait(1000)
                end
                lastVehicle = nil
            end
            lastFrameVehiclespeed2 = 0
            lastFrameVehiclespeed = 0
            newvehicleBodyHealth = 0
            currentvehicleBodyHealth = 0
            frameBodyChange = 0
            Wait(2000)
        end
    end
end)
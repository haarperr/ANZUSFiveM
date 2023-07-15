local DoesEntityExist = DoesEntityExist
local IsEntityInAir = IsEntityInAir
local GetEntityRoll = GetEntityRoll

CreateThread(function()
  while true do
    local sleep = 1000
    local vehicle = cache.vehicle
    local roll, class

    if not vehicle then goto continue end
    if not DoesEntityExist(vehicle) then goto continue end
    sleep = 200

    roll = GetEntityRoll(vehicle)
    if not IsEntityInAir(vehicle) and (roll < 75.0 or roll < -75.0) then goto continue end

    class = GetVehicleClass(vehicle)
    if class == 13 then goto continue end -- Cycles
    if class == 14 then goto continue end -- Boats
    if class == 15 then goto continue end -- Helicopters
    if class == 16 then goto continue end -- Planes
    sleep = 0

    DisableControlAction(0, 59, true) -- INPUT_VEH_MOVE_LR
    DisableControlAction(0, 60, true) -- INPUT_VEH_MOVE_UD
    DisableControlAction(0, 61, true) -- INPUT_VEH_MOVE_UP_ONLY
    DisableControlAction(0, 62, true) -- INPUT_VEH_MOVE_DOWN_ONLY
    DisableControlAction(0, 63, true) -- INPUT_VEH_MOVE_LEFT_ONLY
    DisableControlAction(0, 64, true) -- INPUT_VEH_MOVE_RIGHT_ONLY

    ::continue::
    Wait(sleep)
  end
end)

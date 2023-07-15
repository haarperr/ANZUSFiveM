local shot = false
local check = false
local check2 = false
local count = 0

local inVehicle = false

local GetFollowPedCamViewMode = GetFollowPedCamViewMode
local IsPlayerFreeAiming = IsPlayerFreeAiming
local SetFollowVehicleCamViewMode = SetFollowVehicleCamViewMode
local IsPedShooting = IsPedShooting

lib.onCache('vehicle', function(value)
  inVehicle = value

  CreateThread(function()
    while inVehicle do
      Wait(1)
      if IsPlayerFreeAiming(PlayerId()) then
        if GetFollowPedCamViewMode() == 4 and check == false then
          check = false
        else
          SetFollowVehicleCamViewMode(4)
          check = true
        end
      else
        if check == true then
          SetFollowVehicleCamViewMode(1)
          check = false
        end
      end
    end
  end)

  CreateThread(function()
    while inVehicle do
      Wait(1)
      if IsPedShooting(PlayerPedId()) and shot == false and GetFollowPedCamViewMode() ~= 4 then
        check2 = true
        shot = true
        SetFollowVehicleCamViewMode(4)
      end
      if IsPedShooting(PlayerPedId()) and shot == true and GetFollowPedCamViewMode() == 4 then
        count = 0
      end
      if not IsPedShooting(PlayerPedId()) and shot == true then
        count = count + 1
      end
      if not IsPedShooting(PlayerPedId()) and shot == true then
        if not IsPedShooting(PlayerPedId()) and shot == true and count > 20 then
          if check2 == true then
            check2 = false
            shot = false
            SetFollowVehicleCamViewMode(1)
          end
        end
      end
    end
  end)
end)

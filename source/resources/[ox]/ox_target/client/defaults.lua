if GetConvarInt('ox_target:defaults', 1) ~= 1 then return end

local api = require 'client.api'
local GetEntityBoneIndexByName = GetEntityBoneIndexByName
local GetEntityBonePosition_2 = GetEntityBonePosition_2
local GetVehicleDoorLockStatus = GetVehicleDoorLockStatus

local function toggleDoor(vehicle, door)
  if GetVehicleDoorLockStatus(vehicle) ~= 2 then
    if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
      SetVehicleDoorShut(vehicle, door, false)
    else
      SetVehicleDoorOpen(vehicle, door, false, false)
    end
  end
end

api.addGlobalVehicle({
  {
    name = 'ox_target:flipVehicle',
    icon = 'fa-solid fa-car-rear',
    label = "Unflip Vehicle",
    distance = 1.2,
    bones = { 'boot', 'bonnet', 'door_dside_f', 'seat_dside_f', 'door_pside_f', 'seat_pside_f', 'door_dside_r', 'seat_dside_r', 'door_pside_r', 'seat_pside_r' },
    canInteract = function(entity, distance, coords, name, boneId)
      if GetVehicleDoorLockStatus(entity) ~= 1 then return end
      return #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.9
    end,
    onSelect = function(data)
      if lib.progressActive() then return end
      if (lib.progressCircle({
            duration = 16000,
            label = "Unflipping Vehicle",
            position = 'bottom',
            canCancel = true,
            disable = {
              car = true,
              move = true,
              combat = true
            },
            anim = {
              dict = 'missfinale_c2ig_11',
              clip = 'pushcar_offcliff_f',
            }
          })) then
        -- Progress Done
        local vehicle = data.entity
        if not DoesEntityExist(vehicle) then return end
        SetVehicleOnGroundProperly(vehicle)
      else
        -- Canceled
        StopAnimTask(playerPed, "missfinale_c2ig_11", "pushcar_offcliff_f", -1)
      end
    end
  },
  {
    name = 'ox_target:seatIn',
    icon = 'fa-solid fa-car-side',
    label = locale('seat_into_vehicle'),
    distance = 1.2,
    canInteract = function(entity, distance, coords, name)
      if GetVehicleDoorLockStatus(entity) ~= 1 then return false end
      return true
    end,
    onSelect = function(data)
      exports.ag_police:seatIntoVehicle(data)
    end
  },
  {
    name = 'ox_target:seatOut',
    icon = 'fa-solid fa-car-side',
    label = locale('seat_out_vehicle'),
    distance = 1.2,
    canInteract = function(entity, distance, coords, name)
      if GetVehicleDoorLockStatus(entity) ~= 1 then return false end
      return true
    end,
    onSelect = function(data)
      exports.ag_police:seatOutVehicle(data)
    end
  },
  {
    name = 'ox_target:bonnet',
    icon = 'fa-solid fa-car',
    label = locale('toggle_hood'),
    bones = 'bonnet',
    distance = 1.2,
    canInteract = function(entity, distance, coords, name, boneId)
      if GetVehicleDoorLockStatus(entity) ~= 1 then return false end
      return #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.9
    end,
    onSelect = function(data)
      toggleDoor(data.entity, 4)
    end
  },
})

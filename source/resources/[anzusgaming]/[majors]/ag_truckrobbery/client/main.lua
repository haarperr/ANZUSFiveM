lib.locale()
local utils = require 'client.utils'

---Start truck robbery (closest player gets this)
---@param data {vehicle: number}
utils.registerNetEvent('ag_truckrobbery:client:initTruckRobbery', function(data)
  if not DoesEntityExist(NetworkGetEntityFromNetworkId(data.vehicle)) then return end

  local vehicle = NetworkGetEntityFromNetworkId(data.vehicle)
  Wait(100)

  lib.requestModel(`MP_M_SecuroGuard_01`)

  local driver = CreatePedInsideVehicle(vehicle, 4, `MP_M_SecuroGuard_01`, -1, true, false)
  SetPedFleeAttributes(guard, 0, false)
  SetPedCombatAttributes(guard, 46, true)
  SetPedCombatAbility(guard, 100)
  SetPedCombatMovement(guard, 2)
  SetPedCombatRange(guard, 2)
  SetPedKeepTask(guard, true)
  GiveWeaponToPed(guard, `WEAPON_GLOCK`, 250, false, true)
  SetPedAsCop(guard, true)

  local navigator = CreatePedInsideVehicle(vehicle, 4, `MP_M_SecuroGuard_01`, 0, true, false)
  SetPedFleeAttributes(navigator, 0, false)
  SetPedCombatAttributes(navigator, 46, true)
  SetPedCombatAbility(navigator, 100)
  SetPedCombatMovement(navigator, 2)
  SetPedCombatRange(navigator, 2)
  SetPedKeepTask(navigator, true)
  GiveWeaponToPed(navigator, `WEAPON_GLOCK`, 250, false, true)
  SetPedAsCop(navigator, true)

  local navigator2 = CreatePedInsideVehicle(vehicle, 4, `MP_M_SecuroGuard_01`, 1, true, false)
  SetPedFleeAttributes(navigator2, 0, false)
  SetPedCombatAttributes(navigator2, 46, true)
  SetPedCombatAbility(navigator2, 100)
  SetPedCombatMovement(navigator2, 2)
  SetPedCombatRange(navigator2, 2)
  SetPedKeepTask(navigator2, true)
  GiveWeaponToPed(navigator2, `WEAPON_GLOCK`, 250, false, true)
  SetPedAsCop(navigator2, true)

  TaskVehicleDriveWander(driver, vehicle, 30.0, 443)

  TriggerServerEvent('ag_truckrobbery:server:setGuards',
    { NetworkGetNetworkIdFromEntity(driver), NetworkGetNetworkIdFromEntity(navigator), NetworkGetNetworkIdFromEntity(navigator2) })
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
  lib.requestModel(`MP_M_SecuroGuard_01`)
end)

exports.ox_target:addModel({ `stockade` }, {
  {
    label = 'Blow Doors',
    icon = 'fa-solid fa-bomb',
    distance = 1.5,
    canInteract = function(entity, _, _, _, _)
      if GetEntityHealth(entity) == 0 and utils.canTruckBeRobbed(entity) then return false end
      if lib.progressActive() then return false end
      if utils.isBusy(entity) then return false end
      if utils.isRobbed(entity) then return false end
      local coords = GetEntityCoords(cache.ped)
      local boneCoords = GetWorldPositionOfEntityBone(entity, GetEntityBoneIndexByName(entity, 'door_pside_r'))
      if #(boneCoords - coords) < 4 then return true end
      return false
    end,
    items = 'thermite',
    onSelect = function(data)
      BlowDoor(data)
    end
  },
  {
    label = 'Grab Loot',
    distance = 1.5,
    canInteract = function(entity, _, _, _, _)
      if GetEntityHealth(entity) ~= 0 and not utils.canTruckBeRobbed(entity) then return false end
      if lib.progressActive() then return false end
      if utils.isBusy(entity) then return false end
      if utils.isRobbed(entity) then return false end
      return true
    end,
    onSelect = function(data)
      GrabLoot(data)
    end
  }
})

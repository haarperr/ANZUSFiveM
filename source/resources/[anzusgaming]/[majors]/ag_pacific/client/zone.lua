local points = {}
local inside = false

function CreateZoneAroundBank(coords)
  local point = lib.points.new({
    coords = coords,
    distance = 100,
    nearbyDone = false
  })

  function point:onEnter()
    local drill = lib.requestModel(`k4mb1_prop_thermaldrill`)
    inside = true
    for index, _ in ipairs(Config.Bank.vault) do
      ToggleVault(index)
    end

    local peds = lib.callback.await('ag_pacific:server:getPeds', false)
    local manager = NetworkGetEntityFromNetworkId(peds.manager)
    local t = 0

    repeat
      Wait(10)
      t += 1
    until DoesEntityExist(manager) or t >= 25

    TaskSetBlockingOfNonTemporaryEvents(manager, true)
    SetPedFleeAttributes(manager, 0, false)
    SetPedAsCop(manager, true)

    for _, v in pairs(peds.guards) do
      local entity = NetworkGetEntityFromNetworkId(v)
      local timeout = 0
      repeat
        Wait(10)
        timeout += 1
      until DoesEntityExist(entity) or timeout >= 25

      if GetPedArmour(entity) == 0 then
        SetPedArmour(entity, 100)
      end

      SetPedFleeAttributes(entity, 0, false)
      SetPedCombatAttributes(entity, 46, true)
      SetPedCombatAbility(entity, 2)
      SetPedCombatMovement(entity, 2)
      SetPedCombatRange(entity, 1)
      SetPedAlertness(entity, 3)
      SetPedAsCop(entity, true)
    end

    exports.ox_target:addLocalEntity({ manager }, {
      {
        icon = 'fa-solid fa-id-card-clip',
        label = locale('steal_security_card'),
        distance = 2,
        canInteract = function(e, _, _, _, _)
          if Config.KeycardStolen then return false end

          local health = GetEntityHealth(e)
          if health > 10 then return false end
          return true
        end,
        onSelect = function()
          TriggerServerEvent('ag_pacific:server:stealSecurityCard')
          TriggerServerEvent('ag_pacific:server:setManagerDead')
        end,
      }
    })

    local zone = { x = 262.87, y = 219.67, z = 106.26 }
    local ZoneVec = vector3(262.87, 219.67, 106.26)
    local interiorId = GetInteriorAtCoords(zone.x, zone.y, zone.z)

    CreateThread(function()
      while inside do
        local portalFlag = GetInteriorPortalFlag(interiorId, 19)
        local PlayerVec = GetEntityCoords(PlayerPedId())
        local dist = #(PlayerVec.xy - ZoneVec.xy)

        if dist <= 10 and portalFlag == 64 then
          SetInteriorPortalFlag(interiorId, 19, 0)
          RefreshInterior(interiorId)
        end

        Wait(1500)
      end
    end)
  end

  function point:onExit()
    inside = false
    self.nearbyDone = false
  end

  function point:nearby()
    if self.nearbyDone then return end
    print('nearby')
    for index, _ in ipairs(Config.Bank.vault) do
      ToggleVault(index)
    end
    self.nearbyDone = true
  end

  points[#points + 1] = point
end

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_pacific:client:stealSecurityCard', function(data)
  Config.Banks[data.key].manager.stolen = data.bool
end)

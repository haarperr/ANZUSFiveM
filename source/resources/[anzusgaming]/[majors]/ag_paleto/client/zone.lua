local points = {}
local inside = false


function CreateZoneAroundBank(key, coords)
  ToggleVault(key)

  local point = lib.points.new({
    coords = coords,
    distance = 50,
    key = key,
    nearbyDone = false,
    object = nil
  })

  function point:onEnter()
    ToggleVault(self.key)
    inside = true
    local zone = { x = -104.37, y = 6468.01, z = 31.62 }
    local ZoneVec = vector3(-104.37, 6468.01, 31.62)
    local interiorId = GetInteriorAtCoords(zone.x, zone.y, zone.z)

    CreateThread(function()
      while inside do
        local portalFlag = GetInteriorPortalFlag(interiorId, 2)
        local PlayerVec = GetEntityCoords(PlayerPedId())
        local dist = #(PlayerVec.xy - ZoneVec.xy)

        if dist <= 8 and portalFlag == 64 then
          SetInteriorPortalFlag(interiorId, 2, 0)
          RefreshInterior(interiorId)
        end

        Wait(1500)
      end
    end)
  end

  function point:onExit()
    self.nearbyDone = false
    inside = false
  end

  function point:nearby()
    if self.nearbyDone then return end
    ToggleVault(self.key)
    self.nearbyDone = true
  end

  points[#points + 1] = point
end

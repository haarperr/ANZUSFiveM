local points = {}

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
  end

  function point:onExit()
    self.nearbyDone = false
  end

  function point:nearby()
    if self.nearbyDone then return end
    ToggleVault(self.key)
    self.nearbyDone = true
  end

  points[#points + 1] = point
end

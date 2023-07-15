local points = {}

local function setup(key)
  local config = Config.Banks[key]
  lib.requestModel(config.manager.model)

  local manager = lib.callback.await('ag_fleeca:getManagerNet', false, key)
  if not manager then return end

  if config.manager.dead then return end
  local entity = NetworkGetEntityFromNetworkId(manager.netid)
  TaskStartScenarioInPlace(NetworkGetEntityFromNetworkId(manager.netid), config.manager.anim, 0, true)

  exports.ox_target:addLocalEntity({ entity }, {
    {
      icon = 'fa-solid fa-id-card-clip',
      label = locale('steal_security_card'),
      distance = 2,
      canInteract = function(e, _, _, _, _)
        if GlobalState.fleecaData.cooldown and GlobalState.fleecaData.allowedBank ~= key then return false end
        if Config.Banks[key].manager.stolen then return false end

        local health = GetEntityHealth(e)
        if health > 10 then return false end
        return true
      end,
      onSelect = function()
        TriggerServerEvent('ag_fleeca:server:stealSecurityCard', key)
        TriggerServerEvent('ag_fleeca:server:setManagerDead', { key = key })
      end,
    }
  })
end

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
    self.object = CreateObject(Config.Banks[key].cameracontrol.model, Config.Banks[key].cameracontrol.coords, Config.Banks[key].cameracontrol.coords.w)

    setup(self.key)
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

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_fleeca:client:stealSecurityCard', function(data)
  Config.Banks[data.key].manager.stolen = data.bool
end)

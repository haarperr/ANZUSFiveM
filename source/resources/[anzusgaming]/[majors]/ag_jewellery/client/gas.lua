GasEnabled = false
CannistersBroken = false
local inRange = false

local function startGas()
  CreateThread(function()
    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
      Wait(10)
    end

    local Gas, Gas2, Gas3, Gas4, Gas5
    while GasEnabled and inRange do
      UseParticleFxAsset("core")
      Gas = StartParticleFxLoopedAtCoord("veh_respray_smoke", -622.92, -225.64, 40.28, 0.0, 0.0, 0.0, 0.80, false, false, false, false)
      UseParticleFxAsset("core")
      Gas2 = StartParticleFxLoopedAtCoord("veh_respray_smoke", -623.44, -227.84, 40.28, 0.0, 0.0, 0.0, 0.80, false, false, false, false)
      UseParticleFxAsset("core")
      Gas3 = StartParticleFxLoopedAtCoord("veh_respray_smoke", -617.56, -233.2, 40.4, 0.0, 0.0, 0.0, 0.80, false, false, false, false)
      UseParticleFxAsset("core")
      Gas4 = StartParticleFxLoopedAtCoord("veh_respray_smoke", -618.6, -233.24, 40.4, 0.0, 0.0, 0.0, 0.80, false, false, false, false)
      UseParticleFxAsset("core")
      Gas5 = StartParticleFxLoopedAtCoord("veh_respray_smoke", -625.52, -237.32, 40.28, 0.0, 0.0, 0.0, 0.80, false, false, false, false)
      Wait(5000)
      StopParticleFxLooped(Gas, false)
      StopParticleFxLooped(Gas2, false)
      StopParticleFxLooped(Gas3, false)
      StopParticleFxLooped(Gas4, false)
      StopParticleFxLooped(Gas5, false)
    end
  end)
end

RegisterNetEvent('ag_jewellery:client:setGas', function(bool)
  GasEnabled = bool

  if bool then
    startGas()
  end
end)

function SetupGasWithinRange()
  local point = lib.points.new({
    coords = Config.Jewellery.centre,
    distance = 60,
  })

  function point:onEnter()
    if GasEnabled then
      inRange = true
      startGas()
    end
  end

  function point:onExit()
    inRange = false
  end
end

local function destroyCannister(key)
  local config = Config.Jewellery.vent[key]
  exports['ps-ui']:Scrambler(function(success)
    if true then
      TriggerServerEvent('ag_jewellery:server:removeItem', 'thermite')

      lib.requestAnimDict("anim@heists@ornate_bank@thermal_charge")
      lib.requestModel(`hei_p_m_bag_var22_arm_s`)
      lib.requestModel(`prop_bomb_01`)

      local ped = cache.ped
      local pedCoords = GetEntityCoords(cache.ped)

      SetEntityHeading(ped, config.scene.heading)
      Wait(100)
      local rot = vec3(GetEntityRotation(ped))
      local bagscene = NetworkCreateSynchronisedScene(config.scene.loc.x + config.scene.px, config.scene.loc.y + config.scene.py, config.scene.loc.z, rot.x, rot.y, rot.z, 2, false,
        false, 1065353216,
        0, 1.3)
      local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, config.scene.loc.x, config.scene.loc.y, config.scene.loc.z, true, true, false)

      NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
      NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
      SetPedComponentVariation(ped, 5, 0, 0, 0)
      NetworkStartSynchronisedScene(bagscene)
      Wait(1500)

      local plantObject = CreateObject(`hei_prop_heist_thermite`, pedCoords.x, pedCoords.y, pedCoords.z, true, true, false)
      NetworkRequestControlOfEntity(plantObject)

      repeat
        Wait(0)
      until NetworkHasControlOfEntity(plantObject)

      SetEntityCollision(plantObject, false, true)
      AttachEntityToEntity(plantObject, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0.0, 0.0, 200.0, true, true, false, true, 1, true)

      DeleteObject(bag)
      DetachEntity(plantObject, true, true)
      FreezeEntityPosition(plantObject, true)

      NetworkStopSynchronisedScene(bagscene)
      lib.notify({ type = 'warning', description = locale('timer_cannister') })
      Wait(10000)
      DeleteObject(plantObject)
      ClearAreaOfObjects(pedCoords.x, pedCoords.y, pedCoords.z, 1, 0)

      UseParticleFxAsset("core")
      local smoke = StartParticleFxLoopedAtCoord("exp_air_blimp", config.scene.loc.x, config.scene.loc.y, config.scene.loc.z, 0.0, 0.0, 0.0, 6.0, false, false, false, false)
      SetParticleFxLoopedAlpha(smoke, 0.8)
      SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, false)
      AddExplosion(config.scene.loc.x, config.scene.loc.y, config.scene.loc.z, 4, 0.0, true, false, 3.0)
      exports['ps-dispatch']:Explosion()
      TriggerServerEvent('ag_jewellery:server:destroyCannister')
    else
      TriggerServerEvent('ag_jewellery:server:setCannisterBusy', { key = key, bool = false })
    end
  end, "runes", 15, 0)
end

function SetupCannister(key)
  local config = Config.Jewellery.vent[key]

  exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        name = ('ag_jewellery:cannister%s'):format(k),
        label = 'Disable Vent',
        icon = 'fa-solid fa-mask-ventilator',
        items = 'thermite',
        canInteract = function()
          return not Config.Jewellery.vent[key].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_jewellery:server:setCannisterBusy', { key = key, bool = true })
          destroyCannister(key)
        end,
        distance = 1
      }
    }
  })
end

---@param data {key: number, bool: boolean}
RegisterNetEvent('ag_jewellery:client:setCannisterBusy', function(data)
  Config.Jewellery.vent[data.key].busy = data.bool
end)

---@param bool boolean
RegisterNetEvent('ag_jewellery:client:setCannistersBroken', function(bool)
  CannistersBroken = bool
end)

local cameraControls = {}
local cameraZones = {}

local function disableCameras(data, key)
  local entity = data.entity
  local entityHeading = GetEntityHeading(entity)
  SetEntityHeading(cache.ped, entityHeading)

  local success = lib.progressCircle({
    duration = 15000,
    label = locale('camera_tamper'),
    canCancel = true,
    disable = {
      move = true,
      car = true,
      combat = true
    },
    anim = {
      scenario = 'WORLD_HUMAN_STAND_MOBILE'
    }
  })

  if not success then return end

  exports['ps-ui']:Maze(function(success)
    if success then
      TriggerServerEvent('ag_fleeca:server:disableCameras', key)
      lib.notify({ type = 'success', description = locale('camera_tamper_success') })
    else
      lib.notify({ type = 'error', description = locale('camera_tamper_fail') })
      if PoliceAlerted then return end
      if math.random() < 0.11 then
        exports['ps-dispatch']:SuspiciousActivity()
      end
    end
  end, 20)
end

function SetupCameraControlZone(key, coords)
  lib.requestModel(`ch_prop_ch_fuse_box_01a`)
  cameraControls[#cameraControls + 1] = exports.ox_target:addSphereZone({
    coords = coords,
    radius = 0.32,
    debug = false,
    options = {
      {
        label = 'Disable Cameras',
        icon = 'fa-solid fa-video',
        distance = 1,
        canInteract = function()
          if GlobalState.fleecaData.cooldown and GlobalState.fleecaData.allowedBank ~= key then return false end
          if lib.progressActive() then return false end
          if Config.Banks[key].cameracontrol.disabled then return false end
          return true
        end,
        onSelect = function(data)
          if not IsEnoughPoliceAvailable() then return end
          disableCameras(data, key)
        end
      }
    }
  })
end

function SetupCameraZone(key, coords, size, rotation)
  cameraZones[#cameraZones + 1] = lib.zones.box({
    coords = coords,
    size = size,
    rotation = rotation or 0,
    debug = false,
    onEnter = function()
      if GlobalState.fleecaData.cooldown and GlobalState.fleecaData.allowedBank ~= key then return false end
      if Config.Banks[key].cameracontrol.disabled then return false end
      if PoliceAlerted then return end

      local has, weaponHash = GetCurrentPedWeapon(cache.ped, true)
      if not has or weaponHash == `WEAPON_UNARMED` then return end

      TriggerServerEvent('ag_fleeca:server:alertPolice')
      exports['ps-dispatch']:SuspiciousActivity()

      lib.notify({ type = 'warning', description = locale('spotted') })
    end,
  })
end

function DestroyCameraZones()
  for _, v in pairs(cameraControls) do
    exports.ox_target:removeZone(v)
  end
  for _, v in pairs(cameraZones) do
    v:remove()
  end
end

---@param key number
---@param index number
local function openLocker(key, index)
  lib.requestModel(`hei_prop_heist_drill`)
  local pos = GetEntityCoords(cache.ped)
  local DrillObject = CreateObject(`hei_prop_heist_drill`, pos.x, pos.y, pos.z, true, true, true)
  AttachEntityToEntity(DrillObject, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)

  local success = lib.progressCircle({
    duration = math.random(Config.LockboxTime.min, Config.LockboxTime.max),
    label = locale('drilling'),
    canCancel = true,
    disable = {
      move = true,
      car = true,
      combat = true
    },
    position = 'bottom',
    anim = {
      dict = 'anim@heists@fleeca_bank@drilling',
      clip = 'drill_straight_idle',
      flag = 1
    },
  })

  DetachEntity(DrillObject, true, true)
  DeleteEntity(DrillObject)
  ClearAreaOfObjects(pos.x, pos.y, pos.z, 1, 0)
  if not success then
    lib.notify({ type = 'error', description = locale('failed_lockbox') })
    return TriggerServerEvent('ag_fleeca:server:setLockboxBusy', { key = key, index = index, bool = false })
  end

  TriggerServerEvent('ag_fleeca:server:removeItem', 'drill')
  lib.notify({ type = 'success', description = locale('success_lockbox') })
  TriggerServerEvent('ag_fleeca:server:rewardItem', { type = 'lockbox', key = key, index = index })
end

---@param key number
---@param index number
function CreateLockboxTarget(key, index)
  local config = Config.Banks[key].lockbox[index]

  exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        name = ('ag_fleeca:locker%d%d'):format(key, index),
        label = locale('use_drill'),
        icon = 'fa-solid fa-file-shield',
        items = 'drill',
        canInteract = function()
          if GlobalState.fleecaData.cooldown and GlobalState.fleecaData.allowedBank ~= key then return false end
          if Config.Banks[key].lockbox[index].busy then return false end
          return true
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_fleeca:server:setLockboxBusy', { key = key, index = index, bool = true })
          openLocker(key, index)
        end,
        distance = 1
      }
    },
  })
end

---@param data {key: number, index: number, bool: boolean}
RegisterNetEvent('ag_fleeca:client:setLockboxBusy', function(data)
  Config.Banks[data.key].lockbox[data.index].busy = data.bool
end)

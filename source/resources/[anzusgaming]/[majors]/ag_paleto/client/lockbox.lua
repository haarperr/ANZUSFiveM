---@param index number
local function openLocker(index)
  lib.requestModel(`hei_prop_heist_drill`)
  local pos = GetEntityCoords(cache.ped)
  local DrillObject = CreateObject(`hei_prop_heist_drill`, pos.x, pos.y, pos.z, true, true, true)
  AttachEntityToEntity(DrillObject, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)

  local success = lib.progressCircle({
    duration = math.random(2, 4444),
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
    return TriggerServerEvent('ag_paleto:server:setBusy', { key = 'lockbox', index = index, bool = false })
  end

  TriggerServerEvent('ag_paleto:server:removeItem', 'drill')
  lib.notify({ type = 'success', description = locale('success_lockbox') })
  TriggerServerEvent('ag_paleto:server:getReward', { key = 'lockbox', index = index })
end

function SetupLockboxZone(index)
  local config = Config.Paleto.lockbox[index]

  exports.ox_target:addBoxZone({
    coords = config.coords,
    size = config.size,
    rotation = config.rotation,
    options = {
      {
        label = 'Drill Lockbox',
        items = 'drill',
        canInteract = function()
          return not Config.Paleto.lockbox[index].busy
        end,
        onSelect = function()
          if not IsEnoughPoliceAvailable() then return end
          TriggerServerEvent('ag_paleto:server:setBusy', { key = 'lockbox', index = index, bool = true })
          openLocker(index)
        end,
        distance = 0.75
      }
    },
  })
end

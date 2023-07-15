local box = nil
local hasBox = false

local barrel = nil
local hasBarrel = false

local function AttachBoxToPed()
  local dict = "anim@heists@box_carry@"
  local model = `prop_cs_cardbox_01`

  lib.requestAnimDict(dict, 500)
  TaskPlayAnim(cache.ped, dict, "idle", 5.0, -1, -1, 50, 0, false, false, false)

  local pos = GetEntityCoords(cache.ped, true)
  lib.requestModel(model, 500)

  local object = CreateObject(model, pos.x, pos.y, pos.z, true, true, true)
  AttachEntityToEntity(object, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.1, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
  box = object
  hasBox = true

  CreateThread(function()
    while hasBox do
      Wait(3)
      SetPlayerSprint(cache.ped, false)
      DisableControlAction(0, 21, true)
      if not IsEntityPlayingAnim(cache.ped, dict, "idle", 3) then
        TaskPlayAnim(cache.ped, dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
      end
    end
  end)
end

local function RemoveBoxFromPed()
  StopAnimTask(cache.ped, "anim@heists@box_carry@", "idle", 1.0)
  DisableControlAction(0, 21, false)
  DetachEntity(box, true, true)
  DeleteObject(box)
  hasBox = false
end

local function AttachBarrelToPed()
  local dict = "anim@heists@box_carry@"
  local model = `prop_barrel_01a`

  lib.requestAnimDict(dict, 500)
  TaskPlayAnim(cache.ped, dict, "idle", 5.0, -1, -1, 50, 0, false, false, false)

  local pos = GetEntityCoords(cache.ped, true)
  lib.requestModel(model, 500)

  local object = CreateObject(model, pos.x, pos.y, pos.z, true, true, true)
  AttachEntityToEntity(object, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.1, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
  barrel = object
  hasBarrel = true

  CreateThread(function()
    while hasBarrel do
      Wait(3)
      SetPlayerSprint(cache.ped, false)
      DisableControlAction(0, 21, true)
      if not IsEntityPlayingAnim(cache.ped, dict, "idle", 3) then
        TaskPlayAnim(cache.ped, dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
      end
    end
  end)
end

local function RemoveBarrelFromPed()
  print('remove')
  StopAnimTask(cache.ped, "anim@heists@box_carry@", "idle", 1.0)
  DisableControlAction(0, 21, false)
  DetachEntity(barrel, true, true)
  DeleteObject(barrel)
  barrel = nil
  hasBarrel = false
end

---@param toggle boolean
RegisterNetEvent('ag_misc:client:crate', function(toggle)
  if toggle then AttachBoxToPed() else RemoveBoxFromPed() end
end)

---@param toggle boolean
RegisterNetEvent('ag_misc:client:barrel_methylamine', function(toggle)
  print(toggle)
  if toggle then AttachBarrelToPed() else RemoveBarrelFromPed() end
end)

lib.callback.register('ag_misc:client_combine', function()
  local success = lib.progressCircle({
    duration = 2000,
    label = 'Combining..',
    useWhileDead = false,
    canCancel = true,
    disable = {
      car = true,
      combat = true,
    },
    anim = {
      dict = 'amb@prop_human_parking_meter@male@base',
      clip = 'base'
    },
  })

  return success
end)

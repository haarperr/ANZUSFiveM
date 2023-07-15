local IsEntityAttachedToEntity = IsEntityAttachedToEntity

---@param civ boolean Is being executed from civ menu (only allows zipties)
function EscortPlayer(civ)
  if LocalPlayer.state.invBusy then return end

  local _, ped = lib.getClosestPlayer(GetEntityCoords(cache.ped))

  if not ped then return lib.notify({ description = 'No one nearby', type = 'error' }) end

  local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
  local target = Player(playerId).state

  if civ and (not target.isZiptied or target.isCuffed) then return lib.notify({ description = 'Target is not wearing zipties', type = 'error' }) end
  if not target.isCuffed and not target.isZiptied then return lib.notify({ description = 'Target is not bound', type = 'error' }) end

  TriggerServerEvent('ag_police:server:setPlayerEscort', playerId, not IsEntityAttachedToEntity(ped, cache.ped))
end

exports('EscortPlayer', EscortPlayer)

local isEscorted = LocalPlayer.state.isEscorted
local AttachEntityToEntity = AttachEntityToEntity
local IsPedWalking = IsPedWalking
local IsEntityPlayingAnim = IsEntityPlayingAnim
local IsPedRunning = IsPedRunning
local IsPedSprinting = IsPedSprinting
local TaskPlayAnim = TaskPlayAnim
local StopAnimTask = StopAnimTask
local EnableControlAction = EnableControlAction
local DisableAllControlActions = DisableAllControlActions

local function escortActions()
  DisableAllControlActions(0)
  EnableControlAction(0, 1, true)
  EnableControlAction(0, 2, true)
  EnableControlAction(0, 245, true)
  EnableControlAction(0, 38, true)
  EnableControlAction(0, 322, true)
  EnableControlAction(0, 249, true)
  EnableControlAction(0, 46, true)
end

---@param serverId number
local function setEscorted(serverId)
  local dict = 'anim@move_m@prisoner_cuffed'
  local dict2 = 'anim@move_m@trash'

  while isEscorted do
    local player = GetPlayerFromServerId(serverId)
    local ped = player > 0 and GetPlayerPed(player)

    if not ped then break end

    if not IsEntityAttachedToEntity(cache.ped, ped) then
      AttachEntityToEntity(cache.ped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, true, true, 2, true)
    end

    if IsPedWalking(ped) then
      if not IsEntityPlayingAnim(cache.ped, dict, 'walk', 3) then
        lib.requestAnimDict(dict)
        TaskPlayAnim(cache.ped, dict, 'walk', 8.0, -8, -1, 1, 0.0, false, false, false)
      end
    elseif IsPedRunning(ped) or IsPedSprinting(ped) then
      if not IsEntityPlayingAnim(cache.ped, dict2, 'run', 3) then
        lib.requestAnimDict(dict2)
        TaskPlayAnim(cache.ped, dict2, 'run', 8.0, -8, -1, 1, 0.0, false, false, false)
      end
    else
      StopAnimTask(cache.ped, dict, 'walk', -8.0)
      StopAnimTask(cache.ped, dict2, 'run', -8.0)
    end

    escortActions()
    Wait(0)
  end

  RemoveAnimDict(dict)
  RemoveAnimDict(dict2)
  LocalPlayer.state:set('isEscorted', false, true)
end

AddStateBagChangeHandler('isEscorted', ('player:%s'):format(cache.serverId), function(_, _, value)
  isEscorted = value

  if IsEntityAttached(cache.ped) then
    DetachEntity(cache.ped, true, false)
  end

  if value then setEscorted(value) end
end)

if isEscorted then
  CreateThread(function()
    setEscorted(isEscorted)
  end)
end

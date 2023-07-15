-- Set to locals for faster calls
local playerState = LocalPlayer.state
local Wait = Wait
local TaskPlayAnim = TaskPlayAnim
local breaks = 0
local handsup = false

local function getRandomKeys()
    local result = {}
    for i = 1, 4 do
        local rand = math.random(1, #Config.BreakoutCuffKeys)
        result[#result+1] = Config.BreakoutCuffKeys[rand]
        table.remove(Config.BreakoutCuffKeys, rand)
    end

    return result
end

local keys = getRandomKeys()

local function remove(type)
    if LocalPlayer.state.invBusy then return end
    if cache.vehicle then return end

    local _, ped = lib.getClosestPlayer(GetEntityCoords(cache.ped))

    if not ped then return lib.notify({ description = 'No one nearby', type = 'error' }) end

    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
    local target = Player(playerId).state

    if type == 'ziptie' then
        if not target.isZiptied or target.isCuffed then return lib.notify({ description = 'Target is not ziptied', type = 'error' }) end
    elseif type == 'cuff' then
        if target.isZiptied or not target.isCuffed then return lib.notify({ description = 'Unable to perform this action', type = 'error' }) end
    end

    if type == 'ziptie' then
        local state = lib.callback.await('ag_police:setPlayerRemoveZiptie', 200, playerId)
        if state.isZiptied == nil and state.cuffType == nil then return end
    elseif type == 'cuff' then
        local state = lib.callback.await('ag_police:setPlayerUnCuff', 200, playerId)
        if state.isCuffed == nil and state.cuffType == nil then return end
    end

    LocalPlayer.state.invBusy = true

    FreezeEntityPosition(cache.ped, true)
    SetCurrentPedWeapon(cache.ped, `WEAPON_UNARMED`, true)
    AttachEntityToEntity(cache.ped, ped, 11816, -0.07, -0.58, 0.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)

    local dict = 'mp_arresting'
    lib.requestAnimDict(dict)
    TaskPlayAnim(cache.ped, dict, 'a_uncuff', 8.0, -8, 5500, 0, 0, false, false, false)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
    Wait(5500)

    DetachEntity(cache.ped, true, false)
    FreezeEntityPosition(cache.ped, false)
    RemoveAnimDict(dict)

    LocalPlayer.state.invBusy = false
end

local function removeZipties()
    remove('ziptie')
end

exports('removeZipties', removeZipties)

function unCuffPlayer()
    remove('cuff')
end

local function ziptiePlayer()
  if LocalPlayer.state.invBusy then return end
  if cache.vehicle then return end

  local id, ped = lib.getClosestPlayer(GetEntityCoords(cache.ped))
  if not id then return lib.notify({ description = 'No one nearby', type = 'error' }) end

  local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
  local target = Player(playerId).state
  if target.isCuffed then return end
	if (not target.isZiptied and not IsEntityPlayingAnim(ped, 'random@arrests@busted', 'idle_a', 3)) then return lib.notify({ description = 'Target must have their handsup', type = 'error' }) end

  local response = lib.callback.await('ag_police:setPlayerZiptie', 200, playerId)
  if not response then return lib.notify({ description = 'Unable to get player', type = 'error' })  end

  if response.cuffType == 'HARD' then return lib.notify({ description = 'This player is already hard cuffed', type = 'error' }) end
  if response.isZiptied == nil and response.cuffType == nil then return end

  LocalPlayer.state.invBusy = true

  FreezeEntityPosition(cache.ped, true)
  SetCurrentPedWeapon(cache.ped, `WEAPON_UNARMED`, true)
  AttachEntityToEntity(cache.ped, ped, 11816, -0.07, -0.58, 0.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)

  local dict = 'mp_arrest_paired'
  lib.requestAnimDict(dict)
  TaskPlayAnim(cache.ped, dict, 'cop_p2_back_right', 8.0, -8.0, 3750, 2, 0.0, false, false, false)
  TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
  Wait(3750)

  DetachEntity(cache.ped, true, false)
  FreezeEntityPosition(cache.ped, false)
  RemoveAnimDict(dict)

  LocalPlayer.state.invBusy = false
end
exports('ziptiePlayer', ziptiePlayer)

local function cuffPlayer()
  if LocalPlayer.state.invBusy then return end
  if cache.vehicle then return end

  local id, ped = lib.getClosestPlayer(GetEntityCoords(cache.ped))

  if not id then return lib.notify({ description = 'No one nearby', type = 'error' }) end

  local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
  local target = Player(playerId).state

  if target.isZiptied then return lib.notify({ description = 'Unable to perform this action', type = 'error' }) end
  if target.cuffType == 'HARD' then return lib.notify({ description = 'This player is already hard cuffed', type = 'error' }) end

  local state = lib.callback.await('ag_police:setPlayerCuffs', 200, playerId)
  if not state then return end
  if state.isCuffed == nil and state.cuffType == nil then return end

  LocalPlayer.state.invBusy = true

  FreezeEntityPosition(cache.ped, true)
  SetCurrentPedWeapon(cache.ped, `WEAPON_UNARMED`, true)
  AttachEntityToEntity(cache.ped, ped, 11816, -0.07, -0.58, 0.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)

  local dict = 'mp_arrest_paired'
  lib.requestAnimDict(dict)
  TaskPlayAnim(cache.ped, dict, 'cop_p2_back_right', 8.0, -8.0, 3750, 2, 0.0, false, false, false)
  TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
  Wait(3750)

  DetachEntity(cache.ped, true, false)
  FreezeEntityPosition(cache.ped, false)
  RemoveAnimDict(dict)

  LocalPlayer.state.invBusy = false
end

exports('cuffPlayer', cuffPlayer)

local isCuffed = playerState.isCuffed
local isZiptied = playerState.isZiptied
local cuffType = playerState.cuffType
local IsEntityPlayingAnim = IsEntityPlayingAnim
local DisablePlayerFiring = DisablePlayerFiring
local DisableControlAction = DisableControlAction

local function DisableControls(value)
  DisableControlAction(0, 24, value)  -- Attack
  DisableControlAction(0, 257, value) -- Attack 2
  DisableControlAction(0, 25, value)  -- Aim
  DisableControlAction(0, 263, value) -- Melee Attack 1

  DisableControlAction(0, 45, value)  -- Reload
  DisableControlAction(0, 22, value)  -- Jump
  DisableControlAction(0, 44, value)  -- Cover
  DisableControlAction(0, 37, value)  -- Select Weapon
  DisableControlAction(0, 23, value)  -- Also 'enter'?

  DisableControlAction(0, 288, value) -- Disable phone
  DisableControlAction(0, 289, value) -- Inventory
  DisableControlAction(0, 170, value) -- Animations
  DisableControlAction(0, 167, value) -- Job

  DisableControlAction(0, 26, value)  -- Disable looking behind
  DisableControlAction(0, 73, value)  -- Disable clearing animation
  DisableControlAction(2, 199, value) -- Disable pause screen

  DisableControlAction(0, 59, value)  -- Disable steering in vehicle
  DisableControlAction(0, 71, value)  -- Disable driving forward in vehicle
  DisableControlAction(0, 72, value)  -- Disable reversing in vehicle

  DisableControlAction(2, 36, value)  -- Disable going stealth
  DisableControlAction(0, 38, value)  -- Disable pickup (and open doors)

  DisableControlAction(0, 264, value) -- Disable melee
  DisableControlAction(0, 257, value) -- Disable melee
  DisableControlAction(0, 140, value) -- Disable melee
  DisableControlAction(0, 141, value) -- Disable melee
  DisableControlAction(0, 142, value) -- Disable melee
  DisableControlAction(0, 143, value) -- Disable melee
  DisableControlAction(0, 75, value)  -- Disable exit vehicle
  DisableControlAction(27, 75, value) -- Disable exit vehicle
  EnableControlAction(0, 249, true)  -- Added for talking while cuffed
  EnableControlAction(0, 46, true)   -- Added for talking while cuffed
  EnableControlAction(0, 200, true)   -- INPUT_FRONTEND_PAUSE_ALTERNATE
  EnableControlAction(0, 199, true)   -- INPUT_FRONTEND_PAUSE
end

local function whileCuffed()
  local ped = cache.ped
  if isCuffed or isZiptied then
    lib.removeRadialItem('walking')
  end

  while isCuffed or isZiptied do
    local dict = 'mp_arresting'
    if not IsEntityPlayingAnim(ped, dict, 'idle', 3) then
      lib.requestAnimDict(dict)
      TaskPlayAnim(ped, dict, 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
    end

    if cuffType == 'HARD' then
      FreezeEntityPosition(ped, true)
    end

    DisableControlAction(0, 21, true)  -- Run
    DisableControls(true)
    DisablePlayerFiring(cache.playerId, true)
    Wait(0)
  end

  FreezeEntityPosition(ped, false)
  DisableControlAction(0, 21, false)  -- Run
  DisableControls(false)
  DisablePlayerFiring(cache.playerId, false)
  ClearPedTasks(ped)
  RemoveAnimDict(dict)

  lib.addRadialItem({
    {
      id = 'walking',
      label = 'Walk Style',
      icon = 'walking',
      menu = 'walking_menu'
    }
  })
end


local function stateChange(value, type)
  local ped = cache.ped

  SetEnableHandcuffs(ped, value)
    --SetEnableBoundAnkles(ped, value)
  local compare = isCuffed

  if type == 'ziptie' then compare = isZiptied end

  if compare ~= value then
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    FreezeEntityPosition(ped, true)

    LocalPlayer.state.invBusy = value
    exports['npwd']:setPhoneDisabled(value)
    if value then
      lib.requestAnimDict('mp_arrest_paired')
      TaskPlayAnim(ped, 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750, 2, 0, false, false, false)
      TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
      local success = false
      if type == 'cuff' then
        success = breaks < 4 and lib.skillCheck({ 'medium', 'medium' }, keys) or false
      end

      if success then
        ClearPedTasks(ped)
        playerState:set('isCuffed', false, true)
        playerState:set('cuffType', 'NONE', true)
        breaks += 1
      else
        Wait(150)
        lib.requestAnimDict('mp_arresting')
        TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
      end
    RemoveAnimDict('mp_arrest_paired')
    elseif compare and not value then
      TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
      Wait(5550)
    end

    FreezeEntityPosition(ped, false)
    if type == 'ziptie' then
      isZiptied = value
    else
      isCuffed = value
    end
  end

  if type == 'ziptie' then
    isZiptied = value
  else
    isCuffed = value
  end

  if value then
    CreateThread(whileCuffed)
  end
end

RegisterCommand('hu', function()
  local ped = cache.ped
  local animDict = "random@arrests@busted"
  local anim = "idle_a"

  if not HasAnimDictLoaded(animDict) then
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
      Wait(10)
    end
  end

  handsup = not handsup
  if LocalPlayer.state.isCuffed or LocalPlayer.state.isZiptied then return end
  if handsup then
    TaskPlayAnim(ped, animDict, anim, 8.0, 8.0, -1, 50, 0, false, false, false)
    while handsup do
      DisableControls(true)
      Wait(0)
    end
  else
    DisableControls(false)
    ClearPedTasks(ped)
  end
end, false)

RegisterKeyMapping('hu', 'Put your hands up', 'KEYBOARD', 'F2')

AddStateBagChangeHandler('isZiptied', ('player:%s'):format(cache.serverId), function(_, _, value)
  stateChange(value, 'ziptie')
end)

AddStateBagChangeHandler('isCuffed', ('player:%s'):format(cache.serverId), function(_, _, value)
  stateChange(value, 'cuff')
end)

AddStateBagChangeHandler('cuffType', ('player:%s'):format(cache.serverId), function(_, _, value)
  cuffType = value
  if value == 'NONE' or value == nil then return end

  FreezeEntityPosition(cache.ped, true)
  Wait(3750)
  FreezeEntityPosition(cache.ped, false)
end)

playerState.isZiptied = isZiptied
playerState.isCuffed = isCuffed
playerState.cuffType = cuffType

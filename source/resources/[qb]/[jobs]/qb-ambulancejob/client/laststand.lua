local isEscorting = false

---blocks until ped is no longer moving
---@param ped number
function WaitForPedToStopMoving(ped)
  while GetEntitySpeed(ped) > 0.5 or IsPedRagdoll(ped) do Wait(10) end
end

---resurrect player
---@param ped number
function ResurrectPlayer(ped)
  local pos = GetEntityCoords(ped)
  local heading = GetEntityHeading(ped)
  local veh = cache.vehicle
  local seat = cache.seat

  NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.5, heading, true, false)
  if veh then
    SetPedIntoVehicle(ped, veh, seat)
  end
end

---put player in last stand animation
---@param ped number
local function playLastStandAnimation(ped)
  if cache.vehicle then
    lib.requestAnimDict("veh@low@front_ps@idle_duck")
    TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 8.0, -1, 1, -1, false, false, false)
  else
    lib.requestAnimDict(LastStandDict)
    TaskPlayAnim(ped, LastStandDict, LastStandAnim, 1.0, 8.0, -1, 1, -1, false, false, false)
  end
end

local function logPlayerKiller()
  local ped = cache.ped
  local player = cache.playerId
  local killer_2, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
  local killer = GetPedSourceOfDeath(ped)
  if killer_2 ~= 0 and killer_2 ~= -1 then killer = killer_2 end
  local killerId = NetworkGetPlayerIndexFromPed(killer)
  local killerName = killerId ~= -1 and GetPlayerName(killerId) .. " " .. "(" .. GetPlayerServerId(killerId) .. ")" or Lang:t('info.self_death')
  local weaponLabel = Lang:t('info.wep_unknown')
  local weaponName = Lang:t('info.wep_unknown')
  local weaponItem = QBCore.Shared.Weapons[killerWeapon]
  if weaponItem then
    weaponLabel = weaponItem.label
    weaponName = weaponItem.name
  end
  TriggerServerEvent("qb-log:server:CreateLog", "death", Lang:t('logs.death_log_title', { playername = GetPlayerName(cache.playerId), playerid = GetPlayerServerId(player) }), "red", Lang:t('logs.death_log_message', { killername = killerName, playername = GetPlayerName(player), weaponlabel = weaponLabel, weaponname = weaponName }))
end

---count down last stand, if last stand is over, put player in death mode and log the killer.
local function countdownLastStand()
  if LaststandTime - 1 > 0 then
    if not LocalPlayer.state.stabilized then
      LaststandTime -= 1
    end
    Config.DeathTime = LaststandTime
  elseif LocalPlayer.state.stabilized then
    LaststandTime = 10
  else
    lib.notify({ description = Lang:t('error.bled_out'), type = 'error' })
    EndLastStand()
    logPlayerKiller()
    DeathTime = 0
    OnDeath()
    AllowRespawn()
  end
  Wait(1000)
end

---put player in last stand mode and notify EMS.
function StartLastStand()
  local ped = cache.ped
  Wait(1000)
  WaitForPedToStopMoving(ped)
  TriggerServerEvent("InteractSound_SV:PlayOnSource", "demo", 0.1)
  LaststandTime = Laststand.ReviveInterval
  ResurrectPlayer(ped)
  SetEntityHealth(ped, 150)
  playLastStandAnimation(ped)
  InLaststand = true
  exports['ps-dispatch']:InjuriedPerson()
  LocalPlayer.state:set('isDown', true, true)
  CreateThread(function()
    while InLaststand do
      countdownLastStand()
    end
  end)
  TriggerServerEvent("hospital:server:SetLaststandStatus", true)
end

---remove last stand mode from player.
function EndLastStand()
  local ped = cache.ped
  TaskPlayAnim(ped, LastStandDict, "exit", 1.0, 8.0, -1, 1, -1, false, false, false)
  InLaststand = false
  LaststandTime = 0
  TriggerServerEvent("hospital:server:SetLaststandStatus", false)
end

---@param bool boolean
---TODO: this event name should be changed within qb-policejob to be generic
AddEventHandler('hospital:client:SetEscortingState', function(bool)
  isEscorting = bool
end)

---@param bool boolean
---TODO: this event name should be changed within qb-policejob to be generic
AddEventHandler('hospital:client:isEscorted', function(bool)
  IsEscorted = bool
end)

---use first aid pack on nearest player.
lib.callback.register('hospital:client:UseDefib', function()
  if isEscorting then
    lib.notify({ description = Lang:t('error.impossible'), type = 'error' })
    return
  end

  local player, distance = GetClosestPlayer()
  if player ~= -1 and distance < 1.5 then
    local playerId = GetPlayerServerId(player)
    TriggerServerEvent('hospital:server:UseDefib', playerId)
  end
end)

lib.callback.register('hospital:client:canHelp', function()
  return InLaststand and LaststandTime <= 300
end)

---@param targetId number playerId
RegisterNetEvent('hospital:client:HelpPerson', function(targetId)
  if GetInvokingResource() then return end
  local ped = cache.ped
  if lib.progressCircle({
    duration = math.random(30000, 60000),
    position = 'bottom',
    label = Lang:t('progress.revive'),
    useWhileDead = false,
    canCancel = true,
    disable = {
      move = false,
      car = false,
      combat = true,
      mouse = false,
    },
    anim = {
      dict = HealAnimDict,
      clip = HealAnim,
    },
  })
  then
    ClearPedTasks(ped)
    lib.notify({ description = Lang:t('success.revived'), type = 'success' })
    TriggerServerEvent("hospital:server:RevivePlayer", targetId)
  else
    ClearPedTasks(ped)
    lib.notify({ description = Lang:t('error.canceled'), type = 'error' })
  end
end)

local time = 30 * 1000 -- 30 seconds for drunk effect
local PlayerPedId = PlayerPedId

local jailBoxCoords = vector3(-74.94596862793, -817.98797607422, 243.38595581055) -- change it to your own jail box coords


local keepAnimPlaying = false

local function StartAnimThread(dict, name)
  if keepAnimPlaying then return end
  keepAnimPlaying = true
  CreateThread(function()
    while keepAnimPlaying do
      Wait(0)
      if not IsEntityPlayingAnim(PlayerPedId(), dict, name, 3) then
        TaskPlayAnim(PlayerPedId(), dict, name, 8.0, 8.0, -1, 1, 0, false, false, false)
      end
    end
  end)
end

local function LoadAnimSet(animSet)
  RequestAnimSet(animSet)
  while not HasAnimSetLoaded(animSet) do
    Wait(5)
  end
end

local function LoadAnimDict(dict)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Wait(5)
  end
end

local function LoadPartificleFx(particle)
  RequestNamedPtfxAsset(particle)
  while not HasNamedPtfxAssetLoaded(particle) do
    Wait(5)
  end
end

-- some of the effects are working while some are not. You might have to play with these. I have uncommented the one I tested and they work fine.
local VehicleEffects = {
  1,    ---brake
  3,    ---brake + reverse
  4,    ---turn left 90 + braking
  5,    ---turn right 90 + braking
  -- 6 ,---brake strong (handbrake?) until time ends
  7,    ---turn left + accelerate
  7,    ---turn right + accelerate
  -- 9 ,---weak acceleration
  -- 10, -- turn left + restore wheel pos to center in the end
  -- 11, -- turn right + restore wheel pos to center in the end
  13,   -- turn left + go reverse
  14,   -- turn left + go reverse
  19,   -- strong brake + turn left/right
  20,   -- weak brake + turn left then turn right
  21,   -- weak brake + turn right then turn left
  22,   -- brake + reverse
  -- 23, -- accelerate fast
  -- 24, -- brake
  25,   -- brake turning left then when almost stopping it turns left more
  -- 26, -- brake turning right then when almost stopping it turns right more
  -- 27, -- brake until car stop or until time ends
  -- 28, -- brake + strong reverse acceleration
  -- 31, -- accelerate + handbrake
  -- 32-- accelerate very strong
}

-- ██████  ██████  ██    ██ ███    ██ ██   ██
-- ██   ██ ██   ██ ██    ██ ████   ██ ██  ██
-- ██   ██ ██████  ██    ██ ██ ██  ██ █████
-- ██   ██ ██   ██ ██    ██ ██  ██ ██ ██  ██
-- ██████  ██   ██  ██████  ██   ████ ██   ██

function DrunkEffect()
  local isDrunk = true
  LoadAnimSet("move_m@drunk@verydrunk")
  SetPedMovementClipset(PlayerPedId(), "move_m@drunk@verydrunk")
  ShakeGameplayCam("DRUNK_SHAKE", 3.0)
  SetPedIsDrunk(PlayerPedId(), true)
  StartScreenEffect("SwitchSceneTrevor", 3.0, 0)
  local drunkTime = time
  CreateThread(function()
    while drunkTime > 0 and isDrunk do
      local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
      if vehicle ~= 0 then
        if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
          local vehicleTask = math.random(1, #VehicleEffects)
          TaskVehicleTempAction(PlayerPedId(), vehicle, VehicleEffects[vehicleTask], 1000)
        end
      end
      drunkTime = drunkTime - 1000
      Wait(1000)
    end
    isDrunk = false
    StopGameplayCamShaking(true)
    ResetPedMovementClipset(PlayerPedId())
    StopScreenEffect("SwitchSceneTrevor")
    RemoveAnimSet("move_m@drunk@verydrunk")
  end)
end

function SetPlayerOnFire()
  StartEntityFire(PlayerPedId())
end

function SendToJailBox()
  SetEntityCoords(PlayerPedId(), jailBoxCoords.x, jailBoxCoords.y, jailBoxCoords.z, 0.0, 0.0, 0.0, false)
end

function SlapSky()
  local playerCoords = GetEntityCoords(PlayerPedId())
  local maxZ = playerCoords.z + 100.0
  FreezeEntityPosition(PlayerPedId(), true)
  CreateThread(function()
    while maxZ > playerCoords.z do
      playerCoords = GetEntityCoords(PlayerPedId())
      SetEntityCoords(PlayerPedId(), playerCoords.x, playerCoords.y, playerCoords.z + 0.1, 0.0, 0.0, 0.0, false)
      Wait(100)
    end
    FreezeEntityPosition(PlayerPedId(), false)
  end)
end

-- if you want to use some other sound script, you can change the event name. the soundName is sent here and triggered on the player selected in UI.
function PlaySound(soundName)
  TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.0, soundName, 0.5)
end

local function DamageVehicle(x, y, z)
  CreateThread(function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
      for i = 1, 10, 1 do
        SetVehicleDamage(vehicle, x, y, z, 2000.0, 500.0, true)
        Wait(200)
      end
    end
  end)
end

function DamagePlayerVehicle()
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    DamageVehicle(0.1, 0.1, 0)
    DamageVehicle(0.1, -0.1, 0)
    DamageVehicle(-0.1, 0.1, 0)
    DamageVehicle(-0.1, -0.1, 0)
    DamageVehicle(0.0, 0.0, 0.4)
    DamageVehicle(0.0, 0.0, -0.4)
  end
end

function PeePlayer()
  local isMale = true
  local PlayerPed = PlayerPedId()
  if (GetEntityModel(PlayerPed) == GetHashKey("mp_f_freemode_01")) then
    isMale = false
  end
  local particleDictionary = "core"
  local particleName = "ent_amb_peeing"
  local animDictionary = 'misscarsteal2peeing'
  local animName = 'peeing_loop'
  LoadPartificleFx(particleDictionary)
  LoadAnimDict(animDictionary)
  LoadAnimDict("missfbi3ig_0")
  if isMale then
    SetPtfxAssetNextCall(particleDictionary)
    local bone = GetPedBoneIndex(PlayerPed, 11816)
    local heading = GetEntityPhysicsHeading(PlayerPed)
    TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
    StartAnimThread(animDictionary, animName)
    local effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.2, 0.0, -140.0, 0.0, 0.0, bone, 2.5, false, false, false)
    Wait(10000)
    keepAnimPlaying = false
    StopParticleFxLooped(effect, 0)
    ClearPedTasks(PlayerPed)
  else
    SetPtfxAssetNextCall(particleDictionary)
    bone = GetPedBoneIndex(PlayerPed, 11816)
    local heading = GetEntityPhysicsHeading(PlayerPed)
    TaskPlayAnim(PlayerPed, 'missfbi3ig_0', 'shit_loop_trev', 8.0, -8.0, -1, 0, 0, false, false, false)
    StartAnimThread('missfbi3ig_0', 'shit_loop_trev')
    local effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.55, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)
    Wait(10000)
    keepAnimPlaying = false
    StopParticleFxLooped(effect, 0)
    ClearPedTasks(PlayerPed)
  end
end

function PoopPlayer()
  local PlayerPed = PlayerPedId()
  local particleDictionary = "scr_amb_chop"
  local particleName = "ent_anim_dog_poo"
  local animDictionary = 'missfbi3ig_0'
  local animName = 'shit_loop_trev'
  LoadPartificleFx(particleDictionary)
  LoadAnimDict(animDictionary)
  SetPtfxAssetNextCall(particleDictionary)
  bone = GetPedBoneIndex(PlayerPed, 11816)
  TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
  StartAnimThread(animDictionary, animName)
  effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.6, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)
  Wait(3500)
  effect2 = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.6, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)
  Wait(4000)
  keepAnimPlaying = false
  StopParticleFxLooped(effect, 0)
  Wait(10)
  StopParticleFxLooped(effect2, 0)
  ClearPedTasks(PlayerPed)
end

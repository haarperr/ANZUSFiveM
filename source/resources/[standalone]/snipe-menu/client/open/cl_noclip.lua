local IsNoClipping           = false
local NoClipEntity
local Invisible              = nil
local Camera                 = nil

local speed                  = 1.0
local MaxSpeed               = 16.0
local minY, maxY             = -89.0, 89.0

local inputRotEnabled        = false

local MOVE_FORWARDS          = 32     -- Default: W
local MOVE_BACKWARDS         = 33     -- Default: S
local MOVE_LEFT              = 34     -- Default: A
local MOVE_RIGHT             = 35     -- Default: D
local MOVE_UP                = 44     -- Default: Q
local MOVE_DOWN              = 46     -- Default: E

local SPEED_DECREASE         = 14     -- Default: Mouse wheel down
local SPEED_INCREASE         = 15     -- Default: Mouse wheel up
local SPEED_RESET            = 348    -- Default: Mouse wheel click
local SPEED_SLOW_MODIFIER    = 36     -- Default: Left Control
local SPEED_FAST_MODIFIER    = 21     -- Default: Left Shift
local SPEED_FASTER_MODIFIER  = 19     -- Default: Left Alt

local IsControlAlwaysPressed = function(inputGroup, control)
  return IsControlPressed(inputGroup, control) or IsDisabledControlPressed(inputGroup, control)
end

local function DisableControls()
  DisableControlAction(2, 32, true)
  DisableControlAction(2, 33, true)
  DisableControlAction(2, 34, true)
  DisableControlAction(2, 35, true)
  DisableControlAction(2, 36, true)
  DisableControlAction(2, 12, true)
  DisableControlAction(2, 13, true)
  DisableControlAction(2, 14, true)
  DisableControlAction(2, 15, true)
  DisableControlAction(2, 16, true)
  DisableControlAction(2, 17, true)
end
local function DestroyCamera()
  DestroyCam(Camera, false)
  Camera = nil
  RenderScriptCams(false, false, 3000, true, false)
end
local function StopNoClip()
  local ped = PlayerPedId()
  FreezeEntityPosition(NoClipEntity, false)
  SetEntityCollision(NoClipEntity, true, true)
  SetEntityVisible(NoClipEntity, true, false)
  SetLocalPlayerVisibleLocally(true)
  ResetEntityAlpha(NoClipEntity)
  ResetEntityAlpha(ped)
  SetEveryoneIgnorePlayer(ped, false)
  SetPoliceIgnorePlayer(ped, false)
  SetPedCanRagdoll(ped, true)
  -- ResetEntityAlpha(NoClipEntity)
  if isInvisible then
    -- RemoveInvisibleEffect()
    isInvisible = false
    Wait(100)
    TriggerEvent("snipe-menu:client:invisibleEffect")
  end

  SetPoliceIgnorePlayer(ped, true)
  DestroyCamera()
  local inVehicle = IsPedInAnyVehicle(ped, false)
  if inVehicle then
    FreezeEntityPosition(ped, false)
    SetEntityCollision(ped, true, true)
    ResetEntityAlpha(ped)
    SetEntityVisible(ped, true)
    SetPedIntoVehicle(ped, NoClipEntity, -1)
  end
end

function toggleNoclip()
  Citizen.CreateThread(function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local inVehicle = false

    if veh ~= 0 then
      inVehicle = true
      NoClipEntity = veh
    else
      NoClipEntity = ped
    end

    local pos = GetEntityCoords(NoClipEntity)
    local rot = GetEntityRotation(NoClipEntity)

    Camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos, 0.0, 0.0, rot.z, 75.0, true, 2)
    AttachCamToEntity(Camera, NoClipEntity, 0.0, 0.0, 0.0, true)
    RenderScriptCams(true, false, 3000, true, false)

    FreezeEntityPosition(NoClipEntity, true)
    SetEntityCollision(NoClipEntity, false, false)
    SetEntityAlpha(NoClipEntity, 0)
    SetPedCanRagdoll(ped, false)
    SetEntityVisible(NoClipEntity, false)
    if not inVehicle then
      ClearPedTasksImmediately(ped)
    end

    if inVehicle then
      FreezeEntityPosition(ped, true)
      SetEntityCollision(ped, false, false)
      SetEntityAlpha(ped, 0)
      SetEntityVisible(ped, false)
    end
    while IsNoClipping do
      Wait(0)
      DisableControls()
      local _, fv, _, _ = GetCamMatrix(Camera)

      if IsControlAlwaysPressed(0, SPEED_INCREASE) then           -- MWheelUp
        speed = math.min(speed + 0.1, MaxSpeed)
      elseif IsControlAlwaysPressed(0, SPEED_DECREASE) then       -- MWheelDown
        speed = math.max(0.1, speed - 0.1)
      end

      local multiplier = 1.0;

      if IsControlAlwaysPressed(0, SPEED_FAST_MODIFIER) then
        multiplier = 2.0
      elseif IsControlAlwaysPressed(0, SPEED_FASTER_MODIFIER) then
        multiplier = 4.0
      elseif IsControlAlwaysPressed(0, SPEED_SLOW_MODIFIER) then
        multiplier = 0.25
      end

      if IsControlAlwaysPressed(2, MOVE_FORWARDS) then       -- Move Forward
        local setpos = GetEntityCoords(NoClipEntity) + fv * (speed * multiplier)
        SetEntityCoordsNoOffset(NoClipEntity, setpos)
        if not inVehicle then
          SetEntityCoordsNoOffset(ped, setpos)
        end
      elseif IsControlAlwaysPressed(2, MOVE_BACKWARDS) then       -- Move Backwards
        local setpos = GetEntityCoords(NoClipEntity) - fv * (speed * multiplier)
        SetEntityCoordsNoOffset(NoClipEntity, setpos)
        if not inVehicle then
          SetEntityCoordsNoOffset(ped, setpos)
        end
      end

      if IsControlAlwaysPressed(0, 34) then       -- move left
        local setpos = GetOffsetFromEntityInWorldCoords(NoClipEntity, -speed * multiplier, 0.0, 0.0)
        SetEntityCoordsNoOffset(NoClipEntity, setpos.x, setpos.y, GetEntityCoords(NoClipEntity).z)
        if not inVehicle then
          SetEntityCoordsNoOffset(ped, setpos.x, setpos.y, GetEntityCoords(NoClipEntity).z)
        end
      elseif IsControlAlwaysPressed(0, 35) then       --  move right
        local setpos = GetOffsetFromEntityInWorldCoords(NoClipEntity, speed * multiplier, 0.0, 0.0)
        SetEntityCoordsNoOffset(NoClipEntity, setpos.x, setpos.y, GetEntityCoords(NoClipEntity).z)
        if not inVehicle then
          SetEntityCoordsNoOffset(ped, setpos.x, setpos.y, GetEntityCoords(NoClipEntity).z)
        end
      end

      if IsControlAlwaysPressed(0, MOVE_UP) then       -- Move UP
        local setpos = GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, 0.0, multiplier * speed / 2)
        SetEntityCoordsNoOffset(NoClipEntity, setpos)
        if not inVehicle then
          SetEntityCoordsNoOffset(ped, setpos)
        end
      elseif IsControlAlwaysPressed(0, MOVE_DOWN) then                                                           -- Move Down
        local setpos = GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, 0.0, multiplier * -speed / 2)         -- Q
        SetEntityCoordsNoOffset(NoClipEntity, setpos)
        if not inVehicle then
          SetEntityCoordsNoOffset(ped, setpos)
        end
      end

      local camrot = GetCamRot(Camera, 2)
      SetEntityHeading(NoClipEntity, (360 + camrot.z) % 360.0)

      SetEntityVisible(NoClipEntity, false)
      if inVehicle then
        SetEntityVisible(ped, false)
      end
      DisablePlayerFiring(PlayerId(), true)
    end
    StopNoClip()
  end)
end

function checkInputRotation()
  CreateThread(function()
    while inputRotEnabled do
      while Camera == nil do
        Wait(0)
      end

      while IsPauseMenuActive() do
        Wait(0)
      end

      local axisX = GetDisabledControlNormal(0, 1)
      local axisY = GetDisabledControlNormal(0, 2)

      local sensitivity = GetProfileSetting(14) * 2

      if GetProfileSetting(15) == 0 --[[ Invert ]] then
        -- this is default inverse
        sensitivity = -sensitivity
      end

      if (math.abs(axisX) > 0) or (math.abs(axisY) > 0) then
        local rotation = GetCamRot(Camera, 2)
        local rotz = rotation.z + (axisX * sensitivity)

        local yValue = (axisY * sensitivity)

        local rotx = rotation.x

        if rotx + yValue > minY and rotx + yValue < maxY then
          rotx = rotation.x + yValue
        end

        SetCamRot(Camera, rotx, rotation.y, rotz, 2)
      end

      Wait(0)
    end
  end)
end

function ToggleNoClip(forceMode)
  IsNoClipping = not IsNoClipping
  inputRotEnabled = IsNoClipping
  if IsNoClipping then
    enabledButtons[#enabledButtons + 1] = "NoClip"
    TriggerServerEvent("snipe-menu:server:sendLogs", "triggered", Config.Locales["noclip_used"])
  else
    for i = 1, #enabledButtons do
      if enabledButtons[i] == "NoClip" then
        table.remove(enabledButtons, i)
        break
      end
    end
  end
  if IsNoClipping and inputRotEnabled then
    toggleNoclip()
    checkInputRotation()
  end
end

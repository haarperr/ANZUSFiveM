config = {
  controls = {
    openKey = 288,        -- [[F2]]
    goUp = 85,            -- [[Q]]
    goDown = 48,          -- [[Z]]
    turnLeft = 34,        -- [[A]]
    turnRight = 35,       -- [[D]]
    goForward = 32,       -- [[W]]
    goBackward = 33,      -- [[S]]
    changeSpeed = 21,     -- [[L-Shift]]
  },

  speeds = {
    { label = "Very Slow",          speed = 0 },
    { label = "Slow",               speed = 0.5 },
    { label = "Normal",             speed = 2 },
    { label = "Fast",               speed = 4 },
    { label = "Very Fast",          speed = 6 },
    { label = "Extremely Fast",     speed = 10 },
    { label = "Extremely Fast 2.0", speed = 20 },
    { label = "Maximum Velocity",   speed = 25 }
  },

  offsets = {
    y = 0.5,
    z = 0.2,
    h = 3,
  },

  bgR = 0,
  bgG = 0,
  bgB = 0,
  bgA = 80,
}

noclipActive = false

index = 1

local function Draw2dText()
  drawTxt(0.8, 0.5, 0.4, 0.5, 0.4, "[Q] Go up", 255, 255, 255, 255)
  drawTxt(0.8, 0.53, 0.4, 0.5, 0.45, "[Z] Go down", 255, 255, 255, 255)
  drawTxt(0.8, 0.56, 0.4, 0.5, 0.5, "[A] Turn left", 255, 255, 255, 255)
  drawTxt(0.8, 0.59, 0.4, 0.5, 0.55, "[D] Turn right", 255, 255, 255, 255)
  drawTxt(0.8, 0.62, 0.4, 0.5, 0.6, "[W] Go forward", 255, 255, 255, 255)
  drawTxt(0.8, 0.65, 0.4, 0.5, 0.65, "[S] Go backward", 255, 255, 255, 255)
  drawTxt(0.8, 0.68, 0.4, 0.5, 0.7, "[L-Shift] Change speed", 255, 255, 255, 255)
  drawTxt(0.8, 0.71, 0.4, 0.5, 0.75, "Current Speed: " .. config.speeds[index].label, 255, 255, 255, 255)
end

function toggleNoclip2()
  Citizen.CreateThread(function()
    noclipActive = not noclipActive
    currentSpeed = config.speeds[index].speed
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
    else
      noclipEntity = PlayerPedId()
    end
    SetLocalPlayerVisibleLocally(true);
    SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
    FreezeEntityPosition(noclipEntity, noclipActive)
    SetEntityInvincible(noclipEntity, noclipActive)
    SetVehicleRadioEnabled(noclipEntity, not noclipActive)
    SetEntityAlpha(noclipEntity, noclipActive and 128 or 255, false)
    while noclipActive do
      Citizen.Wait(1)
      local yoff = 0.0
      local zoff = 0.0
      Draw2dText()
      if IsControlJustPressed(1, config.controls.changeSpeed) then
        if index ~= 8 then
          index = index + 1
          currentSpeed = config.speeds[index].speed
        else
          currentSpeed = config.speeds[1].speed
          index = 1
        end
      end

      DisableControls()

      if IsDisabledControlPressed(0, config.controls.goForward) then
        yoff = config.offsets.y
      end

      if IsDisabledControlPressed(0, config.controls.goBackward) then
        yoff = -config.offsets.y
      end

      if IsDisabledControlPressed(0, config.controls.turnLeft) then
        SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity) + config.offsets.h)
      end

      if IsDisabledControlPressed(0, config.controls.turnRight) then
        SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity) - config.offsets.h)
      end

      if IsDisabledControlPressed(0, config.controls.goUp) then
        zoff = config.offsets.z
      end

      if IsDisabledControlPressed(0, config.controls.goDown) then
        zoff = -config.offsets.z
      end

      local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
      local heading = GetEntityHeading(noclipEntity)
      SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
      SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
      SetEntityHeading(noclipEntity, heading)
      SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
    end

    if isInvisible then
      isInvisible = false
      Wait(100)
      TriggerEvent("snipe-menu:client:invisibleEffect")
    end
  end)
end

function DisableControls()
  DisableControlAction(0, 30, true)
  DisableControlAction(0, 31, true)
  DisableControlAction(0, 32, true)
  DisableControlAction(0, 33, true)
  DisableControlAction(0, 34, true)
  DisableControlAction(0, 35, true)
  DisableControlAction(0, 266, true)
  DisableControlAction(0, 267, true)
  DisableControlAction(0, 268, true)
  DisableControlAction(0, 269, true)
  DisableControlAction(0, 44, true)
  DisableControlAction(0, 20, true)
  DisableControlAction(0, 74, true)
end

RegisterNUICallback("noclip2", function(data, cb)
  enabledButtons = data.panelsClicked
  toggleNoclip2()
  cb({})
end)

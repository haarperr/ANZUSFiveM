local serverObjects = {
  office2 = vec4(-97.80, 6470.10, 31.10, 45.0),
  office1 = vec4(-106.90, 6461.0, 31.14, 46.2),
  office3 = vec4(-102.9, 6476.6, 31.10, 225.0),
}

local sin, cos, abs, rad = math.sin, math.cos, math.abs, math.rad

local cam, viewCam, server, serverCoords

-- DRAWTEXT
local function DrawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
  SetTextFont(4)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(2, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - width / 2, y - height / 2 + 0.005)
end


---- RAYCAST -----
local function RotationToDirection(rot)
  local rotZ = rad(rot.z)
  local rotX = rad(rot.x)
  local cosOfRotX = abs(cos(rotX))
  return vector3(-sin(rotZ) * cosOfRotX, cos(rotZ) * cosOfRotX, sin(rotX))
end

local function RayCastGamePlayCamera(dist)
  local camRot = GetCamRot(cam, 2)
  local camPos = GetCamCoord(cam)
  local dir = RotationToDirection(camRot)
  local dest = camPos + (dir * dist)
  local ray = StartExpensiveSynchronousShapeTestLosProbe(camPos.x, camPos.y, camPos.z, dest.x, dest.y, dest.z, 17, -1, 0)
  local _, hit, endPos, surfaceNormal, entityHit = GetShapeTestResult(ray)
  if hit == 0 then endPos = dest end
  return hit, endPos, entityHit, surfaceNormal
end

local function InstructionButton(ControlButton)
  ScaleformMovieMethodAddParamPlayerNameString(ControlButton)
end

local function InstructionButtonMessage(text)
  BeginTextCommandScaleformString("STRING")
  AddTextComponentSubstringKeyboardDisplay(text)
  EndTextCommandScaleformString()
end

local function CreateInstuctionScaleform(scaleform)
  scaleform = RequestScaleformMovie(scaleform)
  while not HasScaleformMovieLoaded(scaleform) do Wait(0) end
  BeginScaleformMovieMethod(scaleform, "CLEAR_ALL")
  EndScaleformMovieMethod()
  BeginScaleformMovieMethod(scaleform, "SET_CLEAR_SPACE")
  ScaleformMovieMethodAddParamInt(200)
  EndScaleformMovieMethod()
  BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
  ScaleformMovieMethodAddParamInt(1)
  InstructionButton(GetControlInstructionalButton(1, 194, true))
  InstructionButtonMessage('Exit Camera')
  EndScaleformMovieMethod()
  BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
  EndScaleformMovieMethod()
  BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_COLOUR")
  ScaleformMovieMethodAddParamInt(0)
  ScaleformMovieMethodAddParamInt(0)
  ScaleformMovieMethodAddParamInt(0)
  ScaleformMovieMethodAddParamInt(80)
  EndScaleformMovieMethod()
  return scaleform
end

local function ScaleFormCam(scaleform, bool)
  scaleform = RequestScaleformMovie(scaleform)
  while not HasScaleformMovieLoaded(scaleform) do Wait(0) end
  BeginScaleformMovieMethod(scaleform, "SET_RETICLE_IS_VISIBLE")
  ScaleformMovieMethodAddParamBool(bool)
  EndScaleformMovieMethod()
  EndScaleformMovieMethod()
  return scaleform
end

local function SecurityCam(coords, office, interiorids)
  local ped = cache.ped
  local prevCoords = GetEntityCoords(ped)
  SetEntityCoords(ped, coords[1], coords[2], coords[3] - 2.0, false, false, false, false)
  DoScreenFadeOut(5)
  Wait(500)
  SetEntityCoords(ped, prevCoords.x, prevCoords.y, prevCoords.z, false, false, false, false)
  cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords[1], coords[2], coords[3], 0.0, 0.00, coords[4] - 180.0, 80.00, false, 0)
  SetCamActive(cam, true)
  RenderScriptCams(true, true, 500, true, true)
  local secCam = true
  FreezeEntityPosition(ped, true)
  Wait(500)
  DoScreenFadeIn(150)
  local animDict = 'anim@heists@prison_heistig1_p1_guard_checks_bus'

  lib.requestAnimDict(animDict)
  local m = lib.requestModel(`hei_prop_mini_sever_01`)

  TaskPlayAnim(ped, animDict, 'loop', 8.0, 8.0, -1, 1, 1, false, false, false)
  CreateThread(function()
    if office then
      serverCoords = serverObjects[office]
      server = CreateObject(`hei_prop_mini_sever_01`, serverCoords.x, serverCoords.y, serverCoords.z - 0.5, false, false, false)
      while not server do Wait(50) end
      SetEntityHeading(server, serverCoords.w)
    end
    while secCam do
      local instructions = CreateInstuctionScaleform("instructional_buttons")
      DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
      local hud = ScaleFormCam("drone_cam", true)
      DrawScaleformMovieFullscreen(hud, 255, 255, 255, 255, 0)
      SetTimecycleModifier("scanline_cam_cheap")
      SetTimecycleModifierStrength(1.0)
      if IsControlJustPressed(1, 194) then -- Backspace
        DoScreenFadeOut(500)
        Wait(1000)
        RenderScriptCams(false, true, 500, true, true)
        FreezeEntityPosition(ped, false)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        ClearTimecycleModifier()
        cam = nil
        secCam = false
        if server then
          DeleteEntity(server)
          DeleteObject(server)
        end
        ClearPedTasks(ped)
        Wait(500)
        DoScreenFadeIn(150)
      end

      local getCameraRot = GetCamRot(cam, 2)
      -- ROTATE UP
      if IsControlPressed(0, 32) then -- W
        if getCameraRot.x <= 0.0 then
          SetCamRot(cam, getCameraRot.x + 0.7, 0.0, getCameraRot.z, 2)
        end
      end
      -- ROTATE DOWN
      if IsControlPressed(0, 33) then -- S
        if getCameraRot.x >= -50.0 then
          SetCamRot(cam, getCameraRot.x - 0.7, 0.0, getCameraRot.z, 2)
        end
      end
      -- ROTATE LEFT
      if IsControlPressed(0, 34) then -- A
        if getCameraRot.z <= coords[5] then
          SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
        end
      end
      -- ROTATE RIGHT
      if IsControlPressed(0, 35) then -- D
        if getCameraRot.z >= coords[6] then
          SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
        end
      end
      if office then
        local hit, pos, entity, _ = RayCastGamePlayCamera(30)
        if entity == server then
          if office == 'office1' then
            DrawTxt(0.98, 0.84, 1.0, 1.0, 0.5, "~g~" .. SyncData[office].password, 255, 255, 255, 255)
          elseif office == 'office2' then
            if SyncData.office1.hacked then
              DrawTxt(0.98, 0.84, 1.0, 1.0, 0.5, "~g~" .. SyncData[office].password, 255, 255, 255, 255)
            else
              DrawTxt(0.98, 0.84, 1.0, 1.0, 0.5, "???????", 255, 255, 255, 255)
            end
          elseif office == 'office3' then
            if SyncData.office2.hacked then
              DrawTxt(0.98, 0.84, 1.0, 1.0, 0.5, "~g~" .. SyncData[office].password, 255, 255, 255, 255)
            else
              DrawTxt(0.98, 0.84, 1.0, 1.0, 0.5, "???????", 255, 255, 255, 255)
            end
          end
        end
      end
      Wait(1)
    end
  end)
end

function Camera(option)
  if option == 'office1' then
    SecurityCam({ -101.82, 6460.33, 33.12, 285.93, 107.0, 58.0 }, option, { 121090, 595161168 })
  elseif option == 'office2' then
    SecurityCam({ -97.32, 6464.84, 33.11, 185.13, 32.0, -10.0 }, option, { 121090, 1122715848 })
  elseif option == 'office3' then
    SecurityCam({ -105.94, 6480.71, 33.13, 6.13, -133.86, -173.0 }, option, { 121090, 1297762420 })
  end
end

function disableViewCam()
  if viewCam then
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    viewCam = false
  end
end

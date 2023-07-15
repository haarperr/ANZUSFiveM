Drilling = {}

local function PopFloat(scaleform, method, val)
    PushScaleformMovieFunction(scaleform, method)
    PushScaleformMovieFunctionParameterFloat(val)
    PopScaleformMovieFunctionVoid()
end

Drilling.DisabledControls = { 30, 31, 32, 33, 34, 35 }

Drilling.Start = function(callback)
    if not Drilling.Active then
        Drilling.Active = true
        SetAnim()
        Drilling.Init()
        Drilling.Update(callback)
    end
end

Drilling.Init = function()
    if Drilling.Scaleform then
        SetScaleformMovieAsNoLongerNeeded(Drilling.Scaleform)
    end
    Drilling.Scaleform = RequestScaleformMovie("DRILLING")
    while not HasScaleformMovieLoaded(Drilling.Scaleform) do Wait(0) end
    Drilling.DrillSpeed = 0.0
    Drilling.DrillPos = 0.0
    Drilling.DrillTemp = 0.0
    Drilling.HoleDepth = 0.0

    PopFloat(Drilling.Scaleform, "SET_SPEED", 0.0)
    PopFloat(Drilling.Scaleform, "SET_DRILL_POSITION", 0.0)
    PopFloat(Drilling.Scaleform, "SET_TEMPERATURE", 0.0)
    PopFloat(Drilling.Scaleform, "SET_HOLE_DEPTH", 0.0)
end

Drilling.Update = function(callback)
    while Drilling.Active do
        Drilling.Draw()
        Drilling.DisableControls()
        Drilling.HandleControls()
        Wait(0)
    end
    callback(Drilling.Result)
end

Drilling.Draw = function()
    DrawScaleformMovieFullscreen(Drilling.Scaleform, 255, 255, 255, 255, 255)
end

Drilling.HandleControls = function()
    local last_pos = Drilling.DrillPos
    if IsControlJustPressed(0, 172) then
        Drilling.DrillPos = math.min(1.0, Drilling.DrillPos + 0.01)
    elseif IsControlPressed(0, 172) then
        Drilling.DrillPos = math.min(1.0, Drilling.DrillPos +
            (0.1 * GetFrameTime() /
                (math.max(0.1, Drilling.DrillTemp) *
                    10)))
    elseif IsControlJustPressed(0, 173) then
        Drilling.DrillPos = math.max(0.0, Drilling.DrillPos - 0.01)
    elseif IsControlPressed(0, 173) then
        Drilling.DrillPos = math.max(0.0,
            Drilling.DrillPos - (0.1 * GetFrameTime()))
    end
    local last_speed = Drilling.DrillSpeed
    if IsControlJustPressed(0, 175) then
        Drilling.DrillSpeed = math.min(1.0, Drilling.DrillSpeed + 0.05)
    elseif IsControlPressed(0, 175) then
        Drilling.DrillSpeed = math.min(1.0, Drilling.DrillSpeed +
            (0.5 * GetFrameTime()))
    elseif IsControlJustPressed(0, 174) then
        Drilling.DrillSpeed = math.max(0.0, Drilling.DrillSpeed - 0.05)
    elseif IsControlPressed(0, 174) then
        Drilling.DrillSpeed = math.max(0.0, Drilling.DrillSpeed -
            (0.5 * GetFrameTime()))
    end

    local last_temp = Drilling.DrillTemp
    if last_pos < Drilling.DrillPos then
        if Drilling.DrillSpeed > 0.4 then
            Drilling.DrillTemp = math.min(1.0, Drilling.DrillTemp +
                ((0.05 * GetFrameTime()) *
                    (Drilling.DrillSpeed * 10)))
            PopFloat(Drilling.Scaleform, "SET_DRILL_POSITION", Drilling.DrillPos)
        else
            if Drilling.DrillPos < 0.1 or Drilling.DrillPos < Drilling.HoleDepth then
                PopFloat(Drilling.Scaleform, "SET_DRILL_POSITION",
                    Drilling.DrillPos)
            else
                Drilling.DrillPos = last_pos
                Drilling.DrillTemp = math.min(1.0, Drilling.DrillTemp +
                    (0.01 * GetFrameTime()))
            end
        end
    else
        if Drilling.DrillPos < Drilling.HoleDepth then
            Drilling.DrillTemp = math.max(0.0, Drilling.DrillTemp -
                ((0.05 * GetFrameTime()) *
                    math.max(0.005,
                        (Drilling.DrillSpeed *
                            10) / 2)))
        end

        if Drilling.DrillPos ~= Drilling.HoleDepth then
            PopFloat(Drilling.Scaleform, "SET_DRILL_POSITION", Drilling.DrillPos)
        end
    end

    if last_speed ~= Drilling.DrillSpeed then
        PopFloat(Drilling.Scaleform, "SET_SPEED", Drilling.DrillSpeed)
    end

    if last_temp ~= Drilling.DrillTemp then
        PopFloat(Drilling.Scaleform, "SET_TEMPERATURE", Drilling.DrillTemp)
    end

    if Drilling.DrillTemp >= 1.0 then
        Drilling.Result = false
        Drilling.Active = false
        ClearPedTasks(PlayerPedId())
        SetScaleformMovieAsNoLongerNeeded(Drilling.Scaleform)
    elseif Drilling.DrillPos >= 1.0 then
        Drilling.Result = true
        Drilling.Active = false
        ClearPedTasks(PlayerPedId())
        SetScaleformMovieAsNoLongerNeeded(Drilling.Scaleform)
    end

    Drilling.HoleDepth = (Drilling.DrillPos > Drilling.HoleDepth and
        Drilling.DrillPos or Drilling.HoleDepth)

    -- print(Drilling.DrillPos)
end

Drilling.DisableControls = function()
    for _, control in ipairs(Drilling.DisabledControls) do
        DisableControlAction(0, control, true)
    end
end

Drilling.EnableControls = function()
    for _, control in ipairs(Drilling.DisabledControls) do
        DisableControlAction(0, control, true)
    end
end

function SetAnim(state)
    lib.requestAnimDict("anim@heists@fleeca_bank@drilling")
    TaskPlayAnim(PlayerPedId(), "anim@heists@fleeca_bank@drilling",
        "drill_straight_idle", 8.0, 8.0, -1, 1, 1.0, false, false,
        false)
end

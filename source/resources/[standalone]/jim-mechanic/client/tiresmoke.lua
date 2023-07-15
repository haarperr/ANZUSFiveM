--========================================================== Tires
RegisterNetEvent('jim-mechanic:client:Tires:Apply', function(data)
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  spraying = true
  local r, g, b = GetVehicleTyreSmokeColor(vehicle)
  if r == data.R and g == data.G and b == data.B then
    triggerNotify(nil, Loc[Config.Lan]["smoke"].already, "error")
    TriggerEvent('jim-mechanic:client:Tires:Check')
  else
    time = math.random(3000, 5000)
    local fwd = GetEntityForwardVector(PlayerPedId())
    local coords = GetEntityCoords(PlayerPedId()) + fwd * 0.5 + vec3(0.0, 0.0, -0.5)
    CreateThread(function()
      while spraying do
        RequestNamedPtfxAsset("scr_recartheft")
        while not HasNamedPtfxAssetLoaded("scr_recartheft") do Citizen.Wait(0) end
        local heading = GetEntityHeading(vehicle)
        UseParticleFxAssetNextCall("scr_recartheft")
        SetParticleFxNonLoopedColour(data.R / 255, data.G / 255, data.B / 255)
        SetParticleFxNonLoopedAlpha(1.0)
        local spray = StartNetworkedParticleFxNonLoopedAtCoord("scr_wheel_burnout", GetEntityCoords(PlayerPedId()), 0.0, 0.0, heading + 180.0, 0.6, 0.0, 0.0, 0.0)
        Wait(500)
      end
    end)
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["smoke"].installing, time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        ToggleVehicleMod(vehicle, 20, true)
        qblog("`tires - " .. QBCore.Shared.Items["tires"].label .. " - {" .. data.R ..
          ", " .. data.G .. ", " .. data.B .. "}` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleTyreSmokeColor(vehicle, data.R, data.G, data.B)
        emptyHands(PlayerPedId())

        if Config.CosmeticRemoval then
          toggleItem(false, "tires")
        else
          TriggerEvent('jim-mechanic:client:Tires:Check')
        end
        triggerNotify(nil, Loc[Config.Lan]["smoke"].installed, "success")
        spraying = false
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["smoke"].failed, "error")
        emptyHands(PlayerPedId())
        spraying = false
      end, "tires")
  end
end)

RegisterNetEvent('jim-mechanic:client:Tires:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  local found = false
  for _, v in pairs({ "wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr" }) do
    if #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 1.2 then
      lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
      found = true
      break
    end
  end
  if not found then
    triggerNotify(nil, Loc[Config.Lan]["common"].nearwheel, "error")
    return
  end
  local r, g, b = GetVehicleTyreSmokeColor(vehicle)
  local app0, app1, app2, app3, app4, app5, app6, app7, app8, app9, app10, app11, app12, app13, app14, app15 = table.unpack({ "", "", "", "", "", "", "", "", "", "", "", "", "", "",
    "", })
  if r == 1 and g == 1 and b == 1 then
    app1 = Loc[Config.Lan]["common"].current
  elseif r == 255 and g == 255 and b == 255 then
    app2 = Loc[Config.Lan]["common"].current
  elseif r == 2 and g == 21 and b == 255 then
    app3 = Loc[Config.Lan]["common"].current
  elseif r == 3 and g == 83 and b == 255 then
    app4 = Loc[Config.Lan]["common"].current
  elseif r == 0 and g == 255 and b == 140 then
    app5 = Loc[Config.Lan]["common"].current
  elseif r == 94 and g == 255 and b == 1 then
    app6 = Loc[Config.Lan]["common"].current
  elseif r == 255 and g == 255 and b == 0 then
    app7 = Loc[Config.Lan]["common"].current
  elseif r == 255 and g == 150 and b == 0 then
    app8 = Loc[Config.Lan]["common"].current
  elseif r == 255 and g == 62 and b == 1 then
    app9 = Loc[Config.Lan]["common"].current
  elseif r == 255 and g == 1 and b == 1 then
    app10 = Loc[Config.Lan]["common"].current
  elseif r == 255 and g == 50 and b == 100 then
    app11 = Loc[Config.Lan]["common"].current
  elseif r == 255 and g == 5 and b == 190 then
    app12 = Loc[Config.Lan]["common"].current
  elseif r == 35 and g == 1 and b == 255 then
    app13 = Loc[Config.Lan]["common"].current
  elseif r == 15 and g == 3 and b == 255 then
    app14 = Loc[Config.Lan]["common"].current
  elseif r == 0 and g == 0 and b == 0 then
    app15 = Loc[Config.Lan]["common"].current
  else
    app0 = Loc[Config.Lan]["common"].current
  end
  exports['qb-menu']:openMenu({
    { header = searchCar(vehicle) .. Loc[Config.Lan]["smoke"].menuheader, txt = "",    isMenuHeader = true, },
    {
      icon = "fas fa-circle-xmark",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
      params = {
        event = "jim-mechanic:client:Menu:Close" }
    },
    { header = Loc[Config.Lan]["smoke"].remove,                           txt = app15, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 0, G = 0, B = 0 } } },
    { header = Loc[Config.Lan]["smoke"].custom,                           txt = app0,  params = { event = "jim-mechanic:client:smokeCustomMenu", } },
    { header = Loc[Config.Lan]["smoke"].black,                            txt = app1,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 1, G = 1, B = 1 } } },
    { header = Loc[Config.Lan]["smoke"].white,                            txt = app2,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 255, B = 255 } } },
    { header = Loc[Config.Lan]["smoke"].blue,                             txt = app3,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 2, G = 21, B = 255 } } },
    { header = Loc[Config.Lan]["smoke"].eblue,                            txt = app4,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 3, G = 83, B = 255 } } },
    { header = Loc[Config.Lan]["smoke"].mgreen,                           txt = app5,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 0, G = 255, B = 140 } } },
    { header = Loc[Config.Lan]["smoke"].lgreen,                           txt = app6,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 94, G = 255, B = 1 } } },
    { header = Loc[Config.Lan]["smoke"].yellow,                           txt = app7,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 255, B = 0 } } },
    { header = Loc[Config.Lan]["smoke"].gshower,                          txt = app8,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 150, B = 0 } } },
    { header = Loc[Config.Lan]["smoke"].orange,                           txt = app9,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 62, B = 0 } } },
    { header = Loc[Config.Lan]["smoke"].red,                              txt = app10, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 1, B = 1 } } },
    { header = Loc[Config.Lan]["smoke"].ppink,                            txt = app11, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 50, B = 100 } } },
    { header = Loc[Config.Lan]["smoke"].hpink,                            txt = app12, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 5, B = 190 } } },
    { header = Loc[Config.Lan]["smoke"].purple,                           txt = app13, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 35, G = 1, B = 255 } } },
    { header = Loc[Config.Lan]["smoke"].blacklight,                       txt = app14, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 15, G = 3, B = 255 } } },
  })
end)

RegisterNetEvent('jim-mechanic:client:smokeCustomMenu', function()
  local dialog = exports['qb-input']:ShowInput({
    header = Loc[Config.Lan]["smoke"].custom,
    submitText = "Submit",
    inputs = {
      { type = 'number', isRequired = true, name = 'R', text = 'R' },
      { type = 'number', isRequired = true, name = 'G', text = 'G' },
      { type = 'number', isRequired = true, name = 'B', text = 'B' } }
  })
  if dialog then
    if not dialog.R or not dialog.G or not dialog.B then return end
    local data = { R = tonumber(dialog.R), G = tonumber(dialog.G), B = tonumber(dialog.B) }
    TriggerEvent('jim-mechanic:client:Tires:Apply', data)
  end
end)

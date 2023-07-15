--========================================================== Paint

local spraycan = nil
RegisterNetEvent('jim-mechanic:client:Paints:Apply', function(data)
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  local vehicle
  if not IsPedInAnyVehicle(playerPed, false) then
    vehicle = getClosest(coords)
    pushVehicle(vehicle)
    lookVeh(vehicle)
  else
    vehicle = GetVehiclePedIsIn(playerPed, false)
    pushVehicle(vehicle)
  end
  local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
  local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
  if data.paint == Loc[Config.Lan]["paint"].primary then colourCheck = vehPrimaryColour end
  if data.paint == Loc[Config.Lan]["paint"].secondary then colourCheck = vehSecondaryColour end
  if data.paint == Loc[Config.Lan]["paint"].pearl then colourCheck = vehPearlescentColour end
  if data.paint == Loc[Config.Lan]["paint"].wheel then colourCheck = vehWheelColour end
  if colourCheck == data.id then
    triggerNotify(nil, data.finish .. " " .. data.name .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Paints:Choose:Paint', data)
  elseif colourCheck ~= data.id then
    spraycan = makeProp({ prop = `ng_proc_spraycan01b`, coords = vec4(0.0, 0.0, 0.0, 0.0) }, 0, 1)
    AttachEntityToEntity(spraycan, playerPed, GetPedBoneIndex(playerPed, 57005), 0.11, 0.05, -0.06, 28.0, 30.0, 0.0, true, true, false, true, 1, true)
    playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar", 2000, 8)
    Wait(2000)
    local time = math.random(3000, 4000)
    CreateThread(function()
      Wait(900)
      loadPtfxDict("core")
      local color = { 255, 255, 255 }
      UseParticleFxAssetNextCall("core")
      if string.find(data.name, "Red") then color = { 255, 1, 1 } end
      if string.find(data.name, "Black") then color = { 1, 1, 1 } end
      if string.find(data.name, "Blue") then color = { 2, 21, 255 } end
      if string.find(data.name, "Green") then color = { 94, 255, 1 } end
      if string.find(data.name, "Yellow") then color = { 255, 255, 0 } end
      if string.find(data.name, "Orange") then color = { 255, 62, 1 } end
      if string.find(data.name, "Pink") then color = { 255, 50, 100 } end
      if string.find(data.name, "Purple") then color = { 159, 43, 104 } end
      setanimDict = "switch@franklin@lamar_tagging_wall"
      setanim = "lamar_tagging_exit_loop_lamar"
      setflags = 8
      settask = nil
      local spray = StartParticleFxLoopedOnEntity("ent_amb_steam", spraycan, 0.0, 0.13, 0.0, 90.0, 90.0, 0.0, 0.2, 0.0, 0.0, 0.0)
      SetParticleFxLoopedAlpha(spray, 255.0)
      SetParticleFxLoopedColour(spray, color[1] / 255, color[2] / 255, color[3] / 255)
    end)
    stopAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar")
    playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_exit_loop_lamar", time, 8)

    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. data.paint .. " " .. data.finish .. " " .. data.name, time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { task = settask, animDict = setanimDict, anim = setanim, flags = setflag, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        qblog("`paintcan - " ..
          QBCore.Shared.Items["paintcan"].label .. " - " .. data.paint .. " " .. data.finish .. " " .. data.name .. "` installed [**" ..
          trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        if data.paint == Loc[Config.Lan]["paint"].primary then
          ClearVehicleCustomPrimaryColour(vehicle)
          SetVehicleColours(vehicle, data.id, vehSecondaryColour)
        elseif data.paint == Loc[Config.Lan]["paint"].secondary then
          ClearVehicleCustomSecondaryColour(vehicle)
          SetVehicleColours(vehicle, vehPrimaryColour, data.id)
        elseif data.paint == Loc[Config.Lan]["paint"].pearl then
          SetVehicleExtraColours(vehicle, data.id, vehWheelColour)
        elseif data.paint == Loc[Config.Lan]["paint"].wheel then
          SetVehicleExtraColours(vehicle, vehPearlescentColour, data.id)
        elseif data.paint == Loc[Config.Lan]["paint"].dashboard then
          SetVehicleDashboardColour(vehicle, data.id)
        elseif data.paint == Loc[Config.Lan]["paint"].interior then
          SetVehicleInteriorColour(vehicle, data.id)
        end

        triggerNotify(nil, Loc[Config.Lan]["paint"].installed, "success")
        if Config.CosmeticRemoval then
          toggleItem(false, "paintcan")
        else
          TriggerEvent('jim-mechanic:client:Paints:Choose:Paint', data)
        end
        emptyHands(playerPed)
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["paint"].failed, "error")
        TriggerEvent('jim-mechanic:client:Paints:Choose:Paint', data)
        emptyHands(playerPed)
      end, "paintcan")
  end
end)

RegisterNetEvent('jim-mechanic:client:Paints:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  if not nearPoint(coords) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(playerPed, false) then
    vehicle = getClosest(coords)
    pushVehicle(vehicle)
    lookVeh(vehicle)
  else
    vehicle = GetVehiclePedIsIn(playerPed, false)
    pushVehicle(vehicle)
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
    local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
    local interiorColor = GetVehicleInteriorColor(vehicle)
    local dashboardColor = GetVehicleDashboardColour(vehicle)

    for k, v in pairs(Loc[Config.Lan]) do
      if tostring(k) == "vehicleResprayOptionsClassic" or tostring(k) == "vehicleResprayOptionsMatte" or tostring(k) == "vehicleResprayOptionsMetals" or tostring(k) == "vehicleResprayOptionsChameleon" then
        for _, paint in pairs(v) do
          local text = ""
          if k == "vehicleResprayOptionsClassic" then text = Loc[Config.Lan]["paint"].metallic end
          if k == "vehicleResprayOptionsMatte" then text = Loc[Config.Lan]["paint"].matte end

          if vehPrimaryColour == paint.id then vehPrimaryColour = text .. " " .. paint.name end
          if vehSecondaryColour == paint.id then vehSecondaryColour = text .. " " .. paint.name end
          if vehPearlescentColour == paint.id then vehPearlescentColour = text .. " " .. paint.name end
          if vehWheelColour == paint.id then vehWheelColour = text .. " " .. paint.name end
          if interiorColor == paint.id then interiorColor = text .. " " .. paint.name end
          if dashboardColor == paint.id then dashboardColor = text .. " " .. paint.name end
        end
      end
    end
    if type(vehPrimaryColour) == "number" then vehPrimaryColour = Loc[Config.Lan]["common"].stock end
    if type(vehSecondaryColour) == "number" then vehSecondaryColour = Loc[Config.Lan]["common"].stock end
    if type(vehPearlescentColour) == "number" then vehPearlescentColour = Loc[Config.Lan]["common"].stock end
    if type(vehWheelColour) == "number" then vehWheelColour = Loc[Config.Lan]["common"].stock end
    if type(interiorColor) == "number" then interiorColor = Loc[Config.Lan]["common"].stock end
    if type(dashboardColor) == "number" then dashboardColor = Loc[Config.Lan]["common"].stock end
    local PaintMenu = {
      { icon = "paintcan", header = searchCar(vehicle) .. Loc[Config.Lan]["paint"].menuheader, txt = "", isMenuHeader = true },
      {
        icon = "fas fa-circle-xmark",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
        params = {
          event = "jim-mechanic:client:Menu:Close" }
      }, }
    if not IsPedInAnyVehicle(playerPed, false) then
      PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["xenons"].customheader, params = { event = "jim-mechanic:client:rgbORhex" } }
      PaintMenu[#PaintMenu + 1] = {
        header = Loc[Config.Lan]["paint"].primary,
        txt = Loc[Config.Lan]["common"].current .. ": " .. vehPrimaryColour,
        params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].primary }
      }
      PaintMenu[#PaintMenu + 1] = {
        header = Loc[Config.Lan]["paint"].secondary,
        txt = Loc[Config.Lan]["common"].current .. ": " .. vehSecondaryColour,
        params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].secondary }
      }
      PaintMenu[#PaintMenu + 1] = {
        header = Loc[Config.Lan]["paint"].pearl,
        txt = Loc[Config.Lan]["common"].current .. ": " .. vehPearlescentColour,
        params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].pearl }
      }
      PaintMenu[#PaintMenu + 1] = {
        header = Loc[Config.Lan]["paint"].wheel,
        txt = Loc[Config.Lan]["common"].current .. ": " .. vehWheelColour,
        params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].wheel }
      }
    else
      PaintMenu[#PaintMenu + 1] = {
        header = Loc[Config.Lan]["paint"].interior,
        txt = Loc[Config.Lan]["common"].current .. ": " .. interiorColor,
        params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].interior }
      }
      PaintMenu[#PaintMenu + 1] = {
        header = Loc[Config.Lan]["paint"].dashboard,
        txt = Loc[Config.Lan]["common"].current .. ": " .. dashboardColor,
        params = { event = "jim-mechanic:client:Paints:Choose", args = Loc[Config.Lan]["paint"].dashboard }
      }
    end
    exports['qb-menu']:openMenu(PaintMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Paints:Choose', function(data)
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  if not nearPoint(coords) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(playerPed, false) then
    vehicle = getClosest(coords)
    pushVehicle(vehicle)
  else
    vehicle = GetVehiclePedIsIn(playerPed, false)
    pushVehicle(vehicle)
  end
  if DoesEntityExist(vehicle) then
    local PaintMenu = {
      { icon = "paintcan", header = data .. Loc[Config.Lan]["paint"].menuheader, txt = "", isMenuHeader = true },
      {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = {
          event = "jim-mechanic:client:Paints:Check" }
      }, }

    PaintMenu[#PaintMenu + 1] = {
      header = Loc[Config.Lan]["paint"].classic,
      txt = "",
      params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = Loc[Config.Lan]["paint"].classic } }
    }
    PaintMenu[#PaintMenu + 1] = {
      header = Loc[Config.Lan]["paint"].metallic,
      txt = "",
      params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = Loc[Config.Lan]["paint"].metallic } }
    }
    PaintMenu[#PaintMenu + 1] = {
      header = Loc[Config.Lan]["paint"].matte,
      txt = "",
      params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = Loc[Config.Lan]["paint"].matte } }
    }
    PaintMenu[#PaintMenu + 1] = {
      header = Loc[Config.Lan]["paint"].metals,
      txt = "",
      params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = Loc[Config.Lan]["paint"].metals } }
    }
    if Config.Chameleon and (data ~= Loc[Config.Lan]["paint"].interior and data ~= Loc[Config.Lan]["paint"].dashboard) then
      PaintMenu[#PaintMenu + 1] = {
        header = Loc[Config.Lan]["paint"].chameleon,
        txt = "",
        params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = Loc[Config.Lan]["paint"].chameleon } }
      }
    end
    exports['qb-menu']:openMenu(PaintMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Paints:Choose:Paint', function(data)
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  if not nearPoint(coords) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(playerPed, false) then
    vehicle = getClosest(coords)
    pushVehicle(vehicle)
  else
    vehicle = GetVehiclePedIsIn(playerPed, false)
    pushVehicle(vehicle)
  end
  local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
  local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
  if data.paint == Loc[Config.Lan]["paint"].primary then colourCheck = vehPrimaryColour end
  if data.paint == Loc[Config.Lan]["paint"].secondary then colourCheck = vehSecondaryColour end
  if data.paint == Loc[Config.Lan]["paint"].pearl then colourCheck = vehPearlescentColour end
  if data.paint == Loc[Config.Lan]["paint"].wheel then colourCheck = vehWheelColour end
  if data.paint == Loc[Config.Lan]["paint"].dashboard then colourCheck = GetVehicleDashboardColour(vehicle) end
  if data.paint == Loc[Config.Lan]["paint"].interior then colourCheck = GetVehicleInteriorColour(vehicle) end
  if DoesEntityExist(vehicle) then
    local PaintMenu = {
      { isMenuHeader = true, icon = "paintcan", header = data.finish .. " " .. data.paint, txt = "" },
      {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = {
          event = "jim-mechanic:client:Paints:Choose", args = data.paint }
      }, }
    local installed = nil
    if data.finish == Loc[Config.Lan]["paint"].classic then
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
        local icon = ""
        local disabled = false
        if colourCheck == v.id then
          installed = Loc[Config.Lan]["common"].current
          icon = "fas fa-check"
          disabled = true
        else
          installed = ""
        end
        PaintMenu[#PaintMenu + 1] = {
          icon = icon,
          isMenuHeader = disabled,
          header = k .. ". " .. v.name,
          txt = installed,
          params = { event = 'jim-mechanic:client:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } }
        }
      end
    elseif data.finish == Loc[Config.Lan]["paint"].metallic then
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
        local icon = ""
        local disabled = false
        if colourCheck == v.id then
          installed = Loc[Config.Lan]["common"].current
          icon = "fas fa-check"
          disabled = true
        else
          installed = ""
        end
        PaintMenu[#PaintMenu + 1] = {
          icon = icon,
          isMenuHeader = disabled,
          header = k .. ". " .. v.name,
          txt = installed,
          params = { event = 'jim-mechanic:client:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } }
        }
      end
    elseif data.finish == Loc[Config.Lan]["paint"].matte then
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
        local icon = ""
        local disabled = false
        if colourCheck == v.id then
          installed = Loc[Config.Lan]["common"].current
          icon = "fas fa-check"
          disabled = true
        else
          installed = ""
        end
        PaintMenu[#PaintMenu + 1] = {
          icon = icon,
          isMenuHeader = disabled,
          header = k .. ". " .. v.name,
          txt = installed,
          params = { event = 'jim-mechanic:client:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } }
        }
      end
    elseif data.finish == Loc[Config.Lan]["paint"].metals then
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
        local icon = ""
        local disabled = false
        if colourCheck == v.id then
          installed = Loc[Config.Lan]["common"].current
          icon = "fas fa-check"
          disabled = true
        else
          installed = ""
        end
        PaintMenu[#PaintMenu + 1] = {
          icon = icon,
          isMenuHeader = disabled,
          header = k .. ". " .. v.name,
          txt = installed,
          params = { event = 'jim-mechanic:client:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } }
        }
      end
    elseif data.finish == Loc[Config.Lan]["paint"].chameleon then
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsChameleon) do
        local icon = ""
        local disabled = false
        if colourCheck == v.id then
          installed = Loc[Config.Lan]["common"].current
          icon = "fas fa-check"
          disabled = true
        else
          installed = ""
        end
        PaintMenu[#PaintMenu + 1] = {
          icon = icon,
          isMenuHeader = disabled,
          header = k .. ". " .. v.name,
          txt = installed,
          params = { event = 'jim-mechanic:client:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } }
        }
      end
    end
    exports['qb-menu']:openMenu(PaintMenu)
  end
end)

local spraying = false
RegisterNetEvent('jim-mechanic:client:RGBApply', function(data)
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local vehicle = getClosest(coords)
  local r, g, b = table.unpack({ 255, 255, 255 })
  if data.hex then
    r, g, b = HexTorgb(data.hex)
  else
    if data.r >= 255 then r = 255 elseif data.r <= 0 then r = 0 else r = data.r end
    if data.g >= 255 then g = 255 elseif data.g <= 0 then g = 0 else g = data.g end
    if data.b >= 255 then b = 255 elseif data.b <= 0 then b = 0 else b = data.b end
  end

  spraycan = makeProp({ prop = `ng_proc_spraycan01b`, coords = vec4(0.0, 0.0, 0.0, 0.0) }, 0, 1)
  AttachEntityToEntity(spraycan, playerPed, GetPedBoneIndex(playerPed, 57005), 0.11, 0.05, -0.06, 28.0, 30.0, 0.0, true, true, false, true, 1, true)
  playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar", 2000, 8)
  Wait(2000)
  stopAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar", 2000, 8)
  playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_exit_loop_lamar", 10000, 1)
  Wait(1000)

  local colorPrimary, colorSecondary = GetVehicleColours(vehicle)

  spraycan = makeProp({ prop = `ng_proc_spraycan01b`, coords = vec4(0.0, 0.0, 0.0, 0.0) }, 0, 1)
  AttachEntityToEntity(spraycan, playerPed, GetPedBoneIndex(playerPed, 57005), 0.11, 0.05, -0.06, 28.0, 30.0, 0.0, true, true, false, true, 1, true)
  CreateThread(function()
    loadPtfxDict("core")
    UseParticleFxAssetNextCall("core")
    local spray = StartParticleFxLoopedOnEntity("ent_amb_steam", spraycan, 0.0, 0.13, 0.05, 90.0, 90.0, 0.0, 0.2, 0.0, 0.0, 0.0)
    SetParticleFxLoopedAlpha(spray, 255.0)
    SetParticleFxLoopedColour(spray, r / 255, g / 255, b / 255)
  end)

  -- Set car to white/base coat
  if data.select == "pri" then
    SetVehicleCustomPrimaryColour(vehicle, 1.0, 1.0, 1.0)
    SetVehicleColours(vehicle, data.finish, colorSecondary)
  elseif data.select == "sec" then
    SetVehicleCustomSecondaryColour(vehicle, 1.0, 1.0, 1.0)
    SetVehicleColours(vehicle, colorPrimary, data.finish)
  end

  local rd, gd, bd = table.unpack({ 255, 255, 255 }) --Base Coat Numbers

  while rd ~= r or gd ~= g or bd ~= b do
    if rd ~= r then rd = rd - 1 end
    if gd ~= g then gd = gd - 1 end
    if bd ~= b then bd = bd - 1 end
    if data.select == "pri" then
      SetVehicleCustomPrimaryColour(vehicle, rd, gd, bd)
    elseif data.select == "sec" then
      SetVehicleCustomSecondaryColour(vehicle, rd, gd, bd)
    end
    Wait(20)
  end
  spraying = false

  SetVehicleModKit(vehicle, 0)
  qblog("`paintcan - " .. QBCore.Shared.Items["paintcan"].label .. " - {" .. r .. ", " .. g .. ", " .. b .. "}` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
  if Config.CosmeticRemoval then
    toggleItem(false, "paintcan")
  else
    TriggerEvent("jim-mechanic:client:rgbORhex")
  end
  emptyHands(playerPed)
end)

RegisterNetEvent('jim-mechanic:client:RGBPicker', function()
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  local r, g, b = GetVehicleCustomPrimaryColour(vehicle)
  local priCol = "[<span style='color:#" ..
      rgbToHex(GetVehicleCustomPrimaryColour(vehicle)):upper() ..
      "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> " .. r .. " " .. g .. " " .. b .. " </span>]"
  local r, g, b = GetVehicleCustomSecondaryColour(vehicle)
  local secCol = "[<span style='color:#" ..
      rgbToHex(GetVehicleCustomSecondaryColour(vehicle)):upper() ..
      "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> " .. r .. " " .. g .. " " .. b .. " </span>]"
  if DoesEntityExist(vehicle) then
    local dialog = exports['qb-input']:ShowInput({
      header = "<center>" .. Loc[Config.Lan]["paintrgb"].rgb
          .. "<br><br>- " .. Loc[Config.Lan]["paint"].primary .. " -<br>" .. priCol
          .. "<br>- " .. Loc[Config.Lan]["paint"].secondary .. " -<br>" .. secCol,
      inputs = {
        { type = 'number', name = 'Red',   text = 'R' },
        { type = 'number', name = 'Green', text = 'G' },
        { type = 'number', name = 'Blue',  text = 'B' },
        {
          type = 'radio',
          name = 'select',
          text = Loc[Config.Lan]["paintrgb"].select,
          options = { { value = "pri", text = Loc[Config.Lan]["paint"].primary },
            { value = "sec", text = Loc[Config.Lan]["paint"].secondary } }
        },
        {
          type = 'radio',
          name = 'finish',
          text = Loc[Config.Lan]["paintrgb"].finish,
          options = { { value = "147", text = Loc[Config.Lan]["paint"].classic },
            { value = "12",  text = Loc[Config.Lan]["paint"].matte },
            { value = "120", text = Loc[Config.Lan]["paintrgb"].chrome } }
        } }
    })
    if dialog then
      local r, g, b = table.unpack({ (tonumber(dialog.Red) or 0), (tonumber(dialog.Green) or 0), (tonumber(dialog.Blue) or 0) })
      if r > 255 then r = 255 end
      if g > 255 then g = 255 end
      if b > 255 then b = 255 end
      if not dialog.Red or not dialog.Green or not dialog.Blue then return TriggerEvent("jim-mechanic:client:RGBPicker") end
      TriggerEvent('jim-mechanic:client:RGBApply', { finish = tonumber(dialog.finish), select = dialog.select, r = r, g = g, b = b })
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:HEXPicker', function()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local vehicle = getClosest(coords)
  local priCol = "[ #<span style='color:#" ..
      rgbToHex(GetVehicleCustomPrimaryColour(vehicle)):upper() ..
      "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'>" ..
      rgbToHex(GetVehicleCustomPrimaryColour(vehicle)):upper() .. " </span>]"
  local secCol = "[ #<span style='color:#" ..
      rgbToHex(GetVehicleCustomSecondaryColour(vehicle)):upper() ..
      "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'>" ..
      rgbToHex(GetVehicleCustomSecondaryColour(vehicle)):upper() .. " </span>]"
  if DoesEntityExist(vehicle) then
    local dialog = exports['qb-input']:ShowInput({
      header = "<center>" .. Loc[Config.Lan]["paintrgb"].hex
          .. "<br><br>- " .. Loc[Config.Lan]["paint"].primary .. " -<br>" .. priCol
          .. "<br>- " .. Loc[Config.Lan]["paint"].secondary .. " -<br>" .. secCol,
      submitText = Loc[Config.Lan]["xenons"].customconfirm,
      inputs = {
        { type = 'text', name = 'hex', text = '#' },
        {
          type = 'radio',
          name = 'select',
          text = Loc[Config.Lan]["paintrgb"].select,
          options = { { value = "pri", text = Loc[Config.Lan]["paint"].primary },
            { value = "sec", text = Loc[Config.Lan]["paint"].secondary } }
        },
        {
          type = 'radio',
          name = 'finish',
          text = Loc[Config.Lan]["paintrgb"].finish,
          options = { { value = "147", text = Loc[Config.Lan]["paint"].classic },
            { value = "12",  text = Loc[Config.Lan]["paint"].matte },
            { value = "120", text = Loc[Config.Lan]["paintrgb"].chrome } }
        } }
    })
    if dialog then
      if not dialog.hex then return TriggerEvent("jim-mechanic:client:HEXPicker") end
      if dialog.hex then
        local hex = dialog.hex:gsub("#", "")
        while string.len(hex) < 6 do
          hex = hex .. "0"
          Wait(10)
        end
        local r, g, b = HexTorgb(hex)
        TriggerEvent('jim-mechanic:client:RGBApply', { finish = tonumber(dialog.finish), select = dialog.select, r = r, g = g, b = b })
      end
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:rgbORhex', function()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local vehicle = getClosest(coords)
  if not inCar() then return end
  if DoesEntityExist(vehicle) then
    local r, g, b = GetVehicleCustomPrimaryColour(vehicle)
    priRGBCol = Loc[Config.Lan]["paint"].primary ..
        ": [<span style='color:#" ..
        rgbToHex(r, g, b):upper() ..
        "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> " .. r .. " " .. g .. " " .. b .. " </span>]<br>"
    priHexCol = Loc[Config.Lan]["paint"].primary ..
        ": [ #<span style='color:#" ..
        rgbToHex(r, g, b):upper() ..
        "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'>" .. rgbToHex(r, g, b):upper() .. " </span>]<br>"
    local r, g, b = GetVehicleCustomSecondaryColour(vehicle)
    secRGBCol = Loc[Config.Lan]["paint"].secondary ..
        ": [<span style='color:#" ..
        rgbToHex(r, g, b):upper() .. "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> " .. r ..
        " " .. g .. " " .. b .. " </span>]"
    secHexCol = Loc[Config.Lan]["paint"].secondary ..
        ": [ #<span style='color:#" ..
        rgbToHex(r, g, b):upper() ..
        "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'>" .. rgbToHex(r, g, b):upper() .. " </span>]"
    local PaintMenu = {}
    PaintMenu[#PaintMenu + 1] = { icon = "paintcan", header = Loc[Config.Lan]["paint"].menuheader, text = Loc[Config.Lan]["paintrgb"].customheader, isMenuHeader = true }
    PaintMenu[#PaintMenu + 1] = {
      icon = "fas fa-circle-arrow-left",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
      params = { event = "jim-mechanic:client:Paints:Check" }
    }
    PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paintrgb"].hex, text = priHexCol .. secHexCol, params = { event = "jim-mechanic:client:HEXPicker" }, }
    PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paintrgb"].rgb, text = priRGBCol .. secRGBCol, params = { event = "jim-mechanic:client:RGBPicker" }, }
    exports['qb-menu']:openMenu(PaintMenu)
  end
end)

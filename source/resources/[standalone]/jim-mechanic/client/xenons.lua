RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() GetXenonColour() end)

local xenonColour = {}

function GetXenonColour()
  local p = promise.new()
  QBCore.Functions.TriggerCallback('jim-mechanic:GetXenonColour', function(cb) p:resolve(cb) end)
  newxenonColour = Citizen.Await(p)
  for k, v in pairs(newxenonColour) do xenonColour[k] = v end
  for k, v in pairs(xenonColour) do
    if NetworkDoesEntityExistWithNetworkId(k) then
      if IsEntityAVehicle(k) then
        if k ~= 0 or DoesEntityExist(k) then SetVehicleXenonLightsCustomColor(k, v[1], v[2], v[3]) end
      end
    end
  end
end

--========================================================== Headlights
RegisterNetEvent('jim-mechanic:client:applyXenons', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
    lookVeh(vehicle)
    distanceToL = #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "headlight_l")))
    distanceToR = #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "headlight_r")))
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    local currentEngine = GetVehicleMod(vehicle, 11)
    if GetNumVehicleMods(vehicle, 11) == 0 then
      triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
      return
    end
    if distanceToL <= 1 or distanceToR <= 1 then
      if IsToggleModOn(vehicle, 22) then
        triggerNotify(nil, Loc[Config.Lan]["common"].already, "error")
      else
        QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["xenons"].install, math.random(3000, 7000), false, true,
          { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
          { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
            SetVehicleModKit(vehicle, 0)
            if IsToggleModOn(vehicle, 22) then
              TriggerServerEvent("jim-mechanic:server:DupeWarn", "headlights")
              emptyHands(playerPed)
              return
            end
            qblog("`" .. QBCore.Shared.Items["headlights"].label .. " - headlights` installed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
            ToggleVehicleMod(vehicle, 22, true)
            SetVehicleMod(vehicle, 11, currentEngine) -- Attempt to keep the engine as its current level after adding xenons

            toggleItem(false, "headlights")
            triggerNotify(nil, Loc[Config.Lan]["xenons"].installed, "success")
            emptyHands(PlayerPedId())
          end, function() -- Cancel
            triggerNotify(nil, Loc[Config.Lan]["xenons"].failed, "error")
            emptyHands(PlayerPedId())
          end, "headlights")
      end
    else
      triggerNotify(nil, Loc[Config.Lan]["xenons"].closer, "error")
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:giveXenon', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  local headlightl = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "headlight_l"))
  local headlightr = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "headlight_r"))
  local playerpos = GetEntityCoords(PlayerPedId(), 1)
  distanceToL = #(playerpos - headlightl)
  distanceToR = #(playerpos - headlightr)
  if distanceToR <= 1 or distanceToL <= 1 then
    QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["xenons"].removing, math.random(3000, 7000), false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        if not IsToggleModOn(vehicle, 22) then
          TriggerServerEvent("jim-mechanic:server:DupeWarn", "headlights")
          emptyHands(playerPed)
          return
        end
        qblog("`" .. QBCore.Shared.Items["headlights"].label .. " - headlights` removed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        ToggleVehicleMod(vehicle, 22, false)
        SetVehicleXenonLightsColor(vehicle, 0)
        emptyHands(PlayerPedId())

        toggleItem(true, "headlights")
        triggerNotify(nil, Loc[Config.Lan]["xenons"].remove, "success")
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["xenons"].remfail, "error")
        emptyHands(PlayerPedId())
      end, "headlights")
  else
    triggerNotify(nil, Loc[Config.Lan]["xenons"].closer, "error")
  end
end)

RegisterNetEvent('jim-mechanic:client:neonMenu', function()
  local bike = false
  if not outCar() then return end
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  pushVehicle(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if IsThisModelABike(GetEntityModel(vehicle)) or IsThisModelAQuadbike(GetEntityModel(vehicle)) then bike = true end
  if bike and not IsToggleModOn(vehicle, 22) then
    triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
    return
  end
  local NeonMenu = {
    { icon = "underglow_controller", isMenuHeader = true, header = Loc[Config.Lan]["xenons"].neonheader1, },
    { icon = "fas fa-circle-xmark",  header = "",         txt = Loc[Config.Lan]["common"].close,          params = { event = "jim-mechanic:Menu:Close" } } }
  if not bike then NeonMenu[#NeonMenu + 1] = { header = Loc[Config.Lan]["xenons"].neonheader2, txt = "", params = { event = "jim-mechanic:client:neonLightsMenu", } } end

  if IsToggleModOn(vehicle, 22) then NeonMenu[#NeonMenu + 1] = { header = Loc[Config.Lan]["xenons"].neonheader4, txt = "", params = { event = "jim-mechanic:client:xenonMenu", } } end
  exports['qb-menu']:openMenu(NeonMenu)
end)

RegisterNetEvent('jim-mechanic:client:neonLightsMenu', function()
  local bike = false
  if not outCar() then return end
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  pushVehicle(vehicle)
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if IsThisModelABike(GetEntityModel(vehicle)) or IsThisModelAQuadbike(GetEntityModel(vehicle)) then bike = true end
  if bike and not IsToggleModOn(vehicle, 22) then
    triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
    return
  end
  local NeonMenu = {
    { icon = "underglow_controller",     isMenuHeader = true, header = Loc[Config.Lan]["xenons"].neonheader2, },
    { icon = "fas fa-circle-arrow-left", header = "",         txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""), params = { event = "jim-mechanic:client:neonMenu", } } }
  if not bike then NeonMenu[#NeonMenu + 1] = { header = Loc[Config.Lan]["xenons"].neonheader2, txt = "", params = { event = "jim-mechanic:client:neonToggleMenu", } } end
  if not bike then NeonMenu[#NeonMenu + 1] = { header = Loc[Config.Lan]["xenons"].neonheader3, txt = "", params = { event = "jim-mechanic:client:neonColorMenu", } } end
  exports['qb-menu']:openMenu(NeonMenu)
end)

RegisterNetEvent('jim-mechanic:client:applyNeonPostion', function(args)
  local args = tonumber(args)
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  SetVehicleEngineOn(vehicle, true, true)
  animActive = false
  if args == -1 then
    if not IsVehicleNeonLightEnabled(vehicle, 2) or not IsVehicleNeonLightEnabled(vehicle, 1) or not IsVehicleNeonLightEnabled(vehicle, 3) or not IsVehicleNeonLightEnabled(vehicle, 0) then
      for i = 0, 4 do
        SetVehicleNeonLightEnabled(vehicle, i, true)
        Wait(50)
      end
    else
      for i = 0, 4 do
        SetVehicleNeonLightEnabled(vehicle, i, false)
        Wait(50)
      end
    end
  else
    if IsVehicleNeonLightEnabled(vehicle, args) then SetVehicleNeonLightEnabled(vehicle, args, false) else SetVehicleNeonLightEnabled(vehicle, args, true) end
  end

  TriggerEvent("jim-mechanic:client:neonToggleMenu")
end)

RegisterNetEvent('jim-mechanic:client:applyNeonColor', function(data)
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  SetVehicleEngineOn(vehicle, true, false)
  SetVehicleNeonLightsColour(vehicle, data[1], data[2], data[3])

  TriggerEvent("jim-mechanic:client:neonColorMenu")
end)

RegisterNetEvent('jim-mechanic:client:neonCustomMenu', function()
  local dialog = exports['qb-input']:ShowInput({
    header = Loc[Config.Lan]["xenons"].customheader,
    submitText = Loc[Config.Lan]["xenons"].customconfirm,
    inputs = {
      { type = 'number', name = 'Red',   text = 'R' },
      { type = 'number', name = 'Green', text = 'G' },
      { type = 'number', name = 'Blue',  text = 'B' } }
  })
  if dialog then
    local r, g, b = table.unpack({ (tonumber(dialog.Red) or 0), (tonumber(dialog.Green) or 0), (tonumber(dialog.Blue) or 0) })
    if r > 255 then r = 255 end
    if g > 255 then g = 255 end
    if b > 255 then b = 255 end
    if not dialog.Red or not dialog.Green or not dialog.Blue then return end
    TriggerEvent('jim-mechanic:client:applyNeonColor', { r, g, b })
  end
end)

RegisterNetEvent('jim-mechanic:client:neonToggleMenu', function()
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  if IsVehicleNeonLightEnabled(vehicle, 2) then fHead = "fas fa-check" else fHead = "fas fa-x" end
  if IsVehicleNeonLightEnabled(vehicle, 1) then rHead = "fas fa-check" else rHead = "fas fa-x" end
  if IsVehicleNeonLightEnabled(vehicle, 3) then bHead = "fas fa-check" else bHead = "fas fa-x" end
  if IsVehicleNeonLightEnabled(vehicle, 0) then lHead = "fas fa-check" else lHead = "fas fa-x" end
  exports['qb-menu']:openMenu({
    { icon = "underglow_controller",             header = Loc[Config.Lan]["xenons"].neonheader3, txt = Loc[Config.Lan]["xenons"].neontxt1,                              isMenuHeader = true },
    {
      icon = "fas fa-circle-arrow-left",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
      params = {
        event = "jim-mechanic:client:neonLightsMenu", }
    },
    { header = Loc[Config.Lan]["xenons"].toggle, txt = "",                                       params = { event = "jim-mechanic:client:applyNeonPostion", args = -1 } },
    {
      icon = fHead,
      header = Loc[Config.Lan]["xenons"].front,
      txt = "",
      params = {
        event = "jim-mechanic:client:applyNeonPostion", args = 2 }
    },
    {
      icon = rHead,
      header = Loc[Config.Lan]["xenons"].right,
      txt = "",
      params = {
        event = "jim-mechanic:client:applyNeonPostion", args = 1 }
    },
    {
      icon = bHead,
      header = Loc[Config.Lan]["xenons"].back,
      txt = "",
      params = {
        event = "jim-mechanic:client:applyNeonPostion", args = 3 }
    },
    {
      icon = lHead,
      header = Loc[Config.Lan]["xenons"].left,
      txt = "",
      params = {
        event = "jim-mechanic:client:applyNeonPostion", args = 0 }
    },
  })
end)

RegisterNetEvent('jim-mechanic:client:neonColorMenu', function()
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  pushVehicle(vehicle)
  vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
  local validMods = {}
  local r, g, b = GetVehicleNeonLightsColour(vehicle)
  local XenonMenu = {}
  XenonMenu[#XenonMenu + 1] = {
    icon = "underglow_controller",
    header = Loc[Config.Lan]["xenons"].neonheader3,
    txt = Loc[Config.Lan]["xenons"].neontxt2 ..
        "<br>R:" ..
        r ..
        " G:" ..
        g ..
        " B:" ..
        b ..
        "<span style='color:#" ..
        rgbToHex(GetVehicleNeonLightsColour(vehicle)):upper() ..
        "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> ⯀ </span>",
    isMenuHeader = true
  }
  XenonMenu[#XenonMenu + 1] = {
    icon = "fas fa-circle-arrow-left",
    header = "",
    txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
    params = { event = "jim-mechanic:client:neonLightsMenu", }
  }
  XenonMenu[#XenonMenu + 1] = { header = Loc[Config.Lan]["xenons"].customheader, txt = "", params = { event = "jim-mechanic:client:neonCustomMenu", } }
  for k, v in pairs(Loc[Config.Lan].vehicleNeonOptions) do
    local icon = ""
    local disabled = false
    if r == v.R and g == v.G and b == v.B then
      installed = Loc[Config.Lan]["common"].current
      icon = "fas fa-check"
      disabled = true
    else
      installed = ""
    end
    XenonMenu[#XenonMenu + 1] = {
      icon = icon,
      isMenuHeader = disabled,
      header = v.name,
      txt = installed,
      params = { event = 'jim-mechanic:client:applyNeonColor', args = { v.R, v.G, v.B } }
    }
  end
  exports['qb-menu']:openMenu(XenonMenu)
end)

RegisterNetEvent('jim-mechanic:client:applyXenonColor', function(data)
  SetVehicleEngineOn(data.vehicle, true, false)
  if data.stock then
    ClearVehicleXenonLightsCustomColor(data.vehicle)
    SetVehicleXenonLightsColor(data.vehicle, -1)
    TriggerServerEvent('jim-mechanic:server:ChangeXenonStock', VehToNet(data.vehicle))
  else
    SetVehicleXenonLightsColor(data.vehicle, -1)
    SetVehicleXenonLightsCustomColor(data.vehicle, data.R, data.G, data.B)
    TriggerServerEvent('jim-mechanic:server:ChangeXenonColour', VehToNet(data.vehicle), { data.R, data.G, data.B })
  end
  Wait(200)
  Wait(100)
  TriggerEvent("jim-mechanic:client:xenonMenu")
end)

RegisterNetEvent('jim-mechanic:client:xenonMenu', function()
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  pushVehicle(vehicle)
  local validMods = {}
  local stockinstall, stockicon = ""
  local custom, r, g, b = GetVehicleXenonLightsCustomColor(vehicle)
  if not IsToggleModOn(vehicle, 22) then
    triggerNotify(nil, Loc[Config.Lan]["xenons"].notinstall, "error")
  else
    local headtxt = ""
    if custom then
      headtxt = "<br>R:" ..
          r ..
          " G:" ..
          g ..
          " B:" ..
          b ..
          " <span style='color:#" ..
          rgbToHex(r, g, b):upper() .. "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> ⯀ </span>"
    else
      stockinstall = Loc[Config.Lan]["common"].current
      stockicon = "fas fa-check"
    end
    local XenonMenu = {
      { icon = "underglow_controller", header = Loc[Config.Lan]["xenons"].xenonheader, txt = Loc[Config.Lan]["xenons"].xenontxt .. headtxt, isMenuHeader = true },
      {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = {
          event = "jim-mechanic:client:neonMenu" }
      },
      {
        header = Loc[Config.Lan]["xenons"].customheader,
        txt = "",
        params = {
          event = "jim-mechanic:client:xenonCustomMenu",
          args = { vehicle = vehicle }
        }
      },
      {
        header = Loc[Config.Lan]["common"].stock,
        txt = stockinstall,
        params = {
          event = "jim-mechanic:client:applyXenonColor",
          args = { vehicle = vehicle, stock = true }
        }
      } }
    for k, v in pairs(Loc[Config.Lan].vehicleNeonOptions) do
      local icon = ""
      local disabled = false
      if r == v.R and g == v.G and b == v.B then
        installed = Loc[Config.Lan]["common"].current
        icon = "fas fa-check"
        disabled = true
      else
        installed = ""
      end
      XenonMenu[#XenonMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = v.name,
        txt = installed,
        params = { event = 'jim-mechanic:client:applyXenonColor', args = { vehicle = vehicle, R = v.R, G = v.G, B = v.B } }
      }
    end
    exports['qb-menu']:openMenu(XenonMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:xenonCustomMenu', function(data)
  local dialog = exports['qb-input']:ShowInput({
    header = Loc[Config.Lan]["xenons"].customheader,
    submitText = Loc[Config.Lan]["xenons"].customconfirm,
    inputs = {
      { type = 'number', name = 'Red',   text = 'R' },
      { type = 'number', name = 'Green', text = 'G' },
      { type = 'number', name = 'Blue',  text = 'B' } }
  })
  if dialog then
    local r, g, b = table.unpack({ (tonumber(dialog.Red) or 0), (tonumber(dialog.Green) or 0), (tonumber(dialog.Blue) or 0) })
    if r > 255 then r = 255 end
    if g > 255 then g = 255 end
    if b > 255 then b = 255 end
    if not dialog.Red or not dialog.Green or not dialog.Blue then return end
    pushVehicle(data.vehicle)
    TriggerServerEvent('jim-mechanic:server:ChangeXenonColour', VehToNet(data.vehicle), { r, g, b })
    SetVehicleXenonLightsColor(data.vehicle, -1)
    Wait(100)
    TriggerEvent('jim-mechanic:client:xenonMenu')
  end
end)

RegisterNetEvent('jim-mechanic:client:ChangeXenonColour', function(netId, newColour)
  if not LocalPlayer.state.isLoggedIn then return end
  xenonColour[netId] = newColour
  for k, v in pairs(xenonColour) do
    if NetworkDoesEntityExistWithNetworkId(k) then
      if k ~= 0 and DoesEntityExist(NetToVeh(k)) then
        SetVehicleXenonLightsCustomColor(NetToVeh(k), v[1], v[2], v[3])
        if Config.Debug then
          print("^5Debug^7: ^2Recieving new ^3Xenon Colour ^7[^6" .. tostring(NetToVeh(k)) .. "^7] = { ^2RBG ^7= ^6" ..
            v[1] .. "^7, ^6" .. v[2] .. "^7, ^6" .. v[3] .. " ^7}")
        end
      end
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:ChangeXenonStock', function(netId)
  if not LocalPlayer.state.isLoggedIn then return end
  if not NetworkDoesEntityExistWithNetworkId(netid) then return end
  xenonColour[netId] = nil
  if DoesEntityExist(NetToVeh(netId)) then
    ClearVehicleXenonLightsCustomColor(NetToVeh(netId))
    SetVehicleXenonLightsColor(NetToVeh(netId), -1)
    if Config.Debug then print("^5Debug^7: ^2Clearing ^3Xenon Colour for vehicle ^7[^6" .. tostring(NetToVeh(netId)) .. "^7]") end
    xenonColour[netId] = nil
  end
end)

CreateThread(function()
  while true do
    for netId, v in pairs(xenonColour) do
      if NetworkDoesEntityExistWithNetworkId(netId) then
        if NetToVeh(netId) ~= 0 and DoesEntityExist(NetToVeh(netId)) and IsEntityAVehicle(NetToVeh(netId)) then
          SetVehicleXenonLightsCustomColor(NetToVeh(netId), v[1], v[2], v[3])
          if Config.Debug then
            print("^5Debug^7: ^2Ensuring ^3Xenon Colour^7[^6" .. tostring(NetToVeh(netId)) .. "^7] = { ^2RBG ^7= ^6" ..
              v[1] .. "^7, ^6" .. v[2] .. "^7, ^6" .. v[3] .. " ^7}")
          end
        end
      end
    end
    Wait(20000)
  end
end)

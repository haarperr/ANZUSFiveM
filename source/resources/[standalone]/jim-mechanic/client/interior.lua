--========================================================== Interior
RegisterNetEvent('jim-mechanic:client:Interior:Apply', function(data)
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  local modName = GetLabelText(GetModTextLabel(vehicle, tonumber(data.bumperid), tonumber(data.mod)))
  if modName == "NULL" then modName = Loc[Config.Lan]["interior"].stockMod end
  if GetVehicleMod(vehicle, tonumber(data.bumperid)) == tonumber(data.mod) then
    triggerNotify(nil, modName .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Interior:Choose', tonumber(data.bumperid))
  elseif GetVehicleMod(vehicle, tonumber(data.bumperid)) ~= tonumber(data.mod) then
    time = math.random(3000, 5000)
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. modName .. "..", time, false, true,
      { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, },
      { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 16, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        qblog("`internals - " .. QBCore.Shared.Items["internals"].label .. " - " .. modName .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleMod(vehicle, tonumber(data.bumperid), tonumber(data.mod))
        emptyHands(PlayerPedId())

        if Config.CosmeticRemoval then
          toggleItem(false, "internals")
        else
          TriggerEvent('jim-mechanic:client:Interior:Choose', tonumber(data.bumperid))
        end
        triggerNotify(nil, Loc[Config.Lan]["interior"].installed, "success")
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["interior"].failed, "error")
        emptyHands(PlayerPedId())
      end, "internals")
  end
end)

RegisterNetEvent('jim-mechanic:client:Interior:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  if not outCar() then return end
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  pushVehicle(vehicle)
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    installed2 = GetLabelText(GetModTextLabel(vehicle, 28, GetVehicleMod(vehicle, 28)))
    if installed2 == "NULL" then installed2 = Loc[Config.Lan]["common"].stock else end
    installed3 = GetLabelText(GetModTextLabel(vehicle, 29, GetVehicleMod(vehicle, 29)))
    if installed3 == "NULL" then installed3 = Loc[Config.Lan]["common"].stock else end
    installed4 = GetLabelText(GetModTextLabel(vehicle, 30, GetVehicleMod(vehicle, 30)))
    if installed4 == "NULL" then installed4 = Loc[Config.Lan]["common"].stock else end
    installed5 = GetLabelText(GetModTextLabel(vehicle, 31, GetVehicleMod(vehicle, 31)))
    if installed5 == "NULL" then installed5 = Loc[Config.Lan]["common"].stock else end
    installed6 = GetLabelText(GetModTextLabel(vehicle, 33, GetVehicleMod(vehicle, 33)))
    if installed6 == "NULL" then installed6 = Loc[Config.Lan]["common"].stock else end
    installed7 = GetLabelText(GetModTextLabel(vehicle, 34, GetVehicleMod(vehicle, 34)))
    if installed7 == "NULL" then installed7 = Loc[Config.Lan]["common"].stock else end
    installed8 = GetLabelText(GetModTextLabel(vehicle, 35, GetVehicleMod(vehicle, 35)))
    if installed8 == "NULL" then installed8 = Loc[Config.Lan]["common"].stock else end
    installed9 = GetLabelText(GetModTextLabel(vehicle, 36, GetVehicleMod(vehicle, 36)))
    if installed9 == "NULL" then installed9 = Loc[Config.Lan]["common"].stock else end

    local internal = nil
    for _, v in pairs({ 28, 29, 30, 31, 33, 34, 35, 36 }) do
      if GetNumVehicleMods(vehicle, v) ~= 0 then
        internal = true
        break
      end
    end
    if internal ~= true then
      triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
      return
    end

    local InteriorMenu = {
      { isMenuHeader = true,          icon = "internals", header = searchCar(vehicle) .. Loc[Config.Lan]["interior"].menuheader, },
      { icon = "fas fa-circle-xmark", header = "",        txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),        params = { event = "jim-mechanic:client:Menu:Close" } } }

    if GetNumVehicleMods(vehicle, 28) ~= 0 then
      InteriorMenu[#InteriorMenu + 1] = {
        header = Loc[Config.Lan]["interior"].label2,
        txt = "[" .. (GetNumVehicleMods(vehicle, 28) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed2,
        params = { event = "jim-mechanic:client:Interior:Choose", args = 28 }
      }
    end
    if GetNumVehicleMods(vehicle, 29) ~= 0 then
      InteriorMenu[#InteriorMenu + 1] = {
        header = Loc[Config.Lan]["interior"].label3,
        txt = "[" .. (GetNumVehicleMods(vehicle, 29) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed3,
        params = { event = "jim-mechanic:client:Interior:Choose", args = 29 }
      }
    end
    if GetNumVehicleMods(vehicle, 30) ~= 0 then
      InteriorMenu[#InteriorMenu + 1] = {
        header = Loc[Config.Lan]["interior"].label4,
        txt = "[" .. (GetNumVehicleMods(vehicle, 30) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed4,
        params = { event = "jim-mechanic:client:Interior:Choose", args = 30 }
      }
    end
    if GetNumVehicleMods(vehicle, 31) ~= 0 then
      InteriorMenu[#InteriorMenu + 1] = {
        header = Loc[Config.Lan]["interior"].label5,
        txt = "[" .. (GetNumVehicleMods(vehicle, 31) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed5,
        params = { event = "jim-mechanic:client:Interior:Choose", args = 31 }
      }
    end
    if GetNumVehicleMods(vehicle, 33) ~= 0 then
      InteriorMenu[#InteriorMenu + 1] = {
        header = Loc[Config.Lan]["interior"].label6,
        txt = "[" .. (GetNumVehicleMods(vehicle, 33) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed6,
        params = { event = "jim-mechanic:client:Interior:Choose", args = 33 }
      }
    end
    if GetNumVehicleMods(vehicle, 34) ~= 0 then
      InteriorMenu[#InteriorMenu + 1] = {
        header = Loc[Config.Lan]["interior"].label7,
        txt = "[" .. (GetNumVehicleMods(vehicle, 34) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed7,
        params = { event = "jim-mechanic:client:Interior:Choose", args = 34 }
      }
    end
    if GetNumVehicleMods(vehicle, 35) ~= 0 then
      InteriorMenu[#InteriorMenu + 1] = {
        header = Loc[Config.Lan]["interior"].label8,
        txt = "[" .. (GetNumVehicleMods(vehicle, 35) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed8,
        params = { event = "jim-mechanic:client:Interior:Choose", args = 35 }
      }
    end
    if GetNumVehicleMods(vehicle, 36) ~= 0 then
      InteriorMenu[#InteriorMenu + 1] = {
        header = Loc[Config.Lan]["interior"].label9,
        txt = "[" .. (GetNumVehicleMods(vehicle, 36) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed9,
        params = { event = "jim-mechanic:client:Interior:Choose", args = 36 }
      }
    end
    exports['qb-menu']:openMenu(InteriorMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Interior:Choose', function(mod)
  local validMods = {}
  if not outCar() then return end
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), true) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    for i = 1, GetNumVehicleMods(vehicle, tonumber(mod)) do
      local modName = GetLabelText(GetModTextLabel(vehicle, tonumber(mod), (i - 1)))
      if GetVehicleMod(vehicle, tonumber(mod)) == (i - 1) then
        txt = Loc[Config.Lan]["common"].current
      elseif GetVehicleMod(vehicle, tonumber(mod)) ~= (i - 1) then
        txt = ""
      end
      validMods[i] = { id = (i - 1), name = modName, install = txt }
    end
  end
  if lockedCar(vehicle) then return end
  if DoesEntityExist(vehicle) then
    local icon = ""
    local disabled = false
    if GetVehicleMod(vehicle, tonumber(mod)) == -1 then
      stockinstall = Loc[Config.Lan]["common"].current
      icon = "fas fa-check"
      disabled = true
    elseif GetVehicleMod(vehicle, tonumber(mod)) ~= -1 then
      stockinstall = ""
    end
    for i = 0, 5 do SetVehicleDoorOpen(vehicle, i, false, false) end
    local ModMenu = {
      {
        isMenuHeader = true,
        icon = "internals",
        header = searchCar(vehicle) .. Loc[Config.Lan]["interior"].menuheader,
        txt = Loc[Config.Lan]["common"]
            .amountoption .. #validMods + 1,
      },
      {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = {
          event = "jim-mechanic:client:Interior:Check" }
      },
      {
        icon = icon,
        isMenuHeader = disabled,
        header = "0. " .. Loc[Config.Lan]["common"].stock,
        txt = stockinstall,
        params = {
          event = "jim-mechanic:client:Interior:Apply", args = { mod = -1, bumperid = tonumber(mod) } }
      } }
    for k, v in pairs(validMods) do
      local icon = ""
      local disabled = false
      if GetVehicleMod(vehicle, tonumber(mod)) == v.id then
        icon = "fas fa-check"
        disabled = true
      end
      ModMenu[#ModMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = v.install,
        params = { event = 'jim-mechanic:client:Interior:Apply', args = { mod = v.id, bumperid = mod } }
      }
    end
    exports['qb-menu']:openMenu(ModMenu)
  end
end)

QBCore = exports['qb-core']:GetCoreObject()

QBCore.Shared.Items = exports.ox_inventory:Items()
--========================================================== Bumpers
RegisterNetEvent('jim-mechanic:client:Bumpers:Apply', function(data)
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  local modName = GetLabelText(GetModTextLabel(vehicle, tonumber(data.bumperid), tonumber(data.mod)))
  if modName == "NULL" then modName = Loc[Config.Lan]["bumpers"].stockMod end
  if GetVehicleMod(vehicle, tonumber(data.bumperid)) == tonumber(data.mod) then
    triggerNotify(nil, modName .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Bumpers:Choose', tonumber(data.bumperid))
  elseif GetVehicleMod(vehicle, tonumber(data.bumperid)) ~= tonumber(data.mod) then
    time = math.random(3000, 5000)
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. modName, time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        SetVehicleMod(vehicle, tonumber(data.bumperid), tonumber(data.mod))
        qblog("`bumper - " .. QBCore.Shared.Items["bumper"].label .. " - " .. modName .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        emptyHands(PlayerPedId())
        if Config.CosmeticRemoval then
          toggleItem(false, "bumper")
        else
          TriggerEvent('jim-mechanic:client:Bumpers:Choose', tonumber(data.bumperid))
        end
        triggerNotify(nil, Loc[Config.Lan]["bumpers"].installed, "success")
      end, function()
        triggerNotify(nil, Loc[Config.Lan]["bumpers"].failed, "error")
        emptyHands(PlayerPedId())
      end, "bumper")
  end
end)

RegisterNetEvent('jim-mechanic:client:Bumpers:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    lookVeh(vehicle)
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    if GetNumVehicleMods(vehicle, 6) == 0 and GetNumVehicleMods(vehicle, 1) == 0 and GetNumVehicleMods(vehicle, 2) == 0 then
      triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
      return
    end
    installed1 = GetLabelText(GetModTextLabel(vehicle, 6, GetVehicleMod(vehicle, 6)))
    if installed1 == "NULL" then installed1 = Loc[Config.Lan]["common"].stock else end
    installed2 = GetLabelText(GetModTextLabel(vehicle, 1, GetVehicleMod(vehicle, 1)))
    if installed2 == "NULL" then installed2 = Loc[Config.Lan]["common"].stock else end
    installed3 = GetLabelText(GetModTextLabel(vehicle, 2, GetVehicleMod(vehicle, 2)))
    if installed3 == "NULL" then installed3 = Loc[Config.Lan]["common"].stock else end
    local BumperMenu = {
      { icon = "bumper", header = searchCar(vehicle) .. Loc[Config.Lan]["bumpers"].menuheader, txt = "", isMenuHeader = true },
      {
        icon = "fas fa-circle-xmark",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
        params = {
          event = "jim-mechanic:client:Menu:Close" }
      } }
    if GetNumVehicleMods(vehicle, 6) ~= 0 then
      BumperMenu[#BumperMenu + 1] = {
        header = Loc[Config.Lan]["bumpers"].menugrille,
        txt = "[" .. (GetNumVehicleMods(vehicle, 6) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed1,
        params = { event = "jim-mechanic:client:Bumpers:Choose", args = 6 }
      }
    end
    if GetNumVehicleMods(vehicle, 1) ~= 0 then
      BumperMenu[#BumperMenu + 1] = {
        header = Loc[Config.Lan]["bumpers"].menuFBumper,
        txt = "[" .. (GetNumVehicleMods(vehicle, 1) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed2,
        params = { event = "jim-mechanic:client:Bumpers:Choose", args = 1 }
      }
    end
    if GetNumVehicleMods(vehicle, 2) ~= 0 then
      BumperMenu[#BumperMenu + 1] = {
        header = Loc[Config.Lan]["bumpers"].menuBBumper,
        txt = "[" .. (GetNumVehicleMods(vehicle, 2) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed3,
        params = { event = "jim-mechanic:client:Bumpers:Choose", args = 2 }
      }
    end
    exports['qb-menu']:openMenu(BumperMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Bumpers:Choose', function(mod)
  local validMods = {}
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
    for i = 1, GetNumVehicleMods(vehicle, mod) do
      if GetVehicleMod(vehicle, mod) == (i - 1) then txt = Loc[Config.Lan]["common"].current else txt = "" end
      validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, mod, (i - 1))), install = txt }
    end
  end
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
    local BumpersMenu = {
      {
        isMenuHeader = true,
        icon = "bumper",
        header = searchCar(vehicle) .. Loc[Config.Lan]["bumpers"].menuheader,
        txt = Loc[Config.Lan]["common"]
            .amountoption .. #validMods + 1,
      },
      {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = {
          event = "jim-mechanic:client:Bumpers:Check" }
      },
      {
        icon = icon,
        isMenuHeader = disabled,
        header = "0. " .. Loc[Config.Lan]["common"].stock,
        txt = stockinstall,
        params = {
          event = "jim-mechanic:client:Bumpers:Apply", args = { mod = -1, bumperid = tonumber(mod) } }
      }
    }
    for k, v in pairs(validMods) do
      local icon = ""
      local disabled = false
      if GetVehicleMod(vehicle, tonumber(mod)) == v.id then
        icon = "fas fa-check"
        disabled = true
      end
      BumpersMenu[#BumpersMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = v.install,
        params = { event = 'jim-mechanic:client:Bumpers:Apply', args = { mod = tostring(v.id), bumperid = tonumber(mod) } }
      }
    end
    exports['qb-menu']:openMenu(BumpersMenu)
  end
end)

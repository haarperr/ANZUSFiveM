--========================================================== Spoilers
RegisterNetEvent('jim-mechanic:client:Spoilers:Apply', function(mod)
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  local modName = GetLabelText(GetModTextLabel(vehicle, 0, tonumber(mod)))
  if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
  if GetVehicleMod(vehicle, 0) == tonumber(mod) then
    triggerNotify(nil, modName .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Spoilers:Check')
  elseif GetVehicleMod(vehicle, 0) ~= tonumber(mod) then
    time = math.random(3000, 5000)
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. modName .. "..", time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
      { task = "WORLD_HUMAN_WELDING" }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        qblog("`spoiler - " .. QBCore.Shared.Items["spoiler"].label .. " - " .. modName .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleMod(vehicle, 0, tonumber(mod))
        emptyHands(PlayerPedId())

        if Config.CosmeticRemoval then
          toggleItem(false, "spoiler")
        else
          TriggerEvent('jim-mechanic:client:Spoilers:Check')
        end
        triggerNotify(nil, Loc[Config.Lan]["spoilers"].installed, "success")
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["spoilers"].failed, "error")
        emptyHands(PlayerPedId())
      end, "spoiler")
  end
end)

RegisterNetEvent('jim-mechanic:client:Spoilers:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  local validMods = {}
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
    for i = 1, GetNumVehicleMods(vehicle, 0) do
      if GetVehicleMod(vehicle, 0) == (i - 1) then txt = Loc[Config.Lan]["common"].current else txt = "" end
      validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, 0, (i - 1))), install = txt }
    end
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    if GetNumVehicleMods(vehicle, 0) == 0 then
      triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
      return
    end
    local icon = ""
    local disabled = false
    if GetVehicleMod(vehicle, 0) == -1 then
      stockinstall = Loc[Config.Lan]["common"].current
      icon = "fas fa-check"
      disabled = true
    else
      stockinstall = ""
    end
    local spoilerMenu = {
      {
        isMenuHeader = true,
        icon = "spoiler",
        header = searchCar(vehicle) .. Loc[Config.Lan]["spoilers"].menuheader,
        txt = Loc[Config.Lan]["common"].amountoption ..
            #validMods + 1,
      },
      {
        icon = "fas fa-circle-xmark",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
        params = {
          event = "jim-mechanic:client:Menu:Close" }
      },
      {
        icon = icon,
        isMenuHeader = disabled,
        header = "0. " .. Loc[Config.Lan]["common"].stock,
        txt = stockinstall,
        params = {
          event = "jim-mechanic:client:Spoilers:Apply", args = -1 }
      } }
    for k, v in pairs(validMods) do
      local icon = ""
      local disabled = false
      if GetVehicleMod(vehicle, 0) == v.id then
        icon = "fas fa-check"
        disabled = true
      end
      spoilerMenu[#spoilerMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = v.install,
        params = { event = 'jim-mechanic:client:Spoilers:Apply', args = tostring(v.id) }
      }
    end
    exports['qb-menu']:openMenu(spoilerMenu)
  end
end)

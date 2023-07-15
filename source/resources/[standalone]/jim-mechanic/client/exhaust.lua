--========================================================== Exhaust
RegisterNetEvent('jim-mechanic:client:Exhaust:Apply', function(data)
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  local modName = GetLabelText(GetModTextLabel(vehicle, 4, tonumber(data.id)))
  if modName == "NULL" then modName = Loc[Config.Lan]["exhaust"].stockMod end
  if GetVehicleMod(vehicle, 4) == tonumber(data.id) then
    triggerNotify(nil, modName .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Exhaust:Check')
  elseif GetVehicleMod(vehicle, 4) ~= tonumber(data.id) then
    time = math.random(3000, 5000)
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. modName .. "..", time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        qblog("`exhaust - " .. QBCore.Shared.Items["exhaust"].label .. " - " .. modName .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleMod(vehicle, 4, tonumber(data.id))
        emptyHands(PlayerPedId())
        if Config.CosmeticRemoval then
          toggleItem(false, "exhaust")
        else
          TriggerEvent('jim-mechanic:client:Exhaust:Check')
        end
        triggerNotify(nil, Loc[Config.Lan]["exhaust"].installed, "success")
      end, function()
        triggerNotify(nil, Loc[Config.Lan]["exhaust"].failed, "error")
        emptyHands(PlayerPedId())
      end, "exhaust")
  end
end)

RegisterNetEvent('jim-mechanic:client:Exhaust:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  local validMods = {}
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
    lookVeh(vehicle)
    for i = 1, GetNumVehicleMods(vehicle, 4) do
      if GetVehicleMod(vehicle, 4) == (i - 1) then
        txt = Loc[Config.Lan]["common"].current
      elseif GetVehicleMod(vehicle, 4) ~= (i - 1) then
        txt = ""
      end
      validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, 4, (i - 1))), install = txt }
    end
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    local icon = ""
    local disabled = false
    if GetVehicleMod(vehicle, 4) == -1 then
      stockinstall = Loc[Config.Lan]["common"].current
      icon = "fas fa-check"
      disabled = true
    else
      stockinstall = ""
    end
    local ExhaustMenu = {
      {
        isMenuHeader = true,
        icon = "exhaust",
        header = searchCar(vehicle) .. Loc[Config.Lan]["exhaust"].menuheader,
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
          event = "jim-mechanic:client:Exhaust:Apply", args = { id = -1 } }
      }, }
    for k, v in pairs(validMods) do
      local icon = ""
      local disabled = false
      if GetVehicleMod(vehicle, 4) == v.id then
        icon = "fas fa-check"
        disabled = true
      end
      ExhaustMenu[#ExhaustMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = v.install,
        params = { event = 'jim-mechanic:client:Exhaust:Apply', args = { id = tostring(v.id) } }
      }
    end
    exports['qb-menu']:openMenu(ExhaustMenu)
  end
end)

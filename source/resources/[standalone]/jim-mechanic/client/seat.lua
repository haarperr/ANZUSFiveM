--========================================================== Seat
RegisterNetEvent('jim-mechanic:client:Seat:Apply', function(mod)
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  pushVehicle(vehicle)
  local modName = GetLabelText(GetModTextLabel(vehicle, 32, tonumber(mod)))
  if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
  if GetVehicleMod(vehicle, 32) == tonumber(mod) then
    triggerNotify(nil, modName .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Seat:Check')
  elseif GetVehicleMod(vehicle, 32) ~= tonumber(mod) then
    time = math.random(3000, 5000)
    for i = 0, 5 do SetVehicleDoorOpen(vehicle, i, false, false) end
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. modName .. "..", time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 16, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        qblog("`seat - " .. QBCore.Shared.Items["seat"].label .. " - " .. modName .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleMod(vehicle, 32, tonumber(mod))
        emptyHands(PlayerPedId())

        if Config.CosmeticRemoval then
          toggleItem(false, "seat")
        else
          TriggerEvent('jim-mechanic:client:Seat:Check')
        end
        triggerNotify(nil, Loc[Config.Lan]["seat"].installed, "success")
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["seat"].failed, "error")
        emptyHands(PlayerPedId())
      end, "seat")
  end
end)

RegisterNetEvent('jim-mechanic:client:Seat:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  local validMods = {}
  if not outCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
    for i = 1, GetNumVehicleMods(vehicle, 32) do
      if GetVehicleMod(vehicle, 32) == (i - 1) then txt = Loc[Config.Lan]["common"].current else txt = "" end
      validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, 32, (i - 1))), install = txt }
    end
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    if GetNumVehicleMods(vehicle, 32) == 0 then
      triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
      return
    end
    local icon = ""
    local disabled = false
    if GetVehicleMod(vehicle, 32) == -1 then
      stockinstall = Loc[Config.Lan]["common"].current
      icon = "fas fa-check"
      disabled = true
    else
      stockinstall = ""
    end
    local SeatMenu = {
      {
        isMenuHeader = true,
        icon = "seat",
        header = searchCar(vehicle) .. Loc[Config.Lan]["seat"].menuheader,
        txt = Loc[Config.Lan]["common"].amountoption ..
            #validMods + 1,
      },
      { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""), params = { event = "jim-mechanic:client:Menu:Close" } },
      {
        icon = icon,
        isMenuHeader = disabled,
        header = "0. " .. Loc[Config.Lan]["common"].stock,
        txt = stockinstall,
        params = {
          event = "jim-mechanic:client:Seat:Apply", args = -1 }
      } }
    for k, v in pairs(validMods) do
      local icon = ""
      local disabled = false
      if GetVehicleMod(vehicle, 32) == v.id then
        icon = "fas fa-check"
        disabled = true
      end
      SeatMenu[#SeatMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = v.install,
        params = { event = 'jim-mechanic:client:Seat:Apply', args = tostring(v.id) }
      }
    end
    exports['qb-menu']:openMenu(SeatMenu)
  end
end)

--========================================================== Roof
RegisterNetEvent('jim-mechanic:client:Roof:Apply', function(mod)
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  local modName = GetLabelText(GetModTextLabel(vehicle, 10, tonumber(mod)))
  if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
  if GetVehicleMod(vehicle, 10) == tonumber(mod) then
    triggerNotify(nil, modName .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Roof:Check')
  elseif GetVehicleMod(vehicle, 10) ~= tonumber(mod) then
    time = math.random(3000, 5000)
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. modName .. "..", time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { task = "WORLD_HUMAN_WELDING" }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        qblog("`roof - " .. QBCore.Shared.Items["roof"].label .. " - " .. modName .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        emptyHands(PlayerPedId())
        SetVehicleMod(vehicle, 10, tonumber(mod))

        if Config.CosmeticRemoval then
          toggleItem(false, "roof")
        else
          TriggerEvent('jim-mechanic:client:Roof:Check')
        end
        triggerNotify(nil, Loc[Config.Lan]["roof"].installed, "success")
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["common"].failed, "error")
        emptyHands(PlayerPedId())
      end, "roof")
  end
end)

RegisterNetEvent('jim-mechanic:client:Roof:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  local validMods = {}
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
    lookVeh(vehicle)
    if GetNumVehicleMods(vehicle, 10) == 0 then
      triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
      return
    end
    for i = 1, GetNumVehicleMods(vehicle, 10) do
      if GetVehicleMod(vehicle, 10) == (i - 1) then txt = Loc[Config.Lan]["common"].current else txt = "" end
      validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, 10, (i - 1))), install = txt }
    end
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  local icon = ""
  local disabled = false
  if GetVehicleMod(vehicle, 10) == -1 then
    stockinstall = Loc[Config.Lan]["common"].current
    icon = "fas fa-check"
    disabled = true
  else
    stockinstall = ""
  end
  local RoofMenu = {
    {
      isMenuHeader = true,
      icon = "roof",
      header = searchCar(vehicle) .. Loc[Config.Lan]["roof"].menuheader,
      txt = Loc[Config.Lan]["common"].amountoption ..
          GetNumVehicleMods(vehicle, 10) + 1,
    },
    { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""), params = { event = "jim-mechanic:client:Menu:Close" } },
    {
      icon = icon,
      isMenuHeader = disabled,
      header = Loc[Config.Lan]["common"].stock,
      txt = stockinstall,
      params = {
        event = "jim-mechanic:client:Roof:Apply", args = -1 }
    } }
  for k, v in pairs(validMods) do
    local icon = ""
    local disabled = false
    if GetVehicleMod(vehicle, 10) == v.id then
      icon = "fas fa-check"
      disabled = true
    end
    RoofMenu[#RoofMenu + 1] = {
      icon = icon,
      isMenuHeader = disabled,
      header = k .. ". " .. v.name,
      txt = v.install,
      params = { event = 'jim-mechanic:client:Roof:Apply', args = tostring(v.id) }
    }
  end
  exports['qb-menu']:openMenu(RoofMenu)
end)

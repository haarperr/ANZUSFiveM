--========================================================== Hood
RegisterNetEvent('jim-mechanic:client:Hood:Apply', function(data)
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  local modName = GetLabelText(GetModTextLabel(vehicle, 7, tonumber(data.id)))
  if modName == "NULL" then modName = Loc[Config.Lan]["hood"].stockMod end
  if GetVehicleMod(vehicle, 7) == tonumber(data.id) then
    triggerNotify(nil, modName .. Loc[Config.Lan]["hood"].installed, "error")
    TriggerEvent('jim-mechanic:client:Hood:Check')
  elseif GetVehicleMod(vehicle, 7) ~= tonumber(data.id) then
    time = math.random(3000, 5000)
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. modName .. "..", time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        qblog("`hood - " .. QBCore.Shared.Items["hood"].label .. " - " .. modName .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleDoorOpen(vehicle, 4, false, false)
        Wait(500)
        SetVehicleMod(vehicle, 7, tonumber(data.id))
        Wait(500)
        SetVehicleDoorShut(vehicle, 4, false)

        emptyHands(PlayerPedId())
        if Config.CosmeticRemoval then
          toggleItem(false, "hood")
        else
          TriggerEvent('jim-mechanic:client:Hood:Check')
        end
        triggerNotify(nil, Loc[Config.Lan]["hood"].installed, "success")
      end, function()
        triggerNotify(nil, Loc[Config.Lan]["hood"].failed, "error")
        emptyHands(PlayerPedId())
      end, "hood")
  end
end)

RegisterNetEvent('jim-mechanic:client:Hood:Check', function()
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
    for i = 1, GetNumVehicleMods(vehicle, 7) do
      if GetVehicleMod(vehicle, 7) == (i - 1) then txt = Loc[Config.Lan]["common"].current else txt = "" end
      validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, 7, (i - 1))), install = txt }
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
    if GetNumVehicleMods(vehicle, 7) == 0 then
      triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
      return
    end
    if GetVehicleMod(vehicle, 7) == -1 then
      stockinstall = Loc[Config.Lan]["common"].current
      icon = "fas fa-check"
      disabled = true
    else
      stockinstall = ""
    end
    local HoodMenu = {
      {
        isMenuHeader = true,
        icon = "hood",
        header = searchCar(vehicle) .. Loc[Config.Lan]["hood"].menuheader,
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
          event = "jim-mechanic:client:Hood:Apply", args = { id = -1 } }
      }, }
    for k, v in pairs(validMods) do
      local icon = ""
      local disabled = false
      if GetVehicleMod(vehicle, 7) == v.id then
        icon = "fas fa-check"
        disabled = true
      end
      HoodMenu[#HoodMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = v.install,
        params = { event = 'jim-mechanic:client:Hood:Apply', args = { id = tostring(v.id) } }
      }
    end
    exports['qb-menu']:openMenu(HoodMenu)
  end
end)

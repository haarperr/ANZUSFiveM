--========================================================== Horn
RegisterNetEvent('jim-mechanic:client:Horn:Apply', function(data)
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  lookVeh(vehicle)
  time = math.random(3000, 5000)
  SetVehicleDoorOpen(vehicle, 4, false, false)
  QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. data.name .. "..", time, false, true,
    { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
    { animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, }, {}, {}, function()
      SetVehicleModKit(vehicle, 0)
      qblog("`horn - " .. QBCore.Shared.Items["horn"].label .. " - " .. data.name .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
      SetVehicleMod(vehicle, 14, tonumber(data.mod))
      SetVehicleDoorShut(vehicle, 4, false, false)
      emptyHands(PlayerPedId())

      if Config.CosmeticRemoval then
        toggleItem(false, "horn")
      else
        TriggerEvent('jim-mechanic:client:Horn:Check')
      end
      triggerNotify(nil, Loc[Config.Lan]["horns"].installed, "success")
    end, function() -- Cancel
      triggerNotify(nil, Loc[Config.Lan]["horns"].failed, "error")
      emptyHands(PlayerPedId())
      SetVehicleDoorShut(vehicle, 4, false, false)
    end, "horn")
end)

RegisterNetEvent('jim-mechanic:client:Horn:Check', function()
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
    hornCheck = GetVehicleMod(vehicle, 14)
    for k, v in pairs(Loc[Config.Lan].vehicleHorns) do
      if hornCheck == tonumber(v.id) then installed = Loc[Config.Lan]["common"].current else installed = "" end
      validMods[k] = { id = v.id, name = v.name, txt = installed, }
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
    if GetVehicleMod(vehicle, 14) == -1 then
      stockinstall = Loc[Config.Lan]["common"].current
      icon = "fas fa-check"
      disabled = true
    else
      stockinstall = ""
    end
    local HornMenu = {
      {
        icon = "horn",
        header = searchCar(vehicle) .. Loc[Config.Lan]["horns"].menuheader,
        txt = Loc[Config.Lan]["common"].amountoption .. #validMods + 1,
        params = {
          event = "jim-mechanic:client:Horn:Test", args = { veh = vehicle } },
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
        txt =
            stockinstall,
        params = {
          event = "jim-mechanic:client:Horn:Apply", args = { mod = -1, name = Loc[Config.Lan]["common"].stock } }
      } }
    for k, v in pairs(validMods) do
      local icon = ""
      local disabled = false
      if GetVehicleMod(vehicle, 14) == v.id then
        icon = "fas fa-check"
        disabled = true
      end
      HornMenu[#HornMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = v.txt,
        params = { event = 'jim-mechanic:client:Horn:Apply', args = { mod = v.id, name = v.name } }
      }
    end
    exports['qb-menu']:openMenu(HornMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Horn:Test', function(data)
  StartVehicleHorn(data.veh, 2000, "HELDDOWN", false)
  TriggerEvent('jim-mechanic:client:Horn:Check')
end)

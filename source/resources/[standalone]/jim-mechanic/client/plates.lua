--========================================================== Plates
RegisterNetEvent('jim-mechanic:client:Plates:Custom:Apply', function(index)
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  if GetVehicleNumberPlateTextIndex(vehicle) == tonumber(index) then
    triggerNotify(nil, Loc[Config.Lan]["plates"].already, "error")
    TriggerEvent('jim-mechanic:client:Plates:Custom')
  elseif GetVehicleNumberPlateTextIndex(vehicle) ~= tonumber(index) then
    time = math.random(3000, 5000)
    playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", time, 8)
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["plates"].installing, time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        qblog("`customplate - " .. QBCore.Shared.Items["customplate"].label .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleNumberPlateTextIndex(vehicle, index)
        emptyHands(PlayerPedId())

        if Config.CosmeticRemoval then
          toggleItem(false, "customplate")
        else
          TriggerEvent('jim-mechanic:client:Plates:Custom')
        end
        triggerNotify(nil, Loc[Config.Lan]["plates"].installed, "success")
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["plates"].failed, "error")
        emptyHands(PlayerPedId())
      end, "customplate")
  end
end)

RegisterNetEvent('jim-mechanic:client:Plates:Apply', function(data)
  if not inCar() then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  local modName = GetLabelText(GetModTextLabel(vehicle, tonumber(data.mod), tonumber(data.id)))
  if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
  if GetVehicleMod(vehicle, tonumber(data.mod)) == tonumber(data.id) then
    triggerNotify(nil, modName .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Plates:Choose', data)
  elseif GetVehicleMod(vehicle, tonumber(data.mod)) ~= tonumber(data.id) then
    time = math.random(3000, 5000)
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. modName .. "..", time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
      { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 16, }, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        qblog("`customplate - " .. QBCore.Shared.Items["customplate"].label .. " - " .. modName .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleMod(vehicle, tonumber(data.mod), tonumber(data.id))
        emptyHands(PlayerPedId())

        if Config.CosmeticRemoval then
          toggleItem(false, "customplate")
        else
          TriggerEvent('jim-mechanic:client:Plates:Choose', data)
        end
        triggerNotify(nil, Loc[Config.Lan]["plates"].installed, "success")
      end, function()
        triggerNotify(nil, Loc[Config.Lan]["plates"].failed, "error")
        emptyHands(PlayerPedId())
      end, "customplate")
  end
end)

RegisterNetEvent('jim-mechanic:client:Plates:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
    lookVeh(vehicle)
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    if GetLabelText(GetModTextLabel(vehicle, 25, GetVehicleMod(vehicle, 25))) == "NULL" then
      installed1 = Loc[Config.Lan]["common"].stock
    else
      installed1 = GetLabelText(
        GetModTextLabel(vehicle, 25, GetVehicleMod(vehicle, 25)))
    end
    if GetLabelText(GetModTextLabel(vehicle, 26, GetVehicleMod(vehicle, 26))) == "NULL" then
      installed2 = Loc[Config.Lan]["common"].stock
    else
      installed2 = GetLabelText(
        GetModTextLabel(vehicle, 26, GetVehicleMod(vehicle, 26)))
    end
    local PlatesMenu = {
      { isMenuHeader = true,          icon = "customplate", header = searchCar(vehicle) .. Loc[Config.Lan]["plates"].menuheader, },
      { icon = "fas fa-circle-xmark", header = "",          txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),      params = { event = "jim-mechanic:client:Menu:Close" } } }
    if GetNumVehicleMods(vehicle, 25) ~= 0 then
      PlatesMenu[#PlatesMenu + 1] = {
        header = Loc[Config.Lan]["plates"].label1,
        txt = "[" .. (GetNumVehicleMods(vehicle, 25) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed1,
        params = { event = "jim-mechanic:client:Plates:Choose", args = { mod = 25 } }
      }
    end
    if GetNumVehicleMods(vehicle, 26) ~= 0 then
      PlatesMenu[#PlatesMenu + 1] = {
        header = Loc[Config.Lan]["plates"].label2,
        txt = "[" .. (GetNumVehicleMods(vehicle, 26) + 1) .. Loc[Config.Lan]["common"].menuinstalled .. installed2,
        params = { event = "jim-mechanic:client:Plates:Choose", args = { mod = 26 } }
      }
    end
    PlatesMenu[#PlatesMenu + 1] = {
      header = Loc[Config.Lan]["plates"].label3,
      txt = "[" .. GetNumberOfVehicleNumberPlates(vehicle) .. Loc[Config.Lan]["common"].menuinstalled .. installed1,
      params = { event = "jim-mechanic:client:Plates:Custom" }
    }

    exports['qb-menu']:openMenu(PlatesMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Plates:Custom', function()
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
  end
  if DoesEntityExist(vehicle) then
    local PlateMenu = {
      { icon = "customplate", header = searchCar(vehicle) .. Loc[Config.Lan]["plates"].menuheader2, isMenuHeader = true },
      {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = {
          event = "jim-mechanic:client:Plates:Check" }
      } }
    for k, v in pairs(Loc[Config.Lan].vehiclePlateOptions) do
      local icon = ""
      local disabled = false
      if GetVehicleNumberPlateTextIndex(vehicle) == v.id then
        installed = Loc[Config.Lan]["common"].current
        icon = "fas fa-check"
        disabled = true
      else
        installed = ""
      end
      PlateMenu[#PlateMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = installed,
        params = { event = 'jim-mechanic:client:Plates:Custom:Apply', args = v.id }
      }
    end
    exports['qb-menu']:openMenu(PlateMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Plates:Choose', function(data)
  local validMods = {}
  if not inCar() then return end
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
  end
  if DoesEntityExist(vehicle) then
    for i = 1, GetNumVehicleMods(vehicle, tonumber(data.mod)) do
      if GetVehicleMod(vehicle, tonumber(data.mod)) == (i - 1) then txt = Loc[Config.Lan]["common"].current else txt = "" end
      validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, tonumber(data.mod), (i - 1))), install = txt }
    end
    local icon = ""
    local disabled = false
    if GetVehicleMod(vehicle, tonumber(data.mod)) == -1 then
      stockinstall = Loc[Config.Lan]["common"].current
      icon = "fas fa-check"
      disabled = true
    else
      stockinstall = ""
    end
    local ModMenu = {
      {
        isMenuHeader = true,
        icon = "customplate",
        header = searchCar(vehicle) .. Loc[Config.Lan]["plates"].menuheader,
        txt = Loc[Config.Lan]["common"]
            .amountoption .. #validMods + 1,
      },
      {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = {
          event = "jim-mechanic:client:Plates:Check" }
      },
      {
        icon = icon,
        isMenuHeader = disabled,
        header = "0. " .. Loc[Config.Lan]["common"].stock,
        txt = stockinstall,
        params = {
          event = "jim-mechanic:client:Plates:Apply", args = { id = -1, mod = tonumber(data.mod) } }
      } }
    for k, v in pairs(validMods) do
      local icon = ""
      local disabled = false
      if GetVehicleMod(vehicle, tonumber(data.mod)) == v.id then
        icon = "fas fa-check"
        disabled = true
      end
      ModMenu[#ModMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = v.install,
        params = { event = 'jim-mechanic:client:Plates:Apply', args = { id = v.id, mod = data.mod } }
      }
    end
    exports['qb-menu']:openMenu(ModMenu)
  end
end)

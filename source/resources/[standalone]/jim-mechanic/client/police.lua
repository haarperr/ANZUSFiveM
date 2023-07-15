--Set which jobs can use this
Config.QuickJobs = {
  ["police"] = 0,
  ["ambulance"] = 0,
  ["mechanic"] = 0,
}

Config.PoliceLocations = {
  --Add your poly zone box locations and job name for each store and it will add it to the qb-target loop above
  { coords = vec3(451.05, -973.19, 25.7),                              heading = 180.0, },   -- MRPD UNDERGROUND PARKING
  { coords = vec3(342.51, -570.98, 28.8),                              heading = 70.0, },    -- PILL BOX GARAGE
  { coords = vec3(1808.889, 3685.859, 33.974),                         heading = 299.59, },  -- Sandy Shores PD
  { coords = vec3(-489.879, 6002.56, 31.299),                          heading = 225.177, }, -- Paleto PD
  { coords = vec3(-269.54147338867, 6323.0034179688, 32.426174163818), heading = 45.556, },

}

local bench = {}
CreateThread(function()
  for k, v in pairs(Config.PoliceLocations) do
    bench[#bench + 1] = makeProp({ prop = `gr_prop_gr_bench_03a`, coords = vec4(v.coords.x, v.coords.y, v.coords.z - 1.37, v.heading) }, 1, 0)
  end
end)

RegisterNetEvent('jim-mechanic:client:Police:Menu', function()
  local validMods = {}
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  if not outCar() then return end
  if GetPedInVehicleSeat(vehicle, -1) ~= PlayerPedId() then return end
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    local PoliceMenu = {}
    PoliceMenu[#PoliceMenu + 1] = {
      icon = "fas fa-circle-xmark",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
      params = { event = "jim-mechanic:client:Menu:Close" }
    }
    PoliceMenu[#PoliceMenu + 1] = { icon = "fas fa-wrench", header = Loc[Config.Lan]["police"].repair, txt = "", params = { event = "jim-mechanic:client:Police:Repair" }, }
    PoliceMenu[#PoliceMenu + 1] = { icon = "fas fa-toolbox", header = Loc[Config.Lan]["police"].extras, txt = "", params = { event = "jim-mechanic:client:Police:Extra" }, }
    PoliceMenu[#PoliceMenu + 1] = { icon = "fas fa-address-card", header = Loc[Config.Lan]["police"].plates, txt = "", params = { event = "jim-mechanic:client:Police:Plates" }, }
    if GetNumVehicleMods(vehicle, 48) > 0 or GetVehicleLiveryCount(vehicle) > -1 then
      PoliceMenu[#PoliceMenu + 1] = { icon = "fas fa-paint-roller", header = Loc[Config.Lan]["police"].livery, txt = "", params = { event = "jim-mechanic:client:Police:Livery" }, }
    end
    if GetNumVehicleMods(vehicle, 0) ~= 0 then
      PoliceMenu[#PoliceMenu + 1] = { icon = "fas fa-car-burst", header = Loc[Config.Lan]["police"].spoiler, txt = "", params = { event = "jim-mechanic:client:Police:Spoiler" }, }
    end
    PoliceMenu[#PoliceMenu + 1] = { icon = "fas fa-brush", header = Loc[Config.Lan]["paint"].menuheader, txt = "", params = { event = "jim-mechanic:client:Police:Paint" }, }
    --PoliceMenu[#PoliceMenu+1] = { header = "Test", txt = "Vehicle Death Simulator", params = { event = "jim-mechanic:client:Police:test" }, }
    exports['qb-menu']:openMenu(PoliceMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Police:Extra', function()
  local validMods = {}
  local hasMod = false
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    TriggerEvent('jim-mechanic:client:Police:Menu')
    return
  end
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  local ExtraMenu = {}
  ExtraMenu[#ExtraMenu + 1] = { icon = "fas fa-toolbox", isMenuHeader = true, header = Loc[Config.Lan]["police"].extras, txt = "Toggle Vehicle Extras" }
  ExtraMenu[#ExtraMenu + 1] = {
    icon = "fas fa-circle-arrow-left",
    header = "",
    txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
    params = { event = "jim-mechanic:client:Police:Menu" },
  }
  for i = 0, 20 do
    if DoesExtraExist(vehicle, i) then
      hadMod = true
      if IsVehicleExtraTurnedOn(vehicle, i) then icon = "fas fa-check" else icon = "fas fa-x" end
      ExtraMenu[#ExtraMenu + 1] = { icon = icon, header = "Extra " .. i, txt = "", params = { event = "jim-mechanic:client:Police:Extra:Apply", args = { id = i }, }, }
    end
  end
  if hadMod then
    exports['qb-menu']:openMenu(ExtraMenu)
  elseif not hadMod then
    triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
    TriggerEvent('jim-mechanic:client:Police:Menu')
    return
  end
end)
RegisterNetEvent('jim-mechanic:client:Police:Extra:Apply', function(data)
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  local veh = {}
  veh.engine = GetVehicleEngineHealth(vehicle)
  veh.body = GetVehicleBodyHealth(vehicle)
  if IsVehicleExtraTurnedOn(vehicle, data.id) then
    SetVehicleExtra(vehicle, data.id, 1)
  else
    SetVehicleExtra(vehicle, data.id, 0)
    SetVehicleFixed(vehicle)
  end
  doCarDamage(vehicle, veh)
  Wait(100)
  SetVehicleEngineHealth(vehicle, veh.engine)
  SetVehicleBodyHealth(vehicle, veh.body)
  TriggerEvent('jim-mechanic:client:Police:Extra')
end)
RegisterNetEvent('jim-mechanic:client:Police:Repair', function()
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  FreezeEntityPosition(vehicle, true)
  pushVehicle(vehicle)
  local wait = 1500
  triggerNotify(nil, Loc[Config.Lan]["manual"].tyres)
  for _, v in pairs({ 0, 1, 2, 3, 4, 5, 45, 47 }) do
    if IsVehicleTyreBurst(vehicle, v, false) == 1 or IsVehicleTyreBurst(vehicle, v, true) == 1 then
      local offset = GetVehicleWheelXOffset(vehicle, v)
      SetVehicleWheelXOffset(vehicle, v, offset + 2000)
      SetVehicleTyreFixed(vehicle, v)
      Wait(wait)
      SetVehicleWheelXOffset(vehicle, v, offset)
      Wait(wait)
    end
  end
  if not AreAllVehicleWindowsIntact(vehicle) then
    triggerNotify(nil, Loc[Config.Lan]["manual"].window)
    for i = 0, 5 do
      if not IsVehicleWindowIntact(vehicle, i) then
        RemoveVehicleWindow(vehicle, i)
        Wait(wait / 2)
      end
    end
  end
  triggerNotify(nil, Loc[Config.Lan]["manual"].doors)
  for i = 0, 5 do
    if not IsVehicleDoorDamaged(vehicle, i) then
      SetVehicleDoorBroken(vehicle, i, true)
      Wait(wait)
    end
  end
  FreezeEntityPosition(vehicle, true)
  triggerNotify(nil, Loc[Config.Lan]["police"].engine)
  SetVehicleEngineHealth(vehicle, 1000.0)
  SetVehicleBodyHealth(vehicle, 1000.0)
  Wait(2000)
  triggerNotify(nil, Loc[Config.Lan]["police"].body)
  if useMechJob() then
    TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "radiator", 100)
    TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "axle", 100)
    TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "brakes", 100)
    TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "clutch", 100)
    TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "fuel", 100)
  end
  SetVehicleFixed(vehicle)
  Wait(2000)
  triggerNotify(nil, Loc[Config.Lan]["police"].cleaning)
  local cleaning = true
  while cleaning do
    if GetVehicleDirtLevel(vehicle) >= 1.0 then
      SetVehicleDirtLevel(vehicle, (tonumber(GetVehicleDirtLevel(vehicle))) - 0.8)
    elseif GetVehicleDirtLevel(vehicle) <= 1.0 then
      SetVehicleDirtLevel(vehicle, 0.0)
      cleaning = false
    end
    Wait(300)
  end
  triggerNotify(nil, Loc[Config.Lan]["police"].complete, "success")
  FreezeEntityPosition(vehicle, false)
  TriggerEvent('jim-mechanic:client:Police:Menu')
end)
RegisterNetEvent('jim-mechanic:client:Police:Livery', function()
  local validMods = {}
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
    if GetNumVehicleMods(vehicle, 48) == 0 and GetVehicleLiveryCount(vehicle) ~= 0 then
      oldlivery = true
      for i = 0, GetVehicleLiveryCount(vehicle) - 1 do
        if GetVehicleLivery(vehicle) == (i) then
          txt = Loc[Config.Lan]["common"].current
        elseif GetVehicleLivery(vehicle) ~= (i) then
          txt = ""
        end
        if i ~= 0 then validMods[i] = { id = i, name = Loc[Config.Lan]["police"].livery .. " " .. i, install = txt } end
      end
    else
      oldlivery = false
      for i = 1, GetNumVehicleMods(vehicle, 48) do
        local modName = GetLabelText(GetModTextLabel(vehicle, 48, (i - 1)))
        if GetVehicleMod(vehicle, 48) == (i - 1) then
          txt = Loc[Config.Lan]["common"].current
        elseif GetVehicleMod(vehicle, 48) ~= (i - 1) then
          txt = ""
        end
        validMods[i] = { id = (i - 1), name = modName, install = txt }
      end
    end
  end
  if DoesEntityExist(vehicle) then
    local LiveryMenu = {}
    if oldlivery == true then
      local icon = ""
      local disabled = false
      if GetVehicleLivery(vehicle) == 0 then
        stockinstall = Loc[Config.Lan]["common"].current
        icon = "fas fa-check"
        disabled = true
      else
        stockinstall = ""
      end
      LiveryMenu[#LiveryMenu + 1] = {
        icon = "fas fa-paint-roller",
        isMenuHeader = true,
        header = Loc[Config.Lan]["livery"].menuheader,
        txt = 'Amount of Options: ' .. GetVehicleLiveryCount(vehicle)
      }
      LiveryMenu[#LiveryMenu + 1] = {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = { event = "jim-mechanic:client:Police:Menu" },
      }
      LiveryMenu[#LiveryMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = "0. " .. Loc[Config.Lan]["common"].stock,
        txt = stockinstall,
        params = { event = "jim-mechanic:client:Police:Apply", args = { id = tostring(0), old = true } }
      }
      for k, v in pairs(validMods) do
        local icon = ""
        local disabled = false
        if GetVehicleLivery(vehicle) == v.id then
          icon = "fas fa-check"
          disabled = true
        end
        LiveryMenu[#LiveryMenu + 1] = {
          icon = icon,
          isMenuHeader = disabled,
          header = k .. ". " .. v.name,
          txt = v.install,
          params = { event = 'jim-mechanic:client:Police:Apply', args = { id = tostring(v.id), old = true } }
        }
      end
    elseif oldlivery ~= true then
      local icon = ""
      local disabled = false
      if GetVehicleMod(vehicle, 48) == -1 then
        stockinstall = Loc[Config.Lan]["common"].current
        icon = "fas fa-check"
        disabled = true
      else
        stockinstall = ""
      end
      LiveryMenu[#LiveryMenu + 1] = {
        icon = "fas fa-paint-roller",
        isMenuHeader = true,
        header = Loc[Config.Lan]["livery"].menuheader,
        txt = 'Amount of Options: ' .. GetNumVehicleMods(vehicle, 48) + 1
      }
      LiveryMenu[#LiveryMenu + 1] = {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = { event = "jim-mechanic:client:Police:Menu" },
      }
      LiveryMenu[#LiveryMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = "0. " .. Loc[Config.Lan]["common"].stock,
        txt = stockinstall,
        params = { event = "jim-mechanic:client:Police:Apply", args = { id = tostring(-1) } }
      }
      for k, v in pairs(validMods) do
        local icon = ""
        local disabled = false
        if GetVehicleMod(vehicle, 48) == v.id then
          icon = "fas fa-check"
          disabled = true
        end
        LiveryMenu[#LiveryMenu + 1] = {
          icon = icon,
          isMenuHeader = disabled,
          header = k .. ". " .. v.name,
          txt = v.install,
          params = { event = 'jim-mechanic:client:Police:Apply', args = { id = tostring(v.id) } }
        }
      end
    end
    exports['qb-menu']:openMenu(LiveryMenu)
  end
end)
RegisterNetEvent('jim-mechanic:client:Police:Apply', function(data)
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
  end
  local label = GetModTextLabel(vehicle, 48, tonumber(data.id))
  local modName = GetLabelText(label)
  if data.old then
    if modName == "NULL" then modName = Loc[Config.Lan]["livery"].oldMod end
    if GetVehicleLivery(vehicle) == tonumber(data.id) then
      triggerNotify(nil, data.id .. Loc[Config.Lan]["common"].already, "error")
      TriggerEvent('jim-mechanic:client:Police:Livery')
      return
    end
  else
    if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
    if GetVehicleMod(vehicle, 48) == tonumber(data.id) then
      triggerNotify(nil, modName .. Loc[Config.Lan]["common"].already, "error")
      TriggerEvent('jim-mechanic:client:Police:Livery')
      return
    end
  end
  if data.old then
    if tonumber(data.id) == 0 then
      SetVehicleMod(vehicle, 48, -1, false)
      SetVehicleLivery(vehicle, 0)
    else
      SetVehicleMod(vehicle, 48, -1, false)
      SetVehicleLivery(vehicle, tonumber(data.id))
    end
  elseif not data.old then
    if tonumber(data.id) == -1 then
      SetVehicleMod(vehicle, 48, -1, false)
      SetVehicleLivery(vehicle, -1)
    else
      SetVehicleMod(vehicle, 48, tonumber(data.id), false)
      SetVehicleLivery(vehicle, -1)
    end
  end
  TriggerEvent('jim-mechanic:client:Police:Livery')
  oldlivery = nil
end)
RegisterNetEvent('jim-mechanic:client:Police:Plates', function()
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
    if DoesEntityExist(vehicle) then
      local PlateMenu = {
        { icon = "fas fa-address-card", header = searchCar(vehicle) .. Loc[Config.Lan]["plates"].menuheader2, isMenuHeader = true },
        {
          icon = "fas fa-circle-arrow-left",
          header = "",
          txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
          params = {
            event = "jim-mechanic:client:Police:Menu" }
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
          params = { event = 'jim-mechanic:client:Police:Plates:Apply', args = v.id }
        }
      end
      exports['qb-menu']:openMenu(PlateMenu)
    end
  end
end)
RegisterNetEvent('jim-mechanic:client:Police:Plates:Apply', function(index)
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
  end
  if GetVehicleNumberPlateTextIndex(vehicle) == tonumber(index) then
    triggerNotify(nil, Loc[Config.Lan]["plates"].already, "error")
    TriggerEvent('jim-mechanic:client:Police:Plates')
  elseif GetVehicleNumberPlateTextIndex(vehicle) ~= tonumber(index) then
    SetVehicleNumberPlateTextIndex(vehicle, index)
    TriggerEvent('jim-mechanic:client:Police:Plates')
  end
end)
RegisterNetEvent('jim-mechanic:client:Police:Spoiler', function()
  local validMods = {}
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
    for i = 1, GetNumVehicleMods(vehicle, 0) do
      if GetVehicleMod(vehicle, 0) == (i - 1) then txt = Loc[Config.Lan]["common"].current else txt = "" end
      validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, 0, (i - 1))), install = txt }
    end
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
        icon = "fas fa-car-burst",
        isMenuHeader = true,
        header = Loc[Config.Lan]["spoilers"].menuheader,
        txt = Loc[Config.Lan]["common"].amountoption ..
            #validMods + 1,
      },
      {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = {
          event = "jim-mechanic:client:Police:Menu" }
      },
      {
        icon = icon,
        isMenuHeader = disabled,
        header = "0. " .. Loc[Config.Lan]["common"].stock,
        txt = stockinstall,
        params = {
          event = "jim-mechanic:client:Police:Spoilers:Apply", args = -1 }
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
        params = { event = 'jim-mechanic:client:Police:Spoilers:Apply', args = tostring(v.id) }
      }
    end
    exports['qb-menu']:openMenu(spoilerMenu)
  end
end)
RegisterNetEvent('jim-mechanic:client:Police:Spoilers:Apply', function(mod)
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
  end
  local modName = GetLabelText(GetModTextLabel(vehicle, 0, tonumber(mod)))
  if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
  if GetVehicleMod(vehicle, 0) == tonumber(mod) then
    triggerNotify(nil, modName .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Police:Spoiler')
  elseif GetVehicleMod(vehicle, 0) ~= tonumber(mod) then
    SetVehicleMod(vehicle, 0, tonumber(mod))
    TriggerEvent('jim-mechanic:client:Police:Spoiler')
    triggerNotify(nil, Loc[Config.Lan]["spoilers"].installed, "success")
  end
end)
RegisterNetEvent('jim-mechanic:client:Police:Paint', function()
  local validMods = {}
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
  end

  local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
  local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
  for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
    if vehPrimaryColour == v.id then vehPrimaryColour = Loc[Config.Lan]["paint"].metallic .. " " .. v.name end
    if vehSecondaryColour == v.id then vehSecondaryColour = Loc[Config.Lan]["paint"].metallic .. " " .. v.name end
    if vehPearlescentColour == v.id then vehPearlescentColour = Loc[Config.Lan]["paint"].metallic .. " " .. v.name end
  end
  for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
    if vehPrimaryColour == v.id then vehPrimaryColour = Loc[Config.Lan]["paint"].matte .. " " .. v.name end
    if vehSecondaryColour == v.id then vehSecondaryColour = Loc[Config.Lan]["paint"].matte .. " " .. v.name end
    if vehPearlescentColour == v.id then vehPearlescentColour = Loc[Config.Lan]["paint"].matte .. " " .. v.name end
  end
  for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
    if vehPrimaryColour == v.id then vehPrimaryColour = v.name end
    if vehSecondaryColour == v.id then vehSecondaryColour = v.name end
    if vehPearlescentColour == v.id then vehPearlescentColour = v.name end
  end
  if type(vehPrimaryColour) == "number" then vehPrimaryColour = Loc[Config.Lan]["common"].stock end
  if type(vehSecondaryColour) == "number" then vehSecondaryColour = Loc[Config.Lan]["common"].stock end
  if type(vehPearlescentColour) == "number" then vehPearlescentColour = Loc[Config.Lan]["common"].stock end
  local PaintMenu = {
    { icon = "fas fa-brush", header = Loc[Config.Lan]["paint"].menuheader, txt = "", isMenuHeader = true },
    {
      icon = "fas fa-circle-arrow-left",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
      params = {
        event = "jim-mechanic:client:Police:Menu", }
    } }
  PaintMenu[#PaintMenu + 1] = {
    header = Loc[Config.Lan]["paint"].primary,
    txt = Loc[Config.Lan]["common"].current .. ": " .. vehPrimaryColour,
    params = { event = "jim-mechanic:client:Police:Paints:Choose", args = Loc[Config.Lan]["paint"].primary }
  }
  PaintMenu[#PaintMenu + 1] = {
    header = Loc[Config.Lan]["paint"].secondary,
    txt = Loc[Config.Lan]["common"].current .. ": " .. vehSecondaryColour,
    params = { event = "jim-mechanic:client:Police:Paints:Choose", args = Loc[Config.Lan]["paint"].secondary }
  }
  PaintMenu[#PaintMenu + 1] = {
    header = Loc[Config.Lan]["paint"].pearl,
    txt = Loc[Config.Lan]["common"].current .. ": " .. vehPearlescentColour,
    params = { event = "jim-mechanic:client:Police:Paints:Choose", args = Loc[Config.Lan]["paint"].pearl }
  }
  exports['qb-menu']:openMenu(PaintMenu)
end)

RegisterNetEvent('jim-mechanic:client:Police:Paints:Choose', function(data)
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
  end
  if DoesEntityExist(vehicle) then
    exports['qb-menu']:openMenu({
      { icon = "fas fa-brush", header = data .. Loc[Config.Lan]["paint"].menuheader, txt = "", isMenuHeader = true },
      {
        icon = "fas fa-circle-arrow-left",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
        params = {
          event = "jim-mechanic:client:Police:Paint" }
      },
      {
        header = Loc[Config.Lan]["paint"].metallic,
        txt = "",
        params = {
          event = "jim-mechanic:client:Police:Paints:Choose:Colour",
          args = { paint = data, finish = Loc[Config.Lan]["paint"].metallic }
        }
      },
      {
        header = Loc[Config.Lan]["paint"].matte,
        txt = "",
        params = {
          event = "jim-mechanic:client:Police:Paints:Choose:Colour",
          args = { paint = data, finish = Loc[Config.Lan]["paint"].matte }
        }
      },
      {
        header = Loc[Config.Lan]["paint"].metals,
        txt = "",
        params = {
          event = "jim-mechanic:client:Police:Paints:Choose:Colour",
          args = { paint = data, finish = Loc[Config.Lan]["paint"].metals }
        }
      },
    })
  end
end)

RegisterNetEvent('jim-mechanic:client:Police:Paints:Choose:Colour', function(data)
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
  end
  local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
  local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
  if data.paint == Loc[Config.Lan]["paint"].primary then colourCheck = vehPrimaryColour end
  if data.paint == Loc[Config.Lan]["paint"].secondary then colourCheck = vehSecondaryColour end
  if data.paint == Loc[Config.Lan]["paint"].pearl then colourCheck = vehPearlescentColour end
  local PaintMenu = {
    { icon = "fas fa-brush", isMenuHeader = true, header = data.finish .. " " .. data.paint, txt = "" },
    {
      icon = "fas fa-circle-arrow-left",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
      params = {
        event = "jim-mechanic:client:Police:Paints:Choose", args = data.paint }
    } }
  local installed = nil
  if data.finish == Loc[Config.Lan]["paint"].metallic then
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
      local icon = ""
      local disabled = false
      if colourCheck == v.id then
        installed = Loc[Config.Lan]["common"].current
        icon = "fas fa-check"
        disabled = true
      else
        installed = ""
      end
      PaintMenu[#PaintMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = installed,
        params = { event = 'jim-mechanic:client:Police:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } }
      }
    end
  elseif data.finish == Loc[Config.Lan]["paint"].matte then
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
      local icon = ""
      local disabled = false
      if colourCheck == v.id then
        installed = Loc[Config.Lan]["common"].current
        icon = "fas fa-check"
        disabled = true
      else
        installed = ""
      end
      PaintMenu[#PaintMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = installed,
        params = { event = 'jim-mechanic:client:Police:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } }
      }
    end
  elseif data.finish == Loc[Config.Lan]["paint"].metals then
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
      local icon = ""
      local disabled = false
      if colourCheck == v.id then
        installed = Loc[Config.Lan]["common"].current
        icon = "fas fa-check"
        disabled = true
      else
        installed = ""
      end
      PaintMenu[#PaintMenu + 1] = {
        icon = icon,
        isMenuHeader = disabled,
        header = k .. ". " .. v.name,
        txt = installed,
        params = { event = 'jim-mechanic:client:Police:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } }
      }
    end
  end
  exports['qb-menu']:openMenu(PaintMenu)
end)

RegisterNetEvent('jim-mechanic:client:Police:Paints:Apply', function(data)
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    pushVehicle(vehicle)
  end
  local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
  local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
  if data.paint == Loc[Config.Lan]["paint"].primary then
    SetVehicleColours(vehicle, data.id, vehSecondaryColour)
  elseif data.paint == Loc[Config.Lan]["paint"].secondary then
    SetVehicleColours(vehicle, vehPrimaryColour, data.id)
  elseif data.paint == Loc[Config.Lan]["paint"].pearl then
    SetVehicleExtraColours(vehicle, data.id, vehWheelColour)
  end
  TriggerEvent('jim-mechanic:client:Police:Paints:Choose:Colour', data)
end)


RegisterNetEvent('jim-mechanic:client:Police:test', function(data)
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  SetVehicleEngineHealth(vehicle, 50.0)
  SetVehicleBodyHealth(vehicle, 200.0)
  local veh = {}
  veh.engine = GetVehicleEngineHealth(vehicle)
  veh.body = GetVehicleBodyHealth(vehicle)
  doCarDamage(vehicle, veh)
  SetVehicleDirtLevel(vehicle, 14.5)
  if useMechJob() then
    TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "radiator", 20.0)
    TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "axle", 20.0)
    TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "brakes", 20.0)
    TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "clutch", 20.0)
    TriggerServerEvent("vehiclemod:server:updatePart", trim(GetVehicleNumberPlateText(vehicle)), "fuel", 20.0)
  end
  TriggerEvent('jim-mechanic:client:Police:Menu')
end)

AddEventHandler('onResourceStop', function(r)
  if r == GetCurrentResourceName() then
    for k, v in pairs(Config.PoliceLocations) do exports['qb-target']:RemoveZone("bench" .. k) end
    for i = 1, #bench do DeleteEntity(bench[i]) end
  end
end)

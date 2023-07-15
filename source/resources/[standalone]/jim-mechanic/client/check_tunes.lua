--========================================================= CheckTunes
local vehicle = nil
local toolbox = nil

RegisterNetEvent('jim-mechanic:client:Menu', function()
  if not jobChecks() then return end
  if not locationChecks() then return end
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local vehicle
  if not nearPoint(coords) then return end
  if not inCar() then return end
  if not IsPedInAnyVehicle(ped, false) then
    vehicle = getClosest(coords)
    pushVehicle(vehicle)
  end
  if lockedCar(vehicle) then return end
  loadAnimDict("anim@heists@narcotics@trash")
  playAnim("anim@heists@narcotics@trash", "idle", 6000, 8)
  if not DoesEntityExist(vehicle) then return end
  if not toolbox then toolbox = makeProp({ prop = `v_ind_cs_toolbox4`, coords = vec4(0, 0, 0, 0) }, 1, 1) else emptyHands(PlayerPedId()) end
  AttachEntityToEntity(toolbox, ped, GetPedBoneIndex(ped, 57005), 0.20, -0.04, 0.0, 25.0, 270.0, 180.0, true, true, false, true, 1, true)
  CreateThread(function()
    Wait(10000)
    DeleteEntity(toolbox)
    toolbox = nil
    unloadAnimDict("anim@heists@narcotics@trash")
  end)

  local CheckMenu = {
    {
      isMenuHeader = true,
      header = searchCar(vehicle),
      txt = "Class: " ..
          getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle)
    },
    {
      icon = "fas fa-circle-xmark",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
      params = {
        event = "jim-mechanic:client:Menu:Close" }
    } }
  local armicon, turicon, headicon, drifticon, bprooficon = ""
  --Engine--
  if GetNumVehicleMods(vehicle, 11) ~= 0 then -- If engine can be changed
    if GetVehicleMod(vehicle, 11) == -1 then  -- If Stock
      modEngine = Loc[Config.Lan]["common"].stock .. ": [LVL 0 / " .. GetNumVehicleMods(vehicle, 11) .. "]"
      modEngineHead = true
    else
      local lvl = (GetVehicleMod(vehicle, 11) + 1) -- If engine level found
      modEngine = QBCore.Shared.Items["engine" .. lvl].label .. ": [LVL " .. lvl .. " / " .. GetNumVehicleMods(vehicle, 11) .. "]"
      modEngineHead = false
    end
  else
    modEngine = Loc[Config.Lan]["check"].unavail
    modEngineHead = true
  end
  --Brakes--
  if GetNumVehicleMods(vehicle, 12) ~= 0 then
    if GetVehicleMod(vehicle, 12) == -1 then
      modBrakes = Loc[Config.Lan]["common"].stock .. ": [LVL 0 / " .. GetNumVehicleMods(vehicle, 12) .. "]"
      modBrakesHead = true
    else
      local lvl = (GetVehicleMod(vehicle, 12) + 1)
      modBrakes = QBCore.Shared.Items["brakes" .. lvl].label .. ": [LVL " .. lvl .. " / " .. GetNumVehicleMods(vehicle, 12) .. "]"
      modBrakesHead = false
    end
  else
    modBrakes = Loc[Config.Lan]["check"].unavail
    modBrakesHead = true
  end
  --Suspension
  if GetNumVehicleMods(vehicle, 15) ~= 0 then
    if GetVehicleMod(vehicle, 15) == -1 then
      modSuspension = Loc[Config.Lan]["common"].stock .. ": [LVL 0 / " .. GetNumVehicleMods(vehicle, 15) .. "]"
      modSuspensionHead = true
    else
      local lvl = (GetVehicleMod(vehicle, 15) + 1)
      modSuspension = QBCore.Shared.Items["suspension" .. lvl].label .. ": [LVL " .. lvl .. " / " .. GetNumVehicleMods(vehicle, 15) .. "]"
      modSuspensionHead = false
    end
  else
    modSuspension = Loc[Config.Lan]["check"].unavail
    modSuspensionHead = true
  end
  --Transmission
  if GetNumVehicleMods(vehicle, 13) ~= 0 then
    if GetVehicleMod(vehicle, 13) == -1 then
      modTransmission = Loc[Config.Lan]["common"].stock .. ": [LVL 0 / " .. GetNumVehicleMods(vehicle, 13) .. "]"
      modTransmissionHead = true
    else
      local lvl = (GetVehicleMod(vehicle, 13) + 1)
      modTransmission = QBCore.Shared.Items["transmission" .. lvl].label .. " [LVL " .. lvl .. " / " .. GetNumVehicleMods(vehicle, 13) .. "]"
      modTransmissionHead = false
    end
  else
    modTransmission = Loc[Config.Lan]["check"].unavail
    modTransmissionHead = true
  end
  --Armor
  if GetNumVehicleMods(vehicle, 16) ~= 0 then
    if (GetVehicleMod(vehicle, 16) + 1) == GetNumVehicleMods(vehicle, 16) then
      armicon = "car_armor"
      modArmor = Loc[Config.Lan]["check"].reinforced
      modArmorHead = false
    else
      modArmor = Loc[Config.Lan]["common"].stock
      modArmorHead = true
    end
  else
    modArmor = Loc[Config.Lan]["check"].unavail
    modArmorHead = true
  end
  --Turbo
  if not IsToggleModOn(vehicle, 18) and GetNumVehicleMods(vehicle, 11) ~= 0 then
    modTurbo = Loc[Config.Lan]["check"].notinstall
    modTurboHead = true
  elseif IsToggleModOn(vehicle, 18) then
    turicon = "turbo"
    modTurbo = QBCore.Shared.Items["turbo"].label
    modTurboHead = false
  elseif GetNumVehicleMods(vehicle, 11) == 0 then
    modTurbo = Loc[Config.Lan]["check"].unavail
    modTurboHead = true
  end
  --Xenons
  if not IsToggleModOn(vehicle, 22) and GetNumVehicleMods(vehicle, 11) ~= 0 then
    modXenon = Loc[Config.Lan]["check"].notinstall
    modXenonHead = true
  elseif IsToggleModOn(vehicle, 22) then
    headicon = "headlights"
    modXenon = Loc[Config.Lan]["check"].xenoninst
    modXenonHead = false
  elseif GetNumVehicleMods(vehicle, 11) == 0 then
    modXenon = Loc[Config.Lan]["check"].unavail
    modXenonHead = true
  end
  local custom, r, g, b = GetVehicleXenonLightsCustomColor(vehicle)
  if custom then
    xenonColor = "<br>R: " ..
        r ..
        " G: " ..
        g ..
        " B: " ..
        b ..
        " <span style='color:#" ..
        rgbToHex(r, g, b):upper() .. "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> ⯀ </span>"
  else
    xenonColor = ""
  end
  --Drift
  if GetGameBuildNumber() >= 2372 then
    if GetDriftTyresEnabled(vehicle) == false and GetNumVehicleMods(vehicle, 11) ~= 0 then
      modDrift = Loc[Config.Lan]["check"].notinstall
      modDriftHead = true
    elseif GetDriftTyresEnabled(vehicle) == 1 then
      drifticon = "drifttires"
      modDrift = Loc[Config.Lan]["check"].tireinst
      modDriftHead = false
    elseif GetNumVehicleMods(vehicle, 11) == 0 then
      modDrift = Loc[Config.Lan]["check"].unavail
      modDriftHead = true
    end
  end
  --BulletProof
  if GetVehicleTyresCanBurst(vehicle) == false and GetNumVehicleMods(vehicle, 11) ~= 0 then
    bprooficon = "bprooftires"
    modBproof = Loc[Config.Lan]["check"].tireinst
    modBproofHead = false
  elseif GetNumVehicleMods(vehicle, 11) == 0 then
    modBproof = Loc[Config.Lan]["check"].unavail
    modBproofHead = true
  end

  if VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))] then
    local text = nosBar(VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))].level) .. " " .. math.floor(VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))].level) .. "%"
    CheckMenu[#CheckMenu + 1] = {
      icon = "nos",
      header = Loc[Config.Lan]["check"].label58,
      txt = text,
      params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "nos" } }
    }
  end

  CheckMenu[#CheckMenu + 1] = {
    icon = "engine" .. (GetVehicleMod(vehicle, 11) + 1),
    isMenuHeader = modEngineHead,
    header = Loc[Config.Lan]["check"].label1,
    txt = modEngine,
    params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "engine" } }
  }
  CheckMenu[#CheckMenu + 1] = {
    icon = "brakes" .. (GetVehicleMod(vehicle, 12) + 1),
    isMenuHeader = modBrakesHead,
    header = Loc[Config.Lan]["check"].label2,
    txt = modBrakes,
    params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "brakes" } }
  }
  CheckMenu[#CheckMenu + 1] = {
    icon = "suspension" .. (GetVehicleMod(vehicle, 15) + 1),
    isMenuHeader = modSuspensionHead,
    header = Loc[Config.Lan]["check"].label3,
    txt = modSuspension,
    params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "suspension" } }
  }
  CheckMenu[#CheckMenu + 1] = {
    icon = "transmission" .. (GetVehicleMod(vehicle, 13) + 1),
    isMenuHeader = modTransmissionHead,
    header = Loc[Config.Lan]["check"].label4,
    txt = modTransmission,
    params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "transmission" } }
  }
  CheckMenu[#CheckMenu + 1] = {
    icon = armicon,
    isMenuHeader = modArmorHead,
    header = Loc[Config.Lan]["check"].label5,
    txt = modArmor,
    params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "armour" } }
  }
  CheckMenu[#CheckMenu + 1] = {
    icon = turicon,
    isMenuHeader = modTurboHead,
    header = Loc[Config.Lan]["check"].label6,
    txt = modTurbo,
    params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "turbo" } }
  }
  CheckMenu[#CheckMenu + 1] = {
    icon = headicon,
    isMenuHeader = modXenonHead,
    header = Loc[Config.Lan]["check"].label7,
    txt = modXenon .. xenonColor,
    params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "xenon" } }
  }
  if GetGameBuildNumber() >= 2372 then
    if GetDriftTyresEnabled(vehicle) == 1 then
      CheckMenu[#CheckMenu + 1] = {
        icon = drifticon,
        isMenuHeader = modDriftHead,
        header = Loc[Config.Lan]["check"].label8,
        txt = modDrift,
        params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "drift" } }
      }
    end
  end
  if GetVehicleTyresCanBurst(vehicle) == false then
    CheckMenu[#CheckMenu + 1] = {
      icon = bprooficon,
      isMenuHeader = modBproofHead,
      header = Loc[Config.Lan]["check"].label9,
      txt = modBproof,
      params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "bproof" } }
    }
  end
  CheckMenu[#CheckMenu + 1] = { icon = "fas fa-toolbox", header = "", txt = Loc[Config.Lan]["check"].label10, params = { event = "jim-mechanic:client:Menu:List" } }

  exports['qb-menu']:openMenu(CheckMenu)
end)

RegisterNetEvent('jim-mechanic:client:Menu:List', function()
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)

  local CheckMenu = {
    { isMenuHeader = true, header = Loc[Config.Lan]["check"].label11 .. searchCar(vehicle), txt = Loc[Config.Lan]["check"].label10 },
    {
      icon = "fas fa-circle-xmark",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
      params = {
        event = "jim-mechanic:client:Menu:Close" }
    } }

  local external = nil
  for _, v in pairs({ 0, 1, 2, 3, 4, 6, 7, 8, 9, 10, 25, 26, 27, 44, 37, 39, 40, 41, 42 }) do
    if GetNumVehicleMods(vehicle, v) ~= 0 then
      external = true
      break
    end
  end

  if external then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = Loc[Config.Lan]["check"].label13, } end

  if GetNumVehicleMods(vehicle, 48) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["police"].livery .. " - [ " .. GetNumVehicleMods(vehicle, 48) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetVehicleLiveryCount(vehicle) ~= -1 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["police"].livery .. " - [ " .. GetVehicleLiveryCount(vehicle) .. Loc[Config.Lan]["check"].label12,
    }
  end

  if GetNumVehicleMods(vehicle, 0) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label15 .. GetNumVehicleMods(vehicle, 0) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 1) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label16 .. GetNumVehicleMods(vehicle, 1) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 2) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label17 .. GetNumVehicleMods(vehicle, 2) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 3) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label18 .. GetNumVehicleMods(vehicle, 3) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 4) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label19 .. GetNumVehicleMods(vehicle, 4) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 6) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label20 .. GetNumVehicleMods(vehicle, 6) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 7) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label21 .. GetNumVehicleMods(vehicle, 7) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 8) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label22 .. GetNumVehicleMods(vehicle, 8) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 9) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label23 .. GetNumVehicleMods(vehicle, 9) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 10) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label24 .. GetNumVehicleMods(vehicle, 10) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 25) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label25 .. GetNumVehicleMods(vehicle, 25) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 26) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label26 .. GetNumVehicleMods(vehicle, 26) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 27) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label27 .. GetNumVehicleMods(vehicle, 27) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 44) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label28 .. GetNumVehicleMods(vehicle, 44) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 37) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label29 .. GetNumVehicleMods(vehicle, 37) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 39) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label30 .. GetNumVehicleMods(vehicle, 39) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 40) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label31 .. GetNumVehicleMods(vehicle, 40) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 41) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label32 .. GetNumVehicleMods(vehicle, 41) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 42) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label33 .. GetNumVehicleMods(vehicle, 42) .. Loc[Config.Lan]["check"].label12,
    }
  end

  for k, v in pairs({ 5, 28, 29, 30, 31, 32, 33, 34, 35, 36, 38, 43, 45 }) do if GetNumVehicleMods(vehicle, v) ~= 0 then internal = true end end
  if internal then CheckMenu[#CheckMenu + 1] = { isMenuHeader = true, header = Loc[Config.Lan]["check"].label14, } end
  if GetNumVehicleMods(vehicle, 5) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label34 .. GetNumVehicleMods(vehicle, 5) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 28) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label35 .. GetNumVehicleMods(vehicle, 28) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 29) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label36 .. GetNumVehicleMods(vehicle, 29) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 30) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label37 .. GetNumVehicleMods(vehicle, 30) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 31) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label38 .. GetNumVehicleMods(vehicle, 31) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 32) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label39 .. GetNumVehicleMods(vehicle, 32) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 33) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label40 .. GetNumVehicleMods(vehicle, 33) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 34) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label41 .. GetNumVehicleMods(vehicle, 34) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 35) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label42 .. GetNumVehicleMods(vehicle, 35) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 36) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label43 .. GetNumVehicleMods(vehicle, 36) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 38) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label44 .. GetNumVehicleMods(vehicle, 38) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 43) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label45 .. GetNumVehicleMods(vehicle, 43) .. Loc[Config.Lan]["check"].label12,
    }
  end
  if GetNumVehicleMods(vehicle, 45) ~= 0 then
    CheckMenu[#CheckMenu + 1] = {
      isMenuHeader = true,
      header = "",
      txt = Loc[Config.Lan]["check"].label46 .. GetNumVehicleMods(vehicle, 45) .. Loc[Config.Lan]["check"].label12,
    }
  end

  local all = { 0, 1, 2, 3, 4, 6, 7, 8, 9, 10, 25, 26, 27, 44, 37, 39, 40, 41, 42, 5, 28, 29, 30, 31, 32, 33, 34, 35, 36, 38, 43, 45 }
  local mods = nil
  for _, v in pairs(all) do
    if GetNumVehicleMods(vehicle, v) ~= 0 then
      mods = true
      break
    end
  end
  if GetVehicleLiveryCount(vehicle) ~= -1 then mods = true end
  if mods then
    exports['qb-menu']:openMenu(CheckMenu)
  else
    triggerNotify(nil, Loc[Config.Lan]["common"].noOptions, "error")
    return
  end
end)

---BRAKES
RegisterNetEvent('jim-mechanic:client:Menu:Remove', function(data)
  local event, header, icon = ""
  if data.mod == "brakes" then
    icon = "brakes" .. (GetVehicleMod(data.vehicle, 12) + 1)
    header = Loc[Config.Lan]["check"].label49
    event = "jim-mechanic:client:giveBrakes"
  elseif data.mod == "engine" then
    icon = "engine" .. (GetVehicleMod(data.vehicle, 11) + 1)
    header = Loc[Config.Lan]["check"].label50
    event = "jim-mechanic:client:giveEngine"
  elseif data.mod == "suspension" then
    icon = "suspension" .. (GetVehicleMod(data.vehicle, 15) + 1)
    header = Loc[Config.Lan]["check"].label51
    event = "jim-mechanic:client:giveSuspension"
  elseif data.mod == "transmission" then
    icon = "transmission" .. (GetVehicleMod(data.vehicle, 13) + 1)
    header = Loc[Config.Lan]["check"].label52
    event = "jim-mechanic:client:giveTransmission"
  elseif data.mod == "armour" then
    icon = "car_armor"
    header = Loc[Config.Lan]["check"].label53
    event = "jim-mechanic:client:giveArmor"
  elseif data.mod == "turbo" then
    icon = "turbo"
    header = Loc[Config.Lan]["check"].label54
    event = "jim-mechanic:client:giveTurbo"
  elseif data.mod == "xenon" then
    icon = "headlights"
    header = Loc[Config.Lan]["check"].label55
    event = "jim-mechanic:client:giveXenon"
  elseif data.mod == "drift" then
    icon = "drifttires"
    header = Loc[Config.Lan]["check"].label56
    event = "jim-mechanic:client:giveDrift"
  elseif data.mod == "bproof" then
    icon = "bprooftires"
    header = Loc[Config.Lan]["check"].label56
    event = "jim-mechanic:client:giveBulletProof"
  elseif data.mod == "nos" then
    icon = "nos"
    setheader = Loc[Config.Lan]["check"].label57
    header = Loc[Config.Lan]["check"].label57
    event = "jim-mechanic:client:giveNOS"
  end
  local CheckMenu = {
    {
      isMenuHeader = true,
      header = searchCar(data.vehicle),
      txt = Loc[Config.Lan]["check"].plate ..
          trim(GetVehicleNumberPlateText(data.vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(data.vehicle)
    },
    { icon = icon, isMenuHeader = true, header = header },
    {
      icon = "fas fa-circle-check",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["check"].label47, "✅ ", ""),
      params = {
        event = event }
    },
    {
      icon = "fas fa-circle-xmark",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["check"].label48, "❌ ", ""),
      params = {
        event = "jim-mechanic:client:Menu" }
    } }
  exports['qb-menu']:openMenu(CheckMenu)
end)

RegisterNetEvent("jim-mechanic:client:cuscheck", function()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local vehicle
  if not nearPoint(coords) then return end
  if not inCar() then return end
  if not IsPedInAnyVehicle(ped, false) then
    vehicle = getClosest(coords)
    pushVehicle(vehicle)
  end
  if lockedCar(vehicle) then return end
  if not DoesEntityExist(vehicle) then return end
  local CheckMenu = {
    {
      isMenuHeader = true,
      header = searchCar(vehicle),
      txt = "Class: " ..
          getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle)
    },
    {
      icon = "fas fa-circle-xmark",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
      params = {
        event = "jim-mechanic:client:Menu:Close" }
    } }
  local armicon, turicon, headicon, drifticon, bprooficon = ""
  --Engine--
  if GetNumVehicleMods(vehicle, 11) ~= 0 then -- If engine can be changed
    if GetVehicleMod(vehicle, 11) == -1 then  -- If Stock
      modEngine = Loc[Config.Lan]["common"].stock .. ": [LVL 0 / " .. GetNumVehicleMods(vehicle, 11) .. "]"
    else
      local lvl = (GetVehicleMod(vehicle, 11) + 1) -- If engine level found
      modEngine = QBCore.Shared.Items["engine" .. lvl].label .. ": [LVL " .. lvl .. " / " .. GetNumVehicleMods(vehicle, 11) .. "]"
    end
  else
    modEngine = Loc[Config.Lan]["check"].unavail
  end
  --Brakes--
  if GetNumVehicleMods(vehicle, 12) ~= 0 then
    if GetVehicleMod(vehicle, 12) == -1 then
      modBrakes = Loc[Config.Lan]["common"].stock .. ": [LVL 0 / " .. GetNumVehicleMods(vehicle, 12) .. "]"
    else
      local lvl = (GetVehicleMod(vehicle, 12) + 1)
      modBrakes = QBCore.Shared.Items["brakes" .. lvl].label .. ": [LVL " .. lvl .. " / " .. GetNumVehicleMods(vehicle, 12) .. "]"
    end
  else
    modBrakes = Loc[Config.Lan]["check"].unavail
  end
  --Suspension
  if GetNumVehicleMods(vehicle, 15) ~= 0 then
    if GetVehicleMod(vehicle, 15) == -1 then
      modSuspension = Loc[Config.Lan]["common"].stock .. ": [LVL 0 / " .. GetNumVehicleMods(vehicle, 15) .. "]"
    else
      local lvl = (GetVehicleMod(vehicle, 15) + 1)
      modSuspension = QBCore.Shared.Items["suspension" .. lvl].label .. ": [LVL " .. lvl .. " / " .. GetNumVehicleMods(vehicle, 15) .. "]"
    end
  else
    modSuspension = Loc[Config.Lan]["check"].unavail
  end
  --Transmission
  if GetNumVehicleMods(vehicle, 13) ~= 0 then
    if GetVehicleMod(vehicle, 13) == -1 then
      modTransmission = Loc[Config.Lan]["common"].stock .. ": [LVL 0 / " .. GetNumVehicleMods(vehicle, 13) .. "]"
    else
      local lvl = (GetVehicleMod(vehicle, 13) + 1)
      modTransmission = QBCore.Shared.Items["transmission" .. lvl].label .. " [LVL " .. lvl .. " / " .. GetNumVehicleMods(vehicle, 13) .. "]"
    end
  else
    modTransmission = Loc[Config.Lan]["check"].unavail
  end
  --Armor
  if GetNumVehicleMods(vehicle, 16) ~= 0 then
    if (GetVehicleMod(vehicle, 16) + 1) == GetNumVehicleMods(vehicle, 16) then
      armicon = "car_armor"
      modArmor = Loc[Config.Lan]["check"].reinforced
    else
      modArmor = Loc[Config.Lan]["common"].stock
    end
  else
    modArmor = Loc[Config.Lan]["check"].unavail
  end
  --Turbo
  if not IsToggleModOn(vehicle, 18) and GetNumVehicleMods(vehicle, 11) ~= 0 then
    modTurbo = Loc[Config.Lan]["check"].notinstall
  elseif IsToggleModOn(vehicle, 18) then
    turicon = "turbo"
    modTurbo = QBCore.Shared.Items["turbo"].label
  elseif GetNumVehicleMods(vehicle, 11) == 0 then
    modTurbo = Loc[Config.Lan]["check"].unavail
  end
  --Xenons
  if not IsToggleModOn(vehicle, 22) and GetNumVehicleMods(vehicle, 11) ~= 0 then
    modXenon = Loc[Config.Lan]["check"].notinstall
  elseif IsToggleModOn(vehicle, 22) then
    headicon = "headlights"
    modXenon = Loc[Config.Lan]["check"].xenoninst
  elseif GetNumVehicleMods(vehicle, 11) == 0 then
    modXenon = Loc[Config.Lan]["check"].unavail
  end
  local custom, r, g, b = GetVehicleXenonLightsCustomColor(vehicle)
  if custom then
    xenonColor = "<br>R: " ..
        r ..
        " G: " ..
        g ..
        " B: " ..
        b ..
        " <span style='color:#" ..
        rgbToHex(r, g, b):upper() .. "; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black, 0em 0em 0.5em white, 0em 0em 0.5em white'> ⯀ </span>"
  else
    xenonColor = ""
  end
  --Drift
  if GetGameBuildNumber() >= 2372 then
    if GetDriftTyresEnabled(vehicle) == false and GetNumVehicleMods(vehicle, 11) ~= 0 then
      modDrift = Loc[Config.Lan]["check"].notinstall
    elseif GetDriftTyresEnabled(vehicle) == 1 then
      drifticon = "drifttires"
      modDrift = Loc[Config.Lan]["check"].tireinst
    elseif GetNumVehicleMods(vehicle, 11) == 0 then
      modDrift = Loc[Config.Lan]["check"].unavail
    end
  end
  --BulletProof
  if GetVehicleTyresCanBurst(vehicle) == false and GetNumVehicleMods(vehicle, 11) ~= 0 then
    bprooficon = "bprooftires"
    modBproof = Loc[Config.Lan]["check"].tireinst
  elseif GetNumVehicleMods(vehicle, 11) == 0 then
    modBproof = Loc[Config.Lan]["check"].unavail
  end

  if VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))] then
    local text = nosBar(VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))].level) .. " " .. math.floor(VehicleNitrous[trim(GetVehicleNumberPlateText(vehicle))].level) .. "%"
    CheckMenu[#CheckMenu + 1] = {
      icon = "nos",
      header = Loc[Config.Lan]["check"].label58,
      txt = text,
      params = { event = "jim-mechanic:client:Menu:Remove", args = { vehicle = vehicle, mod = "nos" } }
    }
  end

  CheckMenu[#CheckMenu + 1] = { icon = "engine" .. (GetVehicleMod(vehicle, 11) + 1), isMenuHeader = true, header = Loc[Config.Lan]["check"].label1, txt = modEngine }
  CheckMenu[#CheckMenu + 1] = { icon = "brakes" .. (GetVehicleMod(vehicle, 12) + 1), isMenuHeader = true, header = Loc[Config.Lan]["check"].label2, txt = modBrakes }
  CheckMenu[#CheckMenu + 1] = { icon = "suspension" .. (GetVehicleMod(vehicle, 15) + 1), isMenuHeader = true, header = Loc[Config.Lan]["check"].label3, txt = modSuspension }
  CheckMenu[#CheckMenu + 1] = { icon = "transmission" .. (GetVehicleMod(vehicle, 13) + 1), isMenuHeader = true, header = Loc[Config.Lan]["check"].label4, txt = modTransmission }
  CheckMenu[#CheckMenu + 1] = { icon = armicon, isMenuHeader = true, header = Loc[Config.Lan]["check"].label5, txt = modArmor }
  CheckMenu[#CheckMenu + 1] = { icon = turicon, isMenuHeader = true, header = Loc[Config.Lan]["check"].label6, txt = modTurbo }
  CheckMenu[#CheckMenu + 1] = { icon = headicon, isMenuHeader = true, header = Loc[Config.Lan]["check"].label7, txt = modXenon .. xenonColor }
  if GetGameBuildNumber() >= 2372 then
    if GetDriftTyresEnabled(vehicle) == 1 then
      CheckMenu[#CheckMenu + 1] = { icon = drifticon, isMenuHeader = modDriftHead, header = Loc[Config.Lan]["check"].label8, txt = modDrift }
    end
  end
  if GetVehicleTyresCanBurst(vehicle) == false then
    CheckMenu[#CheckMenu + 1] = { icon = bprooficon, isMenuHeader = modBproofHead, header = Loc[Config.Lan]["check"].label9, txt = modBproof }
  end
  exports['qb-menu']:openMenu(CheckMenu)
end)

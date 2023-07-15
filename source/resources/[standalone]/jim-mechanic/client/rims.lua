--==========================================================  Rims
RegisterNetEvent('jim-mechanic:client:Rims:Apply', function(data)
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  local found = false
  for _, v in pairs({ "wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr" }) do
    if #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 1.2 then
      lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
      found = true
      break
    end
  end
  if not found then
    triggerNotify(nil, Loc[Config.Lan]["common"].nearwheel, "error")
    return
  end
  Wait(1000)
  time = math.random(3000, 5000)
  QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["rims"].installing, time, false, true,
    { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
    { animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 8, }, {}, {}, function()
      SetVehicleModKit(vehicle, 0)
      SetVehicleWheelType(vehicle, tonumber(data.wheeltype))
      if not data.bike then
        SetVehicleMod(vehicle, 23, tonumber(data.mod), true)
      else
        SetVehicleMod(vehicle, 24, tonumber(data.mod), false)
      end
      emptyHands(PlayerPedId())

      if data.mod == -1 then
        if Config.CosmeticRemoval then
          toggleItem(false, "rims")
        else
          TriggerEvent('jim-mechanic:client:Rims:Choose', data)
        end
      else
        if Config.CosmeticRemoval then
          toggleItem(false, "rims")
        else
          TriggerEvent('jim-mechanic:client:Rims:SubMenu', data)
        end
      end
      qblog("`rims - " .. QBCore.Shared.Items["rims"].label .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
      triggerNotify(nil, Loc[Config.Lan]["rims"].installed, "success")
    end, function() -- Cancel
      triggerNotify(nil, Loc[Config.Lan]["rims"].failed, "error")
      emptyHands(PlayerPedId())
    end, "rims")
end)

RegisterNetEvent('jim-mechanic:client:Rims:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  if not inCar() then return end
  if not nearPoint(coords) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(playerPed, false) then
    vehicle = getClosest(coords)
    pushVehicle(vehicle)
  end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if lockedCar(vehicle) then return end
  if DoesEntityExist(vehicle) then
    local found = false
    for _, v in pairs({ "wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr" }) do
      if #(GetEntityCoords(PlayerPedId()) - GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v))) <= 1.2 then
        lookVeh(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v)))
        found = true
        break
      end
    end
    if not found then
      triggerNotify(nil, Loc[Config.Lan]["common"].nearwheel, "error")
      return
    end
    if IsThisModelABike(GetEntityModel(vehicle)) then cycle = true else cycle = false end
    --if IsThisModelABicycle(GetEntityModel(vehicle)) then cycle = true end
    --if IsThisModelAQuadbike(GetEntityModel(vehicle)) then cycle = true end

    local WheelMenu = {}
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].menuheader, txt = "", isMenuHeader = true }
    if Config.JimMenu then
      WheelMenu[#WheelMenu + 1] = {
        icon = "fas fa-circle-xmark",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
        params = { event = "jim-mechanic:client:Menu:Close" }
      }
    else
      WheelMenu[#WheelMenu + 1] = { header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } }
    end
    if not cycle then
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label1, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 0, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label2, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 1, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label3, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 2, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label4, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 3, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label5, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 4, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label6, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 5, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label7, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 7, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label8, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 8, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label9, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 9, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label10, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 10, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label11, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 11, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label12, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 12, bike = false } } }
    end
    --if not cycle then WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label15, params = { event = "jim-mechanic:client:Rims:Choose", args = 6 } } end
    if cycle then
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label13, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 6, bike = false } } }
      WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label14, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = 6, bike = true } } }
    end
    exports['qb-menu']:openMenu(WheelMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Rims:Choose', function(data)
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  local validMods = {}
  if not inCar() then return end
  if not nearPoint(coords) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(playerPed, false) then
    vehicle = getClosest(coords)
    if DoesEntityExist(vehicle) then
      originalWheel = GetVehicleWheelType(vehicle)
      SetVehicleWheelType(vehicle, tonumber(data.wheeltype))
      for i = 1, (GetNumVehicleMods(vehicle, 23) + 1) do
        local modName = GetLabelText(GetModTextLabel(vehicle, 23, (i - 1)))
        if not validMods[modName] then
          if GetVehicleMod(vehicle, 23) == (i - 1) and tonumber(originalWheel) == tonumber(data.wheeltype) then txt = Loc[Config.Lan]["common"].current else txt = "" end
          validMods[modName] = {}
          validMods[modName][#validMods[modName] + 1] = { id = (i - 1), name = modName, install = txt }
        elseif validMods[modName] then
          if validMods[modName][1] then
            if GetVehicleMod(vehicle, 23) == (i) and tonumber(originalWheel) == tonumber(data.wheeltype) then txt = Loc[Config.Lan]["common"].current else txt = "" end
            local name = modName
            if modName == "NULL" then name = modName .. " (" .. (i - 1) .. ")" end
            validMods[modName][#validMods[modName] + 1] = { id = (i - 1), name = name .. " - Var " .. (#validMods[modName] + 1), install = txt }
          else
            validMods[modName][#validMods[modName] + 1] = { id = validMods[modName].id, name = validMods[modName].name .. " - Var 1", install = validMods[modName].install }
            if GetVehicleMod(vehicle, 23) == (i) and tonumber(originalWheel) == tonumber(data.wheeltype) then txt = Loc[Config.Lan]["common"].current else txt = "" end
            validMods[modName][#validMods[modName] + 1] = { id = (i - 1), name = modName .. " - Var " .. (#validMods[modName] + 1), install = txt }
          end
        end
      end

      if validMods["NULL"] then
        validMods[Loc[Config.Lan]["rims"].labelcustom] = validMods["NULL"]
        validMods["NULL"] = nil
      end

      if GetVehicleMod(vehicle, 23) == -1 then stockinstall = Loc[Config.Lan]["common"].current else stockinstall = "" end
      label = ""
      if data.wheeltype == 0 then label = Loc[Config.Lan]["rims"].label1 end
      if data.wheeltype == 1 then label = Loc[Config.Lan]["rims"].label2 end
      if data.wheeltype == 2 then label = Loc[Config.Lan]["rims"].label3 end
      if data.wheeltype == 3 then label = Loc[Config.Lan]["rims"].label4 end
      if data.wheeltype == 4 then label = Loc[Config.Lan]["rims"].label5 end
      if data.wheeltype == 5 then label = Loc[Config.Lan]["rims"].label6 end
      if data.wheeltype == 6 then label = Loc[Config.Lan]["rims"].label15 end
      if data.wheeltype == 7 then label = Loc[Config.Lan]["rims"].label7 end
      if data.wheeltype == 8 then label = Loc[Config.Lan]["rims"].label8 end
      if data.wheeltype == 9 then label = Loc[Config.Lan]["rims"].label9 end
      if data.wheeltype == 10 then label = Loc[Config.Lan]["rims"].label10 end
      if data.wheeltype == 11 then label = Loc[Config.Lan]["rims"].label11 end
      if data.wheeltype == 12 then label = Loc[Config.Lan]["rims"].label12 end
      local RimsMenu = {}
      RimsMenu[#RimsMenu + 1] = { isMenuHeader = true, header = searchCar(vehicle) .. " " .. Loc[Config.Lan]["rims"].menuheader .. "<br>(" .. string.upper(label) .. ")", txt = "", }

      if Config.JimMenu then
        RimsMenu[#RimsMenu + 1] = {
          icon = "fas fa-circle-arrow-left",
          header = "",
          txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
          params = { event = "jim-mechanic:client:Rims:Check" }
        }
      else
        RimsMenu[#RimsMenu + 1] = { header = "", txt = Loc[Config.Lan]["common"].ret, params = { event = "jim-mechanic:client:Rims:Check" } }
      end

      RimsMenu[#RimsMenu + 1] = {
        header = Loc[Config.Lan]["common"].stock,
        txt = stockinstall,
        params = { event = "jim-mechanic:client:Rims:Apply", args = { mod = -1, wheeltype = data.wheeltype, } }
      }
      for k, v in pairsByKeys(validMods) do
        RimsMenu[#RimsMenu + 1] = {
          header = k,
          txt = Loc[Config.Lan]["common"].amountoption .. #validMods[k],
          params = { event = 'jim-mechanic:client:Rims:SubMenu', args = { mod = v.id, wheeltype = data.wheeltype, wheeltable = validMods[k], bike = data.bike } }
        }
      end
      exports['qb-menu']:openMenu(RimsMenu)
      SetVehicleWheelType(vehicle, originalWheel)
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:Rims:SubMenu', function(data)
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  if not inCar() then return end
  if not nearPoint(coords) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(playerPed, false) then
    vehicle = getClosest(coords)
    if DoesEntityExist(vehicle) then
      local RimsMenu = {
        {
          isMenuHeader = true,
          header = searchCar(vehicle) .. " " .. Loc[Config.Lan]["rims"].menuheader .. "<br>(" .. string.upper(label) .. ")",
          txt = Loc[Config.Lan]["common"].amountoption ..
              #data.wheeltable .. "<br>" .. Loc[Config.Lan]["common"].current .. ": " .. GetLabelText(GetModTextLabel(vehicle, 23, GetVehicleMod(vehicle, 23))),
        }, }

      if Config.JimMenu then
        RimsMenu[#RimsMenu + 1] = {
          icon = "fas fa-circle-arrow-left",
          header = "",
          txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
          params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = data.wheeltype } }
        }
      else
        RimsMenu[#RimsMenu + 1] = { header = "", txt = Loc[Config.Lan]["common"].ret, params = { event = "jim-mechanic:client:Rims:Choose", args = { wheeltype = data.wheeltype } } }
      end

      for i = 1, #data.wheeltable do
        RimsMenu[#RimsMenu + 1] = {
          header = data.wheeltable[i].name,
          txt = data.wheeltable[i].install,
          params = { event = 'jim-mechanic:client:Rims:Apply', args = { mod = data.wheeltable[i].id, wheeltype = data.wheeltype, wheeltable = data.wheeltable, bike = data.bike } }
        }
      end
      exports['qb-menu']:openMenu(RimsMenu)
    end
  end
end)


CreateThread(function()
  --JDM SPORTS PACK from https://www.gta5-mods.com/vehicles/jdm-rims-pack
  AddTextEntry("0xF9668A07", "Rays TE037")
  AddTextEntry("0xF268CDCF", "Spoon SW388")
  AddTextEntry("0xF4DB3C3D", "5Zigen GN+")
  AddTextEntry("0xEFBD445C", "Mine\'s LM-Evolution")
  AddTextEntry("0xEF0938DB", "Advan GT")
  AddTextEntry("0xEDBA359C", "Enkei Sport RC-T4")
  AddTextEntry("0xEBEDAF71", "Mazdaspeed MS-01")
  AddTextEntry("0xDB417766", "Enkei Tarmac Evo")
  AddTextEntry("0xD290A445", "Rays TE37")
  AddTextEntry("0xD6DB4CC1", "BLITZ BRW Profile 08")
  AddTextEntry("0xD5E61D3B", "Rays TE37V")
  AddTextEntry("0xCCC28AEB", "Work Meister S1")
  AddTextEntry("0xC02DB8B1", "Forgiato Maglia")
  AddTextEntry("0xBF8073EF", "Work Meister L1 3p")
  AddTextEntry("0xB749E7D7", "CST Hyper Zero")
  AddTextEntry("0xB68AC7CF", "Advan GT")
  AddTextEntry("0xB27FBBAF", "SSR Formula Mesh")
  AddTextEntry("0xB3BFAE91", "Rota P45R")
  AddTextEntry("0xB3AACE2D", "SSR Star Shark")
  AddTextEntry("0xAE9A2298", "Work VS-XX")
  AddTextEntry("0xA4635825", "Work DH")
  AddTextEntry("0xA3229E78", "Work Meister CR01")
  AddTextEntry("0x77549955", "BBS RS")
  AddTextEntry("0x75341294", "Works Equip 01")
  AddTextEntry("0x669673D9", "Junction Produce Scara")
  AddTextEntry("0x648744CF", "Work VS-KF")
  AddTextEntry("0x69215F65", "Rays CE28")
  AddTextEntry("0x47984B7F", "Rays TE37 SL")
  AddTextEntry("0x9712C980", "Watanabe RS")
  AddTextEntry("0x8420AF35", "Grenade GX-01")
  AddTextEntry("0x5713E17E", "SSR Speed Star MKIII")
  AddTextEntry("0x4334E708", "Work Equip 40")
  AddTextEntry("0x2159D6ED", "Enkei RPF1")
  AddTextEntry("0x988C8565", "Speedline Corse Challenge")
  AddTextEntry("0x604CCF19", "Enkei ES Tarmac")
  AddTextEntry("0x567E3F09", "BBS LM")
  AddTextEntry("0x461F07C5", "Nismo LM-GT1")
  AddTextEntry("0x218BCEA5", "Mugen RNR")
  AddTextEntry("0x109FA030", "GTR Spec-V & Black Edition")
  AddTextEntry("0x88B32C2A", "Blitz Type03")
  AddTextEntry("0x84A88CD9", "Advan RGII")
  AddTextEntry("0x82F5930A", "Fabulous Expand")
  AddTextEntry("0x80E91952", "Mugen MF10")
  AddTextEntry("0x74D8B607", "Hyperlock HL-06S")
  AddTextEntry("0x70C65D13", "Nismo LM-GT4")
  AddTextEntry("0x56A6CC52", "Buddy Club P1 Racing")
  AddTextEntry("0x35E5E809", "Spoon Cr93")
  AddTextEntry("0x24FEB2A7", "SSR Vienna Kreis")
  AddTextEntry("0x11F8F6C5", "OZ Crono")
  AddTextEntry("0x8B73F26D", "Enkei Apache V")
  AddTextEntry("0x7BA6F10A", "Enkei 6666")
  AddTextEntry("0x5EC0D765", "Weds Kranze Bazreia")
  AddTextEntry("0x5CE23050", "WedsSport SA60m")
  AddTextEntry("0x4AEECEBB", "Rays 57C6")
  AddTextEntry("0x3C809BF2", "SSR Formula Mesh")
  AddTextEntry("0x3B1018AD", "Rays GT-C")
  AddTextEntry("0x2E63C5AD", "Rays RE30")
  AddTextEntry("0x2AC069A1", "SSR MK2r")
  AddTextEntry("0x1CE33E72", "DY Champion")
  AddTextEntry("0x1A933317", "Enkei Racing GTC01")
  AddTextEntry("0x08C6208F", "Enkei RP03")
  AddTextEntry("0x051D191F", "Mugen GP")
  AddTextEntry("0x04A41A26", "Enkei RS05rr")

  --Forgiato PACK from  https://www.gta5-mods.com/vehicles/forgiato-wheels-pack-1-add-on
  AddTextEntry("0x02DDD6C7", "Forgiato Monoleggera Freddo-M (Custom)")
  AddTextEntry("0x03B058DC", "Forgiato Monoleggera Maglia-M (Custom)")
  AddTextEntry("0x0ACD6716", "Forgiato Monoleggera GTR-M")
  AddTextEntry("0x0EC7F0D6", "Forgiato Monoleggera Spacco-M")
  AddTextEntry("0x1E340FAA", "Forgiato Monoleggera Vizzo-M")
  AddTextEntry("0x2F132FA1", "Forgiato MonoLeggera Freddo-M")
  AddTextEntry("0x3C97CAAA", "Forgiato Monoleggera GTR-M (Custom)")
  AddTextEntry("0x4C3FEBC1", "Forgiato Monoleggera Vizzo-M (Custom)")
  AddTextEntry("0x9CF20B5D", "Forgiato Monoleggera Spacco-M (Custom)")
  AddTextEntry("0x18FB0371", "Forgiato Monoleggera Labbro-M (Custom)")
  AddTextEntry("0x279A2276", "Forgiato Ventoso-ECL (Custom)")
  AddTextEntry("0x952CFD9E", "Forgiato Monoleggera Spacco-M (Custom)")
  AddTextEntry("0x85945D7A", "Forgiato Monoleggera Freddo-M (Custom)")
  AddTextEntry("0xBC37CBB7", "Forgiato Monoleggera Vizzo-M (Custom)")
  AddTextEntry("0xBE234E97", "Forgiato Monoleggera Fissato-M")
  AddTextEntry("0xC7E5621B", "Forgiato Monoleggera Fissato-M (Custom)")
  AddTextEntry("0xCDE06F08", "Forgiato Monoleggera Vizzo-M (Custom)")
  AddTextEntry("0xD1C3F500", "Forgiato Monoleggera Maglia-M (Custom)")
  AddTextEntry("0xE0059187", "Forgiato Monoleggera Maglia-M")
  AddTextEntry("0xE05F1405", "Forgiato Monoleggera Tello-M")
  AddTextEntry("0xE2B517BE", "Forgiato Monoleggera Fissato-M (Custom)")
  AddTextEntry("0xF9CD46E1", "Forgiato Ventoso-ECL")
  AddTextEntry("0xF569BC4F", "Forgiato Monoleggera Labbro-M")
end)

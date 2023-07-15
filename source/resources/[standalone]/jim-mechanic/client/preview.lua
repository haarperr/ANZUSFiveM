local previewing = false
local properties

local wheelCats = {
  { id = 0,  name = Loc[Config.Lan]["rims"].label1 },
  { id = 1,  name = Loc[Config.Lan]["rims"].label2 },
  { id = 2,  name = Loc[Config.Lan]["rims"].label3 },
  { id = 3,  name = Loc[Config.Lan]["rims"].label4 },
  { id = 4,  name = Loc[Config.Lan]["rims"].label5 },
  { id = 5,  name = Loc[Config.Lan]["rims"].label6 },
  { id = 7,  name = Loc[Config.Lan]["rims"].label7 },
  { id = 8,  name = Loc[Config.Lan]["rims"].label8 },
  { id = 9,  name = Loc[Config.Lan]["rims"].label9 },
  { id = 10, name = Loc[Config.Lan]["rims"].label10 },
  { id = 11, name = Loc[Config.Lan]["rims"].label11 },
  { id = 12, name = Loc[Config.Lan]["rims"].label12 },
  { id = 6,  name = Loc[Config.Lan]["rims"].label13 },
  { id = 7,  name = Loc[Config.Lan]["rims"].label14 },
}

local function printDifferences(vehicle, properties, newproperties)
  qblog("Finished Previewing: [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
  local veh = searchCar(vehicle)
  local vehplate = "[" .. trim(properties.plate) .. "]"
  SetVehicleWindowTint(vehicle, properties["windowTint"])   -- Had issues resetting the windows if changed, manually do it here
  local vehlist = {}
  local modlist = {}
  if properties["color1"] ~= newproperties["color1"] then
    if type(newproperties["color1"]) ~= "table" then
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
        if newproperties["color1"] == v.id then
          vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].primary .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ") ]"
          modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ")",
            ["item"] = Loc[Config.Lan]["paint"].primary .. " - " .. QBCore.Shared.Items["paintcan"].label }
        end
      end
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
        if newproperties["color1"] == v.id then
          vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].primary .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ") ]"
          modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ")",
            ["item"] = Loc[Config.Lan]["paint"].primary .. " - " .. QBCore.Shared.Items["paintcan"].label }
        end
      end
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
        if newproperties["color1"] == v.id then
          vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].primary .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ") ]"
          modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ")",
            ["item"] = Loc[Config.Lan]["paint"].primary .. " - " .. QBCore.Shared.Items["paintcan"].label }
        end
      end
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsChameleon) do
        if newproperties["color1"] == v.id then
          vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].primary .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].chameleon .. ") ]"
          modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].chameleon .. ")",
            ["item"] = Loc[Config.Lan]["paint"].primary .. " - " .. QBCore.Shared.Items["paintcan"].label }
        end
      end
    end
  end
  if properties["color2"] ~= newproperties["color2"] then
    if type(newproperties["color2"]) ~= "table" then
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
        if newproperties["color2"] == v.id then
          vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].secondary .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ") ]"
          modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ")",
            ["item"] = Loc[Config.Lan]["paint"].secondary .. " - " .. QBCore.Shared.Items["paintcan"].label }
        end
      end
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
        if newproperties["color2"] == v.id then
          vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].secondary .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ") ]"
          modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ")",
            ["item"] = Loc[Config.Lan]["paint"].secondary .. " - " .. QBCore.Shared.Items["paintcan"].label }
        end
      end
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
        if newproperties["color2"] == v.id then
          vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].secondary .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ") ]"
          modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ")",
            ["item"] = Loc[Config.Lan]["paint"].secondary .. " - " .. QBCore.Shared.Items["paintcan"].label }
        end
      end
      for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsChameleon) do
        if newproperties["color2"] == v.id then
          vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].secondary .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].chameleon .. ") ]"
          modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].chameleon .. ")",
            ["item"] = Loc[Config.Lan]["paint"].secondary .. " - " .. QBCore.Shared.Items["paintcan"].label }
        end
      end
    end
  end
  if properties["pearlescentColor"] ~= newproperties["pearlescentColor"] then
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
      if newproperties["pearlescentColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].pearl .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ")",
          ["item"] = Loc[Config.Lan]["paint"].pearl .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
      if newproperties["pearlescentColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].pearl .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ")",
          ["item"] = Loc[Config.Lan]["paint"].pearl .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
      if newproperties["pearlescentColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].pearl .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ")",
          ["item"] = Loc[Config.Lan]["paint"].pearl .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsChameleon) do
      if newproperties["pearlescentColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].pearl .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].chameleon .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].chameleon .. ")",
          ["item"] = Loc[Config.Lan]["paint"].pearl .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
  end
  if properties["wheelColor"] ~= newproperties["wheelColor"] then
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
      if newproperties["wheelColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].wheel .. " Color - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ")",
          ["item"] = Loc[Config.Lan]["paint"].wheel .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
      if newproperties["wheelColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].wheel .. "Color - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ")",
          ["item"] = Loc[Config.Lan]["paint"].wheel .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
      if newproperties["wheelColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].wheel .. "Color - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ")",
          ["item"] = Loc[Config.Lan]["paint"].wheel .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsChameleon) do
      if newproperties["wheelColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].wheel .. "Color - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].chameleon .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].chameleon .. ")",
          ["item"] = Loc[Config.Lan]["paint"].wheel .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
  end
  if properties["dashboardColor"] ~= newproperties["dashboardColor"] then
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
      if newproperties["dashboardColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].dashboard .. "Color - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ")",
          ["item"] = Loc[Config.Lan]["paint"].dashboard .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
      if newproperties["dashboardColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].dashboard .. "Color - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ")",
          ["item"] = Loc[Config.Lan]["paint"].dashboard .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
      if newproperties["dashboardColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].dashboard .. "Color - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ")",
          ["item"] = Loc[Config.Lan]["paint"].dashboard .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
  end
  if properties["interiorColor"] ~= newproperties["interiorColor"] then
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
      if newproperties["interiorColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].interior .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metallic .. ")",
          ["item"] = Loc[Config.Lan]["paint"].interior .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
      if newproperties["interiorColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].interior .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].matte .. ")",
          ["item"] = Loc[Config.Lan]["paint"].interior .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
      if newproperties["interiorColor"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["paint"].interior .. " - [ " .. v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ") ]"
        modlist[#modlist + 1] = { ['type'] = v.name .. " (" .. Loc[Config.Lan]["paint"].metals .. ")",
          ["item"] = Loc[Config.Lan]["paint"].interior .. " - " .. QBCore.Shared.Items["paintcan"].label }
      end
    end
  end
  if properties["modFrontWheels"] ~= newproperties["modFrontWheels"] then
    for i = 1, #wheelCats do if newproperties["wheels"] == wheelCats[i].id then name = wheelCats[i].name end end
    originalWheel = GetVehicleWheelType(vehicle)
    SetVehicleWheelType(vehicle, newproperties["wheels"])
    if GetLabelText(GetModTextLabel(vehicle, 23, (newproperties["modFrontWheels"]))) == "NULL" then
      vehlist[#vehlist + 1] = "Wheels - [ " ..
      GetLabelText(GetModTextLabel(vehicle, 23, (newproperties["modFrontWheels"]))) .. " (" .. newproperties["modFrontWheels"] .. ") (" .. name .. ") ]"
      modlist[#modlist + 1] = { ['type'] = "(" .. name .. ")",
        ["item"] = "Wheels - [ " .. GetLabelText(GetModTextLabel(vehicle, 23, (newproperties["modFrontWheels"]))) .. " (" .. newproperties["modFrontWheels"] .. ") - " .. QBCore.Shared.Items["rims"].label }
    else
      vehlist[#vehlist + 1] = "Wheels - [ " .. GetLabelText(GetModTextLabel(vehicle, 23, (newproperties["modFrontWheels"]))) .. " (" .. name .. ") ]"
      modlist[#modlist + 1] = { ['type'] = "(" .. name .. ")",
        ["item"] = "Wheels - [ " .. GetLabelText(GetModTextLabel(vehicle, 23, (newproperties["modFrontWheels"]))) .. " ] - " .. QBCore.Shared.Items["rims"].label }
    end
    SetVehicleWheelType(vehicle, originalWheel)
  end
  if properties["modBackWheels"] ~= newproperties["modBackWheels"] then
    for i = 1, #wheelCats do if (newproperties["wheels"] + 1) == wheelCats[i].id then name = wheelCats[i].name end end
    originalWheel = GetVehicleWheelType(vehicle)
    SetVehicleWheelType(vehicle, newproperties["wheels"])
    --vehlist[#vehlist+1] = "Back Wheels -[ "..GetLabelText(GetModTextLabel(vehicle, 24, (newproperties["modBackWheels"]))).." - ("..name..") ]"
    if GetLabelText(GetModTextLabel(vehicle, 23, (newproperties["modFrontWheels"]))) == "NULL" then
      vehlist[#vehlist + 1] = "Back Wheels - [ " ..
      GetLabelText(GetModTextLabel(vehicle, 24, (newproperties["modBackWheels"]))) .. " (" .. newproperties["modBackWheels"] .. ") (" .. name .. ") ]"
      modlist[#modlist + 1] = { ['type'] = "(" .. name .. ")",
        ["item"] = "Back Wheels - [ " .. GetLabelText(GetModTextLabel(vehicle, 24, (newproperties["modBackWheels"]))) .. " (" .. newproperties["modBackWheels"] .. ") - " .. QBCore.Shared.Items["rims"].label }
    else
      vehlist[#vehlist + 1] = "Back Wheels - [ " .. GetLabelText(GetModTextLabel(vehicle, 24, (newproperties["modBackWheels"]))) .. " (" .. name .. ") ]"
      modlist[#modlist + 1] = { ['type'] = "(" .. name .. ")",
        ["item"] = "Back Wheels - [ " .. GetLabelText(GetModTextLabel(vehicle, 24, (newproperties["modBackWheels"]))) .. " ] - " .. QBCore.Shared.Items["rims"].label }
    end
    SetVehicleWheelType(vehicle, originalWheel)
  end
  if properties["plateIndex"] ~= newproperties["plateIndex"] then
    for k, v in pairs(Loc[Config.Lan].vehiclePlateOptions) do
      if newproperties["plateIndex"] == v.id then
        vehlist[#vehlist + 1] = Loc[Config.Lan]["police"].plates .. " - [ " .. v.name .. " ]"
        modlist[#modlist + 1] = { ['type'] = "(" .. v.name .. ")", ["item"] = Loc[Config.Lan]["police"].plates .. " - " .. QBCore.Shared.Items["customplate"].label }
      end
    end
  end
  if properties["windowTint"] ~= newproperties["windowTint"] then
    local name = ""
    if newproperties["windowTint"] == 0 then
      name = Loc[Config.Lan]["windows"].label1
    elseif newproperties["windowTint"] == 4 then
      name = Loc[Config.Lan]["windows"].label2
    elseif newproperties["windowTint"] == 5 then
      name = Loc[Config.Lan]["windows"].label3
    elseif newproperties["windowTint"] == 3 then
      name = Loc[Config.Lan]["windows"].label4
    elseif newproperties["windowTint"] == 2 then
      name = Loc[Config.Lan]["windows"].label5
    elseif newproperties["windowTint"] == 1 then
      name = Loc[Config.Lan]["windows"].label6
    end
    vehlist[#vehlist + 1] = Loc[Config.Lan]["windows"].menuheader .. " - [ " .. name .. " ] - "
    modlist[#modlist + 1] = { ['type'] = "(" .. name .. ")", ["item"] = Loc[Config.Lan]["windows"].menuheader .. " - " .. QBCore.Shared.Items["tint_supplies"].label }
  end
  if properties["modSpoilers"] ~= newproperties["modSpoilers"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label15 ..
    tostring(newproperties["modSpoilers"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 0, (newproperties["modSpoilers"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 0, (newproperties["modSpoilers"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label15 .. tostring(newproperties["modSpoilers"] + 1 .. " ] - " .. QBCore.Shared.Items["spoiler"].label) }
  end
  if properties["modFrontBumper"] ~= newproperties["modFrontBumper"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label16 ..
    tostring(newproperties["modFrontBumper"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 1, (newproperties["modFrontBumper"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 1, (newproperties["modFrontBumper"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label16 .. tostring(newproperties["modFrontBumper"] + 1 .. " ] - " .. QBCore.Shared.Items["bumper"].label) }
  end
  if properties["modRearBumper"] ~= newproperties["modRearBumper"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label17 ..
    tostring(newproperties["modRearBumper"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 2, (newproperties["modRearBumper"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 2, (newproperties["modRearBumper"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label17 .. tostring(newproperties["modRearBumper"] + 1 .. " ] - " .. QBCore.Shared.Items["bumper"].label) }
  end
  if properties["modSideSkirt"] ~= newproperties["modSideSkirt"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label18 ..
    tostring(newproperties["modSideSkirt"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 3, (newproperties["modSideSkirt"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 3, (newproperties["modSideSkirt"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label18 .. tostring(newproperties["modSideSkirt"] + 1 .. " ] - " .. QBCore.Shared.Items["skirts"].label) }
  end
  if properties["modExhaust"] ~= newproperties["modExhaust"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label19 ..
    tostring(newproperties["modExhaust"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 4, (newproperties["modExhaust"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 4, (newproperties["modExhaust"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label19 .. tostring(newproperties["modExhaust"] + 1 .. " ] - " .. QBCore.Shared.Items["spoiler"].label) }
  end
  if properties["modGrille"] ~= newproperties["modGrille"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label20 ..
    tostring(newproperties["modGrille"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 6, (newproperties["modGrille"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 6, (newproperties["modGrille"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label20 .. tostring(newproperties["modGrille"] + 1 .. " ] - " .. QBCore.Shared.Items["exhaust"].label) }
  end
  if properties["modHood"] ~= newproperties["modHood"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label21 ..
    tostring(newproperties["modHood"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 7, (newproperties["modHood"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 7, (newproperties["modHood"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label21 .. tostring(newproperties["modHood"] + 1 .. " ] - " .. QBCore.Shared.Items["hood"].label) }
  end
  if properties["modFender"] ~= newproperties["modFender"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label22 ..
    tostring(newproperties["modFender"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 8, (newproperties["modFender"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 8, (newproperties["modFender"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label22 .. tostring(newproperties["modFender"] + 1 .. " ] - " .. QBCore.Shared.Items["skirts"].label) }
  end
  if properties["modRightFender"] ~= newproperties["modRightFender"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label23 ..
    tostring(newproperties["modRightFender"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 9, (newproperties["modRightFender"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 9, (newproperties["modRightFender"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label23 .. tostring(newproperties["modRightFender"] + 1 .. " ] - " .. QBCore.Shared.Items["skirts"].label) }
  end
  if properties["modRoof"] ~= newproperties["modRoof"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label24 ..
    tostring(newproperties["modRoof"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 10, (newproperties["modRoof"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 10, (newproperties["modRoof"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label24 .. tostring(newproperties["modRoof"] + 1 .. " ] - " .. QBCore.Shared.Items["roof"].label) }
  end
  if properties["modPlateHolder"] ~= newproperties["modPlateHolder"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label25 ..
    tostring(newproperties["modPlateHolder"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 25, (newproperties["modPlateHolder"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 25, (newproperties["modPlateHolder"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label25 .. tostring(newproperties["modPlateHolder"] + 1 .. " ] - " .. QBCore.Shared.Items["customplate"].label) }
  end
  if properties["modVanityPlate"] ~= newproperties["modVanityPlate"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label26 ..
    tostring(newproperties["modVanityPlate"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 26, (newproperties["modVanityPlate"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 26, (newproperties["modVanityPlate"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label26 .. tostring(newproperties["modVanityPlate"] + 1 .. " ] - " .. QBCore.Shared.Items["customplate"].label) }
  end
  if properties["modTrimA"] ~= newproperties["modTrimA"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label27 ..
    tostring(newproperties["modTrimA"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 27, (newproperties["modTrimA"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 27, (newproperties["modTrimA"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label27 .. tostring(newproperties["modTrimA"] + 1 .. " ] - " .. QBCore.Shared.Items["externals"].label) }
  end
  if properties["modTrimB"] ~= newproperties["modTrimB"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label28 ..
    tostring(newproperties["modTrimB"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 44, (newproperties["modTrimB"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 44, (newproperties["modTrimB"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label28 .. tostring(newproperties["modTrimB"] + 1 .. " ] - " .. QBCore.Shared.Items["externals"].label) }
  end
  if properties["modTrunk"] ~= newproperties["modTrunk"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label29 ..
    tostring(newproperties["modTrunk"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 37, (newproperties["modTrunk"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 37, (newproperties["modTrunk"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label29 .. tostring(newproperties["modTrunk"] + 1 .. " ] - " .. QBCore.Shared.Items["externals"].label) }
  end
  if properties["modEngineBlock"] ~= newproperties["modEngineBlock"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label30 ..
    tostring(newproperties["modEngineBlock"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 39, (newproperties["modEngineBlock"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 39, (newproperties["modEngineBlock"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label30 .. tostring(newproperties["modEngineBlock"] + 1 .. " ] - " .. QBCore.Shared.Items["externals"].label) }
  end
  if properties["modAirFilter"] ~= newproperties["modAirFilter"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label31 ..
    tostring(newproperties["modAirFilter"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 40, (newproperties["modAirFilter"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 40, (newproperties["modAirFilter"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label31 .. tostring(newproperties["modAirFilter"] + 1 .. " ] - " .. QBCore.Shared.Items["externals"].label) }
  end
  if properties["modStruts"] ~= newproperties["modStruts"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label32 ..
    tostring(newproperties["modStruts"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 41, (newproperties["modStruts"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 41, (newproperties["modStruts"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label32 .. tostring(newproperties["modStruts"] + 1 .. " ] - " .. QBCore.Shared.Items["externals"].label) }
  end
  if properties["modArchCover"] ~= newproperties["modArchCover"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label33 ..
    tostring(newproperties["modArchCover"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 42, (newproperties["modArchCover"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 42, (newproperties["modArchCover"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label33 .. tostring(newproperties["modArchCover"] + 1 .. " ] - " .. QBCore.Shared.Items["externals"].label) }
  end

  if properties["modFrame"] ~= newproperties["modFrame"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label34 ..
    tostring(newproperties["modFrame"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 5, (newproperties["modFrame"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 5, (newproperties["modFrame"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label34 .. tostring(newproperties["modFrame"] + 1 .. " ] - " .. QBCore.Shared.Items["rollcage"].label) }
  end
  if properties["modOrnaments"] ~= newproperties["modOrnaments"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label35 ..
    tostring(newproperties["modOrnaments"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 28, (newproperties["modOrnaments"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 5, (newproperties["modOrnaments"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label35 .. tostring(newproperties["modOrnaments"] + 1 .. " ] - " .. QBCore.Shared.Items["internals"].label) }
  end
  if properties["modDashboard"] ~= newproperties["modDashboard"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label36 ..
    tostring(newproperties["modDashboard"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 29, (newproperties["modDashboard"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 29, (newproperties["modDashboard"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label36 .. tostring(newproperties["modDashboard"] + 1 .. " ] - " .. QBCore.Shared.Items["internals"].label) }
  end
  if properties["modDial"] ~= newproperties["modDial"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label37 ..
    tostring(newproperties["modDial"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 30, (newproperties["modDial"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 30, (newproperties["modDial"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label37 .. tostring(newproperties["modDial"] + 1 .. " ] - " .. QBCore.Shared.Items["internals"].label) }
  end
  if properties["modDoorSpeaker"] ~= newproperties["modDoorSpeaker"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label38 ..
    tostring(newproperties["modDoorSpeaker"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 31, (newproperties["modDoorSpeaker"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 31, (newproperties["modDoorSpeaker"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label38 .. tostring(newproperties["modDoorSpeaker"] + 1 .. " ] - " .. QBCore.Shared.Items["internals"].label) }
  end
  if properties["modSeats"] ~= newproperties["modSeats"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label39 ..
    tostring(newproperties["modSeats"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 32, (newproperties["modSeats"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 32, (newproperties["modSeats"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label39 .. tostring(newproperties["modSeats"] + 1 .. " ] - " .. QBCore.Shared.Items["seat"].label) }
  end
  if properties["modSteeringWheel"] ~= newproperties["modSteeringWheel"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label40 ..
    tostring(newproperties["modSteeringWheel"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 33, (newproperties["modSteeringWheel"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 33, (newproperties["modSteeringWheel"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label40 .. tostring(newproperties["modSteeringWheel"] + 1 .. " ] - " .. QBCore.Shared.Items["internals"].label) }
  end
  if properties["modShifterLeavers"] ~= newproperties["modShifterLeavers"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label41 ..
    tostring(newproperties["modShifterLeavers"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 34, (newproperties["modShifterLeavers"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 34, (newproperties["modShifterLeavers"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label41 .. tostring(newproperties["modShifterLeavers"] + 1 .. " ] - " .. QBCore.Shared.Items["internals"].label) }
  end
  if properties["modAPlate"] ~= newproperties["modAPlate"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label42 ..
    tostring(newproperties["modAPlate"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 35, (newproperties["modAPlate"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 35, (newproperties["modAPlate"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label42 .. tostring(newproperties["modAPlate"] + 1 .. " ] - " .. QBCore.Shared.Items["internals"].label) }
  end
  if properties["modSpeakers"] ~= newproperties["modSpeakers"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label43 ..
    tostring(newproperties["modSpeakers"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 36, (newproperties["modSpeakers"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 36, (newproperties["modAPlate"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label43 .. tostring(newproperties["modAPlate"] + 1 .. " ] - " .. QBCore.Shared.Items["internals"].label) }
  end
  if properties["modHydrolic"] ~= newproperties["modHydrolic"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label44 ..
    tostring(newproperties["modHydrolic"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 38, (newproperties["modHydrolic"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 38, (newproperties["modHydrolic"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label44 .. tostring(newproperties["modHydrolic"] + 1 .. " ] - " .. QBCore.Shared.Items["externals"].label) }
  end
  if properties["modAerials"] ~= newproperties["modAerials"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label45 ..
    tostring(newproperties["modAerials"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 43, (newproperties["modAerials"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 43, (newproperties["modAerials"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label45 .. tostring(newproperties["modAerials"] + 1 .. " ] - " .. QBCore.Shared.Items["externals"].label) }
  end
  if properties["modTank"] ~= newproperties["modTank"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["check"].label46 ..
    tostring(newproperties["modTank"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 45, (newproperties["modTank"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 45, (newproperties["modTank"]))) .. ")",
      ["item"] = Loc[Config.Lan]["check"].label46 .. tostring(newproperties["modTank"] + 1 .. " ] - " .. QBCore.Shared.Items["externals"].label) }
  end
  if properties["modLivery"] ~= newproperties["modLivery"] then
    vehlist[#vehlist + 1] = Loc[Config.Lan]["police"].livery ..
    " - [ " .. tostring(newproperties["modLivery"] + 1) .. ". " .. GetLabelText(GetModTextLabel(vehicle, 48, (newproperties["modLivery"]))) .. " ]"
    modlist[#modlist + 1] = { ['type'] = "(" .. GetLabelText(GetModTextLabel(vehicle, 48, (newproperties["modLivery"]))) .. ")",
      ["item"] = Loc[Config.Lan]["police"].livery .. " - [ " .. tostring(newproperties["modLivery"] + 1 .. " ] - " .. QBCore.Shared.Items["livery"].label) }
  end

  if Config.PreviewPhone then
    if vehlist[1] then
      local newlist = ""
      for i = 1, #vehlist do
        newlist = newlist .. "<br>" .. vehlist[i]
      end
      if Config.PhoneMail == "gks" then
        event = 'gksphone:NewMail'
      elseif Config.PhoneMail == "qs" then
        event = 'qs-smartphone:server:sendNewMail'
      elseif Config.PhoneMail == "qb" then
        event = 'qb-phone:server:sendNewMail'
      end
      TriggerServerEvent(event, {
        sender = vehplate,
        subject = veh:gsub("<br>", ""),
        message = veh ..
        Loc[Config.Lan]["police"].plates ..
        ": " .. vehplate .. "<br><br>" .. Loc[Config.Lan]["previews"].changes .. #vehlist .. "<br> ------------------------------ <br>" .. newlist,
        button = {}
      })
    end
  else
    if vehlist[1] then
      local info = { veh = veh, vehplate = vehplate, vehlist = vehlist }
      TriggerServerEvent("jim-mechanic:server:giveList", info)
    end
  end
  if Config.DiscordPreview then
    if modlist[1] then
      local shopName = " - Unknown"
      local thumb = "http://clipart-library.com/image_gallery2/Spanner-PNG-Image.png"
      local htmllink = Config.DiscordDefault
      local colour = 16753920
      for k, v in pairs(Config.Locations) do
        if #(GetEntityCoords(PlayerPedId()) - v.blip) <= 30 then
          if v.discordlink ~= "" then
            shopName = " - " .. v.bliplabel
            thumb = v.discordimg
            htmllink = v.discordlink
            colour = v.discordcolour
          end
          break
        end
      end
      TriggerServerEvent("jim-mechanic:server:discordLog",
        { veh = veh, vehplate = vehplate, modlist = modlist, shopName = shopName, htmllink = htmllink, colour = colour, thumb = thumb })
    end
  end
end

RegisterNetEvent("jim-mechanic:client:giveList", function(item)
  local list = {}
  local newlist = ""
  for i = 1, #item.info["vehlist"] do newlist = newlist .. item.info["vehlist"][i] .. "<br>" end
  list[#list + 1] = { isMenuHeader = true, header = item.info["veh"],
    txt = Loc[Config.Lan]["police"].plates .. ": " .. item.info["vehplate"] .. "<br>" .. Loc[Config.Lan]["previews"].changes .. (#item.info["vehlist"]) }
  list[#list + 1] = { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
    params = { event = "jim-mechanic:client:Menu:Close" }, }
  list[#list + 1] = { isMenuHeader = true, header = "", txt = newlist }
  exports['qb-menu']:openMenu(list)
end)

--A function to detect if the person editing is in the driver seat or not
local function preview(playerPed, vehicle)
  if not previewing then
    previewing = true
    qblog("Used `/preview` in: [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
    TriggerServerEvent("jim-mechanic:server:preview", true, VehToNet(vehicle), trim(GetVehicleNumberPlateText(vehicle)))
    FreezeEntityPosition(vehicle, true)
  else
    return
  end
  properties = QBCore.Functions.GetVehicleProperties(vehicle)
  local startcoords = GetEntityCoords(vehicle)
  while previewing do
    if #(startcoords - GetEntityCoords(vehicle)) > 3 or (GetPedInVehicleSeat(vehicle, -1) ~= playerPed) then previewing = false end
    if not previewing then
      previewing = false
      FreezeEntityPosition(vehicle, false)
      TriggerServerEvent("jim-mechanic:server:preview", false)
      local newproperties = QBCore.Functions.GetVehicleProperties(vehicle)
      QBCore.Functions.SetVehicleProperties(vehicle, properties)
      --TriggerEvent("vehiclekeys:client:SetOwner", trim(GetVehicleNumberPlateText(vehicle)))
      SetVehicleUndriveable(vehicle, false)
      SetVehicleEngineOn(vehicle, true, false, false)
      printDifferences(vehicle, properties, newproperties)
      break
    end
    Wait(2000)
  end
end

RegisterNetEvent("jim-mechanic:preview:exploitfix", function(vehicle, resetprop)
  if Config.Debug then print("^5Debug^7: ^3Preview: ^2Using client to reset vehicle properties of abandoned vehicle^7") end
  if not NetworkDoesEntityExistWithNetworkId(vehicle) then return end   -- Add network check here
  if not DoesEntityExist(NetToVeh(vehicle)) then return end
  QBCore.Functions.SetVehicleProperties(NetToVeh(vehicle), resetprop)
  FreezeEntityPosition(NetToVeh(vehicle), false)
end)

RegisterNetEvent('jim-mechanic:client:Preview:Menu', function()
  if Config.PreviewJob then if not jobChecks() then return end end
  if Config.PreviewLocation then if not locationChecks() then return end end
  local playerPed = PlayerPedId()
  local validMods = {}
  local vehicle = nil
  local hasExtra = false
  if not outCar() then return end
  local vehicle = GetVehiclePedIsIn(playerPed, false)
  pushVehicle(vehicle)
  if GetPedInVehicleSeat(vehicle, -1) ~= playerPed then return end
  if IsPedInAnyVehicle(playerPed, false) then
    local PreviewMenu = {}
    --PreviewMenu[#PreviewMenu+1] = { header = "Test", txt = "Vehicle Death Simulator", params = { event = "jim-mechanic:client:Preview:test" }, }
    PreviewMenu[#PreviewMenu + 1] = { isMenuHeader = true, header = searchCar(vehicle),
      txt = "Class: " ..
      getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle) }

    PreviewMenu[#PreviewMenu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
      params = { event = "jim-mechanic:client:Menu:Close" }, }
    PreviewMenu[#PreviewMenu + 1] = { header = "", txt = Loc[Config.Lan]["paint"].menuheader, params = { event = "jim-mechanic:client:Preview:Paint" }, }
    PreviewMenu[#PreviewMenu + 1] = { header = "", txt = Loc[Config.Lan]["police"].plates, params = { event = "jim-mechanic:client:Preview:Plates" }, }

    if GetNumVehicleMods(vehicle, 48) > 0 or GetVehicleLiveryCount(vehicle) > -1 then
      PreviewMenu[#PreviewMenu + 1] = { header = "", txt = Loc[Config.Lan]["police"].livery, params = { event = "jim-mechanic:client:Preview:Livery" }, }
    end
    PreviewMenu[#PreviewMenu + 1] = { header = "", txt = Loc[Config.Lan]["rims"].menuheader, params = { event = "jim-mechanic:client:Preview:Rims:Check" }, }

    local list = {
      --Exterior
      { id = 0,  name = Loc[Config.Lan]["check"].label15 },
      { id = 1,  name = Loc[Config.Lan]["check"].label16 },
      { id = 2,  name = Loc[Config.Lan]["check"].label17 },
      { id = 3,  name = Loc[Config.Lan]["check"].label18 },
      { id = 4,  name = Loc[Config.Lan]["check"].label19 },
      { id = 6,  name = Loc[Config.Lan]["check"].label20 },
      { id = 7,  name = Loc[Config.Lan]["check"].label21 },
      { id = 8,  name = Loc[Config.Lan]["check"].label22 },
      { id = 9,  name = Loc[Config.Lan]["check"].label23 },
      { id = 10, name = Loc[Config.Lan]["check"].label24 },
      { id = 25, name = Loc[Config.Lan]["check"].label25 },
      { id = 26, name = Loc[Config.Lan]["check"].label26 },
      { id = 27, name = Loc[Config.Lan]["check"].label27 },
      { id = 44, name = Loc[Config.Lan]["check"].label28 },
      { id = 37, name = Loc[Config.Lan]["check"].label29 },
      { id = 39, name = Loc[Config.Lan]["check"].label30 },
      { id = 40, name = Loc[Config.Lan]["check"].label31 },
      { id = 41, name = Loc[Config.Lan]["check"].label32 },
      { id = 42, name = Loc[Config.Lan]["check"].label33 },
      --Interior
      { id = 5,  name = Loc[Config.Lan]["check"].label34 },
      { id = 28, name = Loc[Config.Lan]["check"].label35 },
      { id = 29, name = Loc[Config.Lan]["check"].label36 },
      { id = 30, name = Loc[Config.Lan]["check"].label37 },
      { id = 31, name = Loc[Config.Lan]["check"].label38 },
      { id = 32, name = Loc[Config.Lan]["check"].label39 },
      { id = 33, name = Loc[Config.Lan]["check"].label40 },
      { id = 34, name = Loc[Config.Lan]["check"].label41 },
      { id = 35, name = Loc[Config.Lan]["check"].label42 },
      { id = 36, name = Loc[Config.Lan]["check"].label43 },
      { id = 38, name = Loc[Config.Lan]["check"].label44 },
      { id = 43, name = Loc[Config.Lan]["check"].label45 },
      { id = 45, name = Loc[Config.Lan]["check"].label46 },
    }
    for i = 1, #list do
      if GetNumVehicleMods(vehicle, list[i].id) ~= 0 then
        PreviewMenu[#PreviewMenu + 1] = { header = "", txt = list[i].name .. Loc[Config.Lan]["common"].amountoption .. (GetNumVehicleMods(vehicle, list[i].id) + 1) .. " ]",
          params = { event = "jim-mechanic:client:Preview:Multi", args = list[i] }, }
      end
    end

    if not IsThisModelABike(GetEntityModel(vehicle)) then
      PreviewMenu[#PreviewMenu + 1] = { header = "", txt = Loc[Config.Lan]["windows"].menuheader, params = { event = "jim-mechanic:client:Preview:Windows:Check" }, }
    end
    exports['qb-menu']:openMenu(PreviewMenu)
    preview(playerPed, vehicle)
  end
end)

RegisterNetEvent("jim-mechanic:client:Preview:Camera", function(data)
  Wait(3000)
  TriggerEvent(data.event, data.data)
end)

RegisterNetEvent("jim-mechanic:client:Preview:Multi", function(data)
  local playerPed = PlayerPedId()
  local validMods = {}
  if IsPedInAnyVehicle(playerPed, false) then
    vehicle = GetVehiclePedIsIn(playerPed, false)
    for i = 1, GetNumVehicleMods(vehicle, data.id) do
      if GetVehicleMod(vehicle, data.id) == (i - 1) then txt = Loc[Config.Lan]["common"].current else txt = "" end
      validMods[i] = { id = (i - 1), name = GetLabelText(GetModTextLabel(vehicle, data.id, (i - 1))), install = txt }
    end
  end
  local icon = ""
  local disabled = false
  if GetVehicleMod(vehicle, data.id) == -1 then
    stockinstall = Loc[Config.Lan]["common"].current
    icon = "fas fa-check"
    disabled = true
  else
    stockinstall = ""
  end
  local modMenu = {
    {
      header = searchCar(vehicle),
      txt = "Class: " ..
      getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
      params = { event = "jim-mechanic:client:Preview:Camera", args = { data = data, event = "jim-mechanic:client:Preview:Multi" }, }
    },
    { isMenuHeader = true,               header = "",             txt = data.name .. " " .. Loc[Config.Lan]["common"].amountoption .. (#validMods + 1) .. " ]", },
    { icon = "fas fa-circle-arrow-left", header = "",             txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
                                                                                                                                                                  params = {
        event = "jim-mechanic:client:Preview:Menu" } },
    { icon = icon,                       isMenuHeader = disabled, header = "0. " .. Loc[Config.Lan]["common"].stock,                                            txt = stockinstall,
                                                                                                                                                                                                                          params = {
        event = "jim-mechanic:client:Preview:Multi:Apply", args = { id = -1, mod = data.id, name = data.name }, } } }
  for k, v in pairs(validMods) do
    local icon = ""
    local disabled = false
    if GetVehicleMod(vehicle, data.id) == v.id then
      icon = "fas fa-check"
      disabled = true
    end
    modMenu[#modMenu + 1] = { icon = icon, isMenuHeader = disabled, header = k .. ". " .. v.name, txt = v.install,
      params = { event = 'jim-mechanic:client:Preview:Multi:Apply', args = { id = tostring(v.id), mod = data.id, name = data.name }, } }
  end
  exports['qb-menu']:openMenu(modMenu)
end)

RegisterNetEvent('jim-mechanic:client:Preview:Multi:Apply', function(data)
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  local returndata = { id = data.mod, name = data.name }
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end

  local modName = GetLabelText(GetModTextLabel(vehicle, data.mod, tonumber(data.id)))

  if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
  if GetVehicleMod(vehicle, data.mod) == tonumber(data.id) then
    TriggerEvent('jim-mechanic:client:Preview:Multi', returndata)
  elseif GetVehicleMod(vehicle, data.mod) ~= tonumber(data.id) then
    SetVehicleMod(vehicle, data.mod, tonumber(data.id))
    TriggerEvent('jim-mechanic:client:Preview:Multi', returndata)
  end
end)

RegisterNetEvent('jim-mechanic:client:Preview:Livery', function(data)
  local playerPed = PlayerPedId()
  local validMods = {}
  if not data then data = {} end
  local vehicle = nil
  if IsPedInAnyVehicle(playerPed, false) then
    vehicle = GetVehiclePedIsIn(playerPed, false)
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
      if GetVehicleLivery(vehicle) == 0 then
        stockinstall = Loc[Config.Lan]["common"].current
        icon = "fas fa-check"
        disabled = true
      else
        stockinstall = ""
      end
      LiveryMenu[#LiveryMenu + 1] = {
        header = searchCar(vehicle),
        txt = "Class: " ..
        getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
        params = { event = "jim-mechanic:client:Preview:Camera", args = { data = data, event = "jim-mechanic:client:Preview:Livery" }, }
      }
      LiveryMenu[#LiveryMenu + 1] = { isMenuHeader = true, header = "",
        txt = Loc[Config.Lan]["police"].livery .. " - [ " .. Loc[Config.Lan]["common"].amountoption .. GetVehicleLiveryCount(vehicle) .. " ]" }

      if data and data.close then
        LiveryMenu[#LiveryMenu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
          params = { event = "jim-mechanic:client:Menu:Close" } }
      else
        LiveryMenu[#LiveryMenu + 1] = { icon = "fas fa-circle-arrow-left", header = "", txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
          params = { event = "jim-mechanic:client:Preview:Menu" }, }
      end

      LiveryMenu[#LiveryMenu + 1] = { icon = icon, isMenuHeader = disabled, header = "0. " .. Loc[Config.Lan]["common"].stock, txt = stockinstall,
        params = { event = "jim-mechanic:client:Preview:Apply", args = { id = tostring(0), old = true, close = data.close } } }
      for k, v in pairs(validMods) do
        local icon = ""
        local disabled = false
        if GetVehicleLivery(vehicle) == v.id then
          icon = "fas fa-check"
          disabled = true
        end
        LiveryMenu[#LiveryMenu + 1] = { icon = icon, isMenuHeader = disabled, header = k .. ". " .. v.name, txt = v.install,
          params = { event = 'jim-mechanic:client:Preview:Apply', args = { id = tostring(v.id), old = true, close = data.close } } }
      end
    elseif oldlivery ~= true then
      if GetVehicleMod(vehicle, 48) == -1 then
        stockinstall = Loc[Config.Lan]["common"].current
        icon = "fas fa-check"
        disabled = true
      else
        stockinstall = ""
      end
      LiveryMenu[#LiveryMenu + 1] = {
        header = searchCar(vehicle),
        txt = "Class: " ..
        getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
        params = { event = "jim-mechanic:client:Preview:Camera", args = { data = data, event = "jim-mechanic:client:Preview:Livery" }, }
      }
      LiveryMenu[#LiveryMenu + 1] = { isMenuHeader = true, header = "",
        txt = Loc[Config.Lan]["police"].livery .. " - [ " .. Loc[Config.Lan]["common"].amountoption .. (GetNumVehicleMods(vehicle, 48) + 1) .. " ]" }
      if data and data.close then
        LiveryMenu[#LiveryMenu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
          params = { event = "jim-mechanic:client:Menu:Close" } }
      else
        LiveryMenu[#LiveryMenu + 1] = { icon = "fas fa-circle-arrow-left", header = "", txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
          params = { event = "jim-mechanic:client:Preview:Menu" }, }
      end
      LiveryMenu[#LiveryMenu + 1] = { header = "0. " .. Loc[Config.Lan]["common"].stock, txt = stockinstall,
        params = { event = "jim-mechanic:client:Preview:Apply", args = { id = tostring(-1), close = data.close } } }
      for k, v in pairs(validMods) do
        local icon = ""
        local disabled = false
        if GetVehicleMod(vehicle, 48) == v.id then
          icon = "fas fa-check"
          disabled = true
        end
        LiveryMenu[#LiveryMenu + 1] = { icon = icon, isMenuHeader = disabled, header = k .. ". " .. v.name, txt = v.install,
          params = { event = 'jim-mechanic:client:Preview:Apply', args = { id = tostring(v.id), close = data.close } } }
      end
    end
    exports['qb-menu']:openMenu(LiveryMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Preview:Apply', function(data)
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end
  local label = GetModTextLabel(vehicle, 48, tonumber(data.id))
  local modName = GetLabelText(label)
  if data.old then
    if modName == "NULL" then modName = Loc[Config.Lan]["livery"].oldMod end
    if GetVehicleLivery(vehicle) == tonumber(data.id) then
      triggerNotify(nil, data.id .. Loc[Config.Lan]["common"].already, "error")
      TriggerEvent('jim-mechanic:client:Preview:Livery')
      return
    end
  else
    if modName == "NULL" then modName = Loc[Config.Lan]["common"].stock end
    if GetVehicleMod(vehicle, 48) == tonumber(data.id) then
      triggerNotify(nil, modName .. Loc[Config.Lan]["common"].already, "error")
      TriggerEvent('jim-mechanic:client:Preview:Livery')
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
  if data.close then
    TriggerEvent('jim-mechanic:client:Preview:Livery', { close = true })
  else
    TriggerEvent('jim-mechanic:client:Preview:Livery')
  end
  oldlivery = nil
end)

RegisterNetEvent('jim-mechanic:client:Preview:Plates', function()
  local playerPed = PlayerPedId()
  local vehicle = nil
  if IsPedInAnyVehicle(playerPed, false) then
    vehicle = GetVehiclePedIsIn(playerPed, false)
    if DoesEntityExist(vehicle) then
      local PlateMenu = {
        {
          header = searchCar(vehicle),
          txt = "Class: " ..
          getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
          params = { event = "jim-mechanic:client:Preview:Camera", args = { data = data, event = "jim-mechanic:client:Preview:Plates" }, }
        },
        { header = Loc[Config.Lan]["plates"].menuheader2, isMenuHeader = true },
        { icon = "fas fa-circle-arrow-left",              header = "",        txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
                                                                                                                                                 params = {
            event = "jim-mechanic:client:Preview:Menu" } } }
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
        PlateMenu[#PlateMenu + 1] = { icon = icon, isMenuHeader = disabled, header = k .. ". " .. v.name, txt = installed,
          params = { event = 'jim-mechanic:client:Preview:Plates:Apply', args = v.id } }
      end
      exports['qb-menu']:openMenu(PlateMenu)
    end
  end
end)

RegisterNetEvent('jim-mechanic:client:Preview:Plates:Apply', function(index)
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end
  if GetVehicleNumberPlateTextIndex(vehicle) == tonumber(index) then
    triggerNotify(nil, Loc[Config.Lan]["plates"].already, "error")
    TriggerEvent('jim-mechanic:client:Preview:Plates')
  elseif GetVehicleNumberPlateTextIndex(vehicle) ~= tonumber(index) then
    SetVehicleNumberPlateTextIndex(vehicle, index)
    emptyHands(playerPed)
    TriggerEvent('jim-mechanic:client:Preview:Plates')
  end
end)

RegisterNetEvent('jim-mechanic:client:Preview:Paint', function()
  local playerPed = PlayerPedId()
  local validMods = {}
  local vehicle = nil
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end

  local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
  local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
  local interiorColor = GetVehicleInteriorColor(vehicle)
  local dashboardColor = GetVehicleDashboardColour(vehicle)

  for _, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do
    if vehPrimaryColour == v.id then vehPrimaryColour = Loc[Config.Lan]["paint"].metallic .. " " .. v.name end
    if vehSecondaryColour == v.id then vehSecondaryColour = Loc[Config.Lan]["paint"].metallic .. " " .. v.name end
    if vehPearlescentColour == v.id then vehPearlescentColour = Loc[Config.Lan]["paint"].metallic .. " " .. v.name end
    if vehWheelColour == v.id then vehWheelColour = Loc[Config.Lan]["paint"].metallic .. " " .. v.name end
    if interiorColor == v.id then interiorColor = Loc[Config.Lan]["paint"].metallic .. " " .. v.name end
    if dashboardColor == v.id then dashboardColor = Loc[Config.Lan]["paint"].metallic .. " " .. v.name end
  end
  for _, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMatte) do
    if vehPrimaryColour == v.id then vehPrimaryColour = Loc[Config.Lan]["paint"].matte .. " " .. v.name end
    if vehSecondaryColour == v.id then vehSecondaryColour = Loc[Config.Lan]["paint"].matte .. " " .. v.name end
    if vehPearlescentColour == v.id then vehPearlescentColour = Loc[Config.Lan]["paint"].matte .. " " .. v.name end
    if vehWheelColour == v.id then vehWheelColour = Loc[Config.Lan]["paint"].matte .. " " .. v.name end
    if interiorColor == v.id then interiorColor = Loc[Config.Lan]["paint"].matte .. " " .. v.name end
    if dashboardColor == v.id then dashboardColor = Loc[Config.Lan]["paint"].matte .. " " .. v.name end
  end
  for _, v in pairs(Loc[Config.Lan].vehicleResprayOptionsMetals) do
    if vehPrimaryColour == v.id then vehPrimaryColour = v.name end
    if vehSecondaryColour == v.id then vehSecondaryColour = v.name end
    if vehPearlescentColour == v.id then vehPearlescentColour = v.name end
    if vehWheelColour == v.id then vehWheelColour = v.name end
    if interiorColor == v.id then interiorColor = v.name end
    if dashboardColor == v.id then dashboardColor = v.name end
  end
  for _, v in pairs(Loc[Config.Lan].vehicleResprayOptionsChameleon) do
    if vehPrimaryColour == v.id then vehPrimaryColour = v.name end
    if vehSecondaryColour == v.id then vehSecondaryColour = v.name end
    if vehPearlescentColour == v.id then vehPearlescentColour = v.name end
    if vehWheelColour == v.id then vehWheelColour = v.name end
    if interiorColor == v.id then interiorColor = v.name end
    if dashboardColor == v.id then dashboardColor = v.name end
  end
  if type(vehPrimaryColour) == "number" then vehPrimaryColour = Loc[Config.Lan]["common"].stock end
  if type(vehSecondaryColour) == "number" then vehSecondaryColour = Loc[Config.Lan]["common"].stock end
  if type(vehPearlescentColour) == "number" then vehPearlescentColour = Loc[Config.Lan]["common"].stock end
  if type(vehWheelColour) == "number" then vehWheelColour = Loc[Config.Lan]["common"].stock end
  if type(interiorColor) == "number" then interiorColor = Loc[Config.Lan]["common"].stock end
  if type(dashboardColor) == "number" then dashboardColor = Loc[Config.Lan]["common"].stock end
  local PaintMenu = {
    {
      header = searchCar(vehicle),
      txt = "Class: " ..
      getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
      params = { event = "jim-mechanic:client:Preview:Camera", args = { data = nil, event = "jim-mechanic:client:Preview:Paint" }, }
    },
    { header = Loc[Config.Lan]["paint"].menuheader, txt = "",    isMenuHeader = true },
    { icon = "fas fa-circle-arrow-left",            header = "", txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
                                                                                                                                    params = {
        event = "jim-mechanic:client:Preview:Menu", } } }
  PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].primary, txt = Loc[Config.Lan]["common"].current .. ": " .. vehPrimaryColour,
    params = { event = "jim-mechanic:client:Preview:Paints:Choose", args = Loc[Config.Lan]["paint"].primary } }
  PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].secondary, txt = Loc[Config.Lan]["common"].current .. ": " .. vehSecondaryColour,
    params = { event = "jim-mechanic:client:Preview:Paints:Choose", args = Loc[Config.Lan]["paint"].secondary } }
  PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].pearl, txt = Loc[Config.Lan]["common"].current .. ": " .. vehPearlescentColour,
    params = { event = "jim-mechanic:client:Preview:Paints:Choose", args = Loc[Config.Lan]["paint"].pearl } }
  PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].wheel, txt = Loc[Config.Lan]["common"].current .. ": " .. vehWheelColour,
    params = { event = "jim-mechanic:client:Preview:Paints:Choose", args = Loc[Config.Lan]["paint"].wheel } }
  if not IsThisModelABike(GetEntityModel(vehicle)) then
    PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].interior, txt = Loc[Config.Lan]["common"].current .. ": " .. interiorColor,
      params = { event = "jim-mechanic:client:Preview:Paints:Choose", args = Loc[Config.Lan]["paint"].interior } }
    PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].dashboard, txt = Loc[Config.Lan]["common"].current .. ": " .. dashboardColor,
      params = { event = "jim-mechanic:client:Preview:Paints:Choose", args = Loc[Config.Lan]["paint"].dashboard } }
  end
  exports['qb-menu']:openMenu(PaintMenu)
end)

RegisterNetEvent('jim-mechanic:client:Preview:Paints:Choose', function(data)
  local vehicle = nil
  if IsPedInAnyVehicle(PlayerPedId(), false) then vehicle = GetVehiclePedIsIn(PlayerPedId(), false) end
  if DoesEntityExist(vehicle) then
    local PaintMenu = {
      {
        header = searchCar(vehicle),
        txt = "Class: " ..
        getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
        params = { event = "jim-mechanic:client:Preview:Camera", args = { data = data, event = "jim-mechanic:client:Preview:Paints:Choose" }, }
      },
      { header = data .. Loc[Config.Lan]["paint"].menuheader, txt = "",    isMenuHeader = true },
      { icon = "fas fa-circle-arrow-left",                    header = "", txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
                                                                                                                                              params = {
          event = "jim-mechanic:client:Preview:Paint" } }, }
    PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].classic, txt = "",
      params = { event = "jim-mechanic:client:Preview:Paints:Choose:Colour", args = { paint = data, finish = Loc[Config.Lan]["paint"].classic } } }
    PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].metallic, txt = "",
      params = { event = "jim-mechanic:client:Preview:Paints:Choose:Colour", args = { paint = data, finish = Loc[Config.Lan]["paint"].metallic } } }
    PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].matte, txt = "",
      params = { event = "jim-mechanic:client:Preview:Paints:Choose:Colour", args = { paint = data, finish = Loc[Config.Lan]["paint"].matte } } }
    PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].metals, txt = "",
      params = { event = "jim-mechanic:client:Preview:Paints:Choose:Colour", args = { paint = data, finish = Loc[Config.Lan]["paint"].metals } } }
    if Config.Chameleon and (data ~= Loc[Config.Lan]["paint"].interior and data ~= Loc[Config.Lan]["paint"].dashboard) then
      PaintMenu[#PaintMenu + 1] = { header = Loc[Config.Lan]["paint"].chameleon, txt = "",
        params = { event = "jim-mechanic:client:Preview:Paints:Choose:Colour", args = { paint = data, finish = Loc[Config.Lan]["paint"].chameleon } } }
    end
    exports['qb-menu']:openMenu(PaintMenu)
  end
end)

RegisterNetEvent('jim-mechanic:client:Preview:Paints:Choose:Colour', function(data)
  local playerPed = PlayerPedId()
  local vehicle = nil
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end
  local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
  local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
  if data.paint == Loc[Config.Lan]["paint"].primary then colourCheck = vehPrimaryColour end
  if data.paint == Loc[Config.Lan]["paint"].secondary then colourCheck = vehSecondaryColour end
  if data.paint == Loc[Config.Lan]["paint"].pearl then colourCheck = vehPearlescentColour end
  if data.paint == Loc[Config.Lan]["paint"].wheel then colourCheck = vehWheelColour end
  if data.paint == Loc[Config.Lan]["paint"].dashboard then colourCheck = GetVehicleDashboardColour(vehicle) end
  if data.paint == Loc[Config.Lan]["paint"].interior then colourCheck = GetVehicleInteriorColour(vehicle) end
  local PaintMenu = {
    {
      header = searchCar(vehicle),
      txt = "Class: " ..
      getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
      params = { event = "jim-mechanic:client:Preview:Camera", args = { data = data, event = "jim-mechanic:client:Preview:Paints:Choose:Colour" }, }
    },
    { isMenuHeader = true,               header = data.finish .. " " .. data.paint, txt = "" },
    { icon = "fas fa-circle-arrow-left", header = "",                               txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
                                                                                                                                                       params = {
        event = "jim-mechanic:client:Preview:Paints:Choose", args = data.paint } } }
  local installed = nil
  if data.finish == Loc[Config.Lan]["paint"].classic then
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
      PaintMenu[#PaintMenu + 1] = { icon = icon, isMenuHeader = disabled, header = k .. ". " .. v.name, txt = installed,
        params = { event = 'jim-mechanic:client:Preview:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } } }
    end
  elseif data.finish == Loc[Config.Lan]["paint"].metallic then
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
      PaintMenu[#PaintMenu + 1] = { icon = icon, isMenuHeader = disabled, header = k .. ". " .. v.name, txt = installed,
        params = { event = 'jim-mechanic:client:Preview:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } } }
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
      PaintMenu[#PaintMenu + 1] = { icon = icon, isMenuHeader = disabled, header = k .. ". " .. v.name, txt = installed,
        params = { event = 'jim-mechanic:client:Preview:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } } }
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
      PaintMenu[#PaintMenu + 1] = { icon = icon, isMenuHeader = disabled, header = k .. ". " .. v.name, txt = installed,
        params = { event = 'jim-mechanic:client:Preview:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } } }
    end
  elseif data.finish == Loc[Config.Lan]["paint"].chameleon then
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsChameleon) do
      local icon = ""
      local disabled = false
      if colourCheck == v.id then
        installed = Loc[Config.Lan]["common"].current
        icon = "fas fa-check"
        disabled = true
      else
        installed = ""
      end
      PaintMenu[#PaintMenu + 1] = { icon = icon, isMenuHeader = disabled, header = k .. ". " .. v.name, txt = installed,
        params = { event = 'jim-mechanic:client:Preview:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } } }
    end
  end
  exports['qb-menu']:openMenu(PaintMenu)
end)

RegisterNetEvent('jim-mechanic:client:Preview:Paints:Apply', function(data)
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end
  local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
  local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
  if data.paint == Loc[Config.Lan]["paint"].primary then
    ClearVehicleCustomPrimaryColour(vehicle)
    SetVehicleColours(vehicle, data.id, vehSecondaryColour)
  elseif data.paint == Loc[Config.Lan]["paint"].secondary then
    ClearVehicleCustomSecondaryColour(vehicle)
    SetVehicleColours(vehicle, vehPrimaryColour, data.id)
  elseif data.paint == Loc[Config.Lan]["paint"].pearl then
    SetVehicleExtraColours(vehicle, data.id, vehWheelColour)
  elseif data.paint == Loc[Config.Lan]["paint"].wheel then
    SetVehicleExtraColours(vehicle, vehPearlescentColour, data.id)
  elseif data.paint == Loc[Config.Lan]["paint"].dashboard then
    SetVehicleDashboardColour(vehicle, data.id)
  elseif data.paint == Loc[Config.Lan]["paint"].interior then
    SetVehicleInteriorColour(vehicle, data.id)
  end
  TriggerEvent('jim-mechanic:client:Preview:Paints:Choose:Colour', data)
end)

--WHEELS
RegisterNetEvent('jim-mechanic:client:Preview:Rims:Apply', function(data)
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end
  SetVehicleWheelType(vehicle, tonumber(data.wheeltype))
  if not data.bike then SetVehicleMod(vehicle, 23, tonumber(data.mod), true) else SetVehicleMod(vehicle, 24, tonumber(data.mod), false) end
  if data.mod == -1 then TriggerEvent('jim-mechanic:client:Preview:Rims:Choose', data) else TriggerEvent('jim-mechanic:client:Preview:Rims:SubMenu', data) end
end)

RegisterNetEvent('jim-mechanic:client:Preview:Rims:Check', function()
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end
  if IsThisModelABike(GetEntityModel(vehicle)) then cycle = true else cycle = false end
  local WheelMenu = {}
  WheelMenu[#WheelMenu + 1] = {
    header = searchCar(vehicle),
    txt = "Class: " ..
    getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
    params = { event = "jim-mechanic:client:Preview:Camera", args = { data = nil, event = "jim-mechanic:client:Preview:Rims:Check" }, }
  }
  WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].menuheader, txt = "", isMenuHeader = true }
  WheelMenu[#WheelMenu + 1] = { icon = "fas fa-circle-arrow-left", header = "", txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
    params = { event = "jim-mechanic:client:Preview:Menu" } }
  if not IsThisModelABike(GetEntityModel(vehicle)) then
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label1, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 0, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label2, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 1, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label3, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 2, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label4, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 3, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label5, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 4, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label6, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 5, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label7, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 7, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label8, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 8, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label9, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 9, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label10, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 10, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label11, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 11, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label12, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 12, bike = false } } }
  elseif IsThisModelABike(GetEntityModel(vehicle)) then
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label13, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 6, bike = false } } }
    WheelMenu[#WheelMenu + 1] = { header = Loc[Config.Lan]["rims"].label14, params = { event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = 6, bike = true } } }
  end
  exports['qb-menu']:openMenu(WheelMenu)
end)

RegisterNetEvent('jim-mechanic:client:Preview:Rims:Choose', function(data)
  local playerPed = PlayerPedId()
  local validMods = {}
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end
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
  local RimsMenu = {
    {
      header = searchCar(vehicle),
      txt = "Class: " ..
      getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
      params = { event = "jim-mechanic:client:Preview:Camera", args = { data = data, event = "jim-mechanic:client:Preview:Rims:Choose" }, }
    },
    { isMenuHeader = true,                      header = Loc[Config.Lan]["rims"].menuheader .. "<br>(" .. string.upper(label) .. ")", txt = "", },
    { icon = "fas fa-circle-arrow-left",        header = "",                                                                          txt = string.gsub(
    Loc[Config.Lan]["common"].ret, "⬅️ ", ""),                                                                                                                                                                                                    params = {
      event = "jim-mechanic:client:Preview:Rims:Check" } },
    { header = Loc[Config.Lan]["common"].stock, txt = stockinstall,                                                                   params = {
      event = "jim-mechanic:client:Preview:Rims:Apply", args = { mod = -1, wheeltype = data.wheeltype, } } } }
  for k, v in pairsByKeys(validMods) do
    RimsMenu[#RimsMenu + 1] = { header = k, txt = Loc[Config.Lan]["common"].amountoption .. #validMods[k],
      params = { event = 'jim-mechanic:client:Preview:Rims:SubMenu', args = { mod = v.id, wheeltype = data.wheeltype, wheeltable = validMods[k], bike = data.bike } } }
  end
  exports['qb-menu']:openMenu(RimsMenu)
  SetVehicleWheelType(vehicle, originalWheel)
end)

RegisterNetEvent('jim-mechanic:client:Preview:Rims:SubMenu', function(data)
  local playerPed = PlayerPedId()
  local validMods = {}
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end
  local RimsMenu = {
    {
      header = searchCar(vehicle),
      txt = "Class: " ..
      getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
      params = { event = "jim-mechanic:client:Preview:Camera", args = { data = data, event = "jim-mechanic:client:Preview:Rims:SubMenu" }, }
    },
    { isMenuHeader = true,               header = Loc[Config.Lan]["rims"].menuheader .. "<br>(" .. string.upper(label) .. ")",
                                                                                                                                 txt = Loc[Config.Lan]["common"].amountoption ..
      #data.wheeltable .. "<br>" .. Loc[Config.Lan]["common"].current .. ": " .. GetLabelText(GetModTextLabel(vehicle, 23, GetVehicleMod(vehicle, 23))), },
    { icon = "fas fa-circle-arrow-left", header = "",                                                                          txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ",
      ""),                                                                                                                                                                                                                                                                                                                        params = {
      event = "jim-mechanic:client:Preview:Rims:Choose", args = { wheeltype = data.wheeltype } } } }
  for i = 1, #data.wheeltable do
    RimsMenu[#RimsMenu + 1] = { header = data.wheeltable[i].name, txt = data.wheeltable[i].install,
      params = { event = 'jim-mechanic:client:Preview:Rims:Apply', args = { mod = data.wheeltable[i].id, wheeltype = data.wheeltype, wheeltable = data.wheeltable, bike = data.bike } } }
  end
  exports['qb-menu']:openMenu(RimsMenu)
end)

--Windows
RegisterNetEvent('jim-mechanic:client:Preview:Windows:Apply', function(data)
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end
  if GetVehicleWindowTint(vehicle) == tonumber(data.mod) then
    triggerNotify(nil, data.name .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Preview:Windows:Check')
  elseif GetVehicleWindowTint(vehicle) ~= tonumber(data.mod) then
    SetVehicleWindowTint(vehicle, tonumber(data.mod))
    TriggerEvent('jim-mechanic:client:Preview:Windows:Check')
    emptyHands(playerPed)
  end
end)

RegisterNetEvent('jim-mechanic:client:Preview:Windows:Check', function()
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(playerPed, false) end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    local icon = ""
    local disabled = false
    if GetVehicleWindowTint(vehicle) == 0 then applied1 = Loc[Config.Lan]["common"].current else applied1 = "" end
    if GetVehicleWindowTint(vehicle) == 4 then applied2 = Loc[Config.Lan]["common"].current else applied2 = "" end
    if GetVehicleWindowTint(vehicle) == 5 then applied3 = Loc[Config.Lan]["common"].current else applied3 = "" end
    if GetVehicleWindowTint(vehicle) == 3 then applied4 = Loc[Config.Lan]["common"].current else applied4 = "" end
    if GetVehicleWindowTint(vehicle) == 2 then applied5 = Loc[Config.Lan]["common"].current else applied5 = "" end
    if GetVehicleWindowTint(vehicle) == 1 then applied6 = Loc[Config.Lan]["common"].current else applied6 = "" end

    exports['qb-menu']:openMenu({
      {
        header = searchCar(vehicle),
        txt = "Class: " ..
        getClass(vehicle) .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(vehicle)) .. Loc[Config.Lan]["check"].value .. searchPrice(vehicle),
        params = { event = "jim-mechanic:client:Preview:Camera", args = { data = nil, event = "jim-mechanic:client:Preview:Windows:Check" }, }
      },
      { header = Loc[Config.Lan]["windows"].menuheader, txt = "",       isMenuHeader = true },
      { icon = "fas fa-circle-arrow-left",              header = "",    txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
                                                                                                                                                                                                         params = {
          event = "jim-mechanic:client:Preview:Menu" } },
      { header = Loc[Config.Lan]["windows"].label1,     txt = applied1,
                                                                          params = { event = "jim-mechanic:client:Preview:Windows:Apply",
          args = { mod = 0, name = Loc[Config.Lan]["windows"].label1 } } },
      { header = Loc[Config.Lan]["windows"].label2,     txt = applied2,
                                                                          params = { event = "jim-mechanic:client:Preview:Windows:Apply",
          args = { mod = 4, name = Loc[Config.Lan]["windows"].label2 } } },
      { header = Loc[Config.Lan]["windows"].label3,     txt = applied3,
                                                                          params = { event = "jim-mechanic:client:Preview:Windows:Apply",
          args = { mod = 5, name = Loc[Config.Lan]["windows"].label3 } } },
      { header = Loc[Config.Lan]["windows"].label4,     txt = applied4,
                                                                          params = { event = "jim-mechanic:client:Preview:Windows:Apply",
          args = { mod = 3, name = Loc[Config.Lan]["windows"].label4 } } },
      { header = Loc[Config.Lan]["windows"].label5,     txt = applied5,
                                                                          params = { event = "jim-mechanic:client:Preview:Windows:Apply",
          args = { mod = 2, name = Loc[Config.Lan]["windows"].label5 } } },
      { header = Loc[Config.Lan]["windows"].label6,     txt = applied6,
                                                                          params = { event = "jim-mechanic:client:Preview:Windows:Apply",
          args = { mod = 1, name = Loc[Config.Lan]["windows"].label6 } } },
    })
  end
end)

RegisterCommand("noclip", function()
  if devMode and hasAdminPerms and not IsNuiFocused() then
    ToggleNoClip()
  end
end)

RegisterCommand("+deletelaser", function()
  if devMode and hasAdminPerms then
    DeleteLaser()
  end
end)

RegisterCommand("-deletelaser", function()
  if devMode and hasAdminPerms then
    stopDeleteLaser()
  end
end)

RegisterCommand("teleporttomarker", function()
  if devMode and hasAdminPerms and not IsNuiFocused() then
    TriggerEvent("snipe-menu:client:teleportMarker")
  end
end)

RegisterCommand("fixvehiclekeybind", function()
  if devMode and hasAdminPerms and not IsNuiFocused() then
    TriggerEvent("snipe-menu:client:FixVehicle")
    ShowNotification("[Admin Menu] Vehicle has been fixed", "success")
  end
end)

RegisterCommand("admincarkeybind", function()
  if devMode and hasAdminPerms and not IsNuiFocused() then
    TriggerEvent("snipe-menu:client:addAdminCar")
  end
end)


RegisterCommand("godmodekeybind", function()
  if devMode and hasAdminPerms and not IsNuiFocused() then
    TriggerEvent("snipe-menu:client:godMode")
  end
end)


RegisterCommand("invisiblekeybind", function()
  if devMode and hasAdminPerms and not IsNuiFocused() then
    TriggerEvent("snipe-menu:client:invisibleEffect")
  end
end)

RegisterCommand("toggleblipskeybind", function()
  if devMode and hasAdminPerms and not IsNuiFocused() then
    TriggerEvent("snipe-menu:client:toggleBlips")
  end
end)

RegisterCommand("togglenameskeybind", function()
  if devMode and hasAdminPerms and not IsNuiFocused() then
    TriggerEvent("snipe-menu:client:toggleNames")
  end
end)

if Config.EnableReports then
  RegisterCommand("report", function()
    OpenReports()
  end)

  TriggerEvent('chat:addSuggestion', '/togglereports', "Toggle Report Notifications (Admin Only)")
  RegisterCommand("togglereports", function()
    if hasAdminPerms then
      TriggerServerEvent("snipe-menu:server:toggleReports")
    end
  end)
end

RegisterCommand(Config.CommandName, function()
  OpenAdminMenu()
end)




TriggerEvent("chat:removeSuggestion", "/noclip")
TriggerEvent("chat:removeSuggestion", "/teleporttomarker")
TriggerEvent("chat:removeSuggestion", "/fixvehiclekeybind")
TriggerEvent("chat:removeSuggestion", "/+deletelaser")
TriggerEvent("chat:removeSuggestion", "/-deletelaser")
TriggerEvent("chat:removeSuggestion", "/admincarkeybind")
TriggerEvent("chat:removeSuggestion", "/godmodekeybind")
TriggerEvent("chat:removeSuggestion", "/invisiblekeybind")
TriggerEvent("chat:removeSuggestion", "/toggleblipskeybind")
TriggerEvent("chat:removeSuggestion", "/togglenameskeybind")

RegisterNetEvent("snipe-menu:client:addkeymapping", function()
  if hasAdminPerms then
    RegisterKeyMapping("noclip", "No Clip", "keyboard", "f11")
    RegisterKeyMapping("+deletelaser", "Delete Laser", "keyboard", "l")
    RegisterKeyMapping(Config.CommandName, "Open Admin Menu", "keyboard", "f3")
    RegisterKeyMapping("teleporttomarker", "Teleport to Marker", "keyboard", "f10")
    -- RegisterKeyMapping("fixvehiclekeybind", "Fix Vehicle", "keyboard", "i")
    RegisterKeyMapping("admincarkeybind", "Admin Car", "keyboard", "NUMPAD0")
    RegisterKeyMapping("godmodekeybind", "God Mode", "keyboard", "NUMPAD1")
    RegisterKeyMapping("invisiblekeybind", "Invisible", "keyboard", "NUMPAD2")
    RegisterKeyMapping("toggleblipskeybind", "Toggle Blips", "keyboard", "NUMPAD3")
    RegisterKeyMapping("togglenameskeybind", "Toggle Names", "keyboard", "NUMPAD4")
  else
    devMode = false
  end
end)

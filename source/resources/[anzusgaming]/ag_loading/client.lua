local ran = false

AddEventHandler("playerSpawned", function()
  if not ran then
    ShutdownLoadingScreenNui()
    ran = true
  end
end)

CreateThread(function()
  SetNuiFocus(true, false)
end)

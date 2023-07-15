-- if you have custom clothing script, make sure to add the events to load the players old clothes back when you click revert
RegisterNetEvent("snipe-menu:client:revertClothing", function()
  if Config.Core == "QBCore" then
    if Config.Skin == "qb-clothing" then
      TriggerServerEvent("qb-clothing:server:loadPlayerSkin")       -- LOADING PLAYER'S CLOTHES
      TriggerServerEvent("qb-clothes:loadPlayerSkin")               -- LOADING PLAYER'S CLOTHES
    elseif Config.Skin == "fivem-appearance" then
      TriggerEvent("fivem-appearance:client:reloadSkin")
    elseif Config.Skin == "illenium-appearance" then
      TriggerEvent("illenium-appearance:client:reloadSkin")
    elseif Config.Other == "other" then
      -- add your custom clothing script event here
    end
  elseif Config.Core == "ESX" then
    if Config.Skin == "fivem-appearance" then
      ESX.TriggerServerCallback('fivem-appearance:getPlayerSkin', function(appearance)
        exports['fivem-appearance']:setPlayerAppearance(appearance)
      end)
    elseif Config.Skin == "esx_skin" then
      local p = promise.new()
      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        p:resolve(skin)
      end)
      local skin = Citizen.Await(p)
      TriggerEvent('skinchanger:loadSkin', skin)
    elseif Config.Skin == "illenium-appearance" then
      TriggerEvent("illenium-appearance:client:reloadSkin")
    elseif Config.Other == "other" then
      -- add your custom clothing script event here
    end
  end
end)

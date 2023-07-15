RegisterNetEvent("snipe-menu:client:setWeather", function(weatherName)
  if hasAdminPerms then
    if Config.Core == "QBCore" and Config.WeatherScript ~= "cd_easytime" then
      TriggerServerEvent("qb-weathersync:server:setWeather", weatherName)         -- used to change the weather if you use qb-weathersync (edit if you use another weather script)
    elseif Config.WeatherScript == "cd_easytime" or Config.Core == "ESX" then     -- this is configured for easytime
      local values = {
        instantweather = true,
        weather = weatherName,
        dynamic = exports["cd_easytime"]:GetWeather().dynamic,
        instanttime = true,
        hours = exports["cd_easytime"]:GetWeather().hours,
        mins = exports["cd_easytime"]:GetWeather().mins,
        freeze = exports["cd_easytime"]:GetWeather().freeze,
        tsunami = exports["cd_easytime"]:GetWeather().tsunami,
        blackout = exports["cd_easytime"]:GetWeather().blackout
      }
      TriggerServerEvent('cd_easytime:ForceUpdate', values)
    end
  end
end)

RegisterNetEvent("snipe-menu:client:setTime", function(hours, mins)
  if hasAdminPerms then
    if Config.Core == "QBCore" and Config.WeatherScript ~= "cd_easytime" then
      TriggerServerEvent("qb-weathersync:server:setTime", hours, mins)            -- used to change the time if you use qb-weathersync (edit if you use another weather script)
    elseif Config.WeatherScript == "cd_easytime" or Config.Core == "ESX" then     -- this is configured for easytime
      local values = {
        instantweather = false,
        weather = exports["cd_easytime"]:GetWeather().weather,
        dynamic = exports["cd_easytime"]:GetWeather().dynamic,
        instanttime = true,
        hours = hours,
        mins = mins,
        freeze = exports["cd_easytime"]:GetWeather().freeze,
        tsunami = exports["cd_easytime"]:GetWeather().tsunami,
        blackout = exports["cd_easytime"]:GetWeather().blackout
      }
      TriggerServerEvent('cd_easytime:ForceUpdate', values)
    end
  end
end)

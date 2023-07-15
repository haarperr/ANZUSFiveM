lib.locale()

local blackoutActive = false
local PowerstationBlownUp = {
  paleto = false,
  city = false,
  east = false
}

RegisterNetEvent('ag_powerstation:server:removeItem', function(item)
  exports.ox_inventory:RemoveItem(source, item, 1)
end)

lib.callback.register('ag_powerstation:server:getConfig', function()
  return Config.PowerStations
end)

---@param data {key: number, type: 'hit', bool: boolean}
RegisterNetEvent('ag_powerstation:server:setState', function(data)
  Config.PowerStations[data.key][data.type] = data.bool
  TriggerClientEvent('ag_powerstation:client:setState', -1, data)
end)

local function getPowerstationStatus(station)
  return PowerstationBlownUp[station]
end

exports('getPowerstationStatus', getPowerstationStatus)

local function cityBoom()
  PowerstationBlownUp.city = true
  TriggerClientEvent('ag_powerstation:client:syncBlown', -1, { index = 'city', bool = true })
  TriggerClientEvent('ag_powerstation:client:cityBoom', -1)

  -- TriggerClientEvent('ag_major:client:artgallery:StopLasers', -1)
  -- TriggerClientEvent('ag_major:client:artgallery:PowerPlantHit', -1)
end

local function informAll(description)
  TriggerClientEvent('ox_lib:notify', -1, { type = 'info', title = locale('notify_title'), icon = 'bolt', description = description, duration = 20000 })
end

local function CheckStationHits(src)
  Wait(6000)
  if Config.PowerStations[1].hit and Config.PowerStations[2].hit and Config.PowerStations[3].hit and Config.PowerStations[4].hit then
    -- east powerplant hit
    DisabledAlerts.pacific = true
    PowerstationBlownUp.east = true
    -- explosion
    TriggerClientEvent('ag_powerstation:client:syncBlown', -1, { index = 'east', bool = true })
    TriggerClientEvent('ps-dispatch:Explosion', src)
    TriggerClientEvent('ag_powerstation:client:eastBoom', -1)
    Wait(1000)
    informAll(locale('east_city_wide'))
    print("^3[ag_major] ^5East Power Plant Hit^7")
  elseif Config.PowerStations[5].hit and Config.PowerStations[6].hit and Config.PowerStations[7].hit then
    -- city powerplant hit
    -- explosion
    DisabledAlerts.artgallery = true
    DisabledAlerts.flecca = true
    cityBoom()
    TriggerClientEvent('ps-dispatch:Explosion', src)
    Wait(1000)
    -- blackout
    if not blackoutActive then
      TriggerEvent("qb-weathersync:server:toggleBlackout", true)
    end
    informAll(locale('city_wide'))
    TriggerClientEvent("police:client:DisableAllCameras", -1)
    print("^3[ag_major] ^5City Power Plant Hit^7")
    blackoutActive = true
  elseif Config.PowerStations[8].hit then
    -- paleto powerplant hit
    DisabledAlerts.paleto = true
    PowerstationBlownUp.paleto = true
    TriggerClientEvent('ag_powerstation:client:syncBlown', -1, { index = 'paleto', bool = true })
    TriggerClientEvent('ps-dispatch:Explosion', src)
    TriggerClientEvent('ag_powerstation:client:paletoBoom', -1)
    Wait(1000)
    informAll(locale('paleto_wide'))
    print("^3[ag_powerstation] ^5Paleto Power Plant Hit^7")
  end
end

---@param data {key: number, hit: boolean}
RegisterNetEvent('ag_powerstation:server:StationStatus', function(data)
  local src = source
  Config.PowerStations[data.key].hit = data.hit

  TriggerEvent('ag_powerstation:server:setState', { key = data.key, bool = data.hit, type = 'hit' })

  CheckStationHits(src)
end)

CreateThread(function()
  while true do
    Wait(1000 * 60 * 10)
    if blackoutActive then
      Wait(1000 * 60 * 50)
      TriggerEvent("qb-weathersync:server:toggleBlackout", false)
      TriggerClientEvent('chatMessage', -1, "[LS Water & Power]", "normal", "Power in the city is restored!")
      blackoutActive = false
      DisabledAlerts.pacific = false
      DisabledAlerts.flecca = false
      DisabledAlerts.artgallery = false
    end
  end
end)

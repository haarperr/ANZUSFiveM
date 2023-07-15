local function createStationBlips()
  for i = 1, #PD_Zones, 1 do
    local zone = PD_Zones[i]
    local blip = AddBlipForCoord(zone.blip.x, zone.blip.y, zone.blip.z)
    SetBlipSprite(blip, 60)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 29)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(zone.name)
    EndTextCommandSetBlipName(blip)
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  createStationBlips()
end)

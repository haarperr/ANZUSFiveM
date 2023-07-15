local utils = {}

---@async
function utils.WaitFor(cb)
  local hasValue = cb()

  for i = 1, 500 do
    if hasValue then break elseif i == 500 then return end

    Wait(0)
    hasValue = cb()
  end

  return hasValue
end

function utils.GetClosestLocation(locations)
    local closestDistance = -1
    local closestIndex = -1
    local closestLocation = nil
    local plyCoords = cache.coords
    for i, v in ipairs(locations) do
      local location = vector3(v.x, v.y, v.z)
      local distance = #(plyCoords - location)
      if (closestDistance == -1 or closestDistance > distance) then
        closestDistance = distance
        closestIndex = i
        closestLocation = v
      end
    end
    return closestIndex, closestDistance, closestLocation
end

---Spawn vehicle with the nearest open parking spot
---@param id number vehicle id
---@param parking vector4[]
function utils.SpawnVehicle(id, parking)
  local freeParkingSpots = {}

  for i = 1, #parking, 1 do
    local spot = parking[i]
    local veh = lib.getClosestVehicle(vec3(spot.x, spot.y, spot.z), 2, false)
    if veh ~= nil then goto skip end
    freeParkingSpots[#freeParkingSpots + 1] = spot

    ::skip::
  end
  local _, _, location = utils.GetClosestLocation(freeParkingSpots)

  if location == nil then return lib.notify({ type = 'error', description = 'There are no free parking spots' }) end

  local vehicle = lib.callback.await('ag_garage:SpawnVehicle', 500, id, location)
  if not vehicle then return lib.notify({ type = 'error', description = 'Unable to spawn vehicle' }) end

  return vehicle
end

---Format options for garage menu
---@param vehicles any
---@param parking vector4[]
function utils.FormatOptions(vehicles, parking)
  local options = {}
  for i = 1, #vehicles, 1 do
    local vehicle = vehicles[i]
    local data = vehicle.data
    local engine = (data.properties?.engineHealth or 0)/10
    local body = (data.properties?.bodyHealth or 0)/10
    local fuel = (data.properties?.fuelLevel or 0 )

    options[#options + 1] = {
      title = string.format('🚘 %s | %s', data.name, vehicle.plate),
      colorScheme = 'red',
      metadata = {
        {label = 'Fuel', value = fuel .. '%', progress = fuel},
        {label = 'Engine', value = engine .. '%', progress = engine},
        {label = 'Body', value = body .. '%', progress = body}
        },
      onSelect = function()
        utils.SpawnVehicle(vehicle.id, parking)
      end
    }
  end

  return options
end

function utils.ParkVehicle(type, garage)
  local properties = lib.getVehicleProperties(cache.vehicle)
  local class = GetVehicleClass(cache.vehicle)

  local can = false
  if GarageTypes then
    for _, v in pairs(GarageTypes) do
      if can then break end
      for _, value in pairs(Config.Map[v]) do
        if value == class then
          can = true
          break
        end
      end
    end
  end

  if not can then
    return lib.notify({ type = 'error', description = 'This garage does not support this vehicle' })
  end

  if type == 'public' and class == 18 then
      return lib.notify({ type = 'error', description = 'This type of vehicle cannot be stored here' })
  end

  local res = lib.callback.await('ag_garage:ParkVehicle', 200, { garage = garage, properties = properties, type = type })
  if not res then return lib.notify({type = 'error', description = 'You cannot store this vehicle'}) end
end

function utils.CreateBlip(coords, name)
  local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
  SetBlipSprite(blip, 357)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.60)
  SetBlipAsShortRange(blip, true)
  SetBlipColour(blip, 3)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(name)
  EndTextCommandSetBlipName(blip)
end

return utils

local AGVehicle = {}

local vehicleExports = {}
setmetatable(vehicleExports, {
  __index = function(_, index)
    vehicleExports = AG.GetVehicleExports()
    return vehicleExports[index]
  end
})

local exp = exports.ag_vehicle

function AGVehicle:__index(index)
  local method = AGVehicle[index]

  if method then
    return function(...)
      return method(self, ...)
    end
  end

  local export = vehicleExports[index]

  if export then
    return function(...)
      return exp:CallVehicleMethod(self.entity, index, ...)
    end
  end
end

function AGVehicle:getCoords(update)
  if update or not self.coords then
    self.coords = GetEntityCoords(self.entity)
  end

  return self.coords
end

function AG.GetVehicle(vehicle)
  vehicle = type(vehicle) == 'table' and vehicle.entity or exp:GetVehicle(vehicle)
  return vehicle and setmetatable(vehicle, AGVehicle)
end

function AG.GetVehicleFromNetId(vehicle)
  vehicle = exp:GetVehicleFromNetId(vehicle)
  return vehicle and setmetatable(vehicle, AGVehicle)
end

function AG.CreateVehicle(data, coords, heading)
  local vehicle = exp:CreateVehicle(data, coords, heading)
  return type(vehicle) == 'table' and setmetatable(vehicle, AGVehicle) or vehicle
end

function AG.GetVehicles(usemetatable)
  local vehicles = exp:GetVehicles()

  if usemetatable then
    for i = 1, #vehicles do
      setmetatable(vehicles[i], AGVehicle)
    end
  end

  return vehicles
end

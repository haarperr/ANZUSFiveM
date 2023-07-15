---@class VehicleProperties
---@field id number
---@field owner? number
---@field netid number
---@field entity number
---@field model string
---@field plate string
---@field lock string
---@field vin string
---@field script string
---@field garage string

---@class AGVehicle : VehicleProperties
local AGVehicle = {}

---@type table<string, true>
local vehicleExports = {}

setmetatable(AGVehicle, {
  __newindex = function(self, key, value)
    rawset(self, key, value)
    vehicleExports[key] = true
  end
})

function AG.GetVehicleExports()
  return vehicleExports
end

---Backing method for imported method calls.
---@param source number
---@param method string
---@param ... unknown?
---@return unknown?
function AG.CallVehicleMethod(source, method, ...)
  local vehicle = AG.GetVehicle(source)

  if vehicle then
    return AGVehicle[method](vehicle, ...)
  end
end

local vehicleData = {}
local VehicleRegistry = require 'server.registry'

---Triggered after vehicle instantiation to setup metadata.
---@param data table
function AGVehicle:init(data)
  if not vehicleData[self.entity] then
    VehicleRegistry[self.entity] = self
    vehicleData[self.entity] = data

    local state = self:getState()

    state:set('initVehicle', true, true)
    state:set('owner', self.owner, true)
    state:set('vin', self.vin, true)

    if data.properties then
      state:set('vehicleProperties', data.properties)
    end

    state:set('name', data.name or '')
    state:set('vin_scratched', data.vin_scratched or false)
    state:set('name', data.name or '')

    ---@todo Setup locks / keysystem?
    state:set('lockStatus', data.lockStatus or 1)
    state:set('lock', data.lock)
  end
end

---Gets the vehicle's metadata, returning the entire table if key is omitted.
---@param index any
---@return any
function AGVehicle:get(index)
  local data = vehicleData[self.entity]
  return index and data[index] or data
end

---Update the vehicle's metadata.
---@param key string
---@param value any
function AGVehicle:set(key, value)
  vehicleData[self.entity][key] = value
end

---@return StateBag
function AGVehicle:getState()
  return Entity(self.entity).state
end

local db = require 'server.db'

---Removes a vehicle from the vehicle registry and despawns the entity.
---removeEntry will remove the vehicle from the database, otherwise it will be saved instead.
---@param vehicle AGVehicle
---@param removeEntry boolean?
---@param metadata table?
local function despawnVehicle(vehicle, removeEntry, metadata)
  local entity = vehicle.entity

  if vehicle.owner ~= false then
    if removeEntry then
      db.deleteVehicle(vehicle.id)
    elseif metadata then
      db.updateVehicle({
        vehicle.garage,
        json.encode(metadata),
        0,
        vehicle.id
      })
      db.setOut(0, vehicle.id)
    end
  end

  VehicleRegistry[entity] = nil
  vehicleData[entity] = nil
  DeleteEntity(entity)
end

function AGVehicle:despawn()
  despawnVehicle(self, nil, vehicleData[self.entity])
end

function AGVehicle:delete()
  despawnVehicle(self, true)
end

---@param value string
---@param despawn? boolean
function AGVehicle:setGarage(value, despawn)
  self.garage = value
  db.setGarage(value, self.id)

  if despawn then
    self:despawn()
  end
end

---@param out number
function AGVehicle:setOut(out)
  self.out = out
  db.setOut(out, self.id)
end

---@param newOwner? number
function AGVehicle:setOwner(newOwner)
  db.setOwner(newOwner, self.id)
  self.owner = newOwner
  self:getState():set('owner', newOwner, true)
end

---@param shared number
function AGVehicle:setShared(shared)
  db.setShared(shared, self.id)
  self.shared = shared
end

---May mismatch with properties due to "fake plates". Used to prevent duplicate "persistent plates".
---@param plate string
function AGVehicle:setPlate(plate)
  self.plate = ('%-8s'):format(plate)
  db.setPlate({ self.plate, self.id })
end

---@param lock string
function AGVehicle:setLock(lock)
  self.lock = lock
  db.setLock({ self.id, self.lock })
end

local Class = require 'shared.class'
return Class.new(AGVehicle)

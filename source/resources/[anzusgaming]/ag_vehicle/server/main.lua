local Vehicle = {}
local db = require 'server.db'
local VehicleRegistry = require 'server.registry'

require 'server.commands'

---Save all vehicles for the resource and despawn them.
---@param resource string?
function Vehicle.saveAll(resource)
  local parameters = {}
  local size = 0

  for _, vehicle in pairs(VehicleRegistry) do
    if not resource or resource == vehicle.script then
      if (vehicle.owner) ~= false then
        size += 1
        parameters[size] = { vehicle.garage, json.encode(vehicle:get()), 0, vehicle.id }
      end

      if resource then
        vehicle:despawn()
      else
        DeleteEntity(vehicle.entity)
      end
    end
  end

  if size > 0 then
    db.updateVehicle(parameters)
  end
end

local AGVehicle = require 'server.class'

---@param id? number
---@param owner? number | boolean
---@param plate string
---@param vin string
---@param model string
---@param script string
---@param data table
---@param garage? string
---@param coords vector3
---@param heading number
---@param vType string
---@param lock string
---@param class string
---@return AGVehicle?
local function spawnVehicle(id, owner, plate, vin, model, script, data, garage, coords, heading, vType, lock, class)
  -- New native seems to be missing some types, for now we'll convert to known types
  -- https://github.com/citizenfx/fivem/commit/1e266a2ca5c04eb96c090de67508a3475d35d6da
  if vType == 'bicycle' or vType == 'quadbike' or vType == 'amphibious_quadbike' then
    vType = 'bike'
  elseif vType == 'amphibious_automobile' or vType == 'submarinecar' then
    vType = 'automobile'
  elseif vType == 'blimp' then
    vType = 'heli'
  end

  local entity = CreateVehicleServerSetter(joaat(model), vType, coords.x, coords.y, coords.z, heading)

  if DoesEntityExist(entity) then
    local vehicle = AGVehicle.new({
      id = id,
      netid = NetworkGetNetworkIdFromEntity(entity),
      owner = owner,
      entity = entity,
      script = script,
      plate = plate,
      vin = vin,
      model = model,
      garage = garage,
      lock = lock
    })

    vehicle:init(data)

    if class == 18 then
      exports.ox_inventory:RegisterStash('gunrack-' .. plate, 'Gunrack ' .. plate, 5, 440000, false)
    end

    if owner ~= false then
      db.setOut(1, vehicle.id)
      lib.logger(-1, 'spawnVehicle',
        ('Vehicle (%s) %s has been spawned with vin %s plate %s garage %s owner %s'):format(tostring(vehicle.id), tostring(model), tostring(vin), tostring(plate), tostring(garage),
          tostring(owner)))
    else
      lib.logger(-1, 'spawnVehicle',
        ('Vehicle %s has been spawned with vin %s and plate %s'):format(model, vin, plate))
    end

    return vehicle
  else
    print(("^1Failed to spawn vehicle '%s'^0"):format(model))
  end
end

-----------------------------------------------------------------------------------------------
-- Interface
-----------------------------------------------------------------------------------------------

---Loads a vehicle from the database by id, or creates a new vehicle using provided data.
---@param data table | number
---@param coords vector3
---@param heading? number
---@return table | number | nil
function AG.CreateVehicle(data, coords, heading)
  local script = GetInvokingResource()

  if type(data) == 'number' then
    do
      local type = type(coords)

      if type == 'table' then
        if coords[1] then
          coords = vector3(coords[1], coords[2], coords[3])
        end
      elseif type ~= 'vector3' then
        TypeError('coords', 'vector3', type)
      end
    end

    do
      local type = type(heading)

      if type ~= 'number' then
        TypeError('heading', 'number', type)
      end
    end

    local vehicle = db.getVehicleFromId(data)

    if not vehicle then
      error(("Failed to spawn vehicle with id '%s' (invalid id or already spawned)"):format(data))
    end

    vehicle.data = json.decode(vehicle.data --[[@as string]])
    local modelData = AG.GetVehicleData(vehicle.model) --[[@as VehicleData]]
    vehicle.data.name = modelData.name

    if not modelData then
      error(("Vehicle model is invalid '%s'\nEnsure vehicle exists in '@ag-vehicle/shared/files/vehicles.json'"):format(vehicle.model))
    end

    return spawnVehicle(data, vehicle.owner, vehicle.plate, vehicle.vin, vehicle.model, script, vehicle.data, vehicle.garage, coords,
      heading or 90.0, modelData.type, vehicle.lock, modelData.class)
  end

  do
    local type = type(data.model)

    if type ~= 'string' then
      TypeError('data.model', 'string', type)
    end
  end

  local model = data.model:lower()
  local modelData = AG.GetVehicleData(model) --[[@as VehicleData]]

  if not modelData then
    error(("Vehicle model is invalid '%s'\nEnsure vehicle exists in '@ag-vehicle/shared/files/vehicles.json'"):format(model))
  end

  local owner = data.owner or false --[[@as boolean?]]
  local garage = data.garage or not coords and 'impound' or nil
  local plate = data.plate or AG.GeneratePlate()
  local vin = data.vin or AG.GenerateVin(model)
  local shared = data.shared and 1 or 0
  local lock = data.lock or AG.GenerateLock()

  data = {
    properties = lib.table.merge({
      engineHealth = 1000,
      bodyHealth = 1000,
      tankHealth = 1000,
      fuelLevel = 100,
    }, data.properties or {}),
    lockStatus = data.lockStatus or 1,
    vin_scratched = data.vin_scratched or false,
    name = data.name or modelData.name,
  }

  data.properties.plate = plate

  if not owner then
    owner = nil
  end

  local vehicleId

  if owner ~= false and owner ~= nil then
    vehicleId = db.createVehicle(modelData.type, plate, vin, owner, model, modelData.class, data, garage, shared)

    lib.logger(-1, 'CreateVehicle',
      ('Vehicle (%d) %s created with vin %s plate %s owner %s'):format(vehicleId, tostring(model), vin, plate, tostring(owner)))
  else
    lib.logger(-1, 'CreateVehicle',
      ('Vehicle %s created with vin %s plate %s'):format(vehicleId, model, vin, plate))
  end

  if garage then
    return vehicleId
  end

  return spawnVehicle(vehicleId, owner, plate, vin, model, script, data, garage, coords, heading or 90.0, modelData.type, lock, modelData.class)
end

local math_random = math.random

local function getNumber()
  return math_random(0, 9)
end

local function getLetter()
  return string.char(math_random(65, 90))
end

local function getAlphanumeric()
  return math_random(0, 1) == 1 and getLetter() or getNumber()
end

local plateFormat = string.upper('........')
local formatLen = #plateFormat

---Creates a unique vehicle license plate.
---@return string
function AG.GeneratePlate()
  local plate = table.create(8, 0)

  while true do
    local tableLen = 1

    for i = 1, formatLen do
      local char = plateFormat:sub(i, i)

      if char == '1' then
        plate[tableLen] = getNumber()
      elseif char == 'A' then
        plate[tableLen] = getLetter()
      elseif char == '.' then
        plate[tableLen] = getAlphanumeric()
      elseif char == '^' then
        i += 1

        plate[tableLen] = plateFormat:sub(i, i)
      else
        plate[tableLen] = char
      end

      tableLen += 1

      if tableLen == 9 then
        break
      end
    end

    if tableLen < 9 then
      for i = tableLen, 8 do
        plate[i] = ' '
      end
    end

    local str = table.concat(plate)

    if db.isPlateAvailable(str) then return str end
  end
end

local lockFormat = string.upper('1111')
local lockLen = #lockFormat
function AG.GenerateLock()
  local lock = table.create(4, 0)

  while true do
    local tableLen = 1

    for i = 1, lockLen do
      local char = lockFormat:sub(i, i)

      if char == '1' then
        lock[tableLen] = getNumber()
      elseif char == 'A' then
        lock[tableLen] = getLetter()
      elseif char == '.' then
        lock[tableLen] = getAlphanumeric()
      elseif char == '^' then
        i += 1

        lock[tableLen] = lockFormat:sub(i, i)
      else
        lock[tableLen] = char
      end

      tableLen += 1

      if tableLen == 5 then
        break
      end
    end

    if tableLen < 5 then
      for i = tableLen, 4 do
        lock[i] = ' '
      end
    end

    local str = table.concat(lock)

    return str
  end
end

---Creates a unique vehicle vin number.
---@param model string
---@return string
function AG.GenerateVin(model)
  local vehicle = AG.GetVehicleData(model:lower())
  local arr = {
    math_random(1, 9),
    vehicle.make == '' and 'AG' or vehicle.make:sub(1, 2):upper(),
    model:sub(1, 2):upper(),
    getAlphanumeric(),
    string.char(math_random(65, 90)),
  }

  while true do
    ---@diagnostic disable-next-line: param-type-mismatch
    arr[6] = os.time(os.date("!*t"))
    local vin = table.concat(arr)

    if db.isVinAvailable(vin) then return vin end
  end
end

local StarterVehicles = { 'weevil' }
local britishVehicles = { { model = 'faggio3', liveries = { 0, 1, 2, 9 } }, { model = 'stafford', liveries = { 8 } } }

---@param owner string
---@param isBritish boolean
function AG.StarterVehicle(owner, isBritish)
  local randomVehicle = nil
  local livery = -1
  if isBritish then
    local vehicle = britishVehicles[math.random(#britishVehicles)]
    livery = vehicle.liveries[math.random(#vehicle.liveries)]
    randomVehicle = vehicle.model
  else
    randomVehicle = StarterVehicles[math.random(#StarterVehicles)]
  end

  AG.CreateVehicle({ model = randomVehicle, owner = owner, garage = 'apartments', properties = { modLivery = livery } })
end

AddEventHandler('onResourceStop', Vehicle.saveAll)
AddEventHandler('txAdmin:events:serverShuttingDown', function() Vehicle.saveAll() end)

AddEventHandler('entityCreated', function(entity)
  local entityType = GetEntityType(entity)

  if entityType ~= 2 then return end

  if GetEntityPopulationType(entity) > 5 then return end

  SetVehicleDoorsLocked(entity, 2)
end)

local MySQL = MySQL
local db = {}

local SQL_QUERIES = {
  SELECT_VEHICLE = 'SELECT `owner`, `plate`, `vin`, `model`, `data`, `out`, `garage`, `lock` FROM `character_vehicles` WHERE `id` = ? AND `out` = 0',
  INSERT_VEHICLE = 'INSERT INTO `character_vehicles` (type, plate, vin, owner, model, class, data, garage, shared) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
  DELETE_VEHICLE = 'DELETE FROM `character_vehicles` WHERE `id` = ?',
  DOES_PLATE_EXIST = 'SELECT 1 FROM `character_vehicles` WHERE `plate` = ?',
  DOES_VIN_EXIST = 'SELECT 1 FROM `character_vehicles` WHERE `vin` = ?',
  UPDATE_GARAGE = 'UPDATE `character_vehicles` SET `garage` = ? WHERE `id` = ?',
  UPDATE_OWNER = 'UPDATE `character_vehicles` SET `owner` = ? WHERE `id` = ?',
  UPDATE_VEHICLE = 'UPDATE `character_vehicles` SET `garage` = ?, `data` = ?, `out` = ? WHERE `id` = ?',
  UPDATE_PLATE = 'UPDATE `character_vehicles` SET `plate` = ? WHERE `id` = ?',
  UPDATE_SHARED = 'UPDATE `character_vehicles` SET `shared` = ? WHERE `id` = ?',
  UPDATE_OUT = 'UPDATE `character_vehicles` SET `out` = ? WHERE `id` = ?',
  UPDATE_LOCK = 'UPDATE `character_vehicles` SET `lock` = ? WHERE `id` = ?'
}

MySQL.ready(function()
  MySQL.query('UPDATE `character_vehicles` SET `out` = ? WHERE `out` = 1', { 0 })
end)

---Removes a vehicle from the database with the given id.
---@param id number
function db.deleteVehicle(id)
  MySQL.prepare(SQL_QUERIES.DELETE_VEHICLE, { id })
end

---Creates a new database entry and returns the vehicleId.
---@param type string
---@param plate string
---@param vin string
---@param owner? number | boolean
---@param model string
---@param class number
---@param data table
---@param garage string?
---@param shared number?
---@return number?
function db.createVehicle(type, plate, vin, owner, model, class, data, garage, shared)
  return MySQL.prepare.await(SQL_QUERIES.INSERT_VEHICLE, { type, plate, vin, owner or nil, model, class, json.encode(data), garage, shared }) --[[@as number?]]
end

---Check if a plate is already in use.
---@param plate string
---@return boolean
function db.isPlateAvailable(plate)
  return not MySQL.scalar.await(SQL_QUERIES.DOES_PLATE_EXIST, { plate })
end

---Check if a plate is already in use.
---@param vin string
---@return boolean
function db.isVinAvailable(vin)
  return not MySQL.scalar.await(SQL_QUERIES.DOES_VIN_EXIST, { vin })
end

---Fetch vehicle data for the given id.
---@param id number
function db.getVehicleFromId(id)
  return MySQL.prepare.await(SQL_QUERIES.SELECT_VEHICLE, { id })
end

---Updates a vehicle's garage state. nil is used when it is spawned, otherwise it can be a garage name, impound, etc.
---@param garage string?
---@param id number
function db.setGarage(garage, id)
  MySQL.update.await(SQL_QUERIES.UPDATE_GARAGE, { garage, id })
end

---Updates a vehicle's owner
---@param owner number?
---@param id number
function db.setOwner(owner, id)
  MySQL.prepare.await(SQL_QUERIES.UPDATE_OWNER, { owner or nil, id })
end

---Updates a vehicle's shared state
---@param shared number
---@param id number
function db.setShared(shared, id)
  MySQL.prepare.await(SQL_QUERIES.UPDATE_SHARED, { shared, id })
end

---Updates a vehicle's out state
---@param out number
---@param id number
function db.setOut(out, id)
  MySQL.prepare.await(SQL_QUERIES.UPDATE_OUT, { out, id })
end

---Update vehicle data for one or multiple vehicles.
---@param parameters table<number, any> | table<number, any>[]
function db.updateVehicle(parameters)
  MySQL.prepare(SQL_QUERIES.UPDATE_VEHICLE, parameters)
end

---Update lock for one vehicle
---@param id number
---@param lock string
function db.updateLock(id, lock)
  MySQL.prepare(SQL_QUERIES.UPDATE_LOCK, { lock, id })
end

---Update vehicle data for one or multiple vehicles.
---@param parameters { plate: string, id: number }
function db.setPlate(parameters)
  MySQL.prepare(SQL_QUERIES.UPDATE_PLATE, parameters)
end

return db

local MySQL = MySQL

local SQL_QUERIES = {
  GET_ALL_CUSTOM_PLATES = 'SELECT id, plate FROM character_vehicles WHERE owner = ? AND `out` = 0 AND customPlate = 1',
  SELECT_PLATE_BY_PLATE = 'SELECT plate FROM character_vehicles WHERE plate = ?',
  UPDATE_PLATE = 'UPDATE character_vehicles SET plate = ?, data=REPLACE(data, ?, ?), customPlate = 0 WHERE owner = ? AND plate = ?',
  SELECT_PHONE_NUMBER_BY_ID = 'SELECT phone_number FROM characters WHERE citizenid = ? AND customNumber = 1',
  SELECT_PHONE_NUMBER_BY_NUMBER = 'SELECT phone_number FROM characters WHERE phone_number = ?',
  RESET_PHONE_NUMBER = 'UPDATE characters SET phone_number = ?, customNumber = 0 WHERE citizenid = ?',
  GET_PLAYER_VEHICLES = 'SELECT plate, model FROM character_vehicles WHERE owner = ? AND `out` = 0',
  UPDATE_PLATE_CUSTOM = 'UPDATE character_vehicles SET plate = ?, data=REPLACE(data, ?, ?), customPlate = 1 WHERE plate = ? AND owner = ?',
  UPDATE_PHONE_NUMBER_CUSTOM = 'UPDATE characters SET phone_number = ?, customNumber = 1 WHERE phone_number = ? AND citizenid = ?',
}

local db = {}

--- Get all the players custom plates
---@param id string
---@return table
function db.getPlayerCustomPlates(id)
  return MySQL.query.await(SQL_QUERIES.GET_ALL_CUSTOM_PLATES, { id })
end

--- Check that the plate exists in the database
---@param plate string
---@return boolean
function db.doesPlateExist(plate)
  local vehicles = MySQL.single.await(SQL_QUERIES.SELECT_PLATE_BY_PLATE, { plate })
  return vehicles ~= nil
end

--- Update the plate of a vehicle
---@param oldPlate string
---@param newPlate string
---@param id string
---@return boolean
function db.updatePlate(oldPlate, newPlate, id)
  local affectedRows = MySQL.update.await(SQL_QUERIES.UPDATE_PLATE, { newPlate, oldPlate, newPlate, id, oldPlate })
  return affectedRows > 0
end

--- Get the players custom phone number
---@param id string
---@return table
function db.getPlayerCustomNumbers(id)
  return MySQL.single.await(SQL_QUERIES.SELECT_PHONE_NUMBER_BY_ID, { id })
end

-- Check if the number is already in use
---@param number string
---@return boolean
function db.isNumberInUse(number)
  local phones = MySQL.single.await(SQL_QUERIES.SELECT_PHONE_NUMBER_BY_NUMBER, { number })
  return phones ~= nil
end

--- Update the phone number of a player
---@param newNumber string
---@param id string
---@return boolean
function db.updateNumber(newNumber, id)
  local affectedRows = MySQL.update.await(SQL_QUERIES.RESET_PHONE_NUMBER, { newNumber, id })
  return affectedRows > 0
end

--- Get all the vehicles in a players garage
---@param id string
---@return table
function db.getPlayerVehicles(id)
  return MySQL.query.await(SQL_QUERIES.GET_PLAYER_VEHICLES, { id })
end

--- Update a vehicles license plate
---@param oldPlate string
---@param newPlate string
---@param id string
---@return boolean
function db.updateVehiclePlate(oldPlate, newPlate, id)
  local affectedRows = MySQL.update.await(SQL_QUERIES.UPDATE_PLATE_CUSTOM, { newPlate, oldPlate, newPlate, oldPlate, id })
  return affectedRows > 0
end

--- Update a players phone number
---@param oldNumber string
---@param newNumber string
---@param id string
---@return boolean
function db.updatePlayerNumber(oldNumber, newNumber, id)
  local affectedRows = MySQL.update.await(SQL_QUERIES.UPDATE_PHONE_NUMBER_CUSTOM, { newNumber, oldNumber, id })
  return affectedRows > 0
end

return db

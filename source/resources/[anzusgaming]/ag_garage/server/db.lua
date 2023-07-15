local MySQL = MySQL

local SQL_QUERIES = {
  GET_VEHICLES_AT_GARAGE =
  'SELECT `id`, `plate`, `model`, `data` FROM `character_vehicles` WHERE `owner` = ? AND (`garage` = ? OR `garage` IS NULL) AND `shared` = 0 AND `out` = 0 AND `type` IN (%s)',
  GET_ALL_VEHICLES =
  'SELECT `id`, `plate`, `model`, `vin`, JSON_UNQUOTE(JSON_EXTRACT(data, \'$.name\')) as `name` FROM `character_vehicles` WHERE `owner` = ? AND `shared` = 0 AND `out` = 0',
  GET_SHARED_VEHICLES_AT_GARAGE =
  'SELECT `id`, `plate`, `model`, `data`, `shared`, `out` FROM `character_vehicles` WHERE `garage` = ? AND `shared` = 1 AND `out` = 0 AND `type` IN (%s)',
  GET_IMPOUND_VEHICLES = 'SELECT `id`, `plate`, `model`, `data` FROM `character_vehicles` WHERE `owner` = ? AND `garage` = ? AND `shared` = 0 AND `out` = 0 AND `type` IN (%s)',
  REMOVE_FROM_IMPOUND = 'UPDATE character_vehicles SET garage = ? WHERE plate = ? AND owner = ?'
}

local db = {}

---Fetch vehicle data for the given owner
---@param owner string
---@param data {garage: string, pool: 'shared' | 'public' | 'all' | 'property' | 'impound', type: string[]} Garage info
function db.getVehiclesInGarage(owner, data)
  local type = ''
  for i, v in ipairs(data.type) do
    if i > 1 then
      type = type .. ", "
    end
    type = type .. "'" .. v .. "'"
  end

  if data.pool == 'public' or data.pool == 'property' then
    return MySQL.prepare.await((SQL_QUERIES.GET_VEHICLES_AT_GARAGE):format(type), { owner, data.garage })
  elseif data.pool == 'shared' then
    return MySQL.prepare.await((SQL_QUERIES.GET_SHARED_VEHICLES_AT_GARAGE):format(type), { data.garage })
  elseif data.pool == 'all' then
    return MySQL.prepare.await(SQL_QUERIES.GET_ALL_VEHICLES, { owner })
  elseif data.pool == 'impound' then
    return MySQL.prepare.await((SQL_QUERIES.GET_IMPOUND_VEHICLES):format(type), { owner, data.garage })
  end

  return nil
end

return db

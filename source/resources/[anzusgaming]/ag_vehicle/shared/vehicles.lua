---@class VehicleStats
---@field acceleration number
---@field braking number
---@field handling number
---@field speed number

---@class TopVehicleStats
---@field air VehicleStats
---@field land VehicleStats
---@field sea VehicleStats

---@class VehicleData : VehicleStats
---@field class number
---@field doors number
---@field make string
---@field name string
---@field price number
---@field seats number
---@field type string
---@field defaultProperties table<{}>

---@type table<string, VehicleData>
local vehicleList = json.load('shared/files/vehicles.json')

local function filterData(model, data, filter)
  if filter.model and not model:find(filter.model) then return end
  if filter.bodytype and filter.bodytype ~= data.bodytype then return end
  if filter.class and filter.class ~= data.class then return end
  if filter.doors and filter.doors == data.doors then return end
  if filter.make and filter.make ~= data.make then return end
  if filter.minprice and filter.minprice > data.price then return end
  if filter.maxprice and data.price > filter.maxprice then return end
  if filter.seats and filter.seats ~= data.seats then return end
  if filter.type and type(filter.type) == 'table' then
    local res = false
    for _, value in pairs(filter.type) do
      if value == data.type then
        res = true
      end
    end
    return res
  end
  if filter.type and type(filter.type) == 'string' and filter.type ~= data.type then return end

  return true
end

---@param filter string | string[] | table<string, string | number> | table<string, string[] | number> | nil
function AG.GetVehicleData(filter)
  if filter then
    if type(filter) == 'table' then
      local rv = {}

      if table.type(filter) == 'array' then
        for i = 1, #filter do
          local model = filter[i]
          rv[model] = vehicleList[model]
        end
      else
        for model, data in pairs(vehicleList) do
          if filterData(model, data, filter) then
            rv[model] = data
          end
        end
      end

      return rv
    end

    return vehicleList[filter]
  end

  return vehicleList
end

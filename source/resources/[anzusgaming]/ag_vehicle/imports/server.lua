local agvehicle = exports.ag_vehicle

AG = setmetatable({}, {
  __index = function(self, index)
    self[index] = function(...)
      return agvehicle[index](nil, ...)
    end

    return self[index]
  end
})

local function import(path)
  local file = ('imports/%s.lua'):format(path)
  local chunk, err = load(LoadResourceFile('ag_vehicle', file), ('@@ag_vehicle/%s'):format(file))

  if err or not chunk then
    error(err or ("Unable to load file '%s'"):format(file))
  end

  return chunk()
end

import 'server/vehicle'

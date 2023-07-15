QBCore = exports['qb-core']:GetCoreObject()

Config = {}

-- Enables drawing targets and runs the target setup function on resource start
Config.Debug = true

-- Link to the Tebex store where premium vehicles are sold
Config.TebexLink = "https://tebex.io/yourstore"

-- Locations where an ox_target will be placed to open the vehicle shop menu
Config.Locations =
{
  vec3(-208.368866, -1019.354919, 30.138384),
}

Config.FormatNumber = function(number)
  local formatted = number
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k == 0) then
      break
    end
  end
  return formatted
end

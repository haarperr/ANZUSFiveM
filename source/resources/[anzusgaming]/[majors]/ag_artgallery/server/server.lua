-- Generate a completely unique seed using current time and clock
local seed = tostring(os.time()) .. tostring(os.clock())
local seedNumber = tonumber(seed:reverse():sub(1, 6))

math.randomseed(math.floor(seedNumber))

local code = nil
local attempts = 0

lib.callback.register('ag_artgallery:server:checkCode', function(source, data)
  attempts += 1
  return { correct = code == data.code, attempts = attempts }
end)

lib.callback.register('ag_artgallery:server:getVaultCode', function()
  return code
end)

function GenerateVaultCode()
  local chars = {}
  local hexCharacters = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'a', 'b', 'c', 'd', 'e', 'f' }

  local numCharacters = #hexCharacters

  for i = 1, 8 do
    local randomNum = math.random(1, numCharacters)
    local char = hexCharacters[randomNum]
    table.insert(chars, char)
  end

  code = table.concat(chars)
  print(code)
end

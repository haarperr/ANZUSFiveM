-- Generate a completely unique seed using current time and clock
local seed = tostring(os.time()) .. tostring(os.clock())
local seedNumber = tonumber(seed:reverse():sub(1, 6))

math.randomseed(math.floor(seedNumber))

local function generateCode()
  local chars = {}
  local hexCharacters = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'a', 'b', 'c', 'd', 'e', 'f' }

  local numCharacters = #hexCharacters

  for i = 1, 6 do
    local randomNum = math.random(1, numCharacters)
    local char = hexCharacters[randomNum]
    table.insert(chars, char)
  end

  return table.concat(chars)
end

SyncData = {
  office1 = { password = generateCode(), hacked = false },
  office2 = { password = generateCode(), hacked = false },
  office3 = { password = generateCode(), hacked = false },
}

---@param source any
---@param data {code: number, office: string}
lib.callback.register('ag_paleto:server:correctDoorCode', function(source, data)
  return data.code == SyncData[data.office].password
end)

lib.callback.register('ag_paleto:server:getSyncData', function()
  return SyncData
end)

---@param data {key: string, bool: boolean}
RegisterNetEvent('ag_paleto:server:setHacked', function(data)
  print(json.encode(data))
  SyncData[data.key].hacked = data.bool
  TriggerClientEvent('ag_paleto:client:setHacked', -1, data)
end)

print(json.encode(SyncData, { indent = true }))

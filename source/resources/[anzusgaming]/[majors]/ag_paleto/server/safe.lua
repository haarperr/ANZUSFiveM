local codes = {}
local attempts = 0

---@param data {index: number}
RegisterNetEvent('ag_paleto:server:safeCrack', function(data)
  local src = source
  local code = tostring(codes[data.index])

  Inventory:AddItem(src, 'stickynote', 1, { label = 'Vault Code', description = code })
end)

---@param data {index: number, code: string}
lib.callback.register('ag_paleto:server:checkCode', function(source, data)
  attempts += 1
  TriggerClientEvent('ag_paleto:client:setAttemptCount', -1, attempts)
  return { correct = codes[1] == data.code, attempts = attempts }
end)

---@param data {code: string, index: number, bool: boolean}
RegisterNetEvent('ag_paleto:server:setVaultDoor', function(data)
  Config.Paleto.vault[data.index].opened = data.bool

  TriggerClientEvent('ag_paleto:client:setVaultDoor', -1, data)
end)

function SetupVaultCodes()
  for k, _ in ipairs(Config.Paleto.vault) do
    codes[k] = tostring(math.random(111111, 999999))
    print(('[Paleto] Vault %s - %d'):format(k, codes[k]))
  end
end

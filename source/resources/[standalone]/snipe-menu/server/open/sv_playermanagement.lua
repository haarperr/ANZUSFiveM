CreateCallback("snipe-menu:server:getAllUniquePlayers", function(source, cb)
  local addedLicenses = {}
  local returnData = {}
  if Config.Core == "QBCore" then
    -- grab firstname and lastname from players table
    local player = MySQL.query.await(
      'SELECT citizenid, JSON_VALUE(characters.charinfo, "$.firstname") as firstname, JSON_VALUE(characters.charinfo, "$.lastname") as lastname FROM characters')
    if player ~= nil then
      for k, v in pairs(player) do
        returnData[#returnData + 1] = {
          id = v.citizenid,
          name = v.firstname .. " " .. v.lastname
        }
      end
    end
  elseif Config.Core == "ESX" then
    local player = MySQL.query.await('SELECT DISTINCT identifier, firstname, lastname FROM users')
    if player ~= nil then
      for k, v in pairs(player) do
        local extracted = v.identifier
        if string.match(v.identifier, ":") then
          extracted = string.match(v.identifier, ":(.*)")
        end
        if not addedLicenses[extracted] then
          returnData[#returnData + 1] = {
            id = "license:" .. extracted,
            name = v.firstname .. " " .. v.lastname
          }
          addedLicenses[extracted] = true
        end
      end
    end
  end
  cb(returnData)
end)

local wipeTables = {
  QBCore = {
    ['characters'] = "citizenid",
    ["character_vehicles"] = "citizenid",
    ['properties'] = "citizenid",
  },
  ESX = {
    ['users'] = "identifier",
    ["owned_vehicles"] = "owner"
  }
}


RegisterServerEvent("snipe-menu:server:wipePlayer", function(id)
  local src = source
  if onlineAdmins[src] then
    SendLogs(source, "triggered", Config.Locales["wiped_player"] .. id)
    if Config.Core == "QBCore" then
      for k, v in pairs(wipeTables.QBCore) do
        MySQL.Async.execute('DELETE FROM ' .. k .. ' WHERE ' .. v .. ' = @id', {
          ['@id'] = id
        }, function(rowsChanged)
          print("Wiped " .. rowsChanged .. " rows from " .. k)
        end)
      end
    elseif Config.Core == "ESX" then
      for k, v in pairs(wipeTables.ESX) do
        MySQL.Async.execute('DELETE FROM ' .. k .. ' WHERE ' .. v .. ' = @id', {
          ['@id'] = id
        }, function(rowsChanged)
          print("Wiped " .. rowsChanged .. " rows from " .. k)
        end)
      end
    end
  end
end)

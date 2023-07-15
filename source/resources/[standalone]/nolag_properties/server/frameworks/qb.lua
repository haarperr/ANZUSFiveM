if Config.Framework.Active ~= 2 then return end



QBCore = exports["qb-core"]:GetCoreObject()
Framework = {

  GetPlayerFromId = function(source)
    local xPlayer = {}
    local qbPlayer = QBCore.Functions.GetPlayer(source)
    ---------
    if not qbPlayer then
      return nil
    end
    xPlayer.source = qbPlayer.PlayerData.source
    ---------
    xPlayer.identifier = qbPlayer.PlayerData.citizenid
    ---------
    xPlayer.license = qbPlayer.PlayerData.license
    ---------
    local gradeName = "none"
    local gradeLevel = -1

    if qbPlayer.PlayerData.job.grade then
      gradeName = qbPlayer.PlayerData.job.grade.name
      gradeLevel = qbPlayer.PlayerData.job.grade.level
    end

    xPlayer.job = {
      name = qbPlayer.PlayerData.job.name,
      label = qbPlayer.PlayerData.job.label,
      grade = {
        name = gradeName,
        level = gradeLevel
      }
    }
    ---------
    xPlayer.playerData = qbPlayer.PlayerData
    ---------
    xPlayer.getGroup = function()
      return QBCore.Functions.GetPermission(source)
    end
    ---------
    xPlayer.getJob = function()
      if not qbPlayer.PlayerData.job or not qbPlayer.PlayerData.job.grade then
        return {
          grade = 0,
          grade_name = nil,
          name = nil
        }
      end

      local gradeName = "none"
      local gradeLevel = -1

      if qbPlayer.PlayerData.job.grade then
        gradeName = qbPlayer.PlayerData.job.grade.name
        gradeLevel = qbPlayer.PlayerData.job.grade.level
      end

      return {
        grade = gradeLevel,
        grade_name = gradeName,
        name = qbPlayer.PlayerData.job.name or "none"
      }
    end
    ---------
    xPlayer.getName = function()
      if qbPlayer.PlayerData.charinfo and qbPlayer.PlayerData.charinfo.firstname then
        return qbPlayer.PlayerData.charinfo.firstname
      else
        return qbPlayer.PlayerData.name
      end
    end
    ---------
    xPlayer.getMoney = function()
      return qbPlayer.Functions.GetMoney("cash")
    end
    ---------
    xPlayer.addMoney = function(money)
      qbPlayer.Functions.AddMoney("cash", money)
    end
    ---------
    xPlayer.addAccountMoney = function(type, money)
      if type == "money" then
        type = "cash"
      end
      qbPlayer.Functions.AddMoney(type, money)
    end
    ---------
    xPlayer.getAccount = function(type)
      return {
        money = qbPlayer.Functions.GetMoney(type) or 0
      }
    end
    ---------
    xPlayer.removeAccountMoney = function(type, money)
      qbPlayer.Functions.RemoveMoney(type, money)
    end
    ---------
    xPlayer.removeMoney = function(money)
      qbPlayer.Functions.RemoveMoney("cash", money)
    end
    ---------
    xPlayer.setMeta = function(key, val)
      qbPlayer.Functions.SetMetaData(key, val)
    end
    ---------
    xPlayer.clearMeta = function(key)
      qbPlayer.Functions.SetMetaData(key, nil)
    end
    return xPlayer
  end
}

function UpdatePlayerCooords(identifier, coords)
  local playersTable = 'players'
  return MySQL.query([[
        UPDATE `]] .. playersTable .. [[`
        SET position = ?
        WHERE citizenid = ?
    ]], {
    json.encode(coords),
    identifier
  })
end

function GetOfflinePlayerName(identifier)
  local playersTable = 'players'
  local result = MySQL.query.await([[
        SELECT
            JSON_VALUE(charinfo, '$.firstname') AS firstname,
            JSON_VALUE(charinfo, '$.lastname') AS lastname
        FROM `]] .. playersTable .. [[`
        WHERE citizenid = ?
    ]], { identifier })
  return result[1] and result[1].firstname .. ' ' .. result[1].lastname or "Unknown"
end

RegisterNetEvent('nolag_properties:server:LogoutLocation', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local MyItems = Player.PlayerData.items
  MySQL.update('UPDATE players SET inventory = ? WHERE citizenid = ?',
    { json.encode(MyItems), Player.PlayerData.citizenid })
  QBCore.Player.Logout(src)
  TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
end)

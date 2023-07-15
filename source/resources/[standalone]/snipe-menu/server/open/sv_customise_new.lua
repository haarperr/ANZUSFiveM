local categories = { -- Only include the categories you want. A category not listed defaults to FALSE.
  mods = true,       -- Performance Mods
  repair = true,
  armor = true,
  respray = true,
  liveries = true,
  wheels = true,
  tint = true,
  plate = true,
  extras = true,
  neons = true,
  xenons = true,
  horn = true,
  turbo = true,
  cosmetics = true,       -- Cosmetic Mods
}

RegisterServerEvent("snipe-menu:server:toggleBennys", function()
  local src = source
  if src ~= 0 and onlineAdmins[src] then
    SendLogs(src, "triggered", Config.Locales["open_benny"])
    local override = {}
    override["coords"] = GetEntityCoords(GetPlayerPed(src))
    override["heading"] = GetEntityHeading(GetPlayerPed(src))
    override["categories"] = categories
    TriggerClientEvent("qb-customs:client:EnterCustoms", src, override)
  else
    SendLogs(src, "exploit", Config.Locales["toggle_benny_exploit"])
  end
end)



RegisterServerEvent("snipe-menu:server:unbanPlayer", function(id, license)
  local src = source
  if src ~= 0 and onlineAdmins[src] then
    MySQL.Async.execute('DELETE FROM bans WHERE license = ? ', { license })
    SendLogs(src, "triggered", Config.Locales["unban_player_used"] .. " " .. id .. " (" .. license .. ")")
  else
    SendLogs(src, "exploit", Config.Locales["unban_player_exploit"])
  end
end)

RegisterServerEvent("snipe-menu:server:changeModel", function(id, model)
  local src = source
  if src ~= 0 and onlineAdmins[src] then
    TriggerClientEvent("snipe-menu:client:changeModel", id, model)
    local otherPlayer = QBCore.Functions.GetPlayer(id)
    SendLogs(src, "triggered", Config.Locales["change_model_used"] .. " " .. otherPlayer.PlayerData.citizenid .. " (" .. model .. ")")
  else
    SendLogs(src, "exploit", Config.Locales["change_model_exploit"])
  end
end)


RegisterServerEvent("snipe-menu:server:notifyAdmins", function(name)
  for k, v in pairs(onlineAdmins) do
    if v then
      ShowNotification(k, "New Admin message from: " .. name, "success")
    end
  end
end)

CreateCallback('snipe-menu:server:getAllJobs', function(source, cb)
  local returnData = ESX.GetJobs()
  cb(returnData)
end)

CreateCallback("snipe-menu:server:getPlayerInfo", function(source, cb, otherPlayerId)
  local src = source
  local returnData = {}
  if Config.Core == "QBCore" then
    local otherPlayer = QBCore.Functions.GetPlayer(otherPlayerId)
    returnData.citizenId = otherPlayer.PlayerData.citizenid
    returnData.name = otherPlayer.PlayerData.charinfo.firstname .. " " .. otherPlayer.PlayerData.charinfo.lastname
    returnData.job = otherPlayer.PlayerData.job.label .. " (" .. otherPlayer.PlayerData.job.grade.name .. ")"
    returnData.gang = otherPlayer.PlayerData.gang.label .. " (" .. otherPlayer.PlayerData.gang.grade.name .. ")"
    returnData.cashBalance = otherPlayer.PlayerData.money["cash"]
    returnData.bankBalance = otherPlayer.PlayerData.money["bank"]
    returnData.radio = Player(otherPlayer.PlayerData.source).state.radioChannel
  elseif Config.Core == "ESX" then
    local otherPlayer = ESX.GetPlayerFromId(otherPlayerId)
    returnData.citizenId = otherPlayer.identifier
    returnData.name = otherPlayer.name
    returnData.job = otherPlayer.job.label .. " (" .. otherPlayer.job.grade_label .. ")"
    returnData.gang = otherPlayer.job.label .. " (" .. otherPlayer.job.grade_label .. ")" -- gang is job in ESX. If you have gangs, you can change this.
    returnData.cashBalance = otherPlayer.getMoney()
    returnData.bankBalance = otherPlayer.getAccount("bank").money
    returnData.radio = Player(otherPlayer.source).state.radioChannel
  end
  cb(returnData)
end)

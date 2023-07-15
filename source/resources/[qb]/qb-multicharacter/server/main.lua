local QBCore = exports['qb-core']:GetCoreObject()
local hasDonePreloading = {}

local function GiveStarterItems(source)
  local Player = QBCore.Functions.GetPlayer(source)

  for _, v in pairs(QBCore.Shared.StarterItems) do
    if v.item == 'id_card' then
      local gender = Player.PlayerData.charinfo.gender
      if gender == 0 then gender = 'male' else gender = 'female' end
      local metadata = {
        type = string.format('%s %s', Player.PlayerData.firstname, Player.PlayerData.lastname),
        description = string.format('CID: %s  \nDate of Birth: %s  \nSex: %s  \nNationality: %s',
          Player.PlayerData.citizenid, Player.PlayerData.charinfo.birthdate, gender, Player.PlayerData.charinfo.nationality)
      }
      exports.ox_inventory:AddItem(source, v.item, v.amount, metadata)
    elseif v.item == 'driver_license' then
      local metadata = {
        description = string.format('First Name: %s  \nLast Name: %s  \nDate of Birth: %s',
          Player.PlayerData.firstname, Player.PlayerData.lastname, Player.PlayerData.charinfo.birthdate)
      }
      exports.ox_inventory:AddItem(source, v.item, v.amount, metadata)
    else
      exports.ox_inventory:AddItem(source, v.item, v.amount)
    end
  end
end

QBCore.Commands.Add("logout", Lang:t("commands.logout_description"), {}, false, function(source)
  local src = source
  QBCore.Player.Logout(src)
  TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
end, "admin")

QBCore.Commands.Add("deletechar", Lang:t("commands.deletechar_description"), { { name = Lang:t("commands.citizenid"), help = Lang:t("commands.citizenid_help") } }, false,
  function(source, args)
    if args and args[1] then
      QBCore.Player.ForceDeleteCharacter(tostring(args[1]))
      TriggerClientEvent("QBCore:Notify", source, Lang:t("notifications.deleted_other_char", { citizenid = tostring(args[1]) }))
    else
      TriggerClientEvent("QBCore:Notify", source, Lang:t("notifications.forgot_citizenid"), "error")
    end
  end, "god")

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
  Wait(1000) -- 1 second should be enough to do the preloading in other resources
  hasDonePreloading[Player.PlayerData.source] = true
end)

AddEventHandler('QBCore:Server:OnPlayerUnload', function(src)
  hasDonePreloading[src] = false
end)

RegisterNetEvent('qb-multicharacter:server:loadUserData', function(cData)
  local src = source
  if QBCore.Player.Login(src, cData.citizenid) then
    repeat
      Wait(0)
    until hasDonePreloading[src]
    print('^2[qb-core]^7 ' .. GetPlayerName(src) .. ' (Citizen ID: ' .. cData.citizenid .. ') has succesfully loaded!')
    QBCore.Commands.Refresh(src)
    TriggerClientEvent('apartments:client:setupSpawnUI', src, cData)
    TriggerEvent("qb-log:server:CreateLog", "joinleave", "Loaded", "green",
      "**" ..
      GetPlayerName(src) ..
      "** (" ..
      (QBCore.Functions.GetIdentifier(src, 'discord') or 'undefined') ..
      " |  ||" ..
      (QBCore.Functions.GetIdentifier(src, 'ip') or 'undefined') ..
      "|| | " .. (QBCore.Functions.GetIdentifier(src, 'license') or 'undefined') .. " | " .. cData.citizenid .. " | " .. src .. ") loaded..")
    SetPlayerRoutingBucket(src, 0)
  end
end)

RegisterNetEvent('qb-multicharacter:server:createCharacter', function(data)
  local src = source
  local newData = {}
  newData.charinfo = data
  newData.fullname = newData.charinfo.fullname
  newData.charinfo.fullname = nil
  if QBCore.Player.Login(src, false, newData) then
    repeat
      Wait(0)
    until hasDonePreloading[src]
    exports['um-idcard']:CreateMetaLicense(src, { 'id_card', 'driver_license' })

    local player = QBCore.Functions.GetPlayer(src).PlayerData
    if data.nationality == 'british' or data.nationality == 'British' then
      AG.StarterVehicle(player.citizenid, true)
    else
      AG.StarterVehicle(player.citizenid, false)
    end

    if not Config.HasSpawn then
      SetPlayerRoutingBucket(src, 0)
      lib.callback.await('qb-multicharacter:callback:defaultSpawn', src)
      print('^2[qb-core]^7 ' .. GetPlayerName(src) .. ' has succesfully loaded!')
      if Config.HasClothing then
        TriggerClientEvent('qb-clothes:client:CreateFirstCharacter', src)
      end
    else
      if Config.StartingApartment then
        print('^2[qb-core]^7 ' .. GetPlayerName(src) .. ' has succesfully loaded!')
        QBCore.Commands.Refresh(src)
        TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
      else
        print('^2[qb-core]^7 ' .. GetPlayerName(src) .. ' has succesfully loaded!')
        QBCore.Commands.Refresh(src)
        TriggerClientEvent("qb-multicharacter:client:closeNUIdefault", src)
      end
    end
  end
end)

RegisterNetEvent('qb-multicharacter:server:deleteCharacter', function(citizenid)
  TriggerClientEvent('QBCore:Notify', source, Lang:t("notifications.char_deleted"), "success")
  QBCore.Player.DeleteCharacter(source, citizenid)
end)

lib.callback.register('qb-multicharacter:callback:GetNumberOfCharacters', function(source)
  local License = QBCore.Functions.GetIdentifier(source, 'license2')
  if Config.PlayersNumberOfCharacters[License] then
    return Config.PlayersNumberOfCharacters[License]
  else
    return Config.DefaultNumberOfCharacters
  end
end)

lib.callback.register('qb-multicharacter:callback:GetCurrentCharacters', function(source)
  local Characters = {}
  local identifiers = QBCore.Functions.GetIdentifiers(source)
  local Result = MySQL.query.await(
    'SELECT cc.citizenid, cc.phone_number, cc.fullname, cc.userid, cc.charinfo, cc.money, cc.job FROM users uu INNER JOIN characters cc ON uu.userid = cc.userid WHERE uu.license = ? OR uu.license2 = ?',
    { identifiers.license, identifiers.license2 })
  for i = 1, #Result do
    local firstname, _ = string.strsplit(' ', Result[i].fullname)
    Result[i].charinfo = json.decode(Result[i].charinfo)

    Result[i].charinfo.firstname = firstname
    Result[i].charinfo.lastname = string.gsub(Result[i].fullname, firstname .. " ", "")

    Result[i].money = json.decode(Result[i].money)
    Result[i].job = json.decode(Result[i].job)
    Characters[#Characters + 1] = Result[i]
  end
  return Characters
end)

lib.callback.register('qb-multicharacter:callback:UpdatePreviewPed', function(source, CitizenID)
  local Ped = MySQL.single.await('SELECT * FROM character_skins WHERE citizenid = ?', { CitizenID })
  local PlayerData = MySQL.single.await('SELECT * FROM characters WHERE citizenid = ?', { CitizenID })
  if not Ped or not PlayerData then return end
  Charinfo = json.decode(PlayerData.charinfo)
  return Ped.skin, joaat(Ped.model), Charinfo.gender
end)

AddEventHandler('playerJoining', function()
  SetPlayerRoutingBucket(source, source)
end)

AddEventHandler('onResourceStart', function(resourceName)
  if resourceName ~= GetCurrentResourceName() then return end
  Wait(100)
  for _, playerId in ipairs(GetPlayers()) do
    playerId = tonumber(playerId)
    if not playerId then return end
    SetPlayerRoutingBucket(tostring(playerId), playerId)
  end
end)

RegisterServerEvent('snipe-menu:server:giveClothes', function(otherPlayerId)
  local src = source
  if src ~= 0 and onlineAdmins[src] then
    local otherPlayer = QBCore.Functions.GetPlayer(otherPlayerId)
    SendLogs(src, "triggered", Config.Locales["give_clothes_used"] .. otherPlayer.PlayerData.citizenid)
    if Config.Core == "QBCore" then
      TriggerClientEvent('qb-clothing:client:openMenu', otherPlayerId)
    elseif Config.Core == "ESX" then
      TriggerClientEvent("esx_skin:openSaveableMenu", otherPlayerId)
    end
  else
    TriggerServerEvent("snipe-menu:server:sendLogs", "exploit", Config.Locales["clothes_exploit_event"])
  end
end)

RegisterServerEvent("snipe-menu:server:revertClothing", function(id)
  local src = source
  if src ~= 0 and onlineAdmins[src] then
    TriggerClientEvent("snipe-menu:client:revertClothing", id)
    local otherPlayer = QBCore.Functions.GetPlayer(id)
    SendLogs(src, "triggered", Config.Locales["revert_clothing_used"] .. " " .. otherPlayer.PlayerData.citizenid)
  else
    SendLogs(src, "exploit", Config.Locales["revert_clothing_exploit"])
  end
end)

--  ██████  ██ ██    ██ ███████      ██████  ██    ██ ████████ ███████ ██ ████████ ███████
-- ██       ██ ██    ██ ██          ██    ██ ██    ██    ██    ██      ██    ██    ██
-- ██   ███ ██ ██    ██ █████       ██    ██ ██    ██    ██    █████   ██    ██    ███████
-- ██    ██ ██  ██  ██  ██          ██    ██ ██    ██    ██    ██      ██    ██         ██
--  ██████  ██   ████   ███████      ██████   ██████     ██    ██      ██    ██    ███████

RegisterServerEvent("snipe-menu:server:giveOutfits", function(id)
  local src = source
  if src ~= 0 and onlineAdmins[src] then
    if Config.Skin == "qb-clothing" then
      TriggerClientEvent("qb-clothing:client:openOutfitMenu", id)
    elseif Config.Skin == "fivem-appearance" then
      if Config.Core == "QBCore" then
        TriggerClientEvent("qb-clothing:client:openOutfitMenu", id)
      else
        TriggerClientEvent("fivem-appearance:pickNewOutfit", id, { id = 1, number = 2 })
      end
    elseif Config.Skin == "illenium-appearance" then
      TriggerClientEvent("illenium-appearance:openOutfitMenu", id)
    elseif Config.Skin == "esx_skin" then
      -- ESX Skin does not have outfits options
    elseif Config.Skin == "other" then
      -- Put the event to open the outfit menu here
    end
    TriggerClientEvent("snipe-menu:client:closeMenu", id)
    local otherPlayer = QBCore.Functions.GetPlayer(id)
    SendLogs(src, "triggered", Config.Locales["clothing_outfit_option"] .. otherPlayer.PlayerData.citizenid)
  else
    SendLogs(src, "exploit", Config.Locales["clothing_outfit_option_exploit"])
  end
end)

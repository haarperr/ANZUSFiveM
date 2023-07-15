if GetResourceState('ox_inventory') ~= 'started' then return end

local ox_inventory = exports.ox_inventory

function NewMetaDataLicense(src, itemName)
  local newMetaDataItem = ox_inventory:Search(src, 1, itemName)
  for _, v in pairs(newMetaDataItem) do
    newMetaDataItem = v
    break
  end

  newMetaDataItem.metadata.mugShot = lib.callback.await('um-idcard:client:callBack:getMugShot', src)
  ox_inventory:SetMetadata(src, newMetaDataItem.slot, newMetaDataItem.metadata)

  return newMetaDataItem.metadata
end

function CheckValidFirearm(src)
  local newMetaDataItem = ox_inventory:Search(src, 1, 'firearm_license')
  for _, v in pairs(newMetaDataItem) do
    newMetaDataItem = v
    break
  end

  local Player = QBCore.Functions.GetPlayer(src)
  local data = exports.ag_police:GetVirtualLicense(Player.PlayerData.citizenid, 'firearm')
  if not data then
    newMetaDataItem.metadata.status = 'INVALID'
  else
    newMetaDataItem.metadata.status = 'VALID'
  end

  ox_inventory:SetMetadata(src, newMetaDataItem.slot, newMetaDataItem.metadata)

  return newMetaDataItem.metadata
end

function GetCallSign(src)
  local newMetaDataItem = ox_inventory:Search(src, 1, 'lspd_id')
  for _, v in pairs(newMetaDataItem) do
    newMetaDataItem = v
    break
  end

  local Player = QBCore.Functions.GetPlayer(src)
  newMetaDataItem.metadata.callsign = Player.PlayerData.metadata.callsign

  ox_inventory:SetMetadata(src, newMetaDataItem.slot, newMetaDataItem.metadata)

  return newMetaDataItem.metadata
end

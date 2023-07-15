local QBCore = exports['qb-core']:GetCoreObject()

local bullets = {}
local casings = {}
local blood = {}


QBCore.Functions.CreateCallback("core_evidence:getData", function(_, cb)
  cb({ casings = casings, blood = blood, bullets = bullets, time = os.time() })
end)

QBCore.Functions.CreateCallback("core_evidence:getStorageData", function(_, cb)
  exports.oxmysql:query("SELECT * FROM `evidence_storage` WHERE 1", {}, function(reports)
    cb(reports)
  end)
end)

QBCore.Functions.CreateCallback("core_evidence:findWeaponOwner", function(_, cb, serial)
  local query = '%' .. serial .. '%'
  MySQL.Async.fetchAll("SELECT citizenid, charinfo FROM `characters` WHERE weapon_serials LIKE ?", { query }, function(result)
    local charinfo = json.decode(result[1].charinfo)
    if result[1] then
      cb({ name = charinfo.firstname .. ' ' .. charinfo.lastname, citizenid = result[1].citizenid })
    else
      cb(false)
    end
  end)
end)

function GetItemBySlot(source, slot)
  local Player = QBCore.Functions.GetPlayer(source)
  slot = tonumber(slot)
  return Player.PlayerData.items[slot]
end

RegisterNetEvent("core_evidence:deleteEvidenceFromStorage", function(id)
  exports.oxmysql:update("DELETE FROM `evidence_storage` WHERE id = :id", { ["id"] = id })
end)

local function giveItem(src, evidenceID)
  local Player = QBCore.Functions.GetPlayer(src)

  exports.ox_inventory:AddItem(src, 'evidence_report', 1, { serial = evidenceID })

  TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['evidence_report'], 'add')
end

RegisterNetEvent("core_evidence:addEvidenceToStorage", function(evidence)
  local src = source
  MySQL.insert.await('INSERT INTO evidence_storage (data) VALUES (?)', { evidence })

  local result = MySQL.Sync.fetchSingle('SELECT (SELECT MAX(id) FROM evidence_storage) as maxId')
  local maxId = result['maxId']
  print("MAX ID", maxId)
  if result then giveItem(src, maxId) end
end)

RegisterNetEvent("core_evidence:removeEverything", function()
  for k, v in pairs(blood) do
    if v.interior == 0 then
      blood[k] = nil
    end
  end
  for k, v in pairs(casings) do
    if v.interior == 0 then
      casings[k] = nil
    end
  end
  for k, v in pairs(bullets) do
    if v.interior == 0 then
      bullets[k] = nil
    end
  end
end)

RegisterNetEvent("core_evidence:removeBlood", function(identifier)
  blood[identifier] = nil
end)

RegisterNetEvent("core_evidence:removeBullet", function(identifier)
  bullets[identifier] = nil
end)

RegisterNetEvent("core_evidence:server:removeCasing", function(identifier)
  casings[identifier] = nil
end)

RegisterNetEvent("core_evidence:LastInCar", function(id)
  local src = source
  local entity = NetworkGetEntityFromNetworkId(id)
  local xPlayer = QBCore.Functions.GetPlayer(NetworkGetEntityOwner(entity))

  if xPlayer ~= nil then
    if NetworkGetEntityOwner(entity) ~= src then
      local reportInfo = {}
      if Config.showFirstname then reportInfo.firstname = xPlayer.PlayerData.charinfo.firstname end
      if Config.showLastname then reportInfo.lastname = xPlayer.PlayerData.charinfo.lastname end
      if Config.showGender then reportInfo.gender = xPlayer.PlayerData.charinfo.gender end
      if Config.showBirthdate then reportInfo.birthdate = xPlayer.PlayerData.charinfo.birthdate end
      if Config.showPhone then reportInfo.phone = xPlayer.PlayerData.phone_number end

      TriggerClientEvent("core_evidence:addFingerPrint", src, reportInfo)
    else
      TriggerClientEvent("QBCore:Notify", src, Config.Text["no_fingerprints_found"])
    end
  else
    TriggerClientEvent("QBCore:Notify", src, Config.Text["no_fingerprints_found"])
  end
end)

RegisterNetEvent("core_evidence:saveBlood", function(street, coords, interior)
  local src = source
  local xPlayer = QBCore.Functions.GetPlayer(src)

  local time = os.time()

  local reportInfo = {}
  reportInfo.location = street
  if Config.showFirstname then reportInfo.firstname = xPlayer.PlayerData.charinfo.firstname end
  if Config.showLastname then reportInfo.lastname = xPlayer.PlayerData.charinfo.lastname end
  if Config.showGender then reportInfo.gender = xPlayer.PlayerData.charinfo.gender end
  if Config.showBirthdate then reportInfo.birthdate = xPlayer.PlayerData.charinfo.birthdate end
  if Config.showPhone then reportInfo.phone = xPlayer.PlayerData.phone_number end

  blood[time] = { coords = coords, reportInfo = reportInfo, interior = interior }
end)

QBCore.Functions.CreateUseableItem("uvlight", function(source)
  TriggerClientEvent("core_evidence:checkForFingerprints", source)
end)

QBCore.Functions.CreateUseableItem("evidence_report", function(source, item)
  if GetItemBySlot(source, item.slot) ~= nil then
    local result = MySQL.single.await('SELECT data FROM evidence_storage WHERE id = ?', { item.metadata.serial })

    TriggerClientEvent('core_evidence:client:OpenReport', source, result)
  end
end)

RegisterNetEvent("core_evidence:server:saveCasing", function(street, coords, cartridge, interior, weapon, serial)
  local time = os.time()

  local reportInfo = {}
  reportInfo.location = street
  reportInfo.cartridge = cartridge
  reportInfo.serial = serial

  casings[time] = { coords = coords, reportInfo = reportInfo, interior = interior, weapon = weapon, serial = serial }
end)

RegisterNetEvent("core_evidence:server:saveBullet", function(street, coords, cartridge, interior, serial)
  local time = os.time()

  local reportInfo = {}
  reportInfo.location = street
  reportInfo.cartridge = cartridge
  reportInfo.serial = serial

  bullets[time] = { coords = coords, reportInfo = reportInfo, interior = interior, serial = serial }
end)

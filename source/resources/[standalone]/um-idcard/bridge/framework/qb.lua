if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

--- Convert sex number to string M or F
---@param sexString number | string
---@return string
local function GetStringSex(sexString)
  if sexString ~= 1 then
    sexString = 'M'
  else
    sexString = 'F'
  end
  return sexString
end

--- Get badge for license
---@param src number Source number
---@param itemName string
---@return string | table
local function GetBadge(src, itemName)
  if not Config.Licenses[itemName].badge then return 'none' end
  local Player = QBCore.Functions.GetPlayer(src)
  local badgeTable = {
    img = Config.Licenses[itemName].badge,
    grade = Player.PlayerData.job.grade.name
  }
  return badgeTable
end

--- Create metadata for license
---@param src number Source number
---@param itemTable string | table Item name or table of item names
local function CreateMetaLicense(src, itemTable)
  local Player = QBCore.Functions.GetPlayer(src)

  if type(itemTable) == "string" then
    itemTable = { itemTable }
  end

  if type(itemTable) == "table" then
    for _, v in pairs(itemTable) do
      local metadata = {
        cardtype = v,
        citizenid = Player.PlayerData.citizenid,
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname,
        mugShot = 'none',
      }
      if v == 'firearm_license' then
        local data = exports.ag_police:GetVirtualLicense(Player.PlayerData.citizenid, 'firearm')
        metadata.issuedby = data.issuer_name
        metadata.issuedon = data.issuedOn
        metadata.issuedto = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        metadata.status = 'VALID'
      elseif v == 'lspd_id' then
        metadata.callsign = Player.PlayerData.metadata.callsign
        metadata.badge = GetBadge(src, v)
      else
        metadata.dob = Player.PlayerData.charinfo.birthdate
        metadata.sex = GetStringSex(Player.PlayerData.charinfo.gender)
        metadata.nationality = Player.PlayerData.charinfo.nationality
        metadata.badge = GetBadge(src, v)
      end
      Player.Functions.AddItem(v, 1, false, metadata)
    end
  else
    print("Invalid parameter type")
  end
end

exports('CreateMetaLicense', CreateMetaLicense)


--- Create metadata for license
---@param k string item name
function CreateRegisterItem(k)
  QBCore.Functions.CreateUseableItem(k, function(source, item)
    TriggerEvent('um-idcard:server:sendData', source, item.info or item.metadata)
  end)
end

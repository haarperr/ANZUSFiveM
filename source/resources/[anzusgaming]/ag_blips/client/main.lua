local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData() or {}

---@param id any
---@param label string
---@param job string
---@param location vector4
local function CreateDutyBlips(id, label, job, location)
  local ped = GetPlayerPed(id)
  local blip = GetBlipFromEntity(ped)
  if not DoesBlipExist(blip) then
    if NetworkIsPlayerActive(id) then
      blip = AddBlipForEntity(ped)
    else
      blip = AddBlipForCoord(location.x, location.y, location.z)
    end
    SetBlipSprite(blip, 1)
    ShowHeadingIndicatorOnBlip(blip, true)
    SetBlipRotation(blip, math.ceil(location.w))
    SetBlipScale(blip, 1.0)
    if job == "lspd" then
      SetBlipColour(blip, 38)
    else
      SetBlipColour(blip, 6)
    end
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)
    DutyBlips[#DutyBlips + 1] = blip
  end

  if GetBlipFromEntity(cache.ped) == blip then
    -- Ensure we remove our own blip.
    RemoveBlip(blip)
  end
end

---@param data {source: any, label: string, job: string, location: { x: number, y: number, z: number, w: number}}[]
RegisterNetEvent('ag_blips:client:UpdateBlips', function(data)
  if not PlayerData.job then return end
  if PlayerData.job.type ~= 'leo' or PlayerData.job.name ~= 'ambulance' then return end
  if not PlayerData.job.onduty then return end

  if DutyBlips then
    for _, v in pairs(DutyBlips) do
      RemoveBlip(v)
    end
  end

  DutyBlips = {}
  if not data then return end

  for _, d in pairs(data) do
    local id = GetPlayerFromServerId(d.source)
    CreateDutyBlips(id, d.label, d.job, d.location)
  end
end)

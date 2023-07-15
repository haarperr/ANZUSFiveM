-----------------------
----   Variables   ----
-----------------------
local QBCore = exports['qb-core']:GetCoreObject()
local VehicleList = {}

-----------------------
----   Threads     ----
-----------------------

-----------------------
---- Server Events ----
-----------------------

-- Event to give keys. receiver can either be a single id, or a table of ids.
-- Must already have keys to the vehicle, trigger the event from the server, or pass forcegive paramter as true.
RegisterNetEvent('qb-vehiclekeys:server:GiveVehicleKeys', function(receiver, plate)
  local giver = source

  if HasKeys(giver, plate) then
    TriggerClientEvent('ox_lib:notify', giver, {
      id = 'give_car_keys',
      description = Lang:t("notify.gave_keys"),
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#ffffff'
      },
      icon = 'check',
      iconColor = '#27AE60'
    })
    if type(receiver) == 'table' then
      for _, r in ipairs(receiver) do
        GiveKeys(receiver[r], plate)
      end
    else
      GiveKeys(receiver, plate)
    end
  else
    TriggerClientEvent('ox_lib:notify', giver, {
      id = 'server_no_keys',
      description = Lang:t("notify.no_keys"),
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#ffffff'
      },
      icon = 'xmark',
      iconColor = '#C0392B'
    })
  end
end)

RegisterNetEvent('qb-vehiclekeys:server:AcquireVehicleKeys', function(plate)
  local src = source
  GiveKeys(src, plate)
end)

RegisterNetEvent('qb-vehiclekeys:server:breakLockpick', function(itemName)
  local Player = QBCore.Functions.GetPlayer(source)
  if not Player then return end
  if not (itemName == "lockpick" or itemName == "advancedlockpick") then return end
  if Player.Functions.RemoveItem(itemName, 1) then
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[itemName], "remove")
  end
end)

RegisterNetEvent('qb-vehiclekeys:server:setVehLockState', function(vehNetId, state)
  SetVehicleDoorsLocked(NetworkGetEntityFromNetworkId(vehNetId), state)
end)

QBCore.Functions.CreateCallback('qb-vehiclekeys:server:GetVehicleKeys', function(source, cb)
  local citizenid = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
  local keysList = {}
  for plate, citizenids in pairs(VehicleList) do
    if citizenids[citizenid] then
      keysList[plate] = true
    end
  end
  cb(keysList)
end)

-----------------------
----   Functions   ----
-----------------------

function GiveKeys(id, plate)
  local citizenid = QBCore.Functions.GetPlayer(id).PlayerData.citizenid

  if not VehicleList[plate] then VehicleList[plate] = {} end
  VehicleList[plate][citizenid] = true

  TriggerClientEvent('ox_lib:notify', id, {
    -- id = 'server_id_get_keys',
    description = Lang:t("notify.keys_taken"),
    type = 'success',
    duration = 5000,
    -- style = {
    --   backgroundColor = '#141517',
    --   color = '#ffffff'
    -- },
    -- icon = 'circle-info',
    -- iconColor = '#2980B9'
  })
  TriggerClientEvent('qb-vehiclekeys:client:AddKeys', id, plate)
end

exports('GiveKeys', GiveKeys)

function RemoveKeys(id, plate)
  local citizenid = QBCore.Functions.GetPlayer(id).PlayerData.citizenid

  if VehicleList[plate] and VehicleList[plate][citizenid] then
    VehicleList[plate][citizenid] = nil
  end

  TriggerClientEvent('qb-vehiclekeys:client:RemoveKeys', id, plate)
end

function HasKeys(id, plate)
  local citizenid = QBCore.Functions.GetPlayer(id).PlayerData.citizenid
  if VehicleList[plate] and VehicleList[plate][citizenid] then
    return true
  end
  return false
end

QBCore.Commands.Add("givekeys", Lang:t("addcom.givekeys"), { { name = Lang:t("addcom.givekeys_id"), help = Lang:t("addcom.givekeys_id_help") } }, false, function(source, args)
  local src = source
  if not args[1] then return end
  TriggerClientEvent('qb-vehiclekeys:client:GiveKeys', src, tonumber(args[1]))
end)

QBCore.Commands.Add("addkeys", Lang:t("addcom.addkeys"),
  { { name = Lang:t("addcom.addkeys_id"), help = Lang:t("addcom.addkeys_id_help") }, { name = Lang:t("addcom.addkeys_plate"), help = Lang:t("addcom.addkeys_plate_help") } }, true,
  function(source, args)
    local src = source
    if not args[1] or not args[2] then
      TriggerClientEvent('ox_lib:notify', src, {
        -- id = 'server_notify_fpid',
        description = Lang:t("notify.fpid"),
        type = 'error',
        duration = 5000,
        -- style = {
        --   backgroundColor = '#141517',
        --   color = '#ffffff'
        -- },
        -- icon = 'xmark',
        -- iconColor = '#C0392B'
      })
      return
    end
    GiveKeys(tonumber(args[1]), args[2])
  end, 'admin')

QBCore.Commands.Add("removekeys", Lang:t("addcom.remove_keys"),
  { { name = Lang:t("addcom.remove_keys_id"),  help = Lang:t("addcom.remove_keys_id_help") },
    { name = Lang:t("addcom.remove_keys_plate"), help = Lang:t("addcom.remove_keys_plate_help") } }, true, function(source, args)
    local src = source
    if not args[1] or not args[2] then
      TriggerClientEvent('ox_lib:notify', src, {
        -- id = 'server_notify_fpid',
        type = 'error',
        description = Lang:t("notify.fpid"),
        duration = 5000,
        -- style = {
        --   backgroundColor = '#141517',
        --   color = '#ffffff'
        -- },
        -- icon = 'xmark',
        -- iconColor = '#C0392B'
      })
      return
    end
    RemoveKeys(tonumber(args[1]), args[2])
  end, 'admin')

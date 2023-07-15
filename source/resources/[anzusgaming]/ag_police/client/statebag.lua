Job = {}
local QBCore = exports['qb-core']:GetCoreObject()

AddStateBagChangeHandler('inVehicle', ('player:%s'):format(cache.serverId), function(_, _, value)
  local class = GetVehicleClass(cache.vehicle)
  if Job.type ~= 'leo' then return end
  if not Job.onduty then return end
  if value then
    if class == 18 then
      lib.addRadialItem({
        id = 'pd_gunrack',
        icon = 'person-rifle',
        label = 'Gunrack',
        onSelect = function()
          local plate = GetVehicleNumberPlateText(cache.vehicle)
          exports.ox_inventory:openInventory('stash', { id = 'gunrack-' .. plate, netid = NetworkGetNetworkIdFromEntity(cache.vehicle) })
        end
      })
    end
  elseif not value then
    lib.removeRadialItem('pd_gunrack')
  end
end)

local inJail = LocalPlayer.state.inJail

AddStateBagChangeHandler('inJail', ('player:%s'):format(cache.serverId), function(_, _, value)
  if inJail == value then return end
  if value <= 0 or value == nil then return end

  ClearPedTasks(cache.ped)
  DetachEntity(cache.ped, true, false)
  TriggerEvent("prison:client:Enter", value)

  inJail = value
end)

local isDown = LocalPlayer.state.isDown

AddStateBagChangeHandler('isDown', ('player:%s'):format(cache.serverId), function(_, _, value)
  if isDown == value then return end
  if Job.type ~= 'leo' then return end
  if not Job.onduty then return end

  if value then
    RemoveRadialMenu()
    lib.addRadialItem({
      id = 'agpolice:panic1',
      icon = 'sad-tear',
      label = '10-13B',
      onSelect = function()
        exports['ps-dispatch']:OfficerDownNonUrgent()
      end
    })

    lib.addRadialItem({
      id = 'agpolice:panic2',
      icon = 'sad-cry',
      label = '10-13A',
      onSelect = function()
        exports['ps-dispatch']:OfficerDownUrgent()
      end
    })
  else
    CreateRadialMenu()
    lib.removeRadialItem('agpolice:panic1')
    lib.removeRadialItem('agpolice:panic2')
  end

  isDown = value
end)

local function setup(job)
  Job = job
  RemoveImpoundOptions()
  RemoveRadialOptions()
  RemoveCommands()
  if job.type ~= 'leo' then return end

  CreateTargetOptions()
  if not job.onduty then return end

  CreateRadialOptions()
  SetupCommands()
  CreateImpoundOptions()
end

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
  setup(val.job)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
  setup(job)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  local playerData = QBCore.Functions.GetPlayerData()
  setup(playerData.job)
end)

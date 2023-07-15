local QBCore = exports['qb-core']:GetCoreObject()

local function CitizenRadialSetup()
  lib.registerRadial({
    id = 'citizen_menu',
    items = {
      {
        label = 'Escort',
        icon = 'user-friends',
        onSelect = function()
          exports.ag_police:EscortPlayer(true)
        end
      },

      {
        label = 'Kidnap',
        icon = 'mask',
        onSelect = function()
          exports.ox_inventory:openNearbyInventory()
        end
      },
    }
  })

  lib.registerRadial({
    id = 'illegal_menu',
    items = {
      {
        label = 'Sell Drugs',
        icon = 'cannabis',
        onSelect = function()
          TriggerEvent('ag_drugs:client:cornerselling') -- export/function/event to sell drugs
        end
      }
    }
  })

  lib.addRadialItem({
    {
      id = 'citizen',
      label = 'Citizen',
      icon = 'user',
      menu = 'citizen_menu'
    },
    {
      id = 'illegal',
      label = 'Illegal Menu',
      icon = 'people-robbery',
      menu = 'illegal_menu'
    }
  })
end

local function TaxiRadialSetup()
  lib.registerRadial({
    id = 'taxi_menu',
    items = {
      {
        label = 'Show/Hide Meter',
        icon = 'eye-slash',
        onSelect = function()
          TriggerEvent('qb-taxi:client:toggleMeter')
        end
      },
      {
        label = 'Start/Stop Meter',
        icon = 'hourglass-start',
        onSelect = function()
          TriggerEvent('qb-taxi:client:enableMeter')
        end
      },
      {
        label = 'Local Call',
        icon = 'taxi',
        onSelect = function()
          TriggerEvent('qb-taxi:client:DoTaxiNpc')
        end
      },
    }
  })

  lib.addRadialItem({
    {
      id = 'taxi',
      label = 'Taxi',
      icon = 'user',
      menu = 'taxi_menu'
    }
  })
end

local function AmbulanceRadialSetup()
  lib.registerRadial({
    id = 'ambulance_menu',
    items = {
      {
        label = 'Revive',
        icon = 'user-md',
        onSelect = function()
          TriggerEvent('hospital:client:RevivePlayer')
        end
      },
      {
        label = 'Stabilize',
        icon = 'user-md',
        onSelect = function()
          TriggerEvent('hospital:client:StabilizePlayer')
        end
      },
    }
  })

  lib.addRadialItem({
    {
      id = 'ambulance',
      label = 'EMS',
      icon = 'user-md',
      menu = 'ambulance_menu'
    }
  })
end

local function setup(job)
  CitizenRadialSetup()
  if job.name == 'taxi' then
    TaxiRadialSetup()
  else
    lib.removeRadialItem('taxi')
  end

  if job.name == 'ambulance' then
    lib.removeRadialItem('illegal')
    AmbulanceRadialSetup()
  else
    lib.removeRadialItem('ambulance')
  end

  -- remove illegal radial menu if player is police
  if job.name == 'lspd' then
    lib.removeRadialItem('illegal')
  else
    lib.removeRadialItem('police')
    lib.removeRadialItem('police_radio')
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  local job = QBCore.Functions.GetPlayerData().job
  setup(job)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
  setup(job)
end)

function ExecWalking(style)
  ExecuteCommand(style)
end

AddStateBagChangeHandler('inVehicle', ('player:%s'):format(cache.serverId), function(_, _, value)
  if value then
    lib.addRadialItem({
      id = 'openvehiclemenu',
      icon = 'car',
      label = 'Vehicle',
      onSelect = function()
        TriggerEvent('vehcontrol:openExternal')
      end
    })
  else
    lib.removeRadialItem('openvehiclemenu')
  end
end)

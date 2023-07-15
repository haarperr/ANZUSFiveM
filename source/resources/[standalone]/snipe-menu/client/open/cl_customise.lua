QBCore, ESX = nil, nil

-- ███████ ██████   █████  ███    ███ ███████ ██     ██  ██████  ██████  ██   ██
-- ██      ██   ██ ██   ██ ████  ████ ██      ██     ██ ██    ██ ██   ██ ██  ██
-- █████   ██████  ███████ ██ ████ ██ █████   ██  █  ██ ██    ██ ██████  █████
-- ██      ██   ██ ██   ██ ██  ██  ██ ██      ██ ███ ██ ██    ██ ██   ██ ██  ██
-- ██      ██   ██ ██   ██ ██      ██ ███████  ███ ███   ██████  ██   ██ ██   ██

if Config.Core == "QBCore" then
  QBCore = exports[Config.CoreFolderName]:GetCoreObject()
  Citizen.CreateThread(function()
    while QBCore == nil do
      TriggerEvent(Config.Core .. ':GetObject', function(obj) QBCore = obj end)
      Citizen.Wait(200)
    end
  end)
elseif Config.Core == "ESX" then
  ESX = exports[Config.CoreFolderName]:getSharedObject()
end

-- ███████ ██    ██ ███████ ███    ██ ████████ ███████
-- ██      ██    ██ ██      ████   ██    ██    ██
-- █████   ██    ██ █████   ██ ██  ██    ██    ███████
-- ██       ██  ██  ██      ██  ██ ██    ██         ██
-- ███████   ████   ███████ ██   ████    ██    ███████

RegisterNetEvent("snipe-menu:client:teleportMarker", function()
  if hasAdminPerms then
    local WaypointHandle = GetFirstBlipInfoId(8)

    if DoesBlipExist(WaypointHandle) then
      local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

      for height = 1, 1000 do
        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

        local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

        if foundGround then
          SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

          break
        end

        Citizen.Wait(5)
      end
    end
  else
    TriggerServerEvent("snipe-menu:server:sendLogs", "exploit", Config.Locales["teleport_exploit_event"])
  end
end)

RegisterNetEvent("snipe-menu:client:removeStress", function()
  if hasAdminPerms then
    TriggerServerEvent("hud:server:RelieveStress", 100)     -- this is qbcore event to remove stress (that particular event is in qb-hud/server.lua)
  else
    TriggerServerEvent("snipe-menu:server:sendLogs", "exploit", Config.Locales["stress_exploit_event"])
  end
end)

RegisterNetEvent("snipe-menu:client:teleporttoplayer", function(coords)
  if hasAdminPerms then
    SetPedCoordsKeepVehicle(PlayerPedId(), coords.x, coords.y, coords.z)
  else
    TriggerServerEvent("snipe-menu:server:sendLogs", "exploit", Config.Locales["teleport_exploit_event"])
  end
end)

RegisterNetEvent("snipe-menu:client:openinventory", function(otherPlayer)
  if hasAdminPerms then
    if Config.Core == "QBCore" and Config.Inventory ~= "ox" then
      TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", otherPlayer)
    elseif Config.Core == "ESX" and Config.Inventory == "qs" then
      TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", otherPlayer)
    elseif Config.Inventory == "ox" then
      TriggerServerEvent("snipe-menu:server:openInventory", otherPlayer)
    else
      print("Snipe-Menu: Invalid Inventory Type, please change it to either 'qb' or 'qs' or 'ox' in config.lua")
    end
  end
end)

RegisterNetEvent("snipe-menu:client:toggleDev", function()
  if hasAdminPerms then
    TriggerEvent("qb-admin:client:ToggleDevmode")     -- used to toggle the dev mode ui on hud if you use ps-hud
  end
end)

RegisterNetEvent("snipe-menu:client:reviveInRadius", function(coords)
  if #(GetEntityCoords(PlayerPedId()) - coords) < Config.ReviveRadiusDistance then
    if Config.Core == "QBCore" then
      TriggerEvent("hospital:client:Revive")
    elseif Config.Core == "ESX" then
      TriggerEvent("esx_ambulancejob:revive")
    end
  end
end)


function SetTargetExports(entity, job, size, slots, stashName, isJob, isGang)
  if isJob then
    if Config.Target ~= "ox_target" then
      exports[Config.Target]:AddTargetEntity({ entity }, {
        options = {
          {
            event = "snipe-menu:client:openJobStash",
            icon = "fas fa-box-open",
            label = "Open",
            job = job,
            size = size,
            slots = slots,
            jobStashName = stashName,
          },
          {
            event = "snipe-menu:client:openJobStash",
            icon = "fas fa-box-open",
            label = "Raid Stash",
            job = "police",
            size = size,
            slots = slots,
            jobStashName = stashName,
          },
        },
        distance = 1.5
      })
    elseif Config.Target == "ox_target" then
      local options = {
        {
          event = "snipe-menu:client:openJobStash",
          icon = "fas fa-box-open",
          label = "Open",
          groups = job,
          size = size,
          slots = slots,
          jobStashName = stashName,
        },
      }
      exports.ox_target:addLocalEntity(entity, options)
    end
  elseif isGang then
    if Config.Target ~= "ox_target" then
      exports[Config.Target]:AddTargetEntity({ entity }, {
        options = {
          {
            event = "snipe-menu:client:openJobStash",
            icon = "fas fa-box-open",
            label = "Open",
            gang = job,
            size = size,
            slots = slots,
            jobStashName = stashName,
          },
          {
            event = "snipe-menu:client:openJobStash",
            icon = "fas fa-box-open",
            label = "Raid Stash",
            job = "police",
            size = size,
            slots = slots,
            jobStashName = stashName,
          },
        },
        distance = 1.5
      })
    elseif Config.Target == "ox_target" then
      local options = {
        {
          event = "snipe-menu:client:openJobStash",
          icon = "fas fa-box-open",
          label = "Open",
          groups = job,
          size = size,
          slots = slots,
          jobStashName = stashName,
        },
      }
      exports.ox_target:addLocalEntity(entity, options)
    end
  end
end

-- ███    ██  ██████  ████████ ██ ███████ ██    ██
-- ████   ██ ██    ██    ██    ██ ██       ██  ██
-- ██ ██  ██ ██    ██    ██    ██ █████     ████
-- ██  ██ ██ ██    ██    ██    ██ ██         ██
-- ██   ████  ██████     ██    ██ ██         ██

function ShowNotification(msg, type)
  if Config.Core == "QBCore" then
    QBCore.Functions.Notify(msg, type)
  elseif Config.Core == "ESX" then
    ESX.ShowNotification(msg)
  end
end

local function isAdmin()
  return hasAdminPerms
end

exports('isAdmin', isAdmin)


local function forceCloseAdminMenu()
  SendNUIMessage({
    action = "forceClose"
  })
  SetNuiFocus(false, false)
end

RegisterNetEvent("snipe-menu:client:forceCloseAdminMenu", function()
  forceCloseAdminMenu()
end)

exports('forceCloseAdminMenu', forceCloseAdminMenu)

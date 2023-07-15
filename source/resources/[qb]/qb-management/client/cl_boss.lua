local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = QBCore.Functions.GetPlayerData().job
local shownBossMenu = false
local DynamicMenuItems = {}

-- UTIL
local function CloseMenuFull()
  lib.hideContext()
  lib.hideTextUI()
  shownBossMenu = false
end

local function AddBossMenuItem(data, id)
  local menuID = id or #DynamicMenuItems + 1
  DynamicMenuItems[menuID] = deepcopy(data)
  return menuID
end

exports("AddBossMenuItem", AddBossMenuItem)

local function RemoveBossMenuItem(id)
  DynamicMenuItems[id] = nil
end

exports("RemoveBossMenuItem", RemoveBossMenuItem)

AddEventHandler('onResourceStart', function(resource)
  if resource ~= GetCurrentResourceName() then return end

  PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerJob = JobInfo
end)

RegisterNetEvent('qb-bossmenu:client:OpenMenu', function()
  if not PlayerJob.name or not PlayerJob.isboss then return end

  local bossMenu = {
    {
      title = "Manage Employees",
      description = "Check your Employees List",
      icon = 'fa-solid fa-list',
      event = 'qb-bossmenu:client:employeelist'
    },
    {
      title = "Hire Employees",
      description = "Hire Nearby Civilians",
      icon = 'fa-solid fa-hand-holding',
      event = 'qb-bossmenu:client:HireMenu'
    }
  }

  for _, v in pairs(DynamicMenuItems) do
    bossMenu[#bossMenu + 1] = v
  end

  lib.registerContext({
    id = 'qb_management_open_bossMenu',
    title = "Boss Menu - " .. PlayerJob.label,
    options = bossMenu
  })
  lib.showContext('qb_management_open_bossMenu')
end)

RegisterNetEvent('qb-bossmenu:client:employeelist', function()
  local EmployeesMenu = {}

  local employees = lib.callback.await('qb-bossmenu:server:GetEmployees', false, PlayerJob.name)
  for _, v in pairs(employees) do
    EmployeesMenu[#EmployeesMenu + 1] = {
      title = v.name,
      description = v.grade.name,
      event = 'qb-bossmenu:client:ManageEmployee',
      args = {
        player = v,
        work = PlayerJob
      }
    }
  end

  EmployeesMenu[#EmployeesMenu + 1] = {
    title = "Return",
    icon = 'fa-solid fa-angle-left',
    event = 'qb-bossmenu:client:OpenMenu'
  }

  lib.registerContext({
    id = 'qb_management_open_bossManage',
    title = "Manage Employees - " .. string.upper(PlayerJob.label),
    options = EmployeesMenu
  })

  lib.showContext('qb_management_open_bossManage')
end)

RegisterNetEvent('qb-bossmenu:client:ManageEmployee', function(data)
  local EmployeeMenu = {}

  for k, v in pairs(QBCore.Shared.Jobs[data.work.name].grades) do
    EmployeeMenu[#EmployeeMenu + 1] = {
      title = v.name,
      description = "Grade: " .. k,
      serverEvent = 'qb-bossmenu:server:GradeUpdate',
      args = {
        cid = data.player.empSource,
        grade = tonumber(k),
        gradename = v.name
      }
    }
  end

  EmployeeMenu[#EmployeeMenu + 1] = {
    title = "Fire Employee",
    icon = 'fa-solid fa-user-large-slash',
    serverEvent = 'qb-bossmenu:server:FireEmployee',
    args = data.player.empSource
  }

  EmployeeMenu[#EmployeeMenu + 1] = {
    title = "Return",
    icon = 'fa-solid fa-angle-left',
    event = 'qb-bossmenu:client:OpenMenu'
  }

  lib.registerContext({
    id = 'qb_management_open_bossMember',
    title = "Manage " .. data.player.name .. " - " .. string.upper(PlayerJob.label),
    options = EmployeeMenu
  })

  lib.showContext('qb_management_open_bossMember')
end)

RegisterNetEvent('qb-bossmenu:client:HireMenu', function()
  local HireMenu = {}

  local players = lib.callback.await('qb-bossmenu:getplayers')
  for _, v in pairs(players) do
    if v and v ~= cache.playerId then
      HireMenu[#HireMenu + 1] = {
        title = v.name,
        description = "Citizen ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
        serverEvent = 'qb-bossmenu:server:HireEmployee',
        args = v.sourceplayer
      }
    end
  end

  HireMenu[#HireMenu + 1] = {
    title = "Return",
    icon = 'fa-solid fa-angle-left',
    event = 'qb-bossmenu:client:OpenMenu'
  }

  lib.registerContext({
    id = 'qb_management_open_bossHire',
    title = "Hire Employees - " .. string.upper(PlayerJob.label),
    options = HireMenu
  })

  lib.showContext('qb_management_open_bossHire')
end)

RegisterNetEvent('qb-bossmenu:client:SocietyMenu', function()
  local SocietyMenu = {
    {
      title = "Return",
      icon = 'fa-solid fa-angle-left',
      event = 'qb-bossmenu:client:OpenMenu'
    }
  }

  lib.registerContext({
    id = 'qb_management_open_bossSociety',
    title = string.upper(PlayerJob.label),
    options = SocietyMenu
  })

  lib.showContext('qb_management_open_bossSociety')
end)

-- MAIN THREAD
CreateThread(function()
  for job, zones in pairs(Config.BossMenuZones) do
    for i = 1, #zones do
      local data = zones[i]
      exports.ox_target:addBoxZone({
        coords = data.coords,
        size = data.size,
        rotation = data.rotation,
        options = {
          {
            name = 'boss_menu',
            event = 'qb-bossmenu:client:OpenMenu',
            icon = "fa-solid fa-right-to-bracket",
            label = "Boss Menu",
            canInteract = function()
              return job == PlayerJob.name
            end
          }
        }
      })
    end
  end
end)

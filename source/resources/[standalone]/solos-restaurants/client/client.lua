local QBCore = exports['qb-core']:GetCoreObject()

local bankBalance = nil
local cashBalance = nil

local onduty = false

local labels = {}

CreateThread(function()
  for k, v in pairs(config.recipes) do
    labels[k] = exports.ox_inventory:Items(k).label
    for _, v2 in pairs(v['ingredients']) do
      print(v2.ingredient)
      labels[v2.ingredient] = exports.ox_inventory:Items(v2.ingredient).label
    end
  end
end)

--targets

--cook targets
CreateThread(function()
  for k, v in pairs(config.blips) do
    local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
    SetBlipSprite(blip, v.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.60)
    SetBlipColour(blip, v.colour)
    SetBlipAsShortRange(blip, true)
    AddTextEntry(k, v.name)
    BeginTextCommandSetBlipName(k)
    EndTextCommandSetBlipName(blip)
  end
  for k, v in pairs(config.locations) do
    for x, data in pairs(v) do
      local cookoptions = {
        {
          name = x,
          icon = 'fa-solid fa-kitchen-set',
          label = x:gsub("^%l", string.upper),
          onSelect = function(action, recipes)
            TriggerEvent('solos-food:client:openmenu', x, data.recipes, data.animdict, data.animation,
              data.flags, data.scenario, data.prop) -- ??
          end,
          groups = data.job,
        },
      }

      exports.ox_target:addBoxZone({
        coords = data.coords,
        size = data.size,
        rotation = data.rotation,
        debug = data.debugPoly,
        options = cookoptions,
      })
    end
  end
end)

--cash registers
-- CreateThread(function()
--   for k, data in pairs(config.cashregisters) do
--     local cashoptions = {
--       {
--         name = data.name,
--         icon = 'fa-solid fa-dollar',
--         label = 'Charge',
--         groups = data.job,
--         onSelect = function()
--           TriggerEvent('solos-cashier:client:chargecustomer', data.name, data.receipt)
--         end,
--       },
--       {
--         name = data.name,
--         icon = 'fa-solid fa-dollar',
--         label = 'Invoice',
--         groups = data.job,
--         onSelect = function()
--           TriggerEvent('solos-cashier:client:billcustomer', data.receipt)
--         end,
--       },
--       {
--         name = data.name,
--         icon = 'fa-solid fa-dollar',
--         label = 'Pay',
--         groups = data.job,
--         onSelect = function()
--           TriggerEvent('solos-cashier:client:pay', data.name, data.receipt)
--         end,
--       },
--     }

--     exports.ox_target:addBoxZone({
--       coords = data.coords,
--       size = data.size,
--       rotation = data.rotation,
--       options = cashoptions,
--     })
--   end
-- end)

--receipt redeem locations
CreateThread(function()
  for k, v in pairs(config.redeemlocations) do
    local receiptoptions = {
      {
        name = v.name,
        icon = 'fas fa-receipt',
        label = 'Redeem Receipt',
        distance = 1.1,
        onSelect = function()
          TriggerEvent('solos-cashier:client:redeem')
        end,
      },
    }
    if v.ped then
      local ped = GetHashKey(v.ped)
      RequestModel(ped)
      while not HasModelLoaded(ped) do
        Wait(1)
      end
      local ped = CreatePed(4, ped, v.coords.x, v.coords.y, v.coords.z - 1, v.heading, false, true)
      SetEntityHeading(ped, v.heading)
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      SetModelAsNoLongerNeeded(ped)

      exports.ox_target:addBoxZone({
        coords = v.coords,
        size = v.size,
        options = receiptoptions,
      })
    else
      exports.ox_target:addBoxZone({
        coords = v.coords,
        size = v.size,
        rotation = v.rotation,
        options = receiptoptions,
      })
    end
  end
end)

--tray targets
CreateThread(function()
  for k, data in pairs(config.trays) do
    local trayoptions = {
      {
        name = data.name,
        icon = 'fa solid fa-hand-holding',
        label = 'Open Tray',
        onSelect = function()
          exports.ox_inventory:openInventory('stash', data.id)
        end,
      },
    }

    exports.ox_target:addBoxZone({
      coords = data.coords,
      size = data.size,
      rotation = data.rotation,
      options = trayoptions,
    })
  end
end)

--storage targets
CreateThread(function()
  for k, data in pairs(config.storages) do
    local storageoptions = {
      {
        name = k,
        icon = 'fa-solid fa-box',
        label = "Open Storage",
        onSelect = function()
          exports.ox_inventory:openInventory('stash', data.id)
        end,
        groups = data.job,
      }
    }

    exports.ox_target:addBoxZone({
      coords = data.coords,
      size = data.size,
      rotation = data.rotation,
      options = storageoptions,
    })
  end
end)

local function setupDutyZones(job)
  for k, v in pairs(config.jobzones) do
    if job == v.job then
      local employeeoptions = {
        {
          name = v.name,
          icon = 'fa solid fa-sign-in-alt',
          label = 'Toggle Duty',
          onSelect = function()
            TriggerServerEvent('QBCore:ToggleDuty')
          end,
        }
      }
      if v.ped then
        local ped = GetHashKey(v.ped)
        RequestModel(ped)
        while not HasModelLoaded(ped) do
          Wait(1)
        end
        local ped = CreatePed(4, ped, v.coords.x, v.coords.y, v.coords.z - 1, v.heading, false, true)
        SetEntityHeading(ped, v.heading)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetModelAsNoLongerNeeded(ped)

        exports.ox_target:addBoxZone({
          coords = v.coords,
          size = v.size,
          options = employeeoptions,
        })
      else
        exports.ox_target:addBoxZone({
          coords = v.coords,
          size = v.size,
          rotation = v.rotation,
          options = employeeoptions,
        })
      end
    end
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  local playerData = QBCore.Functions.GetPlayerData()
  setupDutyZones(playerData.job.name)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
  setupDutyZones(job.name)
end)

--boss menus
CreateThread(function()
  for k, data in pairs(config.bossmenus) do
    local options = {
      {
        name = k,
        icon = 'fa-solid fa-person',
        label = "Open Boss Menu",
        onSelect = function()
          TriggerEvent('qb-bossmenu:client:OpenMenu')
        end,
        groups = data.job,
      }
    }

    exports.ox_target:addBoxZone({
      coords = data.coords,
      size = data.size,
      rotation = data.rotation,
      debugPoly = data.debugPoly,
      options = options,
    })
  end
end)

RegisterNetEvent('solos-food:client:openmenu', function(action, recipes, animdict, anim, flags, scenario, prop)
  local options = {}

  for _, v in ipairs(recipes) do
    local ingredients = 'You need:\n'
    for _, v2 in pairs(config.recipes[v].ingredients) do
      ingredients = ingredients .. ('%s - %d\n'):format(labels[v2.ingredient], v2.amount)
    end

    options[#options + 1] = {
      title = config.recipes[v].label:gsub("^%l", string.upper),
      description = ingredients,
      onSelect = function()
        TriggerEvent('solos-food:client:preparefood', {
          food = v,
          animdict = animdict,
          anim = anim,
          flags = flags,
          scenario = scenario,
          prop = prop,
        })
      end
    }
  end

  lib.registerContext({
    options = options,
    title = tostring(action:gsub("^%l", string.upper)),
    id = "openmenu_food"
  })
  lib.showContext("openmenu_food")
end)

RegisterNetEvent('solos-cashier:client:chargecustomer', function(name, receipt)
  local input = lib.inputDialog('Charge Customer ', { 'Purchase Amount' })

  if not input then return end
  TriggerServerEvent('solos-cashier:server:chargecustomer', input[1], name, receipt)
end)

RegisterNetEvent('solos-cashier:client:pay', function(name)
  lib.registerContext({
    id = 'pay_menu',
    title = 'How would you like to pay?',
    options = {
      {
        title = 'Cash',
        onSelect = function()
          TriggerServerEvent('solos-cashier:server:pay', 'cash', name)
        end,
      },
      {
        title = 'Bank',
        onSelect = function()
          TriggerServerEvent('solos-cashier:server:pay', 'bank', name)
        end,
      },
    }
  })

  lib.showContext('pay_menu')
end)

RegisterNetEvent('solos-cashier:client:bankbalance', function(balancebank, balancecash, moneytype, amount, id, receipt)
  bankBalance = balancebank
  cashBalance = balancecash
  if tostring(moneytype) == 'cash' then
    if tonumber(cashBalance) >= tonumber(amount) then
      TriggerServerEvent('solos-cashier:server:removemoney', moneytype, amount)
      --send receipt
      if receipt then
        TriggerServerEvent('solos-cashier:server:sendreceipt', id)
      end
      TriggerServerEvent('solos-cashier:server:society', id, amount)
    else
      TriggerEvent('solos-cashier:client:casherror')
      TriggerServerEvent('solos-cashier:server:paymentdeclined', id)
    end
  elseif tostring(moneytype) == 'bank' then
    if tonumber(bankBalance) >= tonumber(amount) then
      TriggerServerEvent('solos-cashier:server:removemoney', moneytype, amount)
      TriggerEvent('solos-cashier:client:bankpaid', amount)
      TriggerServerEvent('solos-cashier:server:society', id, amount)
      --send receipt
      if receipt then
        TriggerServerEvent('solos-cashier:server:sendreceipt', id)
      end
    else
      TriggerEvent('solos-cashier:client:bankerror')
      TriggerServerEvent('solos-cashier:server:paymentdeclined', id)
    end
  end
end)

RegisterNetEvent('solos-cashier:client:bill', function(moneytype, amount, id, receipt)
  TriggerServerEvent('solos-cashier:server:getbalances', moneytype, amount, id, receipt)
end)

RegisterNetEvent('solos-cashier:client:billcustomer', function() --invoice
  local input = lib.inputDialog('Send Invoice', { 'Server ID #', 'Invoice Amount $' })

  if not input then return end
  TriggerServerEvent('solos-cashier:server:qbinvoice', input[1], input[2])
end)

--receipts
RegisterNetEvent('solos-cashier:client:redeem', function()
  local job = QBCore.Functions.GetPlayerData().job.name
  local amount = nil

  local count = exports.ox_inventory:Search('count', 'receipt')

  for k, v in pairs(config.receiptpayouts) do
    local jobname = v.job
    if jobname == job then
      amount = v.payout
    end
  end

  if count >= 1 then
    TriggerServerEvent('solos-cashier:server:itemremove', 'receipt', 1)
    TriggerServerEvent('solos-cashier:server:addmoney', 'bank', amount)
    TriggerEvent('solos-cashier:client:moneydeposited', amount)
    TriggerServerEvent('solos-cashier:server:societyremove', amount)
  else
    TriggerEvent('solos-cashier:client:receipterror')
  end
end)

-- RegisterCommand('duty', function()
--     TriggerServerEvent('QBCore:ToggleDuty')
-- end)

-- RegisterCommand('boss', function()
--     if QBCore then
--         TriggerEvent('qb-bossmenu:client:OpenMenu')
--     elseif ESX then
--         TriggerEvent('esx_society:openBossMenu', 'cashier', function(data, menu)
--             menu.close()
--         end, {wash = false})
--     end
-- end)

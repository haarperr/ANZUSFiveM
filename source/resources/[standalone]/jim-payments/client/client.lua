local QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}
PlayerGang = {}

local onDuty = false
local BankPed = nil
local Targets = {}
local Till = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  QBCore.Functions.GetPlayerData(function(PlayerData)
    PlayerJob = PlayerData.job
    PlayerGang = PlayerData.gang
  end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerJob = JobInfo
  onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty) onDuty = duty end)
RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo) PlayerGang = GangInfo end)

--Keeps track of duty on script restarts
AddEventHandler('onResourceStart', function(resource)
  if GetCurrentResourceName() ~= resource then return end
  QBCore.Functions.GetPlayerData(function(PlayerData)
    PlayerJob = PlayerData.job
    PlayerGang = PlayerData.gang
    onDuty = PlayerJob.onduty
  end)
end)

CreateThread(function()
  local jobroles = {}
  local gangroles = {}
  --Build Job/Gang Checks for cashin location
  for k, v in pairs(Config.Jobs) do if v.gang then gangroles[tostring(k)] = 0 else jobroles[tostring(k)] = 0 end end
  --Create Target at location
  Targets["JimBank"] =
      exports['qb-target']:AddCircleZone("JimBank", vector3(Config.CashInLocation.x, Config.CashInLocation.y, Config.CashInLocation.z), 2.0,
        { name = "JimBank", debugPoly = Config.Debug, useZ = true, },
        {
          options = {
            { event = "jim-payments:Tickets:Menu", icon = "fas fa-receipt", label = Loc[Config.Lan].target["cashin_boss"], job = jobroles, },
            { event = "jim-payments:Tickets:Menu", icon = "fas fa-receipt", label = Loc[Config.Lan].target["cashin_gang"], gang = gangroles, } },
          distance = 2.0
        })

  --Crete Ped at the location
  if Config.Peds then
    if not Config.Gabz then CreateModelHide(vector3(Config.CashInLocation.x, Config.CashInLocation.y, Config.CashInLocation.z), 1.0, `v_corp_bk_chair3`, true) end
    BankPed = makePed(Config.PedPool[math.random(1, #Config.PedPool)], Config.CashInLocation, false, false)
  end

  --Spawn Custom Cash Register Targets
  for k, v in pairs(Config.CustomCashRegisters) do
    for i = 1, #v do
      local job = { k }
      local gang = nil
      if v[i].gang then
        gang = k
      end
      Targets["CustomRegister: " .. k .. i] = exports.ox_target:addBoxZone({
        coords = v[i].coords,
        size = v[i].size,
        rotation = v[i].rotation,
        debug = false,
        options = {
          {
            label = Loc[Config.Lan].target["charge"],
            icon = 'fas fa-credit-card',
            onSelect = function()
              TriggerEvent('jim-payments:client:Charge', { job = v[i].gang and nil or job, gang = gang })
            end,
            groups = job
          }
        },
      })
      if v[i].prop then
        Till[#Till + 1] = makeProp({ prop = `prop_till_03`, coords = v[i].coords }, 1, false)
      end
    end
  end
end)

RegisterNetEvent('jim-payments:client:Charge', function(data, outside)
  --Check if player is using /cashregister command
  if not outside and not onDuty and data.gang == nil then
    triggerNotify(nil, Loc[Config.Lan].error["not_onduty"], "error")
    return
  end
  local newinputs = {}
  if Config.List then
    --Retrieve a list of nearby players from server
    local onlineList = lib.callback.await('ag_payments:generatePlayerList', false)
    local nearbyList = {}

    local myCoords = GetEntityCoords(cache.ped)

    for _, v in pairs(QBCore.Functions.GetPlayersFromCoords(myCoords, Config.PaymentRadius)) do
      local dist = #(GetEntityCoords(GetPlayerPed(v)) - myCoords)
      for i = 1, #onlineList do
        if onlineList[i].value == GetPlayerServerId(v) then
          if v ~= cache.serverId or Config.Debug then
            nearbyList[#nearbyList + 1] = { value = onlineList[i].value, label = onlineList[i].text .. ' (' .. math.floor(dist + 0.05) .. 'm)' }
          end
        end
      end
    end

    --If list is empty(no one nearby) show error and stop
    if not nearbyList[1] then
      triggerNotify(nil, Loc[Config.Lan].error["no_one"], "error")
      return
    end
    newinputs[#newinputs + 1] = { label = "Citizen", type = "select", options = nearbyList, required = true }
  else -- If Config.List is false, create input text box for ID's
    newinputs[#newinputs + 1] = { type = 'input', required = true, label = "Citizen", description = Loc[Config.Lan].menu["cus_id"] }
  end
  --Check if image was given when opening the regsiter
  local img = data.img or ""
  --Continue adding payment options
  newinputs[#newinputs + 1] = {
    label = Loc[Config.Lan].menu["type"],
    type = "select",
    options = {
      {
        value = 'cash',
        label = Loc[Config.Lan].menu["cash"]
      },
      {
        value = 'bank',
        label = Loc[Config.Lan].menu["card"]
      }
    },
    required = true
  }
  newinputs[#newinputs + 1] = { type = 'number', required = true, label = Loc[Config.Lan].menu["amount_charge"], icon = 'hashtag' }
  --Grab Player Job name or Gang Name if needed
  local label = PlayerJob.label
  local gang = false
  if data.gang then
    label = PlayerGang.label
    gang = true
  end

  local input = lib.inputDialog(label .. Loc[Config.Lan].menu["cash_reg"], newinputs)
  if not input then return end

  local player = input[1]
  local type = input[2]
  local amount = input[3]
  if not player or not amount then return end
  TriggerServerEvent('jim-payments:server:Charge', player, amount, type, data.img, outside, gang)
end)

RegisterNetEvent('jim-payments:Tickets:Menu', function(data)
  --Get ticket info

  local amount = exports.ox_inventory:Search('count', 'commissionslip')

  if amount == 0 then
    triggerNotify(nil, Loc[Config.Lan].error["no_ticket"], "error")
    return
  end

  local totalAmount = 0
  local commissionCount = 0
  local slots = exports.ox_inventory:GetSlotsWithItem('commissionslip')

  for i = 1, #slots, 1 do
    if not slots[i].metadata.job then goto skip end
    totalAmount += Config.Jobs[slots[i].metadata.job].PayPerTicket
    commissionCount += 1
    ::skip::
  end


  if commissionCount == 0 then
    return lib.notify({type = 'error', description = 'You have invalid commission slips'})
  end

  --Check/adjust for job/gang names

  local input = lib.inputDialog("🧾 " .. Loc[Config.Lan].menu["receipt"], {
    { type = 'number', label = 'Comission Amount', default = amount,                                    disabled = true, icon = 'hashtag' },
    { type = 'number', label = 'Total Payment', default = totalAmount, disabled = true, icon = 'hashtag' },
  })

  if not input then return end
  TriggerServerEvent('jim-payments:Tickets:Sell')
end)

RegisterNetEvent("jim-payments:client:PayPopup", function(amount, biller, billtype, img, billerjob, gang, outside)
  local success = lib.inputDialog("🧾 " .. billerjob .. Loc[Config.Lan].menu["payment"], {
    { type = 'number', label = 'Charge',         default = amount,   disabled = true, icon = 'hashtag' },
    { type = 'input',  label = 'Payment Method', default = billtype, disabled = true },
  })

  if not success then return TriggerServerEvent('jim-payments:server:PayPopup', { accept = false, amount = amount, biller = biller, billtype = billtype, outside = outside }) end
  TriggerServerEvent('jim-payments:server:PayPopup', { accept = true, amount = amount, biller = biller, billtype = billtype, gang = gang, outside = outside })
end)

RegisterNetEvent("jim-payments:client:PolPopup", function(amount, biller, billerjob)
  local success = lib.inputDialog("🧾 " .. billerjob .. Loc[Config.Lan].menu["payment"], {
    { type = 'number', label = 'Charge',         default = amount, disabled = true, icon = 'hashtag' },
    { type = 'input',  label = 'Payment Method', default = 'bank', disabled = true },
  })

  if not success then return TriggerServerEvent('jim-payments:server:PolPopup', { accept = false, amount = amount, biller = biller }) end
  TriggerServerEvent('jim-payments:server:PolPopup', { accept = true, amount = amount, biller = biller })
end)

AddEventHandler('onResourceStop', function(r)
  if r ~= GetCurrentResourceName() then return end
  for k in pairs(Targets) do exports['qb-target']:RemoveZone(k) end
  for i = 1, #Till do DeleteEntity(Till[i]) end
  unloadModel(GetEntityModel(BankPed))
  DeletePed(BankPed)
end)

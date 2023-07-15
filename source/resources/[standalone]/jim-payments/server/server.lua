local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onResourceStart', function(resource)
  if GetCurrentResourceName() ~= resource then return end
  for k in pairs(Config.Jobs) do
    if not QBCore.Shared.Jobs[k] and not QBCore.Shared.Gangs[k] then
      print("Jim-Payments: Config.Jobs searched for job/gang '" .. k .. "' and couldn't find it in the Shared")
    end
  end
end)

QBCore.Commands.Add("cashregister", Loc[Config.Lan].command["cash_reg"], {}, false, function(source) TriggerClientEvent("jim-payments:client:Charge", source, {}, true) end)
-- QBCore.Commands.Add("polcharge", Loc[Config.Lan].command["charge"], {}, false, function(source) TriggerClientEvent("jim-payments:client:PolCharge", source) end)

local function giveTicket(data, biller, gang)
  local billed = QBCore.Functions.GetPlayer(source) -- This should always be from the person who accepted the payment
  local takecomm = math.floor(tonumber(data.amount) * Config.Jobs[data.society].Commission)
  if biller then                                    -- If this is found, it ISN'T a phone payment, so add money to society here
    if gang then
      if Config.RenewedBanking then
        exports['Renewed-Banking']:addAccountMoney(tostring(biller.PlayerData.gang.name), data.amount - takecomm)
        if Config.Debug then
          print("^5Debug^7: ^3Renewed-Banking^7(^3Gang^7): ^2Adding ^7$^6" ..
            data.amount - takecomm ..
            " ^2to account ^7'^6" .. tostring(biller.PlayerData.gang.name) .. "^7' ($^6" .. exports['Renewed-Banking']:getAccountMoney(biller.PlayerData.gang.name) .. "^7)")
        end
      else
        exports["qb-management"]:AddGangMoney(tostring(biller.PlayerData.gang.name), data.amount - takecomm)
        if Config.Debug then
          print("^5Debug^7: ^3QB-Management^7(^3Gang^7): ^2Adding ^7$^6" ..
            data.amount - takecomm ..
            " ^2to account ^7'^6" .. tostring(biller.PlayerData.gang.name) .. "^7' ($^6" .. exports["qb-management"]:GetGangAccount(biller.PlayerData.gang.name) .. "^7)")
        end
      end
    elseif not gang then
      if Config.RenewedBanking then
        exports['Renewed-Banking']:addAccountMoney(tostring(biller.PlayerData.job.name), data.amount - takecomm)
        if Config.Debug then
          print("^5Debug^7: ^3Renewed-Banking^7(^3Job^7): ^2Adding ^7$^6" ..
            data.amount - takecomm ..
            " ^2to account ^7'^6" .. tostring(biller.PlayerData.job.name) .. "^7' ($^6" .. tostring(exports['Renewed-Banking']:getAccountMoney(biller.PlayerData.job.name)) .. "^7)")
        end
      else
        exports["qb-management"]:AddMoney(tostring(biller.PlayerData.job.name), data.amount - takecomm)
        if Config.Debug then
          print("^5Debug^7: ^3QB-Management^7(^3Job^7): ^2Adding ^7$^6" ..
            data.amount - takecomm .. " ^2to account ^7'^6" .. tostring(biller.PlayerData.job.name) ..
            "^7' ($^6" .. exports["qb-management"]:GetAccount(biller.PlayerData.job.name) .. "^7)")
        end
      end
    end
  else
    local Player = QBCore.Functions.GetPlayerByCitizenId(data.senderCitizenId)
    if Player then biller = Player end
    triggerNotify(nil, data.sender .. Loc[Config.Lan].success["invoice_start"] .. data.amount .. Loc[Config.Lan].success["invoice_end"], "success", biller.PlayerData.source)
  end

  -- If ticket system enabled, do this
  if (biller.PlayerData.job.onduty or gang) and Config.TicketSystem then
    if data.amount >= Config.Jobs[data.society].MinAmountforTicket then
      exports.ox_inventory:AddItem(biller.PlayerData.source, 'commissionslip', 1, { job = biller.PlayerData.job.name })
      triggerNotify(nil, Loc[Config.Lan].success["rec_rec"], 'success', biller.PlayerData.source)
    end
  end

  -- Commission section, does each config option separately
  local comm = tonumber(Config.Jobs[data.society].Commission)
  if Config.Commission and comm ~= 0 then
    if Config.CommissionLimit and data.amount < Config.Jobs[data.society].MinAmountforTicket then return end
    if Config.CommissionDouble then
      biller.Functions.AddMoney("bank", math.floor(tonumber(data.amount) * (comm * 2)))
      triggerNotify(nil, Loc[Config.Lan].success["recieved"] .. math.floor(tonumber(data.amount) * (comm * 2)) .. Loc[Config.Lan].success["commission"], "success",
        biller.PlayerData.source)
    else
      biller.Functions.AddMoney("bank", math.floor(tonumber(data.amount) * comm))
      triggerNotify(nil, Loc[Config.Lan].success["recieved"] .. math.floor(tonumber(data.amount) * comm) .. Loc[Config.Lan].success["commission"], "success",
        biller.PlayerData.source)
    end
    if Config.CommissionAll then
      for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player and Player ~= biller then
          if Player.PlayerData.job.name == data.society and Player.PlayerData.job.onduty then
            Player.Functions.AddMoney("bank", math.floor(tonumber(data.amount) * comm))
            triggerNotify(nil, Loc[Config.Lan].success["recieved"] .. math.floor(tonumber(data.amount) * comm) .. Loc[Config.Lan].success["commission"], "success",
              Player.PlayerData.source)
          end
        end
      end
    end
  end
end

RegisterServerEvent('jim-payments:Tickets:Sell', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(source)

  local count = exports.ox_inventory:Search(src, 'count', 'commissionslip')

  if count == 0 then
    triggerNotify(nil, Loc[Config.Lan].error["no_ticket_to"], 'error', source)
    return
  end

  local items = exports.ox_inventory:GetSlotsWithItem(src, 'commissionslip')

  local cnt = 0
  for i = 1, #items, 1 do
    local v = items[i]
    if v.metadata.job then
      local success, _ exports.ox_inventory:RemoveItem(src, 'commissionslip', 1, {}, v.slot)
      if success then
        Player.Functions.AddMoney('cash', Config.Jobs[v.metadata.job].PayPerTicket)
        cnt += 1

        lib.logger(src, 'Tickets:Sell',
        {
          message = ('Commission %d for handing in slip'):format(Config.Jobs[v.metadata.job].PayPerTicket),
          amount = Config.Jobs[v.metadata.job].PayPerTicket,
          job = v.metadata.job,
          currency = 'cash',
          type = 'added'
        }, 'economy:commissionslip')
      end
    end
  end

  if cnt == 0 then
    TriggerClientEvent('ox_lib:notify', src, {type = 'warning', description = 'You have no commission tickets to hand in'})
  end
end)

QBCore.Functions.CreateCallback('jim-payments:Ticket:Count', function(source, cb)
  cb(QBCore.Functions.GetPlayer(source).Functions.GetItemByName('commissionslip'))
end)

RegisterServerEvent("jim-payments:server:Charge", function(citizen, price, billtype, img, outside, gang)
  local src = source
  local biller = QBCore.Functions.GetPlayer(src)
  local billed = QBCore.Functions.GetPlayer(tonumber(citizen))
  local amount = tonumber(price)

  local balance = billed.Functions.GetMoney(billtype)
  if amount and amount > 0 then
    if balance < amount then
      triggerNotify(nil, Loc[Config.Lan].error["customer_nocash"], "error", src)
      triggerNotify(nil, Loc[Config.Lan].error["you_nocash"], "error", tonumber(citizen))
      return
    end
    local label = biller.PlayerData.job.label
    if gang == true then label = biller.PlayerData.gang.label end
    if Config.PhoneBank == false or gang == true or billtype == "cash" then
      TriggerClientEvent("jim-payments:client:PayPopup", billed.PlayerData.source, amount, src, billtype, img, label, gang, outside)
    else
      if Config.PhoneType == "qb" then
        MySQL.Async.insert(
          'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',
          { billed.PlayerData.citizenid, amount, biller.PlayerData.job.name, biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid }, function(id)
            if id then
              TriggerClientEvent('qb-phone:client:AcceptorDenyInvoice', billed.PlayerData.source, id, biller.PlayerData.charinfo.firstname, biller.PlayerData.job.name,
                biller.PlayerData.citizenid, amount, GetInvokingResource())
            end
          end)
        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
      elseif Config.PhoneType == "gks" then
        MySQL.Async.execute(
          'INSERT INTO gksphone_invoices (citizenid, amount, society, sender, sendercitizenid, label) VALUES (@citizenid, @amount, @society, @sender, @sendercitizenid, @label)', {
            ['@citizenid'] = billed.PlayerData.citizenid,
            ['@amount'] = amount,
            ['@society'] = biller.PlayerData.job.name,
            ['@sender'] = biller.PlayerData.charinfo.firstname,
            ['@sendercitizenid'] = biller.PlayerData.citizenid,
            ['@label'] = biller.PlayerData.job.label,
          })
        TriggerClientEvent('gksphone:notifi', src, { title = 'Billing', message = Loc[Config.Lan].success["inv_succ"], img = '/html/static/img/icons/logo.png' })
        TriggerClientEvent('gksphone:notifi', billed.PlayerData.source,
          { title = 'Billing', message = Loc[Config.Lan].success["inv_recieved"], img = '/html/static/img/icons/logo.png' })
      end
      triggerNotify(nil, Loc[Config.Lan].success["inv_succ"], 'success', src)
      triggerNotify(nil, Loc[Config.Lan].success["inv_recieved"], nil, billed.PlayerData.source)
    end
  else
    triggerNotify(nil, Loc[Config.Lan].error["charge_zero"], 'error', source)
    return
  end
end)

RegisterServerEvent("jim-payments:server:PayPopup", function(data)
  local src = source
  local billed = QBCore.Functions.GetPlayer(src)
  local biller = QBCore.Functions.GetPlayer(tonumber(data.biller))
  local newdata = { senderCitizenId = biller.PlayerData.citizenid, society = biller.PlayerData.job.name, amount = data.amount }
  if data.gang == true then newdata.society = biller.PlayerData.gang.name end
  if data.accept == true then
    billed.Functions.RemoveMoney(tostring(data.billtype), data.amount)
    if Config.ApGov then exports['ap-government']:chargeCityTax(billed.PlayerData.source, "Item", data.amount) end
    giveTicket(newdata, biller, data.gang)
    triggerNotify(nil, billed.PlayerData.charinfo.firstname .. Loc[Config.Lan].success["accepted_pay"] .. data.amount .. Loc[Config.Lan].success["payment"], "success", data.biller)
  elseif data.accept == false then
    triggerNotify(nil, Loc[Config.Lan].success["declined"], nil, src)
    triggerNotify(nil, billed.PlayerData.charinfo.firstname .. Loc[Config.Lan].error["decline_pay"] .. data.amount .. Loc[Config.Lan].success["payment"], "error", data.biller)
  end
end)

lib.callback.register('ag_payments:generatePlayerList', function()
  local onlineList = {}
  for _, v in pairs(QBCore.Functions.GetPlayers()) do
    local P = QBCore.Functions.GetPlayer(v)
    onlineList[#onlineList + 1] = { value = tonumber(v), text = "[" .. v .. "] - " .. P.PlayerData.charinfo.firstname .. ' ' .. P.PlayerData.charinfo.lastname }
  end

  return onlineList
end)

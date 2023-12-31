CreateThread(function()
  local timeout = 60000 * QBCore.Config.UpdateInterval
  while true do
    Wait(timeout)

    for src, Player in pairs(QBCore.Players) do
      if Player then
        local newHunger = Player.PlayerData.metadata.hunger - QBCore.Config.Player.HungerRate
        local newThirst = Player.PlayerData.metadata.thirst - QBCore.Config.Player.ThirstRate
        if newHunger <= 0 then
          newHunger = 0
        end
        if newThirst <= 0 then
          newThirst = 0
        end
        Player.Functions.SetMetaData('thirst', newThirst)
        Player.Functions.SetMetaData('hunger', newHunger)
        TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst)
        Player.Functions.Save()
      end
    end
  end
end)

CreateThread(function()
  local timeout = 60000 * QBCore.Config.Money.PaycheckTimeout
  while true do
    Wait(timeout)

    for _, Player in pairs(QBCore.Players) do
      if Player then
        local payment = QBShared.Jobs[Player.PlayerData.job.name].grades[Player.PlayerData.job.grade.level].payment or 0
        if not payment then payment = Player.PlayerData.job.payment end
        if Player.PlayerData.job and payment > 0 and (QBShared.Jobs[Player.PlayerData.job.name].offDutyPay or Player.PlayerData.job.onduty) then
          local currentPayslip = Player.PlayerData.metadata.payslip
          if QBCore.Config.Money.PayCheckSociety then
            local account = exports['qb-management']:GetAccount(Player.PlayerData.job.name)
            if account ~= 0 then        -- Checks if player is employed by a society
              if account < payment then -- Checks if company has enough money to pay society
                TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('error.company_too_poor'), 'error')
              else
                Player.Functions.SetMetaData('payslip', currentPayslip + payment)
                exports['qb-management']:RemoveMoney(Player.PlayerData.job.name, payment)
                TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', { value = payment }))
              end
            else
              Player.Functions.SetMetaData('payslip', currentPayslip + payment)
              TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', { value = payment }))
            end
          else
            Player.Functions.SetMetaData('payslip', currentPayslip + payment)
            TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('info.received_paycheck', { value = payment }))
          end

          lib.logger(Player.PlayerData.source, 'Paycheck',
            { message = ('Received %s'):format(payment), amount = payment, type = 'added', currency = 'cash' }, 'economy:paycheck')
        end
      end
    end
  end
end)

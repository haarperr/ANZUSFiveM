lib.locale()
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ag_paycheck:server:claimPaycheck', function()
  local src = source
  local player = QBCore.Functions.GetPlayer(src)
  if not player then return end

  local paycheckAmount = player.PlayerData.metadata.payslip
  if paycheckAmount <= 0 then return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('no_paycheck') }) end

  player.Functions.SetMetaData('payslip', 0)
  player.Functions.AddMoney('cash', paycheckAmount)

  lib.logger(src, 'claimPaycheck', { message = ('Claimed %s as a paycheck'):format(paycheckAmount), type = 'added', currency = 'cash' })
end)

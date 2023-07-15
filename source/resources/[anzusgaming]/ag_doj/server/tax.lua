local db = require 'server.db'
local taxRate = 0

---@param source any
---@param data {rate: number}
---@return boolean
lib.callback.register('ag_doj:SetTaxRate', function(source, data)
  if not data.rate then return false end
  local player = Player(source).state
  if player.job.name ~= 'gov' or data.rate <= -1 or data.rate > 100 then return false end
  local oldRate = taxRate * 100

  ---@diagnostic disable-next-line: param-type-mismatch
  local success = db.setSetting('tax_rate', data.rate)

  if success <= 0 then return false end

  GlobalState:set('tax', data.rate, true)
  taxRate = data.rate / 100

  TriggerClientEvent('ox_lib:notify', -1,
    {
      type = 'info',
      title = 'Department of Justice',
      description = string.format('The tax rate has been changed from %s%% to %s%%', oldRate, data.rate),
      icon = 'scale-balanced',
      duration = 10000
    })

  lib.logger(source, 'SetTaxRate', { ('Set %d from %d'):format(data.rate, oldRate), old = oldRate, new = data.rate }, 'economy:tax')
  return true
end)

function SetTaxOnStart()
  local tax = db.getSetting('tax_rate')

  GlobalState:set('tax', tax.value, true)
  taxRate = tonumber(tax.value) / 100
end

local taxedAmount = 0

exports.ox_inventory:registerHook('buyItem', function(payload)
  if taxRate > 0 then
    local total = payload.totalPrice * taxRate
    if total <= 0 then return true end
      taxedAmount += total
  end
  return true
end, {})

lib.cron.new('*/30 * * * *', function (task, date)
  local a = taxedAmount
  taxedAmount = 0
    exports.pefcl:addBankBalanceByIdentifier(-1,
      { identifier = 'gov', amount = a, message = string.format('VAT received from purchases') })
end)
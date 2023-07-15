Tax = {}
local zone = nil
local GlobalState = GlobalState

local function changeTax()
  local input = lib.inputDialog('Change Tax', {
    { type = 'number', label = 'Rate', default = GlobalState.tax, max = 100, min = 1, icon = 'percent' },
  })

  if not input then return end
  local success = lib.callback.await('ag_doj:SetTaxRate', 200, { rate = input[1] })

  if not success then return lib.notify({ type = 'error', title = 'Department of Justice', description = 'There was an error processing your request' }) end

  lib.notify({ type = 'success', title = 'Department of Justice', description = 'The tax rate has successfully been updated' })
end

local function openMenu()
  lib.registerContext({
    id = 'tax_management',
    title = 'Tax Mangement',
    options = {
      {
        title = string.format('Current Tax: %s%%', GlobalState.tax),
        icon = 'chart-line'
      },
      {
        title = 'Change Tax',
        icon = 'file-invoice',
        onSelect = function()
          changeTax()
        end
      },
    }
  })
  lib.showContext('tax_management')
end

function SetupTaxZones()
  zone = exports.ox_target:addBoxZone({
    coords = Config.Tax.computer.coords,
    size = Config.Tax.computer.size,
    rotation = Config.Tax.computer.rotation,
    options = {
      {
        name = 'agdoj:TaxComputer',
        icon = 'fa-solid fa-cube',
        label = 'Tax Computer',
        onSelect = function()
          openMenu()
        end,
      }
    }
  })
end

function DestroyTaxZones()
  if zone ~= nil then
    exports.ox_target:removeZone(zone)
    zone = nil
  end
end

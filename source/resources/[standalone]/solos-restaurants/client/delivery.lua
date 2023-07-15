local active = false
local object = nil

---@param data {index: string, ingredient: string, total: number}
RegisterNetEvent('solos-restaurants:client:receiveIngredientUpdate', function(data)
  config.delivery[data.index].items[data.ingredient].total = data.total
end)

---@param index string
---@param ingredient string
---@param toOrder number
local function createPickup(index, ingredient, toOrder)
  local pickup = config.delivery[index].pickup

  local obj = CreateObject(pickup.model, pickup.coords.x, pickup.coords.y, pickup.coords.z, false, false, false)
  FreezeEntityPosition(obj, true)
  object = {
    object = obj,
    zone = exports.ox_target:addSphereZone({
      coords = pickup.coords,
      radius = 0.4,
      options = {
        {
          groups = index,
          label = 'Pickup Crate',
          icon = 'fa-solid fa-box',
          onSelect = function()
            TriggerServerEvent('solos-restaurants:server:pickupCrate', index, ingredient, toOrder)
            lib.notify({ type = 'info', description = 'Now lets head back to the resturant and put this in the fridge!' })
            DeleteObject(object.object)
            exports.ox_target:removeZone(object.zone)
            active = false
            object = nil
          end
        }
      }
    })
  }
end

---@param index string
---@param ingredient string
local function orderIngredient(index, ingredient)
  active = true
  local data = config.delivery[index].items[ingredient]

  if not data then return end -- shouldn't happen but good check incase anyway

  lib.hideContext()
  local amount = lib.inputDialog(('Order %s'):format(ingredient), {
    { type = 'number', label = 'Amount', max = data.total, required = true, min = 1 }
  })

  if not amount then
    active = false
    return
  end
  local toOrder = tonumber(amount[1])

  if toOrder > data.total then
    active = false
    return lib.notify({ type = 'error', description = 'You cannot order more than we have in stock' })
  end

  lib.callback('solos-restaurants:orderIngredient', false, function(res)
    if not res then return lib.notify({ type = 'error', description = 'You do not have enough funds on you' }) end
    lib.notify({ type = 'info', description = 'Order has been placed' })

    Wait(2500)
    createPickup(index, ingredient, toOrder)
    lib.notify({ type = 'info', description = 'Ingredients are ready for pickup, route placed on GPS' })
    SetNewWaypoint(config.delivery[index].pickup.coords.x, config.delivery[index].pickup.coords.y)
  end, { index = index, ingredient = ingredient, total = data.total - toOrder })
end

---@param index string
local function orderMenu(index)
  local options = {}

  for k, v in pairs(config.delivery[index].items) do
    options[#options + 1] = {
      title = v.title,
      description = ('$%d - %d left'):format(v.price, v.total),
      disabled = active or v.total == 0,
      onSelect = function()
        orderIngredient(index, k)
      end
    }
  end

  lib.registerContext({
    id = ('%s_order_menu'):format(index),
    title = 'Ingredient Ordering',
    options = options
  })

  lib.showContext(('%s_order_menu'):format(index))
end

---@param job string
function SetupDeliveryZones(job)
  for k, v in pairs(config.delivery) do
    if job == k then
      exports.ox_target:addBoxZone({
        coords = v.zone.coords,
        radius = v.zone.radius,
        rotation = v.zone.rotation,
        options = {
          {
            groups = k,
            label = 'Order Ingredients',
            icon = 'fa-solid fa-bars',
            onSelect = function()
              orderMenu(k)
            end
          }
        }
      })
    end
  end
end

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  if object == nil then return end
  -- Cleanup
  exports.ox_target:removeZone(object.zone)
  DeleteObject(object.object)
end)

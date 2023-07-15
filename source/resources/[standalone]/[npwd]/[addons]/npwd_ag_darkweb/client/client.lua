local ped = nil

RegisterNUICallback("npwd:ag_darkweb:checkout", function(data, cb)

  local sum = 0

  for i = 1, #data, 1 do
    sum += (data[i].amount * data[i].price)
  end

  local input = lib.inputDialog('Crypto Secure Login', {
    { type = 'input', label = 'Key Phrase', required = true, password = true },
  })
  if not input then return cb({ status = "ok", data = res }) end

  lib.callback('ag_crypto:checkWalletByPasscode', false, function(wallet)
    if not wallet or not wallet.value or not wallet.wallet then
      lib.notify({ type = 'error', title = 'Crypto Exchange', description = 'Invalid key phrase' })
      return cb({ status = "ok", data = res })
    end

    if wallet.value < sum then
      lib.notify({ type = 'error', title = 'Crypto Exchange', description = 'Insufficient funds in the wallet' })
      return cb({ status = "ok", data = res })
    else
      lib.callback('npwd:ag_darkweb:checkout', false, function(res)
        cb({ status = "ok", data = res })
      end, data, wallet)
    end
  end, input[1])
end)


RegisterNUICallback("npwd:ag_darkweb:getItems", function(_, cb)
  lib.callback('npwd:ag_darkweb:getItems', false, function(res)
    cb({ status = "ok", data = res })
  end)
end)

local function openPickup()
  local ready = lib.callback.await('ag_darkweb:getReadyPickup', false)

  if #ready == 0 then return lib.notify({ type = 'error', description = 'You do not have anything to pickup' }) end
  local options = {}

  for i = 1, #ready, 1 do
    local item = ready[i]
    options[#options + 1] = {
      title = item.label,
      description = ('Amount: %d'):format(item.amount),
      disabled = true
    }
  end

  options[#options + 1] = {
    title = 'Pickup all',
    onSelect = function()
      if lib.progressActive() then return end
      local success = lib.progressCircle({
        duration = 5000,
        canCancel = true,
        disable = {
          move = true,
          combat = true,
          car = true
        },
        anim = {
          dict = "mp_common",
          clip = "givetake1_a"
        }
      })
      if not success then return end
      TriggerServerEvent('ag_darkweb:pickupItems')
    end
  }

  lib.registerContext({
    id = 'ag_darkweb:pickupPurchase',
    title = 'Pickup Purchases',
    options = options
  })

  lib.showContext('ag_darkweb:pickupPurchase')
end

---@param data {coords: vector4}
RegisterNetEvent('ag_darkweb:spawnPed', function(data)
  local coords = data.coords
  if ped then return end

  local vec = vec3(coords.x, coords.y, coords.z)

  CreateThread(function()
    local pedCoords = GetEntityCoords(cache.ped)
    while #(pedCoords - vec) > 150 do
      pedCoords = GetEntityCoords(cache.ped)
      Wait(100)
    end

    local _, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)

    lib.requestModel(Config.Pickup.ped)
    ped = CreatePed(0, Config.Pickup.ped, coords.x, coords.y, groundZ, coords.w, false, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)

    exports.ox_target:addLocalEntity({ ped }, {
      {
        label = 'Pickup Delivery',
        distance = 1,
        onSelect = openPickup
      }
    })
  end)
end)

RegisterNetEvent('ag_darkweb:deletePed', function()
  if ped == nil then return end
  DeleteEntity(ped)
end)

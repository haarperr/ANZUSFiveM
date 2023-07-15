local ped
local isSelling = false

local function sell(key, value, all)
  isSelling = true
  local amount = 0

  if not all then
    local input = lib.inputDialog(('Sell %s'):format(value.label), {
      { type = 'number', label = 'Amount', description = 'Amount to sell', max = items, icon = 'hashtag' },
    })

    if not input then return end

    ---@diagnostic disable-next-line: cast-local-type
    amount = tonumber(input[1])
  end

  lib.callback('ag_fishing:server:canSellFish', false, function(res)
    if not res then return lib.notify({ type = 'error', title = locale('notify_title'), description = locale('not_enough_fish') }) end
    TaskTurnPedToFaceEntity(ped, cache.ped, 1.0)
    TaskTurnPedToFaceEntity(cache.ped, ped, 1.0)
    Wait(1500)
    PlayPedAmbientSpeechNative(ped, "Generic_Hi", "Speech_Params_Force")
    Wait(1000)

    FreezeEntityPosition(cache.ped, true)

    lib.requestAnimDict('mp_safehouselost@')
    TaskPlayAnim(cache.ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, false, false, false)
    Wait(4000)

    TriggerServerEvent('ag_fishing:server:sellFish', { item = key, amount = amount })

    PlayPedAmbientSpeechNative(ped, "Chat_State", "Speech_Params_Force")
    Wait(500)
    TaskPlayAnim(ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, false, false, false)
    Wait(3000)

    FreezeEntityPosition(cache.ped, false)
    isSelling = false
  end, { item = key, amount = amount })
end


local function openSell()
  -- Anti spam
  if isSelling then return end

  local options = {}

  for key, value in pairs(Config.SellPrices) do
    local items = exports.ox_inventory:Search('count', key)
    options[#options + 1] = {
      title = value.label,
      description = ('Value: $%d/per | You have: %d'):format(value.price, items),
      disabled = items == 0,
      onSelect = function()
        sell(key, value, false)
      end
    }
  end

  options[#options + 1] = {
    title = 'Sell All',
    onSelect = function()
      TriggerServerEvent('ag_fishing:server:sellFish', { item = 'all' })

      sell('all', nil, true)
    end,
  }

  lib.registerContext({
    id = 'fish_sell_market',
    title = 'Sell Your Fish',
    options = options
  })

  lib.showContext('fish_sell_market')
end

function SetupSell()
  lib.requestModel(Config.SellPed)

  local blip = AddBlipForCoord(Config.SellLocation.x, Config.SellLocation.y, Config.SellLocation.z)
  SetBlipSprite(blip, 628)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.7)
  SetBlipAsShortRange(blip, true)
  SetBlipColour(blip, 3)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName("Fish Market")
  EndTextCommandSetBlipName(blip)

  ped = CreatePed(5, Config.SellPed, Config.SellLocation.x, Config.SellLocation.y, Config.SellLocation.z, Config.SellLocation.w, false, false)
  FreezeEntityPosition(ped, true)
  SetEntityInvincible(ped, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)

  exports.ox_target:addLocalEntity({ ped }, {
    {
      label = 'Sell',
      icon = 'fas fa-hand-holding-dollar',
      onSelect = function()
        openSell()
      end,
      distance = 1.5
    }
  })
end

lib.locale()

local entitiesDone = {}

local function hasAxe()
  local ped = cache.ped
  local selectedWeapon = GetSelectedPedWeapon(ped)

  if selectedWeapon == `weapon_battleaxe` then return true end

  return false
end

local function chopTree(data)
  if not hasAxe() then return lib.notify({ type = 'error', title = 'Lumberjacking', description = locale('need_axe') }) end
  if entitiesDone[data.entity] then return end
  if lib.progressActive() then return end

  local success = lib.progressCircle({
    duration = Config.ChopDuration,
    label = locale('chopping_tree'),
    canCancel = true,
    disable = {
      move = true,
      combat = true,
      car = true
    },
    anim = {
      dict = "melee@hatchet@streamed_core",
      clip = "plyr_rear_takedown_b"
    }
  })

  if not success then return end
  TriggerServerEvent('ag_lumberjack:server:chopTree', NetworkGetNetworkIdFromEntity(data.entity))
  entitiesDone[data.entity] = true
end

local function setupTreeTarget()
  exports.ox_target:addModel(Config.TreeModels, {
    {
      label = locale('chop_tree'),
      icon = 'fa fa-hand',
      onSelect = chopTree,
      canInteract = function(entity)
        if lib.progressActive() then return end
        if entitiesDone[entity] then return false end
        return true
      end
    }
  })
end
local function processLumber()
  if lib.progressActive() then return end
  local hasEnough = false

  for key, value in pairs(Config.Processer.items) do
    local count = exports.ox_inventory:Search('count', key)
    if count < value.required then goto skip end

    hasEnough = true

    ::skip::
  end

  if not hasEnough then return lib.notify({ type = 'error', title = 'Lumberjacking', description = 'You do not have enough items to process' }) end

  local success = lib.progressCircle({
    duration = Config.ProcessDuration,
    label = locale('processing_lumber'),
    canCancel = true,
    disable = {
      move = true,
      combat = true,
      car = true
    },
    anim = {
      dict = "missheistdockssetup1ig_10@base",
      clip = "talk_pipe_base_worker3"
    }
  })

  if not success then return end


  TriggerServerEvent('ag_lumberjack:server:processLumber')
end

local function setupProcesserPeds()
  lib.requestModel(Config.Processer.ped)
  local netids = lib.callback.await('ag_lumberjack:getProcesserPeds', false)

  for i = 1, #netids, 1 do
    local entity = NetworkGetEntityFromNetworkId(netids[i])
    SetBlockingOfNonTemporaryEvents(entity, true)
    SetEntityInvincible(entity, true)
  end

  exports.ox_target:addEntity(netids, {
    {
      label = locale('process_lumber'),
      icon = 'fa fa-hand',
      distance = 2.0,
      onSelect = function()
        lib.registerContext({
          id = 'process_lumber',
          title = locale('lumber_mill'),
          options = {
            {
              title = locale('process_lumber'),
              onSelect = processLumber
            }
          }
        })

        lib.showContext('process_lumber')
      end
    }
  })
end

local function setupSellPed()
  lib.requestModel(Config.Seller.ped)
  local netids = lib.callback.await('ag_lumberjack:getSellerPeds', false)

  for i = 1, #netids, 1 do
    local entity = NetworkGetEntityFromNetworkId(netids[i])
    SetBlockingOfNonTemporaryEvents(entity, true)
    SetEntityInvincible(entity, true)
  end

  exports.ox_target:addEntity(netids, {
    {
      label = locale('sell'),
      icon = 'fa fa-hand',
      distance = 2.0,
      onSelect = function()
        local options = {}

        for item, value in pairs(Config.Seller.items) do
          options[#options + 1] = {
            title = value.label,
            description = ('Value: $%d/per'):format(value.price),
            onSelect = function()
              TriggerServerEvent('ag_lumberjack:server:sell', { item = item })
            end,
          }
        end

        lib.registerContext({
          id = 'sell_lumber',
          title = locale('sell'),
          options = options
        })

        lib.showContext('sell_lumber')
      end
    }
  })
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  local config = lib.callback.await('ag_lumberjack:getSellerConfig', false)
  Config.Seller = config

  setupTreeTarget()
  Wait(1000)
  setupProcesserPeds()
  setupSellPed()
end)


CreateThread(function()
  local config = lib.callback.await('ag_lumberjack:getSellerConfig', false)
  Config.Seller = config

  setupTreeTarget()
  Wait(1000)
  setupProcesserPeds()
  setupSellPed()
end)


CreateThread(function()
  while true do
    entitiesDone = {}
    Wait(Config.Reset)
  end
end)

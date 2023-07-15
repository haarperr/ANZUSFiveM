lib.locale()
QBCore = exports['qb-core']:GetCoreObject()

local canFish = true
local isFishing = false
local zones = {}

local function getRandomKeys()
  local result = {}
  local configKeys = Config.Keys
  for i = 1, 4 do
    local rand = math.random(1, #configKeys)
    result[#result + 1] = configKeys[rand]
    table.remove(configKeys, rand)
  end

  return result
end

local keys = getRandomKeys()

--- Method to perform fishing animation
--- @return nil
local function fishAnimation()
  -- Remove Fishing Bait
  TriggerServerEvent('ag_fishing:server:RemoveBait')

  -- Throw Bait Animation
  local ped = cache.ped
  lib.requestAnimDict('mini@tennis')
  TaskPlayAnim(ped, 'mini@tennis', 'forehand_ts_md_far', 1.0, -1.0, 1.0, 48, 0, false, false, false)
  while IsEntityPlayingAnim(ped, 'mini@tennis', 'forehand_ts_md_far', 3) do Wait(0) end

  -- Fish Animation
  lib.notify({ type = 'success', title = locale('notify_title'), description = locale('line_dropped'), duration = 2500 })
  Wait(math.random(Config.CastTimeMin, Config.CastTimeMax) * 1000)

  -- Minigame

  local success = lib.skillCheck(Config.MinigameDifficulties, keys)

  if success then
    TriggerServerEvent('ag_fishing:server:ReceiveFish')
  else
    lib.notify({ type = 'error', title = locale('notify_title'), description = locale('fish_got_away') })
  end

  -- Finishing up
  local position = GetEntityCoords(cache.ped)
  ClearPedTasks(cache.ped)
  ClearAreaOfObjects(position.x, position.y, position.z, 2.0, 0)
  isFishing = false
end

-- Check if the player is looking at water
local function isLookingAtWater()
  local ped = PlayerPedId()
  local pedPos = GetEntityCoords(ped)

  local forwardVector = GetEntityForwardVector(ped)
  local forwardPos = vector3(pedPos.x + forwardVector.x * 10, pedPos.y + forwardVector.y * 10, pedPos.z)

  lib.requestModel(`a_c_fish`)

  local fishHandle = CreatePed(1, `a_c_fish`, forwardPos.x, forwardPos.y, forwardPos.z, 0.0, false, false)
  SetEntityAlpha(fishHandle, 0, true)

  lib.notify({ type = 'info', title = locale('notify_title'), description = locale('checking_location') })
  Wait(3000)

  local fishInWater = IsEntityInWater(fishHandle)
  DeleteEntity(fishHandle)
  SetModelAsNoLongerNeeded(`a_c_fish`)

  return fishInWater
end

local function useFishingRod(slot)
  if not canFish or isFishing then return end
  canFish = false

  local waterValidated = isLookingAtWater()
  canFish = true
  if not waterValidated then return lib.notify({ type = 'error', title = locale('notify_title'), description = locale('cant_fish_here') }) end

  local hasItem = exports.ox_inventory:Search('count', 'fishingbait')
  if hasItem == 0 then return lib.notify({ type = 'error', title = locale('notify_title'), description = locale('no_fishing_rod_or_bait') }) end

  TaskStartScenarioInPlace(cache.ped, "WORLD_HUMAN_STAND_FISHING", 0, false)

  TriggerServerEvent('ag_fishing:server:decreaseDurability', slot)
  -- Start Fishing
  isFishing = true
  fishAnimation()
end

exports('useFishingRod', useFishingRod)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  SetupSell()

  local conf = lib.callback.await('ag_fishing:getSellPrices', false)
  Config.SellPrices = conf
end)


RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  for i = 1, #zones, 1 do
    zones[i]:remove()
  end
end)

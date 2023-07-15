math.randomseed(os.time())

local ox_inventory = exports.ox_inventory
GlobalState:set('registerCooldown', false, true)
GlobalState:set('safeCooldown', false, true)

-- Function to check the players distance to registers/safes/etc
local function checkPlayerDistance(source)
  local ped = GetPlayerPed(source)
  local playerPos = GetEntityCoords(ped)
  for _, locations in pairs(Config.Locations) do
    for _, location in pairs(locations) do
      local distance = #(playerPos - location)
      if distance < 5 then
        return true
      end
    end
  end
  return false
end

-- Function that handles the register cooldowns
local function registerCooldown()
  GlobalState.registerCooldown = true
  GlobalState:set('registerCooldown', true, true)
  local cooldown = math.random(Config.RegisterMinCooldown * 60000, Config.RegisterMaxCooldown * 60000)
  local format = cooldown / 1000 / 60
  local cooldownRound = math.floor(format)
  print('24/7 register robbery cooldown now active for ' .. cooldownRound .. ' minutes')
  Wait(cooldown)
  print('24/7 register robbery cooldown now inactive')
  GlobalState:set('registerCooldown', false, true)
end

-- Function that handles the safe cooldowns
local function safeCooldown()
  GlobalState:set('safeCooldown', true, true)
  local cooldown = math.random(Config.SafeMinCooldown * 60000, Config.SafeMaxCooldown * 60000)
  local format = cooldown / 1000 / 60
  local cooldownRound = math.floor(format)
  print('24/7 safe robbery cooldown now active for ' .. cooldownRound .. ' minutes')
  Wait(cooldown)
  print('24/7 safe robbery cooldown now inactive')
  GlobalState:set('safeCooldown', false, true)
end

-- Function that rewards the player upon a successful register robbery
lib.callback.register('lation_247robbery:registerSuccessful', function(source, verifyReward)
  local source = source
  local playerName = GetPlayerName(source)
  local distanceCheck = checkPlayerDistance(source)

  if not verifyReward then
    -- Potential cheating if verifyReward is false?
    lib.logger(source, 'registerSuccessful', 'Attempted to get rewards for a register robbery, despite verifyReward not being true', 'type:critical')
    return false
  end

  if not distanceCheck then
    -- Potential cheating if player is not nearby any of the store coords
    lib.logger(source, 'registerSuccessful', 'Attempted to get rewards for a register robbery, despite not being within range of any 24/7', 'type:critical')
    return false
  end

  if GlobalState.registerCooldown then return end

  CreateThread(function()
    registerCooldown()
  end)

  if Config.RegisterRewardRandom then
    local rewardQuantity = math.random(Config.RegisterRewardMinQuantity, Config.RegisterRewardMaxQuantity)
    ox_inventory:AddItem(source, Config.RegisterRewardItem, rewardQuantity)
    lib.logger(source, 'registerSuccessful',
      {
        message = ('Received %s x%d'):format(Config.RegisterRewardItem, rewardQuantity),
        item = Config.RegisterRewardItem,
        amount = rewardQuantity,
        type = 'added'
      }, 'economy:item')
    return true
  else
    ox_inventory:AddItem(source, Config.RegisterRewardItem, Config.RegisterRewardQuantity)
    lib.logger(source, 'registerSuccessful',
      {
        message = ('Received %s x%d'):format(Config.RegisterRewardItem, Config.RegisterRewardQuantity),
        item = Config.RegisterRewardItem,
        amount = Config.RegisterRewardQuantity,
        type = 'added'
      }, 'economy:item')
    return true
  end
end)

-- Function that rewards the player upon a successful safe robbery
lib.callback.register('lation_247robbery:safeSuccessful', function(source, verifyReward)
  local source = source

  local playerName = GetPlayerName(source)
  local distanceCheck = checkPlayerDistance(source)
  if not verifyReward then
    -- Potential cheating if verifyReward is false?
    lib.logger(source, 'safeSuccessful', 'Attempted to get rewards for a safe robbery, despite verifyReward not being true', 'type:critical')
    return false
  end

  if not distanceCheck then
    -- Potential cheating if player is not nearby any of the store coords
    lib.logger(source, 'safeSuccessful', 'Attempted to get rewards for a safe robbery, despite not being within range of any 24/7', 'type:critical')
    return false
  end

  if GlobalState.safeCooldown then return end

  CreateThread(function()
    safeCooldown()
  end)

  if Config.SafeRewardRandom then
    local rewardQuantity = math.random(Config.SafeRewardMinQuantity, Config.SafeRewardMaxQuantity)
    ox_inventory:AddItem(source, Config.SafeRewardItem, rewardQuantity)
    lib.logger(source, 'safeSuccessful',
      {
        message = ('Received %s x%d'):format(Config.SafeRewardItem, rewardQuantity),
        item = Config.SafeRewardItem,
        amount = rewardQuantity,
        type = 'added'
      }, 'economy:item')
    return true
  else
    ox_inventory:AddItem(source, Config.SafeRewardItem, Config.SafeRewardQuantity)
    lib.logger(source, 'safeSuccessful',
      {
        message = ('Received %s x%d'):format(Config.SafeRewardItem, Config.SafeRewardQuantity),
        item = Config.SafeRewardItem,
        amount = Config.SafeRewardQuantity,
        type = 'added'
      }, 'economy:item')
    return true
  end
end)


-- Function to decrease item durability
RegisterNetEvent('lation_247robbery:decreaseDurability', function(slot)
  local src = source
  local item = ox_inventory:GetSlot(src, slot)

  if not item.metadata.durability then
    ox_inventory:RemoveItem(src, item.name, 1, {}, slot)
    return
  end

  if item.metadata.durability and item.metadata.durability - 20 <= 19 then
    ox_inventory:RemoveItem(src, item.name, 1, {}, slot)
  else
    ox_inventory:SetDurability(src, slot, item.metadata.durability - 20)
  end
end)

-- Function that gets the passed item & quantity and removes it
lib.callback.register('lation_247robbery:removeItem', function(source, item, quantity)
  ox_inventory:RemoveItem(source, item, quantity)
end)

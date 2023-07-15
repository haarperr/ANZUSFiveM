local QBCore = exports['qb-core']:GetCoreObject()
local currentDivingArea = math.random(1, #Config.CoralLocations)
local availableCoral = {}

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end
  currentDivingArea = math.random(1, #Config.CoralLocations)

  for key, value in pairs(Config.CoralLocations[currentDivingArea].coords.Coral) do
    local obj = CreateObjectNoOffset(`prop_coral_pillar_01`, value.coords.x, value.coords.y, value.coords.z, true, true, false)
    Config.CoralLocations[currentDivingArea].coords.Coral[key].netid = NetworkGetNetworkIdFromEntity(obj)
  end
end)

-- Functions

local function getItemPrice(amount, price)
  for k, v in pairs(Config.PriceModifiers) do
    local modifier = #Config.PriceModifiers == k and amount >= v.minAmount or amount >= v.minAmount and amount <= v.maxAmount
    if modifier then
        price /= 100 * math.random(v.minPercentage, v.maxPercentage)
        price = math.ceil(price)
    end
  end

  return price
end

local function hasCoral(src)
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return false end

  local coral = {}

  for _, v in pairs(Config.CoralTypes) do
    local item = Player.Functions.GetItemByName(v.item)
    if item then
      coral[#coral + 1] = v
    end
  end

  availableCoral[src] = coral

  return table.type(availableCoral[src]) ~= 'empty'
end

-- Events

RegisterNetEvent('qb-diving:server:SellCoral', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end

  if not hasCoral(src) then
    return TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_coral"), 'error')
  end

  if not availableCoral[src] then
    return TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_coral"), 'error')
  end

  for _, v in pairs(availableCoral[src]) do
    local item = Player.Functions.GetItemByName(v.item)
    local price = item.amount * v.price
    local reward = getItemPrice(item.amount, price)
    Player.Functions.RemoveItem(item.name, item.amount)
    Player.Functions.AddMoney('cash', math.ceil(reward / item.amount), "sold-coral")

    lib.logger(src, 'SellCoral', {
      message = ('Sold %s x%d for %d'):format(item.name, item.amount, math.ceil(reward / item.amount)),
      item = item.name,
      amount = math.ceil(reward / item.amount),
      count = item.amount,
      currency = 'cash',
      type = 'added'
    }, 'economy:sell')

  end

  availableCoral[src] = {}
end)

RegisterNetEvent('qb-diving:server:TakeCoral', function(area, coral, bool)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end

  local coralType = math.random(1, #Config.CoralTypes)
  local amount = math.random(1, Config.CoralTypes[coralType].maxAmount)
  if amount > 1 then
    for _ = 1, amount, 1 do
      Player.Functions.AddItem(Config.CoralTypes[coralType].item, 1)
      Wait(250)
    end
  else
    Player.Functions.AddItem(Config.CoralTypes[coralType].item, amount)
  end

  DeleteEntity(NetworkGetEntityFromNetworkId(Config.CoralLocations[area].coords.Coral[coral].netid))

  if (Config.CoralLocations[area].TotalCoral - 1) == 0 then
    for _, v in pairs(Config.CoralLocations[currentDivingArea].coords.Coral) do
      v.PickedUp = false
    end
    Config.CoralLocations[currentDivingArea].TotalCoral = Config.CoralLocations[currentDivingArea].DefaultCoral
    local newLocation = math.random(1, #Config.CoralLocations)
    while newLocation == currentDivingArea do
      Wait(0)
      newLocation = math.random(1, #Config.CoralLocations)
    end

    currentDivingArea = newLocation

    for key, value in pairs(Config.CoralLocations[currentDivingArea].coords.Coral) do
      local obj = CreateObjectNoOffset(`vb_35b_coral_fan_p_l`, value.coords.x, value.coords.y, value.coords.z, true, true, false)
      Config.CoralLocations[currentDivingArea].coords.Coral[key].netid = NetworkGetNetworkIdFromEntity(obj)
    end

    TriggerClientEvent('qb-diving:client:NewLocations', -1)
  else
    Config.CoralLocations[area].coords.Coral[coral].PickedUp = bool
    Config.CoralLocations[area].TotalCoral -= 1
  end

  TriggerClientEvent('qb-diving:client:UpdateCoral', -1, area, coral, bool)
end)

RegisterNetEvent('qb-diving:server:removeItemAfterFill', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end

  Player.Functions.RemoveItem("diving_fill", 1)
end)

-- Callbacks

lib.callback.register('qb-diving:server:GetDivingConfig', function()
  return Config.CoralLocations, currentDivingArea
end)

-- Items

QBCore.Functions.CreateUseableItem("diving_gear", function(source)
  TriggerClientEvent("qb-diving:client:UseGear", source)
end)

QBCore.Functions.CreateUseableItem("diving_fill", function(source)
  TriggerClientEvent("qb-diving:client:setoxygenlevel", source)
end)

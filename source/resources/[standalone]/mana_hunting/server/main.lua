math.randomseed(os.time())

lib.locale()
local antifarm = {}

lib.versionCheck('manason/mana_hunting')
if not lib.checkDependency('ox_lib', '3.2.1') then error() end
if not lib.checkDependency('ox_inventory', '2.28.0') then error() end
if not lib.checkDependency('ox_target', '1.8.0') then error() end

local function arrayContains(array, value)
  for i = 1, #array, 1 do
    if array[i] == value then
      return true
    end
  end
  return false
end

local function isPlayerFarming(source, coords)
  if Config.AntiFarm.enable == false then return false end
  if Config.AntiFarm.personal == false then
    source = 1
  end

  local curentTime = os.time()
  local playerData = antifarm[source]
  if not next(antifarm) or playerData == nil or not next(playerData) then -- table empty
    playerData = {
      {
        time = curentTime, coords = coords, amount = 1
      }
    }
    return false
  end
  for i = 1, #playerData do
    if (curentTime - playerData[i].time) > Config.AntiFarm.time then    -- delete old table
      playerData[i] = nil
    elseif #(playerData[i].coords - coords) < Config.AntiFarm.size then -- if found table in coord
      if playerData[i].amount >= Config.AntiFarm.maxAmount then         -- if amount more than max
        return true
      end
      playerData[i].amount += 1 -- if not amount more than max
      playerData[i].time = curentTime
      return false
    end
  end
  playerData[#playerData + 1] = { time = curentTime, coords = coords, amount = 1 } -- if no table in coords found
  return false
end

local function getCarcassGrade(weapon, bone, carcass)
  local grade = '★☆☆'
  local image = carcass.item .. 1
  if arrayContains(Config.GoodWeapon, weapon) then
    grade = '★★☆'
    image = carcass.item .. 2
    if arrayContains(carcass.headshotBones, bone) then
      grade = '★★★'
      image = carcass.item .. 3
    end
  end

  return grade, image
end

local function getPeltGrade(item)
  local randomValue = math.random(1, 100)
  local grade = '★☆☆'
  local image = item .. 1
  if randomValue <= 75 then
    grade = '★★☆'
    image = item .. 2
    return grade, image
  elseif randomValue <= 85 then
    grade = '★★★'
    image = item .. 2
  end

  return grade, image
end


local function map(x, in_min, in_max, out_min, out_max)
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

RegisterNetEvent('mana_hunting:harvestSkin', function(entityId, bone)
  local src = source
  local playerCoords = GetEntityCoords(GetPlayerPed(src))
  local entity = NetworkGetEntityFromNetworkId(entityId)
  local entityCoords = GetEntityCoords(entity)
  if #(playerCoords - entityCoords) >= 5 then
    TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('too_far') })
    return
  end
  if isPlayerFarming(src, entityCoords) then
    TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('stop_farm') })
    return
  end
  local weapon = GetPedCauseOfDeath(entity)
  local animalModel = GetEntityModel(entity)
  local skin = Config.Skin[animalModel]
  local grade, image = getPeltGrade(skin.item)
  if exports.ox_inventory:CanCarryItem(src, skin.item, 1) and DoesEntityExist(entity) and GetEntityAttachedTo(entity) == 0 then
    exports.ox_inventory:AddItem(src, skin.item, 1,
      { type = grade, image = image, description = ('Identifier: %s\n\nShot: %s'):format(skin.identifier, os.date('%d-%m-%Y %H:%M')), identifier = skin.identifier })
    DeleteEntity(entity)
  end
end)

RegisterNetEvent('mana_hunting:harvestCarcass', function(entityId, bone)
  local src = source
  local playerCoords = GetEntityCoords(GetPlayerPed(src))
  local entity = NetworkGetEntityFromNetworkId(entityId)
  local entityCoords = GetEntityCoords(entity)
  if #(playerCoords - entityCoords) >= 5 then
    TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('too_far') })
    return
  end
  if isPlayerFarming(src, entityCoords) then
    TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('stop_farm') })
    return
  end
  local weapon = GetPedCauseOfDeath(entity)
  local carcassModel = GetEntityModel(entity)
  local carcass = Config.Carcass[carcassModel]
  local grade, image = getCarcassGrade(weapon, bone, carcass)
  if exports.ox_inventory:CanCarryItem(src, carcass.item, 1) and DoesEntityExist(entity) and GetEntityAttachedTo(entity) == 0 then
    exports.ox_inventory:AddItem(src, carcass.item, 1, { type = grade, image = image })
    DeleteEntity(entity)
  end
end)

---@param data {item: string, location: number}
RegisterNetEvent('mana_hunting:sellItem', function(data)
  local src = source
  local slots = exports.ox_inventory:GetSlotsWithItem(src, data.item, {})

  if not slots or #slots == 0 then return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'You do not have any of this' }) end

  for _, v in pairs(slots) do
    local type = v.metadata.type or '★☆☆'
    local reward = math.random(Config.SellingLocations[data.location].price[data.item].min, Config.SellingLocations[data.location].price[data.item].max) *
        Config.GradeMultiplier[type]
    if Config.Degrade and v.metadata.durability then
      local currentTime = os.time()
      local maxTime = v.metadata.durability
      local minTime = maxTime - v.metadata.degrade * 60
      if currentTime >= maxTime then
        currentTime = maxTime
      end
      reward = math.floor(
        map(
          currentTime,
          maxTime,
          minTime,
          Config.SellingLocations[data.location].price[data.item].min * Config.GradeMultiplier[type],
          Config.SellingLocations[data.location].price[data.item].max * Config.GradeMultiplier[type]))
    end
    exports.ox_inventory:RemoveItem(src, data.item, 1, nil, v.slot)
    exports.ox_inventory:AddItem(src, 'money', reward)

    lib.logger(src, 'sellItem', {
      message = ('Sold %s x1 for %s'):format(data.item, reward),
      item = data.item,
      amount = reward,
      count = 1,
      currency = 'cash',
      type = 'added'
    }, 'economy:sell')
  end
end)

-- RegisterNetEvent('mana_hunting:SellCarcass',function (item)
--   local itemData = exports.ox_inventory:Search(source, 'slots', item)[1]
--   if itemData.count < 1 then return end

--   local reward = Config.SellPrice[item].max * Config.GradeMultiplier[itemData.metadata.type]
--   if Config.Degrade and itemData.metadata.durability then
--     local currentTime = os.time()
--     local maxTime = itemData.metadata.durability
--     local minTime = maxTime - itemData.metadata.degrade * 60
--     if currentTime >= maxTime then
--         currentTime = maxTime
--     end
--     reward = math.floor(
--       map(
--         currentTime,
--         maxTime,
--         minTime,
--         Config.SellPrice[item].min * Config.GradeMultiplier[itemData.metadata.type],
--         Config.SellPrice[item].max * Config.GradeMultiplier[itemData.metadata.type]))
--   end
--   exports.ox_inventory:RemoveItem(source, item, 1, nil, itemData.slot)
--   exports.ox_inventory:AddItem(source, 'money', reward)
-- end)

local function generatePrices()
  for k, v in pairs(Config.SellingLocations) do
    local modifier = math.random(v.sellModifier.min, v.sellModifier.max)
    local application = math.random() < 0.5 and 'remove' or 'add'
    Config.SellingLocations[k].modifier = {
      modifier = modifier,
      application = application
    }
    Config.SellingLocations[k].price = {}

    for key, value in pairs(Config.SellPrice) do
      Config.SellingLocations[k].price[key] = {}
      local max = value.max
      local min = value.min
      if v.modifier.application == 'remove' then
        max -= v.modifier.modifier
        min -= v.modifier.modifier
      elseif v.modifier.application == 'add' then
        max += v.modifier.modifier
        min += v.modifier.modifier
      end

      if max <= 0 then max = 1 end
      if value.min >= max then min = 1 end

      Config.SellingLocations[k].price[key].max = max
      Config.SellingLocations[k].price[key].min = min
    end
  end
end

AddEventHandler('onResourceStart', function(name)
  if GetCurrentResourceName() ~= name then return end
  generatePrices()
end)

lib.callback.register('mana_hunting:getModifiers', function(source)
  return Config.SellingLocations
end)

local itemfilter = {}

for key, value in pairs(Config.Carcass) do
  itemfilter[value.item] = true
end

exports.ox_inventory:registerHook('swapItems', function(payload)
  if payload.action == 'give' then
    local ped = GetPlayerPed(payload.toInventory)
    local veh = GetVehiclePedIsIn(ped, false)
    if not veh then return true end
    TriggerClientEvent('ox_lib:notify', payload.source, { type = 'error', description = 'The target cannot be in a vehicle to get this item' })
    return false
  end
end, {
  itemfilter = itemfilter
})

lib.locale()
local carriedCarcass = 0
local heaviestCarcass = 0

local animals = {}
local listItemCarcass = {}
local carcassByItem = {}

local itemLabels = {}

for key, value in pairs(Config.Carcass) do
  animals[#animals + 1] = key
  listItemCarcass[#listItemCarcass + 1] = value.item
  carcassByItem[value.item] = key
end

for k, _ in pairs(Config.SellPrice) do
  for key, value in pairs(exports.ox_inventory:Items()) do
    if k == key then
      itemLabels[k] = value.label
      break
    end
  end
end

local function customControl()
  Citizen.CreateThread(function()
    local playerPed = cache.ped
    local enable = true

    while enable do
      if IsControlPressed(0, 35) then -- Right
        FreezeEntityPosition(playerPed, false)
        SetEntityHeading(playerPed, GetEntityHeading(playerPed) + 0.5)
      elseif IsControlPressed(0, 34) then -- Left
        FreezeEntityPosition(playerPed, false)
        SetEntityHeading(playerPed, GetEntityHeading(playerPed) - 0.5)
      elseif IsControlPressed(0, 32) or IsControlPressed(0, 33) then
        FreezeEntityPosition(playerPed, false)
      else
        FreezeEntityPosition(playerPed, true)
        TaskPlayAnim(cache.ped, 'combat@drag_ped@', 'injured_drag_plyr', 0.0, 0.0, 1, 2, 7, false, false, false)
      end
      Wait(7)
      if heaviestCarcass ~= 0 then
        enable = Config.Carcass[heaviestCarcass].drag
      else
        enable = false
      end
    end
    FreezeEntityPosition(playerPed, false)
    ClearPedSecondaryTask(playerPed)
    ClearPedTasksImmediately(playerPed)
  end)
end

local function playCarryAnim()
  if carriedCarcass == 0 then
    ClearPedSecondaryTask(cache.ped)
    return
  end
  if Config.Carcass[heaviestCarcass].drag then
    lib.requestAnimDict('combat@drag_ped@')
    TaskPlayAnim(cache.ped, 'combat@drag_ped@', 'injured_drag_plyr', 2.0, 2.0, 100000, 1, 0, false, false, false)
    customControl()
    while carriedCarcass ~= 0 do
      while not IsEntityPlayingAnim(cache.ped, 'combat@drag_ped@', 'injured_drag_plyr', 1) do
        TaskPlayAnim(cache.ped, 'combat@drag_ped@', 'injured_drag_plyr', 2.0, 2.0, 100000, 1, 0, false, false, false)
        Wait(0)
      end
      DisableControlAction(0, 23, true)
      Wait(0)
    end
  else
    lib.requestAnimDict('missfinale_c2mcs_1')
    TaskPlayAnim(cache.ped, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
    while carriedCarcass ~= 0 do
      while not IsEntityPlayingAnim(cache.ped, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 49) do
        TaskPlayAnim(cache.ped, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
        Wait(0)
      end
      DisableControlAction(0, 23, true)
      Wait(0)
    end
  end
end

RegisterNetEvent('mana_hunting:client:carryCarcass', function()
  TriggerEvent('ox_inventory:disarm')
  FreezeEntityPosition(cache.ped, false)
  heaviestCarcass = 0
  local carcassCount = 0
  for _, value in pairs(exports.ox_inventory:Search('count', listItemCarcass)) do
    carcassCount += value
  end
  if carcassCount > 0 then
    local inventory = exports.ox_inventory:Search('slots', listItemCarcass)
    local weight = 0
    for key, value in pairs(inventory) do
      if next(value) ~= nil and value[1].weight > weight then
        weight = value[1].weight
        heaviestCarcass = carcassByItem[key]
      end
    end

    lib.requestModel(heaviestCarcass)
    DeleteEntity(carriedCarcass)
    carriedCarcass = CreatePed(1, heaviestCarcass, GetEntityCoords(cache.ped), GetEntityHeading(cache.ped), true, true)
    SetEntityInvincible(carriedCarcass, true)
    SetEntityHealth(carriedCarcass, 0)
    local pos = Config.Carcass[heaviestCarcass]
    AttachEntityToEntity(carriedCarcass, cache.ped, 11816, pos.xPos, pos.yPos, pos.zPos, pos.xRot, pos.yRot, pos.zRot, false, false, false, true, 2, true)
    playCarryAnim()
  else
    DeleteEntity(carriedCarcass)
    carriedCarcass = 0
    playCarryAnim()
  end
end)

exports('carryCarcass', carryCarcass)

RegisterNetEvent('ox:playerLoaded', function()
  carryCarcass()
end)
RegisterNetEvent('esx:playerLoaded', function()
  carryCarcass()
end)

local function pickupCarcass(data)
  local entity = data.entity
  TriggerEvent('ox_inventory:disarm')
  local _, bone = GetPedLastDamageBone(entity)
  TaskTurnPedToFaceEntity(cache.ped, entity, -1)
  Wait(500)
  if lib.progressCircle({
        duration = 3000,
        label = locale('pickup_carcass'),
        useWhileDead = false,
        canCancel = true,
        disable = {
          move = true,
          car = true,
          combat = true,
          mouse = false
        },
        anim = {
          dict = 'amb@medic@standing@kneel@idle_a',
          clip = 'idle_a',
          flag = 1,
        },
      }) then
    TriggerServerEvent('mana_hunting:harvestCarcass', NetworkGetNetworkIdFromEntity(entity), bone)
  end
end

local function skinAnimal(data)
  local entity = data.entity
  TriggerEvent('ox_inventory:disarm')
  local _, bone = GetPedLastDamageBone(entity)
  TaskTurnPedToFaceEntity(cache.ped, entity, -1)
  Wait(500)
  if lib.progressCircle({
        duration = 3000,
        label = locale('skin_animal'),
        useWhileDead = false,
        canCancel = true,
        disable = {
          move = true,
          car = true,
          combat = true,
          mouse = false
        },
        anim = {
          dict = 'amb@medic@standing@kneel@idle_a',
          clip = 'idle_a',
          flag = 1,
        },
      }) then
    TriggerServerEvent('mana_hunting:harvestSkin', NetworkGetNetworkIdFromEntity(entity), bone)
  end
end

exports.ox_target:addModel(animals, {
  {
    icon = "fa-solid fa-paw",
    label = locale('pickup_carcass'),
    canInteract = function(entity)
      return IsEntityDead(entity) and not IsEntityAMissionEntity(entity)
    end,
    onSelect = pickupCarcass
  },
  {
    icon = "fa-solid fa-paw",
    label = locale('skin_animal'),
    items = { 'WEAPON_KNIFE' },
    canInteract = function(entity)
      return IsEntityDead(entity) and not IsEntityAMissionEntity(entity)
    end,
    onSelect = skinAnimal
  }
})

-- RegisterCommand('carcass', function ()
--     lib.requestAnimDict('amb@medic@standing@kneel@idle_a')
--     TaskPlayAnim(cache.ped, 'amb@medic@standing@kneel@idle_a', 'idle_a', 8.0, -8.0, 10000, 1, 0, false, false, false)
-- end)


--------------------- SELL -----------------------------------

local function load()
  local config = lib.callback.await('mana_hunting:getModifiers', false)
  Config.SellingLocations = config

  for k, v in pairs(Config.SellingLocations) do
    local point = lib.points.new({
      coords = vec3(v.coords.x, v.coords.y, v.coords.z),
      distance = 50,
      ped = nil
    })

    function point:onEnter()
      if self.ped then return end
      lib.requestModel(v.ped)

      local ret, z = GetGroundZAndNormalFor_3dCoord(v.coords.x, v.coords.y, v.coords.z)

      self.ped = CreatePed(0, v.ped, v.coords.x, v.coords.y, ret and z or v.coords.z, v.w, false, false)
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)

      local function sellMenu()
        local options = {}

        for key, value in pairs(v.price) do
          options[#options + 1] = {
            title = itemLabels[key],
            description = ('Max Value: %s'):format(value.max),
            onSelect = function()
              TriggerServerEvent('mana_hunting:sellItem', { item = key, location = k })
            end
          }
        end

        return options
      end

      local options = sellMenu()
      local function openMenu()
        lib.registerContext({
          id = ('hunting_sell_%d'):format(k),
          title = 'Hunting Store',
          options = options
        })
        lib.showContext(('hunting_sell_%d'):format(k))
      end


      exports.ox_target:addLocalEntity(ped, {
        {
          onSelect = openMenu,
          icon = "fa-solid fa-sack-dollar",
          label = locale('open_sell_menu'),
        }
      })
    end

    local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
    SetBlipSprite(blip, 141)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 43)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(locale('blip_name'))
    EndTextCommandSetBlipName(blip)
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  load()
end)

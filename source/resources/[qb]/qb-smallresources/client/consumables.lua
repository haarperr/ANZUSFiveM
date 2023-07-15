-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local alcoholCount, ParachuteEquiped, currentVest, currentVestTexture, healing, SmokingWeed, RelieveCount = 0, false, nil, nil, false, false, 0

-- Functions

local function EquipParachuteAnim()
  local hasLoaded = lib.requestAnimDict('clothingshirt')
  if not hasLoaded then return end
  TaskPlayAnim(cache.ped, 'clothingshirt', 'try_shirt_positive_d', 8.0, 1.0, -1, 49, 0, false, false, false)
end

local function HealOxy()
  if not healing then
    healing = true
  else
    return
  end

  local count = 9
  while count > 0 do
    Wait(1000)
    count -= 1
    SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) + 6)
  end
  healing = false
end

local function TrevorEffect()
  AnimpostfxPlay('DrugsTrevorClownsFightIn', 3.0, 0)
  Wait(3000)
  AnimpostfxPlay('DrugsTrevorClownsFight', 3.0, 0)
  Wait(3000)
  AnimpostfxPlay('DrugsTrevorClownsFightOut', 3.0, 0)
  AnimpostfxStop('DrugsTrevorClownsFight')
  AnimpostfxStop('DrugsTrevorClownsFightIn')
  AnimpostfxStop('DrugsTrevorClownsFightOut')
end

local function MethBagEffect()
  local startStamina = 8
  TrevorEffect()
  SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
  while startStamina > 0 do
    Wait(1000)
    if math.random(5, 100) < 10 then
      RestorePlayerStamina(PlayerId(), 1.0)
    end
    startStamina = startStamina - 1
    if math.random(5, 100) < 51 then
      TrevorEffect()
    end
  end
  SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

local function EcstasyEffect()
  local startStamina = 30
  SetFlash(0, 0, 500, 7000, 500)
  while startStamina > 0 do
    Wait(1000)
    startStamina -= 1
    RestorePlayerStamina(PlayerId(), 1.0)
    if math.random(1, 100) < 51 then
      SetFlash(0, 0, 500, 7000, 500)
      ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
    end
  end
  if IsPedRunning(cache.ped) then
    SetPedToRagdoll(cache.ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
  end
end

local function AlienEffect()
  AnimpostfxPlay('DrugsMichaelAliensFightIn', 3.0, 0)
  Wait(math.random(5000, 8000))
  AnimpostfxPlay('DrugsMichaelAliensFight', 3.0, 0)
  Wait(math.random(5000, 8000))
  AnimpostfxPlay('DrugsMichaelAliensFightOut', 3.0, 0)
  AnimpostfxStop('DrugsMichaelAliensFightIn')
  AnimpostfxStop('DrugsMichaelAliensFight')
  AnimpostfxStop('DrugsMichaelAliensFightOut')
end

local function CrackBaggyEffect()
  local startStamina = 8
  AlienEffect()
  SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
  while startStamina > 0 do
    Wait(1000)
    if math.random(1, 100) < 10 then
      RestorePlayerStamina(PlayerId(), 1.0)
    end
    startStamina -= 1
    if math.random(1, 100) < 60 and IsPedRunning(cache.ped) then
      SetPedToRagdoll(cache.ped, math.random(1000, 2000), math.random(1000, 2000), 3, false, false, false)
    end
    if math.random(1, 100) < 51 then
      AlienEffect()
    end
  end
  if IsPedRunning(cache.ped) then
    SetPedToRagdoll(cache.ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
  end
  SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

local function CokeBaggyEffect()
  local startStamina = 20
  AlienEffect()
  SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
  while startStamina > 0 do
    Wait(1000)
    if math.random(1, 100) < 20 then
      RestorePlayerStamina(PlayerId(), 1.0)
    end
    startStamina -= 1
    if math.random(1, 100) < 10 and IsPedRunning(cache.ped) then
      SetPedToRagdoll(cache.ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
    end
    if math.random(1, 300) < 10 then
      AlienEffect()
      Wait(math.random(3000, 6000))
    end
  end
  if IsPedRunning(cache.ped) then
    SetPedToRagdoll(cache.ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
  end
  SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

local function SmokeWeed()
  CreateThread(function()
    while SmokingWeed do
      Wait(10000)
      if not exports.scully_emotemenu:isInEmote() then SmokingWeed = false end
      TriggerServerEvent('hud:server:RelieveStress', math.random(15, 18))
      RelieveCount += 1
      if RelieveCount >= 6 then
        exports.scully_emotemenu:cancelEmote()
        if SmokingWeed then
          SmokingWeed = false
          RelieveCount = 0
        end
      end
    end
  end)
end

-- Events

RegisterNetEvent('consumables:client:Cokebaggy', function()
  QBCore.Functions.Progressbar('snort_coke', 'Quick sniff..', math.random(5000, 8000), false, true, {
    disableMovement = false,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = true,
  }, {
    animDict = 'switch@trevor@trev_smoking_meth',
    anim = 'trev_smoking_meth_loop',
    flags = 49,
  }, {}, {}, function() -- Done
    StopAnimTask(cache.ped, 'switch@trevor@trev_smoking_meth', 'trev_smoking_meth_loop', 1.0)
    TriggerServerEvent('consumables:server:useCokeBaggy')
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['cokebaggy'], 'remove')
    TriggerEvent('evidence:client:SetStatus', 'widepupils', 200)
    CokeBaggyEffect()
  end, function() -- Cancel
    StopAnimTask(cache.ped, 'switch@trevor@trev_smoking_meth', 'trev_smoking_meth_loop', 1.0)
    QBCore.Functions.Notify('Canceled..', 'error')
  end)
end)

RegisterNetEvent('consumables:client:Crackbaggy', function()
  QBCore.Functions.Progressbar('snort_coke', 'Smoking crack..', math.random(7000, 10000), false, true, {
    disableMovement = false,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = true,
  }, {
    animDict = 'switch@trevor@trev_smoking_meth',
    anim = 'trev_smoking_meth_loop',
    flags = 49,
  }, {}, {}, function() -- Done
    StopAnimTask(cache.ped, 'switch@trevor@trev_smoking_meth', 'trev_smoking_meth_loop', 1.0)
    TriggerServerEvent('consumables:server:useCrackBaggy')
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['crack_baggy'], 'remove')
    TriggerEvent('evidence:client:SetStatus', 'widepupils', 300)
    CrackBaggyEffect()
  end, function() -- Cancel
    StopAnimTask(cache.ped, 'switch@trevor@trev_smoking_meth', 'trev_smoking_meth_loop', 1.0)
    QBCore.Functions.Notify('Canceled..', 'error')
  end)
end)

RegisterNetEvent('consumables:client:EcstasyBaggy', function()
  QBCore.Functions.Progressbar('use_ecstasy', 'Pops Pills', 3000, false, true, {
    disableMovement = false,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = true,
  }, {
    animDict = 'mp_suicide',
    anim = 'pill',
    flags = 49,
  }, {}, {}, function() -- Done
    StopAnimTask(cache.ped, 'mp_suicide', 'pill', 1.0)
    TriggerServerEvent('consumables:server:useXTCBaggy')
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['xtcbaggy'], 'remove')
    EcstasyEffect()
  end, function() -- Cancel
    StopAnimTask(cache.ped, 'mp_suicide', 'pill', 1.0)
    QBCore.Functions.Notify('Failed', 'error')
  end)
end)

RegisterNetEvent('consumables:client:oxy', function()
  QBCore.Functions.Progressbar('use_oxy', 'Healing', 2000, false, true, {
    disableMovement = false,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = true,
  }, {
    animDict = 'mp_suicide',
    anim = 'pill',
    flags = 49,
  }, {}, {}, function() -- Done
    StopAnimTask(cache.ped, 'mp_suicide', 'pill', 1.0)
    TriggerServerEvent('consumables:server:useOxy')
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['oxy'], 'remove')
    ClearPedBloodDamage(cache.ped)
    HealOxy()
  end, function() -- Cancel
    StopAnimTask(cache.ped, 'mp_suicide', 'pill', 1.0)
    QBCore.Functions.Notify('Canceled', 'error')
  end)
end)

RegisterNetEvent('consumables:client:meth', function()
  QBCore.Functions.Progressbar('snort_meth', 'Smoking Ass Meth', 1500, false, true, {
    disableMovement = false,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = true,
  }, {
    animDict = 'switch@trevor@trev_smoking_meth',
    anim = 'trev_smoking_meth_loop',
    flags = 49,
  }, {}, {}, function() -- Done
    StopAnimTask(cache.ped, 'switch@trevor@trev_smoking_meth', 'trev_smoking_meth_loop', 1.0)
    TriggerServerEvent('consumables:server:useMeth')
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['meth'], 'remove')
    TriggerEvent('evidence:client:SetStatus', 'widepupils', 300)
    TriggerEvent('evidence:client:SetStatus', 'agitated', 300)
    MethBagEffect()
  end, function() -- Cancel
    StopAnimTask(cache.ped, 'switch@trevor@trev_smoking_meth', 'trev_smoking_meth_loop', 1.0)
    QBCore.Functions.Notify('Canceled..', 'error')
  end)
end)

RegisterNetEvent('consumables:client:UseJoint', function()
  QBCore.Functions.Progressbar("smoke_joint", 'Lighting joint', 1500, false, true, {
    disableMovement = false,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = true,
  }, {}, {}, {}, function() -- Done
    SmokingWeed = true
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      exports.scully_emotemenu:playEmoteByCommand('smoke3')
    else
      exports.scully_emotemenu:playEmoteByCommand('smokeweed')
    end
    SmokeWeed()
  end, function()
    exports.scully_emotemenu:cancelEmote()
  end)
end)


RegisterNetEvent('consumables:client:UseParachute', function()
  EquipParachuteAnim()
  QBCore.Functions.Progressbar('use_parachute', 'Putting on parachute..', 5000, false, true, {
    disableMovement = false,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = true,
  }, {}, {}, {}, function() -- Done
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['parachute'], 'remove')
    GiveWeaponToPed(cache.ped, `GADGET_PARACHUTE`, 1, false, false)
    local ParachuteData = {
      outfitData = {
        ['bag'] = { item = 7, texture = 0 }, -- Adding Parachute Clothing
      }
    }
    TriggerEvent('qb-clothing:client:loadOutfit', ParachuteData)
    ParachuteEquiped = true
    TaskPlayAnim(cache.ped, 'clothingshirt', 'exit', 8.0, 1.0, -1, 49, 0, false, false, false)
  end)
end)

RegisterNetEvent('consumables:client:ResetParachute', function()
  if ParachuteEquiped then
    EquipParachuteAnim()
    QBCore.Functions.Progressbar('reset_parachute', 'Packing parachute..', 40000, false, true, {
      disableMovement = false,
      disableCarMovement = false,
      disableMouse = false,
      disableCombat = true,
    }, {}, {}, {}, function() -- Done
      TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['parachute'], 'add')
      local ParachuteRemoveData = {
        outfitData = {
          ['bag'] = { item = 0, texture = 0 } -- Removing Parachute Clothing
        }
      }
      TriggerEvent('qb-clothing:client:loadOutfit', ParachuteRemoveData)
      TaskPlayAnim(cache.ped, 'clothingshirt', 'exit', 8.0, 1.0, -1, 49, 0, false, false, false)
      TriggerServerEvent('qb-smallpenis:server:AddParachute')
      ParachuteEquiped = false
    end)
  else
    QBCore.Functions.Notify('You dont have a parachute!', 'error')
  end
end)

RegisterNetEvent('consumables:client:UseArmor', function()
  if GetPedArmour(cache.ped) >= 50 then
    QBCore.Functions.Notify('You already have enough armor on!', 'error')
    return
  end
  QBCore.Functions.Progressbar('use_armor', 'Putting on the body armour..', 5000, false, true, {
    disableMovement = false,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = true,
  }, {}, {}, {}, function() -- Done
    TriggerServerEvent('hospital:server:SetArmor', 50)
    TriggerServerEvent('consumables:server:useArmor')
    SetPedArmour(cache.ped, 50)
  end)
end)

RegisterNetEvent('consumables:client:UseHeavyArmor', function()
  if GetPedArmour(cache.ped) == 100 then
    QBCore.Functions.Notify('You already have enough armor on!', 'error')
    return
  end
  local PlayerData = QBCore.Functions.GetPlayerData()
  QBCore.Functions.Progressbar('use_heavyarmor', 'Putting on body armour..', 5000, false, true, {
    disableMovement = false,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = true,
  }, {}, {}, {}, function() -- Done
    TriggerServerEvent('consumables:server:useHeavyArmor')
    SetPedArmour(cache.ped, 100)
  end)
end)

--Threads

CreateThread(function()
  while true do
    Wait(10)
    if alcoholCount > 0 then
      Wait(1000 * 60 * 15)
      alcoholCount -= 1
    else
      Wait(2000)
    end
  end
end)

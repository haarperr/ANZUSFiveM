local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

--[[
  This is PlayerSlots here we define the Category of the weapons that goes on the Player
  This means that instead of giving each weapon a designated slot on the back, we can just add a weapon with the designated slot
  This will also allow for weapons to feel and look more natural when added.

  All items that go on your back -> MUST have a SLOT CATEGORY, everything that we CARRY must have Carry = true
]]
local PlayerSlots = {
  [1] = { -- Bigger weapons such as bats, crowbars, Assaultrifles, and also good place for wet weed.
    [1] = { bone = 24817, x = 0.04, y = -0.15, z = 0.12, xr = 0.0, yr = 0.0, zr = 0.0, isBusy = false },
    [2] = { bone = 24817, x = 0.04, y = -0.17, z = 0.02, xr = 0.0, yr = 0.0, zr = 0.0, isBusy = false },
    [3] = { bone = 24817, x = 0.04, y = -0.15, z = -0.12, xr = 0.0, yr = 0.0, zr = 0.0, isBusy = false },
  },

  [2] = { -- Use this for katana knives etc. stuff that goes sideways on the players body
    [1] = { bone = 24817, x = -0.13, y = -0.16, z = -0.14, xr = 5.0, yr = 62.0, zr = 0.0, isBusy = false },
    [2] = { bone = 24817, x = -0.13, y = -0.15, z = 0.10, xr = 5.0, yr = 124.0, zr = 0.0, isBusy = false },
  },

  [3] = { -- Contraband like Drugs and shit
    [1] = { bone = 24817, x = -0.28, y = -0.14, z = 0.15, xr = 0.0, yr = 92.0, zr = -13.0 },
    [2] = { bone = 24817, x = -0.27, y = -0.14, z = 0.15, xr = 0.0, yr = 92.0, zr = 13.0 },
  },

  [4] = { -- I use this for the pelts for hunting
    [1] = { bone = 24817, x = -0.18, y = -0.26, z = -0.02, xr = 0.0, yr = 91.0, zr = 5.0 },
    [2] = { bone = 24817, x = 0.10, y = -0.26, z = -0.02, xr = 0.0, yr = 91.0, zr = 5.0 },
    [3] = { bone = 24817, x = 0.38, y = -0.21, z = -0.02, xr = 0.0, yr = 91.0, zr = 5.0 },
  },

  [5] = { -- I use this for chains, make sure your CHAIN is a CUSTOM prop, will NOT work with a clothing item, if you want to add a CHAIN make sure to have a chain = true as it will not work the same as weapons --
    [1] = { bone = 10706, x = 0.11, y = 0.080, z = -0.473, xr = -366.0, yr = 19.0, zr = -163.0 },
  },
}


-- Add your items here --
local props = {
  ---- ** Drugs ** ----
  -- Weed
  ["wetbud"]                       = { model = "bkr_prop_weed_drying_02a", hash = `bkr_prop_weed_drying_02a`, tier = 1, yr = 90.0 },
  -- meth
  ["meth"]                         = { model = "hei_prop_pill_bag_01", hash = `hei_prop_pill_bag_01`, tier = 3 },
  -- Contraband
  ["markedbills"]                  = { model = "prop_money_bag_01", hash = `prop_money_bag_01`, tier = 3, x = -0.47, zr = 0 }, -- If you put any x,y,z,xr,yr,zr it will offset it from the slots to make it fit perfectly

  -- Custom Weapons Tier 1
  ["weapon_assaultrifle"]          = { model = "w_ar_ak74", hash = `weapon_assaultrifle`, tier = 1 },
  ["weapon_assaultrifle2"]         = { model = "w_ar_assaultrifle2", hash = `weapon_assaultrifle2`, tier = 1 },
  ["weapon_carbinerifle"]          = { model = "w_ar_carbinerifle", hash = `weapon_carbinerifle`, tier = 1 },
  ["weapon_advancedrifle"]         = { model = "w_ar_groza", hash = `weapon_advancedrifle`, tier = 1 },
  ["weapon_m4"]                    = { model = "w_ar_m4", hash = `weapon_m4`, tier = 1 },
  ["weapon_carbinerifle_mk2"]      = { model = "w_ar_carbineriflemk2", hash = `weapon_carbinerifle_mk2`, tier = 1 },
  ["weapon_specialcarbine"]        = { model = "w_ar_specialcarbine", hash = `weapon_specialcarbine`, tier = 1 },
  ["weapon_bullpuprifle"]          = { model = "w_ar_bullpuprifle", hash = `weapon_bullpuprifle`, tier = 1 },
  ["weapon_bullpuprifle_mk2"]      = { model = "w_ar_bullpupriflemk2", hash = `weapon_bullpuprifle_mk2`, tier = 1 },
  ["weapon_specialcarbine_mk2"]    = { model = "w_ar_scar", hash = `weapon_specialcarbine_mk2`, tier = 1 },
  ["weapon_militaryrifle"]         = { model = "w_ar_bullpuprifleh4", hash = `weapon_militaryrifle`, tier = 1 },
  ["weapon_tacticalrifle"]         = { model = "w_ar_carbinerifle_reh", hash = `weapon_tacticalrifle`, tier = 1 },

  ["weapon_mg"]                    = { model = "w_mg_mg", hash = `weapon_mg`, tier = 1 },
  ["weapon_combatmg"]              = { model = "w_mg_combatmg", hash = `weapon_combatmg`, tier = 1 },
  ["weapon_gusenberg"]             = { model = "w_sb_gusenberg", hash = `weapon_gusenberg`, tier = 1 },
  ["weapon_combatmg_mk2"]          = { model = "w_mg_combatmgmk2", hash = `weapon_gunsenberg`, tier = 1 },

  ["weapon_combatpdw"]             = { model = "w_sb_mpx", hash = `weapon_combatpdw`, tier = 1 },
  ["weapon_compactrifle"]          = { model = "w_ar_draco", hash = `weapon_compactrifle`, tier = 1 },
  ["weapon_smg"]                   = { model = "w_sb_mp5", hash = `weapon_smg`, tier = 1 },
  ["weapon_assaultsmg"]            = { model = "w_sb_assaultsmg", hash = `weapon_assaultsmg`, tier = 1 },

  ["weapon_pumpshotgun"]           = { model = "w_sg_izh81", hash = `weapon_pumpshotgun`, tier = 1 },
  ["weapon_sawnoffshotgun"]        = { model = "w_sg_sawnoff", hash = `weapon_sawnoffshotgun`, tier = 1 },
  ["weapon_assaultshotgun"]        = { model = "w_sg_assaultshotgun", hash = `weapon_assaultshotgun`, tier = 1 },
  ["weapon_bullpupshotgun"]        = { model = "w_sg_bullpupshotgun", hash = `weapon_bullpupshotgun`, tier = 1 },
  ["weapon_heavyshotgun"]          = { model = "w_sg_heavyshotgun", hash = `weapon_heavyshotgun`, tier = 1 },
  ["weapon_dbshotgun"]             = { model = "w_sg_doublebarrel", hash = `weapon_dbshotgun`, tier = 1 },
  ["weapon_pumpshotgun_mk2"]       = { model = "w_sg_pumpshotgunmk2", hash = `weapon_pumpshotgun_mk2`, tier = 1 },
  ["weapon_combatshotgun"]         = { model = "w_sg_spas12", hash = `weapon_combatshotgun`, tier = 1 },
  ["weapon_ltl"]                   = { model = "w_sg_ltl", hash = `weapon_ltl`, tier = 1 },

  ["weapon_sniperrifle"]           = { model = "w_sr_m24", hash = `weapon_sniperrifle`, tier = 1 },
  ["weapon_heavysniper"]           = { model = "w_sr_heavysniper", hash = `weapon_heavysniper`, tier = 1 },
  ["weapon_marksmanrifle"]         = { model = "w_sr_marksmanrifle", hash = `weapon_marksmanrifle`, tier = 1 },
  ["weapon_heavysniper_mk2"]       = { model = "w_sr_heavysnipermk2", hash = `weapon_heavysniper_mk2`, tier = 1 },
  ["weapon_marksmanrifle_mk2"]     = { model = "w_sr_heavysnipermk2", hash = `weapon_marksmanrifle_mk2`, tier = 1 },
  ["weapon_precisionrifle"]        = { model = "w_sr_precisionrifle_reh", hash = `weapon_precisionrifle`, tier = 1 },
  ["weapon_dragunov"]              = { model = "w_sr_dragunov", hash = `weapon_dragunov`, tier = 1 },

  ["weapon_m14"]                   = { model = "w_sr_m14", hash = `weapon_m14`, tier = 1 },
  ["weapon_g22"]                   = { model = "w_sr_g22", hash = `weapon_g22`, tier = 1 },

  ["weapon_rpg"]                   = { model = "w_lr_rpg", hash = `weapon_rpg`, tier = 1, x = 0.5 },
  ["weapon_grenadelauncher"]       = { model = "w_lr_grenadelauncher", hash = `weapon_grenadelauncher`, tier = 1 },
  ["weapon_grenadelauncher_smoke"] = { model = "w_lr_potatolauncher", hash = `weapon_grenadelauncher_smoke`, tier = 1 },
  ["weapon_minigun"]               = { model = "w_mg_minigun", hash = `weapon_minigun`, tier = 1 },
  ["weapon_firework"]              = { model = "w_lr_firework", hash = `weapon_firework`, tier = 1, x = 0.5 },
  ["weapon_railgun"]               = { model = "w_ar_railgun", hash = `weapon_railgun`, tier = 1 },
  ["weapon_hominglauncher"]        = { model = "w_lr_homing", hash = `weapon_hominglauncher`, tier = 1, x = 0.5 },

  -- tier2
  ["weapon_bats"]                  = { model = "w_me_baseball_bat_barbed", hash = `weapon_bats`, tier = 2 },
  ["weapon_katana"]                = { model = "katana_sheath", hash = `weapon_katana`, tier = 2, zr = -90.0, xr = -40.0,
    y = -0.14, x = 0.2, z = -0.08 },
  ["weapon_golfclub"]              = { model = "w_me_gclub", hash = `weapon_golfclub`, tier = 2 },
  ["weapon_battleaxe"]             = { model = "w_me_battleaxe", hash = `weapon_battleaxe`, tier = 2 },
  ["weapon_crowbar"]               = { model = "w_me_crowbar", hash = `weapon_crowbar`, tier = 2 },
  ["weapon_wrench"]                = { model = "w_me_wrench", hash = `weapon_wrench`, tier = 2 },


  ["deer_pelt_1"]    = { model = "hunting_pelt_01_a", hash = `hunting_pelt_01_a`, tier = 4 },
  ["deer_pelt_2"]    = { model = "hunting_pelt_01_b", hash = `hunting_pelt_01_b`, tier = 4 },
  ["deer_pelt_3"]    = { model = "hunting_pelt_01_c", hash = `hunting_pelt_01_c`, tier = 4 },

  ["telescope"]      = { carry = true, model = "prop_t_telescope_01b", bone = 24817, x = -0.23, y = 0.43, z = 0.05,
    xr = -10.0, yr = 93.0, zr = 0.0, blockAttack = true, blockCar = true, blockRun = true, },
  ["pcequipment"]    = { carry = true, model = "prop_dyn_pc_02", bone = 24817, x = 0.09, y = 0.43, z = 0.05, xr = 91.0,
    yr = 0.0, zr = -265.0, blockAttack = true, blockCar = true, blockRun = true },
  ["coffeemaker"]    = { carry = true, model = "prop_coffee_mac_02", bone = 24817, x = 0.00, y = 0.43, z = 0.05,
    xr = 91.0, yr = 0.0, zr = -265.0, blockAttack = true, blockCar = true, blockRun = true },
  ["musicequipment"] = { carry = true, model = "prop_speaker_06", bone = 24817, x = 0.00, y = 0.43, z = 0.05, xr = 91.0,
    yr = 0.0, zr = -265.0, blockAttack = true, blockCar = true, blockRun = true },
  ["microwave"]      = { carry = true, model = "prop_microwave_1", bone = 24817, x = -0.20, y = 0.43, z = 0.05, xr = 91.0,
    yr = 0.0, zr = -265.0, blockAttack = true, blockCar = true, blockRun = true },
  ["tube_tv"]        = { carry = true, model = "prop_tv_01", bone = 24817, x = -0.00, y = 0.43, z = 0.05, xr = 0.0,
   yr = -90.0, zr = 180.0, blockAttack = true, blockCar = true, blockRun = true },

  ["printer"]        = { carry = true, model = "prop_printer_01", bone = 24817, x = -0.20, y = 0.43, z = 0.05, xr = 91.0,
    yr = 0.0, zr = -265.0, blockAttack = true, blockCar = true, blockRun = true },
  ["monitor"]        = { carry = true, model = "prop_monitor_w_large", bone = 24817, x = -0.20, y = 0.43, z = 0.05, xr = 0.0,
    yr = 90.0, zr = 0.0, blockAttack = true, blockCar = false, blockRun = false },
  ["tv"]             = { carry = true, model = "prop_tv_flat_michael", bone = 24817, x = 0.0, y = 0.43, z = 0.05, xr = 5.0,
   yr = 90.0, zr = -35.0, blockAttack = true, blockCar = false, blockRun = true },
  ["small_painting"] = {
    carry = true, model = "h4_prop_h4_painting_01c", bone = 24817, x = -0.20, y = 0.7, z = -0.4, xr = 0.0, yr = 0.0,
    zr = 90.0, blockAttack = true, blockCar = true, blockRun = false,
    },



}

local items_attatched = {}
local itemSlots = {}
local override = false

local PlayerData = QBCore.Functions.GetPlayerData()

local FullyLoaded = LocalPlayer.state.isLoggedIn



local function loadmodel(hash)
  if HasModelLoaded(hash) then return end
  RequestModel(hash)
  while not HasModelLoaded(hash) do
    Wait(0)
  end
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ** Weapon Functions ** --


local function getFreeSlot(tier)
  local amount = 0

  for i = 1, #PlayerSlots[tier] do
    if not PlayerSlots[tier][i].isBusy then
      amount = amount + 1
    end
  end

  return amount
end

local function UseSlot(tier)
  local slot = nil
  for i = 1, #PlayerSlots[tier] do
    if not PlayerSlots[tier][i].isBusy then
      PlayerSlots[tier][i].isBusy = true
      slot = i
      break
    end
  end

  return slot
end

local function calcOffsets(x, y, z, xr, yr, zr, item)
  local X, Y, Z, XR, YR, ZR = x, y, z, xr, yr, zr

  if props[item].x then
    X = props[item].x
  end

  if props[item].y then
    Y = props[item].y
  end

  if props[item].z then
    Z = props[item].z
  end

  if props[item].xr then
    XR = props[item].xr
  end


  if props[item].yr then
    YR = props[item].yr
  end

  if props[item].zr then
    ZR = props[item].zr
  end

  return X, Y, Z, XR, YR, ZR
end

local function AttachWeapon(attachModel, modelHash, tier, item)
  local hash = joaat(attachModel)
  local slot = UseSlot(tier)
  if not slot then return end

  local v = PlayerSlots[tier][slot]
  local bone = GetPedBoneIndex(PlayerPedId(), v.bone)

  loadmodel(hash)

  items_attatched[attachModel] = {
    hash = modelHash,
    handle = CreateObject(attachModel, 1.0, 1.0, 1.0, true, true, false),
    slot = slot,
    tier = tier
  }

  local x, y, z, xr, yr, zr = calcOffsets(v.x, v.y, v.z, v.xr, v.yr, v.zr, item)

  AttachEntityToEntity(items_attatched[attachModel].handle, PlayerPedId(), bone, x, y, z, xr, yr, zr, 1, 1, 0, 0, 2, 1)
  SetModelAsNoLongerNeeded(hash)
  SetEntityCompletelyDisableCollision(items_attatched[attachModel].handle, false, true)
end

local WeapDelete = false
local function DeleteWeapon(item)
  local ped = PlayerPedId()
  local hash = items_attatched[item].hash
  if WeapDelete then return end

  WeapDelete = true
  local wait = 0 -- if above 3 seconds then return this function
  while GetSelectedPedWeapon(ped) ~= hash do
    Wait(100)
    wait = wait + 1
    if wait >= 30 then return end -- If they figure out a way to spam then this we just return the function
  end

  if items_attatched[item] then
    DeleteObject(items_attatched[item].handle)

    if items_attatched[item].slot then
      PlayerSlots[items_attatched[item].tier][items_attatched[item].slot].isBusy = false
    end

    items_attatched[item] = nil
  end
  WeapDelete = false
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local carryingBox = nil

local function requestAnimDict(animDict)
  if not HasAnimDictLoaded(animDict) then
    RequestAnimDict(animDict)

    while not HasAnimDictLoaded(animDict) do
      Wait(0)
    end
  end
end

local function doAnim(item)
  if carryingBox then return end -- Only allow the function to be run once at a time
  carryingBox = item
  local ped = PlayerPedId()
  local dict, anim = props[item].dict or 'anim@heists@box_carry@', props[item].anim or 'idle'
  if not anim or not dict then return end

  requestAnimDict(dict)
  CreateThread(function()
    while carryingBox do
      if not IsEntityPlayingAnim(ped, dict, anim, 3) then
        TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
      end

      if props[carryingBox].blockAttack then
        DisableControlAction(0, 24, true)  -- disable attack
        DisableControlAction(0, 25, true)  -- disable aim
        DisableControlAction(0, 47, true)  -- disable weapon
        DisableControlAction(0, 58, true)  -- disable weapon
        DisableControlAction(0, 263, true) -- disable melee
        DisableControlAction(0, 264, true) -- disable melee
        DisableControlAction(0, 257, true) -- disable melee
        DisableControlAction(0, 140, true) -- disable melee
        DisableControlAction(0, 141, true) -- disable melee
        DisableControlAction(0, 142, true) -- disable melee
        DisableControlAction(0, 143, true) -- disable melee
      end

      if props[carryingBox].blockCar and IsPedGettingIntoAVehicle(ped) then
        ClearPedTasksImmediately(ped) -- Stops all tasks for the ped
      end

      if props[carryingBox].blockRun then
        DisableControlAction(0, 22, true) -- disable jumping
        DisableControlAction(0, 21, true) -- disable sprinting
      end

      Wait(1)
    end

    ClearPedTasks(ped)
  end)
end

local function AttatchProp(item)
  if carryingBox then return end
  local ped = PlayerPedId()
  local attachModel = props[item].model
  local hash = joaat(props[item].model)
  local bone = GetPedBoneIndex(ped, props[item].bone)
  SetCurrentPedWeapon(ped, 0xA2719263)
  loadmodel(hash)

  items_attatched[attachModel] = {
    hash = hash,
    handle = CreateObject(attachModel, 1.0, 1.0, 1.0, true, true, false),
    carry = true
  }

  local x, y, z, xr, yr, zr = props[item].x, props[item].y, props[item].z, props[item].xr, props[item].yr, props[item].zr
  AttachEntityToEntity(items_attatched[attachModel].handle, ped, bone, x, y, z, xr, yr, zr, 1, 1, 0, 0, 2, 1)
  SetModelAsNoLongerNeeded(hash)
  SetEntityCompletelyDisableCollision(items_attatched[attachModel].handle, false, true)
  doAnim(item)
end

local tempBox = nil

-- Exports to trick the script into thinking we got an item we can carry --
local function carryProp(item)
  if not item then return print("ITEM NOT DEFINED") end
  if not props[item] then return print("ITEM NOT REGISTERED IN THE CONFIG") end
  if carryingBox then return print("PED IS ALREADY CARRYING AN OBJECT") end
  tempBox = item
  AttatchProp(item)
end

exports('carryProp', carryProp)

local function removeProp(item)
  if not item then return print("ITEM NOT DEFINED") end
  if not props[item] then return print("ITEM NOT REGISTERED IN THE CONFIG") end
  if carryingBox ~= item then return print("Item is not whats being carried...") end
  DeleteObject(items_attatched[props[item].model].handle)
  items_attatched[props[item].model] = nil
  carryingBox = nil
  tempBox = nil
end

exports('removeProp', removeProp)



local carryingChain = nil

local function AttatchChain(attachModel, modelHash, tier, item)
  if carryingChain then return end
  carryingChain = attachModel
  local slot = UseSlot(tier)
  if not slot then return end

  local v = PlayerSlots[tier][slot]
  local bone = GetPedBoneIndex(PlayerPedId(), v.bone)

  loadmodel(modelHash)

  ClearPedTasks(PlayerPedId())


  items_attatched[attachModel] = {
    hash = modelHash,
    handle = CreateObject(attachModel, 1.0, 1.0, 1.0, true, true, false),
    slot = slot,
    tier = tier,
    chain = true,
  }

  local x, y, z, xr, yr, zr = calcOffsets(v.x, v.y, v.z, v.xr, v.yr, v.zr, item)

  AttachEntityToEntity(items_attatched[attachModel].handle, PlayerPedId(), bone, x, y, z, xr, yr, zr, 1, 1, 0, 0, 2, 1)
  SetModelAsNoLongerNeeded(modelHash)
  SetEntityCompletelyDisableCollision(items_attatched[attachModel].handle, false, true)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--** Generic Functions **--

local function getItemByhash(hash)
  for k, v in pairs(props) do
    if v.hash == hash or hash == joaat(v.model) then
      return k
    end
  end
end

local function removeItems()
  if items_attatched then
    for k, v in pairs(items_attatched) do
      local hasitem = false
      local item = getItemByhash(v.hash)
      if item then
        if tempBox ~= item then
          if itemSlots[item] then
            hasitem = true
          end

          if not hasitem or (props[item] and props[item].busy) then
            DeleteObject(v.handle)

            if v.slot then
              PlayerSlots[v.tier][v.slot].isBusy = false
            end

            if v.chain then
              carryingChain = nil
            end

            if v.carry then
              carryingBox = nil
            end

            items_attatched[k] = nil
          end
        end
      end
    end
  end
end

local PlayerId = PlayerId()
local doingCheck = false
local function DoItemCheck()
  if not FullyLoaded then return end
  if doingCheck then return end
  if IsPedShooting(ped) or IsPlayerFreeAiming(PlayerId) then return end -- reduces the shooting spamming
  doingCheck = true
  Wait(math.random(1, 100))                                             -- When shooting a gun, the event is called HUNDREDS of times, this here is to prevent that from affecting the players MS too much at a time.
  local ped = PlayerPedId()
  local items = PlayerData.items
  itemSlots = {}
  if items then
    for _, item in pairs(items) do
      item.name = item.name:lower()
      if item and item.name and props and props[item.name] and not itemSlots[item.name] then
        itemSlots[item.name] = props[item.name]
        if props[item.name].carry then
          if not carryingBox then
            AttatchProp(item.name)
          end
        elseif props[item.name].chain then
          if not carryingChain then
            AttatchChain(props[item.name].model, props[item.name].hash, props[item.name].tier, item.name)
          end
        elseif not items_attatched[props[item.name].model] and GetSelectedPedWeapon(ped) ~= props[item.name].hash and
            getFreeSlot(props[item.name].tier) >= 1 then
          AttachWeapon(props[item.name].model, props[item.name].hash, props[item.name].tier, item.name)
        end
      end
    end
  end

  removeItems()

  Wait(math.random(1, 100)) -- When shooting a gun, the event is called HUNDREDS of times, this here is to prevent that from affecting the players MS too much at a time.
  doingCheck = false
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ** EXPORTS ** --
local function toggleProps()
  if override then
    if items_attatched then
      for k, v in pairs(items_attatched) do
        DeleteObject(v.handle)

        if v.slot then
          PlayerSlots[v.tier][v.slot].isBusy = false
        end

        if v.carry then
          carryingBox = nil
        end

        if v.chain then
          carryingChain = nil
        end

        items_attatched[k] = nil
      end
    end
    override = false
  else
    override = true

    if items_attatched then
      for k, v in pairs(items_attatched) do
        DeleteObject(v.handle)

        if v.slot then
          PlayerSlots[v.tier][v.slot].isBusy = false
        end

        if v.carry then
          carryingBox = nil
        end

        if v.chain then
          carryingChain = nil
        end

        items_attatched[k] = nil
      end
    end
  end
end

exports("toggleProps", toggleProps)

local function isCarryingObject()
  return carryingBox ~= nil and true or false
end

exports('isCarryingObject', isCarryingObject)

local function isCarryingAnObject(item)
  if items_attatched[props[item].model] then return true else return false end
end

exports('isCarryingAnObject', isCarryingAnObject)

local function GetPlayerCarryItems()
  return items_attatched
end

exports('GetPlayerCarryItems', GetPlayerCarryItems)

local function refreshProps()
  if not FullyLoaded then return end
  if items_attatched then
    for k, v in pairs(items_attatched) do
      DeleteObject(v.handle)

      if v.slot then
        PlayerSlots[v.tier][v.slot].isBusy = false
      end

      if v.carry then
        carryingBox = nil
      end

      if v.chain then
        carryingChain = nil
      end

      items_attatched[k] = nil
    end
  end

  DoItemCheck()
end

exports('refreshProps', refreshProps)

local function makeObjectBusy(item, state)
  if not FullyLoaded then return end
  if not item or not state then return print("YOU ARE MISSING ARGS FOR THIS EXPORT") end
  if not props[item] then return print("ITEM: " .. item .. " DOES NOT EXIST") end
  if props[item] and props[item].busy == nil then return print("ITEM: " .. item .. " CANNOT BE SET TO BUSY") end
  props[item].busy = state
  DoItemCheck()
end

exports('makeObjectBusy', makeObjectBusy)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ** GENERIC EVENTS ** --
AddEventHandler('ox_inventory:currentWeapon', function(data)
  if not FullyLoaded then return end
  if override then return end
  if data then
    data.name = data.name:lower()
    if props[data.name] and items_attatched[props[data.name].model] then
      DeleteWeapon(props[data.name].model)
    end
  else
    Wait(1000)
    DoItemCheck()
  end
end)

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(data)
  if data and LocalPlayer.state.isLoggedIn then
    if props[data.name] and items_attatched[props[data.name].model] then
      DeleteWeapon(props[data.name].model)
    end
  elseif not data and LocalPlayer.state.isLoggedIn then
    Wait(1000)
    if not override then DoItemCheck() elseif override and PlayerData.metadata.inside.apartment.apartmentId then DoItemCheck() end
  end
end)

-- Handles state right when the player selects their character and location.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  Wait(20000)
  PlayerData = QBCore.Functions.GetPlayerData()
  FullyLoaded = true
  Wait(250)
  if not override then DoItemCheck() elseif override and PlayerData.metadata.inside.apartment.apartmentId then DoItemCheck() end
end)

-- Resets state on logout, in case of character change.
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  PlayerData = nil
  FullyLoaded = false
end)

-- Handles state when PlayerData is changed. We're just looking for inventory updates.
-- RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
--   PlayerData = val
--   Wait(50)
--   if not override then DoItemCheck() elseif override and PlayerData.metadata.inside.apartment.apartmentId then DoItemCheck() end
-- end)

AddEventHandler('ox_inventory:updateInventory', function(changes)
  PlayerData.items = ox_inventory:GetPlayerItems()
  DoItemCheck()
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
  if GetCurrentResourceName() == resource then
    Wait(100)
    if not FullyLoaded then return end
    DoItemCheck()
  end
end)

AddEventHandler('onResourceStop', function(resource)
  if resource == GetCurrentResourceName() then
    for key, attached_object in pairs(items_attatched) do
      DeleteObject(attached_object.handle)
      items_attatched[key] = nil
    end
  end
end)


AddStateBagChangeHandler('inVehicle', nil, function(_, _, value, _, _)
  if value then
    toggleProps()
  else
    DoItemCheck()
  end
end)

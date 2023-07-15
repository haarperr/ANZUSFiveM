local QBCore = exports['qb-core']:GetCoreObject()

local PlayerJob = {}
local Props = {}
local Targets = {}
local Peds = {}
local Blip = {}
local soundId = GetSoundId()

local itemNames = {}

for item, data in pairs(exports.ox_inventory:Items()) do
  itemNames[item] = { label = data.label, image = item }
end

local function HasItem(item, amount)
  local count = exports.ox_inventory:Search('count', item)
  if count < amount then return false end

  return true
end

------------------------------------------------------------

--Hide the mineshaft doors
CreateModelHide(vector3(-596.04, 2089.01, 131.41), 10.5, -1241212535, true)

--Attempts to disable header icons if JimMenu is enabled
if Config.JimMenu then Config.img = "" end

function removeJob()
  for k in pairs(Targets) do exports['qb-target']:RemoveZone(k) end
  for _, v in pairs(Peds) do
    unloadModel(GetEntityModel(v))
    DeletePed(v)
  end
  for i = 1, #Props do
    unloadModel(GetEntityModel(Props[i]))
    DeleteObject(Props[i])
  end
  for i = 1, #Blip do RemoveBlip(Blip[i]) end
end

function makeJob()
  removeJob()
  if not Config.K4MB1Only then
    if Config.propSpawn then
      --Quickly add outside lighting
      Props[#Props + 1] = makeProp({ coords = vector4(-593.29, 2093.22, 131.7, 110.0), prop = `prop_worklight_02a` }, 1, false)   -- Mineshaft door
      Props[#Props + 1] = makeProp({ coords = vector4(-604.55, 2089.74, 131.15, 300.0), prop = `prop_worklight_02a` }, 1, false)  -- Mineshaft door 2
      Props[#Props + 1] = makeProp({ coords = vector4(2991.59, 2758.07, 42.68, 250.85), prop = `prop_worklight_02a` }, 1, false)  -- Quarry Light
      Props[#Props + 1] = makeProp({ coords = vector4(2991.11, 2758.02, 42.66, 194.6), prop = `prop_worklight_02a` }, 1, false)   -- Quarry Light
      Props[#Props + 1] = makeProp({ coords = vector4(2971.78, 2743.33, 43.29, 258.54), prop = `prop_worklight_02a` }, 1, false)  -- Quarry Light
      Props[#Props + 1] = makeProp({ coords = vector4(3000.72, 2777.08, 43.08, 211.7), prop = `prop_worklight_02a` }, 1, false)   -- Quarry Light
      Props[#Props + 1] = makeProp({ coords = vector4(2998.0, 2767.45, 42.71, 249.22), prop = `prop_worklight_02a` }, 1, false)   -- Quarry Light
      Props[#Props + 1] = makeProp({ coords = vector4(2959.93, 2755.26, 43.71, 164.24), prop = `prop_worklight_02a` }, 1, false)  -- Quarry Light
      Props[#Props + 1] = makeProp({ coords = vector4(1106.46, -1991.44, 31.49, 185.78), prop = `prop_worklight_02a` }, 1, false) -- Foundary Light
      if Config.HangingLights then
        for k, v in pairs(Config.MineLights) do
          if Config.propSpawn then Props[#Props + 1] = makeProp({ coords = v, prop = `xs_prop_arena_lights_ceiling_l_c` }, 1, false) end
        end
      end
      if not Config.HangingLights then
        for k, v in pairs(Config.WorkLights) do
          if Config.propSpawn then Props[#Props + 1] = makeProp({ coords = v, prop = `prop_worklight_03a` }, 1, false) end
        end
      end
    end
    --Smelter to turn stone into ore
    for k, v in pairs(Config.Locations["Smelter"]) do
      if Config.Blips and v.blipTrue then Blip[#Blip + 1] = makeBlip(v) end
      Targets["Smelter" .. k] =
          exports['qb-target']:AddCircleZone("Smelter" .. k, v.coords.xyz, 3.0, { name = "Smelter" .. k, debugPoly = Config.Debug, useZ = true, },
            {
              options = {
                {
                  event = "jim-mining:CraftMenu",
                  icon = "fas fa-fire-burner",
                  label = Loc[Config.Lan].info["use_smelter"],
                  craftable = Crafting.SmeltMenu,
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                  job = Config.Job
                }, },
              distance = 2.0
            })
    end
    --Ore Buying Ped
    for k, v in pairs(Config.Locations["OreBuyer"]) do
      Peds[#Peds + 1] = makePed(v.model, v.coords, 1, 1, v.scenario)
      if Config.Blips and v.blipTrue then Blip[#Blip + 1] = makeBlip(v) end
      local name = "OreBuyer" .. k
      Targets[name] =
          exports['qb-target']:AddCircleZone(name, v.coords.xyz, 0.9, { name = name, debugPoly = Config.Debug, useZ = true, },
            {
              options = { {
                event = "jim-mining:SellOre",
                icon = "fas fa-sack-dollar",
                label = Loc[Config.Lan].info["sell_ores"],
                ped = Peds[#Peds],
                job = Config.Job,
                canInteract = function()
                  if lib.progressActive() then return false end
                  return true
                end,
              }, },
              distance = 2.0
            })
    end

    --Jewel Cutting Bench
    for k, v in pairs(Config.Locations["JewelCut"]) do
      if Config.Blips and v.blipTrue then Blip[#Blip + 1] = makeBlip(v) end
      Props[#Props + 1] = makeProp(v, 1, false)
      Targets["JewelCut" .. k] =
          exports['qb-target']:AddCircleZone("JewelCut" .. k, v.coords.xyz, 2.0, { name = "JewelCut" .. k, debugPoly = Config.Debug, useZ = true, },
            {
              options = { {
                event = "jim-mining:JewelCut",
                icon = "fas fa-gem",
                label = Loc[Config.Lan].info["jewelcut"],
                bench = Props[#Props],
                job = Config.Job,
                canInteract = function()
                  if lib.progressActive() then return false end
                  return true
                end,
              }, },
              distance = 2.0
            })
    end
    --Cracking Bench
    for k, v in pairs(Config.Locations["Cracking"]) do
      Props[#Props + 1] = makeProp(v, 1, false)
      if Config.Blips and v.blipTrue then Blip[#Blip + 1] = makeBlip(v) end
      Targets["Cracking" .. k] =
          exports['qb-target']:AddCircleZone("Cracking" .. k, v.coords.xyz, 1.2, { name = "Cracking" .. k, debugPoly = Config.Debug, useZ = true, },
            {
              options = {
                {
                  event = "jim-mining:CrackStart",
                  icon = "fas fa-compact-disc",
                  item = "stone",
                  label = Loc[Config.Lan].info["crackingbench"],
                  bench = Props[#Props],
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                }, },
              distance = 2.0
            })
    end
    --Stone Washing
    --Ore Spawning
    for k, v in pairs(Config.OrePositions) do
      Props[#Props + 1] = makeProp({ coords = v, prop = `cs_x_rubweec` }, 1, false)
      Targets["Ore" .. k] =
          exports['qb-target']:AddCircleZone("Ore" .. k, vector3(v.x, v.y, v.z - 1.03), 1.2, { name = "Ore" .. k, debugPoly = Config.Debug, useZ = true, },
            {
              options = {
                {
                  event = "jim-mining:MineOre:Pick",
                  icon = "fas fa-hammer",
                  item = "pickaxe",
                  label = Loc[Config.Lan].info["mine_ore"] ..
                      " (" .. itemNames["pickaxe"].label .. ")",
                  job =
                      Config.Job,
                  name =
                      "Ore" .. k,
                  stone =
                      Props[#Props],
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                },
                {
                  event = "jim-mining:MineOre:Drill",
                  icon = "fas fa-screwdriver",
                  item = "miningdrill",
                  label = Loc[Config.Lan].info["mine_ore"] ..
                      " (" .. itemNames["miningdrill"].label .. ")",
                  job =
                      Config.Job,
                  name =
                      "Ore" .. k,
                  stone =
                      Props[#Props],
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                },
                {
                  event = "jim-mining:MineOre:Laser",
                  icon = "fas fa-screwdriver-wrench",
                  item = "mininglaser",
                  label = Loc[Config.Lan].info["mine_ore"] ..
                      " (" .. itemNames["mininglaser"].label .. ")",
                  job =
                      Config.Job,
                  name =
                      "Ore" .. k,
                  stone =
                      Props[#Props],
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                },
              },
              distance = 1.3
            })
      Props[#Props + 1] = makeProp({ coords = vector4(v.x, v.y, v.z + 0.25, v[4]), prop = `prop_rock_5_a` }, 1, false)
    end
  else
    Config.K4MB1 = true
  end

  if Config.K4MB1 then
    --Smelter to turn stone into ore
    for k, v in pairs(K4MB1["Smelter"]) do
      Targets["K4MB1Smelter" .. k] =
          exports['qb-target']:AddCircleZone("K4MB1Smelter" .. k, v.coords.xyz, 1.5, { name = "K4MB1Smelter" .. k, debugPoly = Config.Debug, useZ = true, },
            {
              options = {
                {
                  event = "jim-mining:CraftMenu",
                  icon = "fas fa-fire-burner",
                  label = Loc[Config.Lan].info["use_smelter"],
                  craftable = Crafting.SmeltMenu,
                  job = Config.Job,
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                }, },
              distance = 2.0
            })
      if Config.Blips and v.blipTrue then Blip[#Blip + 1] = makeBlip(v) end
    end
    --Ore Buying Ped
    for k, v in pairs(K4MB1["OreBuyer"]) do
      if Config.Blips and v.blipTrue then Blip[#Blip + 1] = makeBlip(v) end
      Peds[#Peds + 1] = makePed(v.model, v.coords, 1, 1, v.scenario)
      Targets["K4MB1OreBuyer" .. k] =
          exports['qb-target']:AddCircleZone("K4MB1OreBuyer" .. k, v.coords.xyz, 0.9, { name = "K4MB1OreBuyer" .. k, debugPoly = Config.Debug, useZ = true, },
            {
              options = {
                {
                  event = "jim-mining:SellOre",
                  icon = "fas fa-sack-dollar",
                  label = Loc[Config.Lan].info["sell_ores"],
                  ped = Peds[#Peds],
                  job = Config.Job,
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                },
              },
              distance = 2.0
            })
    end

    --Jewel Cutting Bench
    for k, v in pairs(K4MB1["JewelCut"]) do
      Props[#Props + 1] = makeProp(v, 1, false)
      Targets["K4MB1JewelCut" .. k] =
          exports['qb-target']:AddCircleZone("K4MB1JewelCut" .. k, v.coords.xyz, 2.0, { name = "K4MB1JewelCut" .. k, debugPoly = Config.Debug, useZ = true, },
            {
              options = { {
                event = "jim-mining:JewelCut",
                icon = "fas fa-gem",
                label = Loc[Config.Lan].info["jewelcut"],
                job = Config.Job,
                bench = Props[#Props],
                canInteract = function()
                  if lib.progressActive() then return false end
                  return true
                end,
              }, },
              distance = 2.0
            })
      if Config.Blips and v.blipTrue then Blip[#Blip + 1] = makeBlip(v) end
    end
    --Cracking Bench
    for k, v in pairs(K4MB1["Cracking"]) do
      if Config.Blips and v.blipTrue then Blip[#Blip + 1] = makeBlip(v) end
      Props[#Props + 1] = makeProp(v, 1, false)
      Targets["K4MB1Cracking" .. k] =
          exports['qb-target']:AddCircleZone("K4MB1Cracking" .. k, v.coords.xyz, 1.2, { name = "K4MB1Cracking" .. k, debugPoly = Config.Debug, useZ = true, },
            {
              options = {
                {
                  event = "jim-mining:CrackStart",
                  icon = "fas fa-compact-disc",
                  item = "stone",
                  label = Loc[Config.Lan].info["crackingbench"],
                  bench = Props[#Props],
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                }, },
              distance = 2.0
            })
    end
    --Ore Spawning
    for k, v in pairs(K4MB1["OrePositions"]) do
      Props[#Props + 1] = makeProp({ coords = v, prop = `cs_x_rubweec` }, 1, false)
      Targets["K4MB1Ore" .. k] =
          exports['qb-target']:AddCircleZone("K4MB1Ore" .. k, vector3(v.x, v.y, v.z - 1.03), 1.2, { name = "K4MB1Ore" .. k, debugPoly = Config.Debug, useZ = true, },
            {
              options = {
                {
                  event = "jim-mining:MineOre:Pick",
                  icon = "fas fa-hammer",
                  item = "pickaxe",
                  label = Loc[Config.Lan].info["mine_ore"] ..
                      " (" .. itemNames["pickaxe"].label .. ")",
                  job =
                      Config.Job,
                  name =
                      "K4MB1Ore" .. k,
                  stone =
                      Props[#Props],
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                },
                {
                  event = "jim-mining:MineOre:Drill",
                  icon = "fas fa-screwdriver",
                  item = "miningdrill",
                  label = Loc[Config.Lan].info["mine_ore"] ..
                      " (" .. itemNames["miningdrill"].label .. ")",
                  job =
                      Config.Job,
                  name =
                      "K4MB1Ore" .. k,
                  stone =
                      Props[#Props],
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                },
                {
                  event = "jim-mining:MineOre:Laser",
                  icon = "fas fa-screwdriver-wrench",
                  item = "mininglaser",
                  label = Loc[Config.Lan].info["mine_ore"] ..
                      " (" .. itemNames["mininglaser"].label .. ")",
                  job =
                      Config.Job,
                  name =
                      "K4MB1Ore" .. k,
                  stone =
                      Props[#Props],
                  canInteract = function()
                    if lib.progressActive() then return false end
                    return true
                  end,
                },
              },
              distance = 1.3
            })
      Props[#Props + 1] = makeProp({ coords = vector4(v.x, v.y, v.z + 0.25, v[4]), prop = `prop_rock_5_a` }, 1, false)
    end
  end
  for k, v in pairs(Config.Locations["Washing"]) do
    Targets["Washing" .. k] =
        exports['qb-target']:AddCircleZone("Washing" .. k, v.coords.xyz, 9.0, { name = "Washing" .. k, debugPoly = Config.Debug, useZ = true, },
          {
            options = { {
              event = "jim-mining:WashStart",
              icon = "fas fa-hands-bubbles",
              item = "stone",
              label = Loc[Config.Lan].info["washstone"],
              coords = v.coords,
              canInteract = function()
                if lib.progressActive() then return false end
                return true
              end,
            }, },
            distance = 2.0
          })
    if Config.Blips and v.blipTrue then Blip[#Blip + 1] = makeBlip(v) end
  end
  --Panning
  for k, v in pairs(Config.Locations["Panning"]) do
    Targets["Panning" .. k] =
        exports['qb-target']:AddCircleZone("Panning" .. k, v.coords.xyz, 9.0, { name = "Panning" .. k, debugPoly = Config.Debug, useZ = true, },
          {
            options = { {
              event = "jim-mining:PanStart",
              icon = "fas fa-ring",
              item = "goldpan",
              label = Loc[Config.Lan].info["goldpan"],
              coords = v.coords,
              canInteract = function()
                if lib.progressActive() then return false end
                return true
              end,
            }, },
            distance = 2.0
          })
    if Config.Blips and v.blipTrue then Blip[#Blip + 1] = makeBlip(v) end
  end
  --Jewel Buyer
  for k, v in pairs(Config.Locations["JewelBuyer"]) do
    Peds[#Peds + 1] = makePed(v.model, v.coords, 1, 1, v.scenario)
    Targets["JewelBuyer" .. k] =
        exports['qb-target']:AddCircleZone("JewelBuyer" .. k, v.coords.xyz, 1.2, { name = "JewelBuyer" .. k, debugPoly = Config.Debug, useZ = true, },
          {
            options = { {
              event = "jim-mining:JewelSell",
              icon = "fas fa-gem",
              label = Loc[Config.Lan].info["jewelbuyer"],
              ped = Peds[#Peds],
              job = Config.Job,
              canInteract = function()
                if lib.progressActive() then return false end
                return true
              end,
            }, },
            distance = 2.0
          })
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job end)
  if Config.Job then if PlayerJob.name == Config.Job then makeJob() else removeJob() end else makeJob() end
end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerJob = JobInfo
  if Config.Job then if PlayerJob.name == Config.Job then makeJob() else removeJob() end end
end)
AddEventHandler('onResourceStart', function(resource)
  if GetCurrentResourceName() ~= resource then return end
  QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job end)
  if Config.Job then if PlayerJob.name == Config.Job then makeJob() else removeJob() end else makeJob() end
end)

--------------------------------------------------------
RegisterNetEvent('jim-mining:openShop', function()
  if Config.JimShops then event = "jim-shops:ShopOpen" else event = "inventory:server:OpenInventory" end
  TriggerServerEvent(event, "shop", "mine", Config.Items)
end)

function stoneBreak(name, stone)
  local rockcoords = GetEntityCoords(stone)
  if Config.Debug then print("^5Debug^7: ^2Hiding prop and target^7: '^6" .. name .. "^7' ^2at coords^7: ^6" .. rockcoords) end
  --Stone CoolDown + Recreation
  SetEntityAlpha(stone, 0)
  --CreateModelHide(rockcoords, 1.0, `cs_x_rubweec`, true)
  exports['qb-target']:RemoveZone(name)
  Targets[name] = nil
  Wait(Config.Timings["OreRespawn"])
  --Unhide Stone and create a new target location
  SetEntityAlpha(stone, 255)
  --RemoveModelHide(rockcoords, 1.0, `cs_x_rubweec`, true)
  Targets[name] =
      exports['qb-target']:AddCircleZone(name, vector3(rockcoords.x, rockcoords.y, rockcoords.z), 1.2, { name = name, debugPoly = Config.Debug, useZ = true, },
        {
          options = {
            {
              event = "jim-mining:MineOre:Pick",
              icon = "fas fa-hammer",
              item = "pickaxe",
              label = Loc[Config.Lan].info["mine_ore"] ..
                  " (" .. itemNames["pickaxe"].label .. ")",
              job =
                  Config.Job,
              name =
                  name,
              stone =
                  stone
            },
            {
              event = "jim-mining:MineOre:Drill",
              icon = "fas fa-screwdriver",
              item = "miningdrill",
              label = Loc[Config.Lan].info["mine_ore"] ..
                  " (" .. itemNames["miningdrill"].label .. ")",
              job =
                  Config.Job,
              name =
                  name,
              stone =
                  stone
            },
            {
              event = "jim-mining:MineOre:Laser",
              icon = "fas fa-screwdriver-wrench",
              item = "mininglaser",
              label = Loc[Config.Lan].info["mine_ore"] ..
                  " (" .. itemNames["mininglaser"].label .. ")",
              job =
                  Config.Job,
              name =
                  name,
              stone =
                  stone
            },
          },
          distance = 1.3
        })
end

local isMining = false
RegisterNetEvent('jim-mining:MineOre:Drill', function(data)
  if isMining then return else isMining = true end -- Stop players from doubling up the event
  if HasItem("drillbit", 1) then
    -- Sounds & Anim loading
    loadDrillSound()
    local dict = "anim@heists@fleeca_bank@drilling"
    local anim = "drill_straight_fail"
    loadAnimDict(tostring(dict))
    --Create Drill and Attach
    local DrillObject = CreateObject(`hei_prop_heist_drill`, GetEntityCoords(PlayerPedId(), true), true, true, true)
    AttachEntityToEntity(DrillObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
    local IsDrilling = true
    local rockcoords = GetEntityCoords(data.stone)
    --Calculate if you're heading is within 20.0 degrees -
    lookEnt(data.stone)
    if #(rockcoords - GetEntityCoords(PlayerPedId())) > 1.5 then
      TaskGoStraightToCoord(PlayerPedId(), rockcoords, 0.5, 400, 0.0, 0)
      Wait(400)
    end
    TaskPlayAnim(PlayerPedId(), tostring(dict), tostring(anim), 3.0, 3.0, -1, 1, 0, false, false, false)
    Wait(200)
    PlaySoundFromEntity(soundId, "Drill", DrillObject, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
    CreateThread(function() -- Dust/Debris Animation
      loadPtfxDict("core")
      while IsDrilling do
        UseParticleFxAsset("core")
        local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_rocks", rockcoords.x, rockcoords.y, rockcoords.z, 0.0, 0.0, GetEntityHeading(PlayerPedId()) - 180.0,
          1.0, 0.0, 0.0, 0.0)
        Wait(600)
      end
    end)
    QBCore.Functions.Progressbar("open_locker_drill", Loc[Config.Lan].info["drilling_ore"], Config.Timings["Mining"], false, true, {
      disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
      StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_fail", 1.0)
      destroyProp(DrillObject)
      unloadPtfxDict("core")
      unloadAnimDict(dict)
      TriggerServerEvent('jim-mining:MineReward')
      --Destroy drill bit chances
      if math.random(1, 10) >= 8 then
        local breakId = GetSoundId()
        PlaySoundFromEntity(breakId, "Drill_Pin_Break", PlayerPedId(), "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
        toggleItem(0, "drillbit", 1)
      end
      unloadDrillSound()
      StopSound(soundId)
      IsDrilling = false
      isMining = false
      stoneBreak(data.name, data.stone)
    end, function() -- Cancel
      StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
      unloadDrillSound()
      StopSound(soundId)
      destroyProp(DrillObject)
      unloadPtfxDict("core")
      unloadAnimDict(dict)
      IsDrilling = false
      isMining = false
    end, "miningdrill")
  else
    triggerNotify(nil, Loc[Config.Lan].error["no_drillbit"], nil)
    isMining = false
    return
  end
end)

RegisterNetEvent('jim-mining:MineOre:Pick', function(data)
  if isMining then return else isMining = true end -- Stop players from doubling up the event
  -- Anim Loading
  local dict = "amb@world_human_hammering@male@base"
  local anim = "base"
  loadAnimDict(tostring(dict))
  loadDrillSound()
  --Create Pickaxe and Attach
  local PickAxe = CreateObject(`prop_tool_pickaxe`, GetEntityCoords(PlayerPedId(), true), true, true, true)
  DisableCamCollisionForObject(PickAxe)
  DisableCamCollisionForEntity(PickAxe)
  AttachEntityToEntity(PickAxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, -0.53, -0.22, 252.0, 180.0, 0.0, false, true, true, true, 0, true)
  local IsDrilling = true
  local rockcoords = GetEntityCoords(data.stone)
  --Calculate if you're facing the stone--
  lookEnt(data.stone)
  if #(rockcoords - GetEntityCoords(PlayerPedId())) > 1.5 then
    TaskGoStraightToCoord(PlayerPedId(), rockcoords, 0.5, 400, 0.0, 0)
    Wait(400)
  end
  loadPtfxDict("core")
  CreateThread(function()
    while IsDrilling do
      UseParticleFxAsset("core")
      TaskPlayAnim(PlayerPedId(), tostring(dict), tostring(anim), 8.0, -8.0, -1, 2, 0, false, false, false)
      Wait(200)
      local pickcoords = GetOffsetFromEntityInWorldCoords(PickAxe, -0.4, 0.0, 0.7)
      local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_rocks", pickcoords.x, pickcoords.y, pickcoords.z, 0.0, 0.0, 0.0, 0.4, 0.0, 0.0, 0.0)
      Wait(350)
    end
  end)
  QBCore.Functions.Progressbar("open_locker_drill", Loc[Config.Lan].info["drilling_ore"], Config.Timings["Pickaxe"], false, true, {
    disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
    StopAnimTask(PlayerPedId(), tostring(dict), tostring(anim), 1.0)
    destroyProp(PickAxe)
    unloadPtfxDict("core")
    unloadAnimDict(dict)
    TriggerServerEvent('jim-mining:MineReward')
    if math.random(1, 10) >= 9 then
      local breakId = GetSoundId()
      PlaySoundFromEntity(breakId, "Drill_Pin_Break", PlayerPedId(), "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
      toggleItem(false, "pickaxe", 1)
    end
    unloadDrillSound()
    StopSound(soundId)
    IsDrilling = false
    isMining = false
    stoneBreak(data.name, data.stone)
  end, function() -- Cancel
    StopAnimTask(PlayerPedId(), tostring(dict), tostring(anim), 1.0)
    destroyProp(PickAxe)
    unloadPtfxDict("core")
    unloadAnimDict(dict)
    unloadDrillSound()
    StopSound(soundId)
    IsDrilling = false
    isMining = false
  end, "pickaxe")
end)

RegisterNetEvent('jim-mining:MineOre:Laser', function(data)
  if isMining then return else isMining = true end -- Stop players from doubling up the event
  -- Sounds & Anim Loading
  RequestAmbientAudioBank("DLC_HEIST_BIOLAB_DELIVER_EMP_SOUNDS", 0)
  RequestAmbientAudioBank("dlc_xm_silo_laser_hack_sounds", 0)
  local dict = "anim@heists@fleeca_bank@drilling"
  local anim = "drill_straight_fail"
  loadAnimDict(tostring(dict))
  --Create Drill and Attach
  local DrillObject = CreateObject(`ch_prop_laserdrill_01a`, GetEntityCoords(PlayerPedId(), true), true, true, true)
  AttachEntityToEntity(DrillObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
  local IsDrilling = true
  local rockcoords = GetEntityCoords(data.stone)
  --Calculate if you're facing the stone--
  lookEnt(data.stone)
  --Activation noise & Anims
  TaskPlayAnim(PlayerPedId(), tostring(dict), 'drill_straight_idle', 3.0, 3.0, -1, 1, 0, false, false, false)
  PlaySoundFromEntity(soundId, "Pass", DrillObject, "dlc_xm_silo_laser_hack_sounds", 1, 0)
  Wait(1000)
  TaskPlayAnim(PlayerPedId(), tostring(dict), tostring(anim), 3.0, 3.0, -1, 1, 0, false, false, false)
  PlaySoundFromEntity(soundId, "EMP_Vehicle_Hum", DrillObject, "DLC_HEIST_BIOLAB_DELIVER_EMP_SOUNDS", 1, 0) --Not sure about this sound, best one I could find as everything else wouldn't load
  --Laser & Debris Effect
  local lasercoords = GetOffsetFromEntityInWorldCoords(DrillObject, 0.0, -0.5, 0.02)
  CreateThread(function()
    loadPtfxDict("core")
    while IsDrilling do
      UseParticleFxAsset("core")
      local laser = StartNetworkedParticleFxNonLoopedAtCoord("muz_railgun", lasercoords.x, lasercoords.y, lasercoords.z, 0, -10.0, GetEntityHeading(DrillObject) + 270, 1.0,
        0.0, 0.0, 0.0)
      UseParticleFxAsset("core")
      local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_rocks", rockcoords.x, rockcoords.y, rockcoords.z, 0.0, 0.0, GetEntityHeading(PlayerPedId()) - 180.0, 1.0,
        0.0, 0.0, 0.0)
      Wait(60)
    end
  end)
  QBCore.Functions.Progressbar("open_locker_drill", Loc[Config.Lan].info["drilling_ore"], (Config.Timings["Laser"]), false, true, {
    disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
    IsDrilling = false
    isMining = false
    StopAnimTask(PlayerPedId(), tostring(dict), tostring(anim), 1.0)
    ReleaseAmbientAudioBank("DLC_HEIST_BIOLAB_DELIVER_EMP_SOUNDS")
    ReleaseAmbientAudioBank("dlc_xm_silo_laser_hack_sounds")
    StopSound(soundId)
    destroyProp(DrillObject)
    unloadPtfxDict("core")
    unloadAnimDict(dict)
    TriggerServerEvent('jim-mining:MineReward')
    stoneBreak(data.name, data.stone)
  end, function() -- Cancel
    IsDrilling = false
    isMining = false
    StopAnimTask(PlayerPedId(), tostring(dict), tostring(anim), 1.0)
    ReleaseAmbientAudioBank("DLC_HEIST_BIOLAB_DELIVER_EMP_SOUNDS")
    ReleaseAmbientAudioBank("dlc_xm_silo_laser_hack_sounds")
    StopSound(soundId)
    destroyProp(DrillObject)
    unloadPtfxDict("core")
    unloadAnimDict(dict)
    stoneBreak(data.name, data.stone)
    IsDrilling = false
    isMining = false
  end, "mininglaser")
end)
------------------------------------------------------------
-- Cracking Command / Animations
local Cracking = false
RegisterNetEvent('jim-mining:CrackStart', function(data)
  if Cracking then return end
  local cost = 1
  if HasItem("stone", cost) then
    Cracking = true
    LocalPlayer.state:set("invBusy", true, true)
    TriggerEvent('inventory:client:busy:status', true)
    TriggerEvent('canUseInventoryAndHotbar:toggle', false)
    -- Sounds & Anim Loading
    local dict = "amb@prop_human_parking_meter@male@idle_a"
    local anim = "idle_a"
    loadAnimDict(dict)
    loadDrillSound()
    local benchcoords = GetOffsetFromEntityInWorldCoords(data.bench, 0.0, -0.2, 2.08)
    --Calculate if you're facing the bench--
    lookEnt(data.bench)
    if #(benchcoords - GetEntityCoords(PlayerPedId())) > 1.5 then
      TaskGoStraightToCoord(PlayerPedId(), benchcoords, 0.5, 400, 0.0, 0)
      Wait(400)
    end

    local Rock = CreateObject(`prop_rock_5_smash1`, vector3(benchcoords.x, benchcoords.y, benchcoords.z - 1.03), true, true, true)
    PlaySoundFromCoord(soundId, "Drill", benchcoords, "DLC_HEIST_FLEECA_SOUNDSET", 0, 4.5, 0)
    loadPtfxDict("core")
    CreateThread(function()
      while Cracking do
        UseParticleFxAsset("core")
        local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_rocks", benchcoords.x, benchcoords.y, benchcoords.z - 0.9, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0)
        Wait(400)
      end
    end)
    TaskPlayAnim(PlayerPedId(), dict, anim, 3.0, 3.0, -1, 1, 0, false, false, false)
    QBCore.Functions.Progressbar("open_locker_drill", Loc[Config.Lan].info["cracking_stone"], Config.Timings["Cracking"], false, true, {
      disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
      StopAnimTask(PlayerPedId(), dict, anim, 1.0)
      unloadDrillSound()
      StopSound(soundId)
      unloadPtfxDict("core")
      unloadAnimDict(dict)
      destroyProp(Rock)
      TriggerServerEvent('jim-mining:CrackReward', cost)
      LocalPlayer.state:set("invBusy", false, true)
      TriggerEvent('inventory:client:busy:status', false)
      TriggerEvent('canUseInventoryAndHotbar:toggle', true)
      Cracking = false
    end, function() -- Cancel
      StopAnimTask(PlayerPedId(), dict, anim, 1.0)
      unloadDrillSound()
      StopSound(soundId)
      unloadPtfxDict("core")
      unloadAnimDict(dict)
      destroyProp(Rock)
      LocalPlayer.state:set("invBusy", false, true)
      TriggerEvent('inventory:client:busy:status', false)
      TriggerEvent('canUseInventoryAndHotbar:toggle', true)
      Cracking = false
    end, "stone")
  else
    triggerNotify(nil, Loc[Config.Lan].error["no_stone"], 'error')
  end
end)
------------------------------------------------------------
-- Washing Command / Animations
local Washing = false
RegisterNetEvent('jim-mining:WashStart', function(data)
  if Washing then return end
  local cost = 1
  if HasItem("stone", cost) then
    Washing = true
    LocalPlayer.state:set("invBusy", true, true)
    TriggerEvent('inventory:client:busy:status', true)
    TriggerEvent('canUseInventoryAndHotbar:toggle', false)
    --Create Rock and Attach
    local Rock = CreateObject(`prop_rock_5_smash1`, GetEntityCoords(PlayerPedId()), true, true, true)
    local rockcoords = GetEntityCoords(Rock)
    AttachEntityToEntity(Rock, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.1, 0.0, 0.05, 90.0, -90.0, 90.0, true, true, false, true, 1, true)
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    local water
    CreateThread(function()
      Wait(3000)
      loadPtfxDict("core")
      while Washing do
        UseParticleFxAsset("core")
        water = StartNetworkedParticleFxLoopedOnEntity("water_splash_veh_out", PlayerPedId(), 0.0, 1.0, -0.2, 0.0, 0.0, 0.0, 2.0, 0, 0, 0)
        Wait(500)
      end
    end)
    QBCore.Functions.Progressbar("open_locker_drill", Loc[Config.Lan].info["washing_stone"], Config.Timings["Washing"], false, true, {
      disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
      TriggerServerEvent('jim-mining:WashReward', cost)
      LocalPlayer.state:set("invBusy", false, true)
      TriggerEvent('inventory:client:busy:status', false)
      TriggerEvent('canUseInventoryAndHotbar:toggle', true)
      StopParticleFxLooped(water, 0)
      destroyProp(Rock)
      unloadPtfxDict("core")
      Washing = false
    end, function() -- Cancel
      LocalPlayer.state:set("invBusy", false, true)
      TriggerEvent('inventory:client:busy:status', false)
      TriggerEvent('canUseInventoryAndHotbar:toggle', true)
      StopParticleFxLooped(water, 0)
      destroyProp(Rock)
      unloadPtfxDict("core")
      Washing = false
    end, "stone")
  else
    triggerNotify(nil, Loc[Config.Lan].error["no_stone"], 'error')
  end
end)
------------------------------------------------------------
-- Gold Panning Command / Animations
local Panning = false
RegisterNetEvent('jim-mining:PanStart', function(data)
  if IsEntityInWater(PlayerPedId()) then
    if Panning then return else Panning = true end
    LocalPlayer.state:set("invBusy", true, true)
    TriggerEvent('inventory:client:busy:status', true)
    TriggerEvent('canUseInventoryAndHotbar:toggle', false)
    --Create Rock and Attach
    local trayCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.5, -0.9)
    Props[#Props + 1] = makeProp({ coords = vector4(trayCoords.x, trayCoords.y, trayCoords.z + 1.03, GetEntityHeading(PlayerPedId())), prop = `bkr_prop_meth_tray_01b` }, 1, 1)
    CreateThread(function()
      loadPtfxDict("core")
      while Panning do
        UseParticleFxAsset("core")
        local water = StartNetworkedParticleFxLoopedOnEntity("water_splash_veh_out", Props[#Props], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 0, 0, 0)
        Wait(100)
      end
    end)
    --Start Anim
    TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", 0, true)
    QBCore.Functions.Progressbar("open_locker_drill", Loc[Config.Lan].info["goldpanning"], Config.Timings["Panning"], false, true, {
      disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
      TriggerServerEvent('jim-mining:PanReward')
      ClearPedTasksImmediately(PlayerPedId())
      TaskGoStraightToCoord(PlayerPedId(), trayCoords, 4.0, 100, GetEntityHeading(PlayerPedId()), 0)
      destroyProp(Props[#Props])
      unloadPtfxDict("core")
      LocalPlayer.state:set("invBusy", false, true)
      TriggerEvent('inventory:client:busy:status', false)
      TriggerEvent('canUseInventoryAndHotbar:toggle', true)
      Panning = false
    end, function() -- Cance
      ClearPedTasksImmediately(PlayerPedId())
      TaskGoStraightToCoord(PlayerPedId(), trayCoords, 4.0, 100, GetEntityHeading(PlayerPedId()), 0)
      destroyProp(Props[#Props])
      unloadPtfxDict("core")
      LocalPlayer.state:set("invBusy", false, true)
      TriggerEvent('inventory:client:busy:status', false)
      TriggerEvent('canUseInventoryAndHotbar:toggle', true)
      Panning = false
    end, "goldpan")
  end
end)

RegisterNetEvent('jim-mining:MakeItem', function(data)
  if data.ret then
    if not HasItem("drillbit", 1) then
      triggerNotify(nil, Loc[Config.Lan].error["no_drillbit"], 'error')
      TriggerEvent('jim-mining:JewelCut')
      return
    end
  end
  itemProgress(data)
end)

function itemProgress(data)
  if data.craftable then
    if not data.ret then
      bartext = Loc[Config.Lan].info["smelting"] .. itemNames[data.item].label
    else
      bartext = Loc[Config.Lan].info["cutting"] .. itemNames[data.item].label
    end
  end
  LocalPlayer.state:set("invBusy", true, true)
  TriggerEvent('inventory:client:busy:status', true)
  TriggerEvent('canUseInventoryAndHotbar:toggle', false)
  local isDrilling = true
  if data.ret then -- If jewelcutting
    local drillcoords
    local scene
    local dict = "anim@amb@machinery@speed_drill@"
    local anim = "operate_02_hi_amy_skater_01"
    loadAnimDict(tostring(dict))
    for _, v in pairs(Props) do
      if #(GetEntityCoords(v) - GetEntityCoords(PlayerPedId())) <= 2.0 and GetEntityModel(v) == `gr_prop_gr_speeddrill_01c` then
        loadDrillSound()
        PlaySoundFromEntity(soundId, "Drill", v, "DLC_HEIST_FLEECA_SOUNDSET", 0.5, 0)
        drillcoords = GetOffsetFromEntityInWorldCoords(v, 0.0, -0.15, 0.0)
        scene = NetworkCreateSynchronisedScene(GetEntityCoords(v), GetEntityRotation(v), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, tostring(dict), tostring(anim), 0, 0, 0, 16, 1148846080, 0)
        NetworkStartSynchronisedScene(scene)
        break
      end
    end
    CreateThread(function()
      loadPtfxDict("core")
      while isDrilling do
        if not drillcoords then return end
        UseParticleFxAsset("core")
        local dust = StartNetworkedParticleFxNonLoopedAtCoord("glass_side_window", drillcoords.x, drillcoords.y, drillcoords.z + 1.1, 0.0, 0.0,
          GetEntityHeading(PlayerPedId()) + math.random(0, 359), 0.2, 0.0, 0.0, 0.0)
        Wait(100)
      end
    end)
  else -- If not Jewel Cutting, you'd be smelting (need to work out what is possible for this)
    animDictNow = "amb@prop_human_parking_meter@male@idle_a"
    animNow = "idle_a"
  end
  QBCore.Functions.Progressbar('making_food', bartext, Config.Timings["Crafting"], false, true,
    { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
    { animDict = animDictNow, anim = animNow, flags = 8, }, {}, {}, function()
      TriggerServerEvent('jim-mining:GetItem', data)
      if data.ret then
        if math.random(1, 10) >= 8 then
          local breakId = GetSoundId()
          PlaySoundFromEntity(breakId, "Drill_Pin_Break", PlayerPedId(), "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
          toggleItem(false, "drillbit", 1)
        end
      end
      LocalPlayer.state:set("invBusy", false, true)
      TriggerEvent('inventory:client:busy:status', false)
      TriggerEvent('canUseInventoryAndHotbar:toggle', true)
      unloadDrillSound()
      StopSound(soundId)
      unloadPtfxDict("core")
      isDrilling = false
      NetworkStopSynchronisedScene(scene)
    end, function() -- Cancel
      triggerNotify(nil, Loc[Config.Lan].error["cancelled"], 'error')
      StopAnimTask(PlayerPedId(), animDictNow, animNow, 1.0)
      LocalPlayer.state:set("invBusy", false, true)
      TriggerEvent('inventory:client:busy:status', false)
      TriggerEvent('canUseInventoryAndHotbar:toggle', true)
      unloadDrillSound()
      StopSound(soundId)
      unloadPtfxDict("core")
      unloadAnimDict(dict)
      isDrilling = false
      NetworkStopSynchronisedScene(scene)
    end, data.item)
end

------------------------------------------------------------
--Selling animations are simply a pass item to seller animation
local isSelling = false
RegisterNetEvent('jim-mining:SellAnim', function(data)
  if not HasItem(data.item, 1) then
    triggerNotify(nil, Loc[Config.Lan].error["dont_have"] .. " " .. itemNames[data.item].label, "error")
    return
  end
  if isSelling then return end
  isSelling = true
  loadAnimDict("mp_common")
  TriggerServerEvent('jim-mining:Selling', data) -- Had to slip in the sell command during the animation command
  loadAnimDict("mp_common")
  lookEnt(data.ped)
  TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 1, 0.2, 0, 0, 0) --Start animations
  TaskPlayAnim(data.ped, "mp_common", "givetake2_b", 100.0, 200.0, 0.3, 1, 0.2, 0, 0, 0)
  Wait(2000)
  StopAnimTask(PlayerPedId(), "mp_common", "givetake2_a", 1.0)
  StopAnimTask(data.ped, "mp_common", "givetake2_b", 1.0)
  unloadAnimDict("mp_common")
  if data.sub then
    TriggerEvent('jim-mining:JewelSell:Sub', { sub = data.sub, ped = data.ped })
    isSelling = false
    return
  else
    TriggerEvent('jim-mining:SellOre', data)
    isSelling = false
    return
  end
end)

------------------------------------------------------------
RegisterNetEvent('jim-mining:SellOre', function(data)
  local list = { "metalscrap","sulfer","copperore","goldore","silverore","ironore","aluminum","carbon"}
  local options = {}

  for _, v in pairs(list) do
    local disable = true
    if HasItem(v, 1) and not isSelling then
      disable = false
    end
    options[#options + 1] = {
      disabled = disable,
      title = itemNames[v].label,
      description = Loc[Config.Lan].info["sell_all"] .. " " .. Config.SellItems[v] .. " " .. Loc[Config.Lan].info["sell_each"],
      onSelect = function()
        TriggerEvent('jim-mining:SellAnim', { item = v, ped = data.ped })
      end
    }
    Wait(0)
  end

  lib.registerContext({
    id = 'jim-mining:SellOre',
    title = Loc[Config.Lan].info["header_oresell"],
    options = options
  })

  lib.showContext('jim-mining:SellOre')
end)
------------------------
--Jewel Selling Main Menu
RegisterNetEvent('jim-mining:JewelSell', function(data)
  local items = { 'Gemstones', 'Gold Rings', 'Silver Rings', 'Gold Necklaces', 'Silver Necklaces', 'Gold Earrings', 'Silver Earrings' }

  local options = {}

  for k, v in pairs(items) do
    print(v)
    options[#options + 1] = {
      title = v,
      description = Loc[Config.Lan].info["see_options"],
      onSelect = function()
        TriggerEvent('jim-mining:JewelSell:Sub', { sub = v, ped = data.ped })
      end
    }
  end

  lib.registerContext({
    id = 'jim-mining:JewelSell',
    title = Loc[Config.Lan].info["jewel_buyer"],
    options = options
  })

  lib.showContext('jim-mining:JewelSell')
end)
--Jewel Selling - Sub Menu Controller
RegisterNetEvent('jim-mining:JewelSell:Sub', function(data)
  local list = {}

  local options = {}
  if data.sub == "Gemstones" then
    list = {
      "opal",
      "ruby",
      "sapphire",
      "emerald",
      "diamond",
      "amethyst",
      "onyx",
      "citrinequartz",
    }
  elseif data.sub == "Gold Rings" then
    list = {
      "opal_ring_gold",
      "ruby_ring_gold",
      "sapphire_ring_gold",
      "emerald_ring_gold",
      "diamond_ring_gold",
      "amethyst_ring_gold",
      "onyx_ring_gold",
      "citrinequartz_ring_gold",
    }
  elseif data.sub == "Silver Rings" then
    list = {
      "opal_ring_silver",
      "ruby_ring_silver",
      "sapphire_ring_silver",
      "emerald_ring_silver",
      "diamond_ring_silver",
      "amethyst_ring_silver",
      "onyx_ring_silver",
      "citrinequartz_ring_silver",
    }
  elseif data.sub == "Gold Necklaces" then
    list = {
      "opal_necklace_gold",
      "ruby_necklace_gold",
      "sapphire_necklace_gold",
      "emerald_necklace_gold",
      "diamond_necklace_gold",
      "amethyst_necklace_gold",
      "onyx_necklace_gold",
      "citrinequartz_necklace_gold",
    }
  elseif data.sub == "Silver Necklaces" then
    list = {
      "opal_necklace_silver",
      "ruby_necklace_silver",
      "sapphire_necklace_silver",
      "emerald_necklace_silver",
      "diamond_necklace_silver",
      "amethyst_necklace_silver",
      "onyx_necklace_silver",
      "citrinequartz_necklace_silver",
    }
  elseif data.sub == "Gold Earrings" then
    list = {
      "opal_earring_gold",
      "ruby_earring_gold",
      "sapphire_earring_gold",
      "emerald_earring_gold",
      "diamond_earring_gold",
      "amethyst_earring_gold",
      "onyx_earring_gold",
      "citrinequartz_earring_gold",
    }
  elseif data.sub == "Silver Earrings" then
    list = {
      "opal_earring_silver",
      "ruby_earring_silver",
      "sapphire_earring_silver",
      "emerald_earring_silver",
      "diamond_earring_silver",
      "amethyst_earring_silver",
      "onyx_earring_silver",
      "citrinequartz_earring_silver",
    }
  end

  for _, v in pairs(list) do
    local disable = true
    if HasItem(v, 1) and not isSelling then
      disable = false
    end
    options[#options + 1] = {
      disabled = disable,
      title = itemNames[v].label,
      description = Loc[Config.Lan].info["sell_all"] .. " " .. Config.SellItems[v] .. " " .. Loc[Config.Lan].info["sell_each"],
      onSelect = function()
        TriggerEvent('jim-mining:SellAnim', { item = v, sub = data.sub, ped = data.ped })
      end
    }
    Wait(0)
  end

  options[#options + 1] = {
    title = Loc[Config.Lan].info["return"],
    onSelect = function()
      TriggerEvent('jim-mining:JewelSell', data)
    end
  }

  lib.registerContext({
    id = 'jim-mining:JewelSell:Sub',
    title = Loc[Config.Lan].info["jewel_buyer"],
    options = options
  })

  lib.showContext('jim-mining:JewelSell:Sub')
end)

--Cutting Jewels
RegisterNetEvent('jim-mining:JewelCut', function()
  lib.registerContext({
    id = 'jim-mining:JewelCut',
    title = Loc[Config.Lan].info["craft_bench"],
    options = {
      {
        title = Loc[Config.Lan].info["gem_cut"],
        description = Loc[Config.Lan].info["gem_cut_section"],
        onSelect = function()
          TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.GemCut, ret = true })
        end
      },
      {
        title = "Gold Rings",
        description = "Go to Gold Ring Crafting Section",
        onSelect = function()
          TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.GoldRings, ret = true })
        end
      },
      {
        title = "Silver Rings",
        description = "Go to Silver Ring Crafting Section",
        onSelect = function()
          TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.SilverRings, ret = true })
        end
      },
      {
        title = "Gold Necklaces",
        description = "Go to Gold Necklaces Crafting Section",
        onSelect = function()
          TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.GoldNecklace, ret = true })
        end
      },
      {
        title = "Silver Necklaces",
        description = "Go to Silver Necklaces Crafting Section",
        onSelect = function()
          TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.SilverNecklace, ret = true })
        end
      },
      {
        title = "Gold Earrings",
        description = "Go to Gold Earrings Crafting Section",
        onSelect = function()
          TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.GoldEarring, ret = true })
        end
      },
      {
        title = "Silver Earrings",
        description = "Go to Silver Earrings Crafting Section",
        onSelect = function()
          TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.SilverEarring, ret = true })
        end
      },
     
    }
  })

  lib.showContext('jim-mining:JewelCut')
end)

RegisterNetEvent('jim-mining:CraftMenu', function(data)
  local options = {}
  if data and data.ret then
  else
    options[#options + 1] = {
      title = Loc[Config.Lan].info["Gold_Menu"],
      description = Loc[Config.Lan].info["Gold_Menu_section"],
      onSelect = function()
        TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.GoldMenu, ret = true })
      end
    }

    options[#options + 1] = {
      title = Loc[Config.Lan].info["Silver_Menu"],
      description = Loc[Config.Lan].info["Silver_Menu_section"],
      onSelect = function()
        TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.SilverMenu, ret = true })
      end
    }

    options[#options + 1] = {
      title = Loc[Config.Lan].info["Iron_Menu"],
      description = Loc[Config.Lan].info["Iron_Menu_section"],
      onSelect = function()
        TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.IronMenu, ret = true })
      end
    }

    options[#options + 1] = {
      title = Loc[Config.Lan].info["Steel_Menu"],
      description = Loc[Config.Lan].info["Steel_Menu_section"],
      onSelect = function()
        TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.SteelMenu, ret = true })
      end
    }

    options[#options + 1] = {
      title = Loc[Config.Lan].info["Misc_Menu"],
      description = Loc[Config.Lan].info["Misc_Menu_section"],
      onSelect = function()
        TriggerEvent('jim-mining:CraftMenu', { craftable = Crafting.MiscMenu, ret = true })
      end
    }
  end

  if data then
    for i = 1, #data.craftable do
      for k in pairs(data.craftable[i]) do
        if k ~= "amount" then
          local text = "You need:\n"
          local amount = ""
          if data.craftable[i]["amount"] then amount = " x" .. data.craftable[i]["amount"] else amount = "" end
          local setheader = itemNames[k].label .. tostring(amount)
          local disable = false
          local checktable = {}
          local settext = "You need:\n"
          for l, b in pairs(data.craftable[i][tostring(k)]) do
            local number = ""
            if b == 1 then number = "" else number = " x" .. b end
            text = text .. "" .. itemNames[l].label .. number .. "\n"
            settext = text
            checktable[l] = HasItem(l, b)
          end
          for _, v in pairs(checktable) do
            if v == false then
              disable = true
              break
            end
          end
          if lib.progressActive() then disable = true end

          if not disable then setheader = setheader .. " ✔️" end
          options[#options + 1] = {
            title = setheader,
            disabled = disable,
            description = settext,
            onSelect = function()
              if lib.progressActive() then return end
              TriggerEvent('jim-mining:MakeItem', { item = k, tablenumber = i, craftable = data.craftable, ret = data.ret })
            end
          }
        end
      end
    end
  end

  lib.registerContext({
    id = 'jim-mining:CraftMenu',
    title = Loc[Config.Lan].info["smelter"],
    options = options
  })

  lib.showContext('jim-mining:CraftMenu')
end)

AddEventHandler('onResourceStop', function(resource) if resource == GetCurrentResourceName() then removeJob() end end)

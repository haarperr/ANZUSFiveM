local QBCore = exports['qb-core']:GetCoreObject()
local labels = {}
local craftingQueue = {}
local job = ""
local grade = 0
local inZone = false
local craft1Placed = false
local craft1PickedUp = true
local items = exports.ox_inventory:Items()

local function openWorkbench(val)
  local inv = {}
  local recipes = {}
  SetNuiFocus(true, true)
  TriggerScreenblurFadeIn(1000)
  local player = QBCore.Functions.GetPlayerData()
  local xp = player.metadata.craftingrep or 0
  local playerItems = exports.ox_inventory:GetPlayerItems()
  for _, v in pairs(playerItems) do
    inv[v.name] = v.count
  end

  if #labels == 0 then
    for k, v in pairs(Config.Recipes) do
      labels[k] = items[k].label
      for ingredient, _ in pairs(v.Ingredients) do
        if not labels[ingredient] then
          local item = items[ingredient] or {}
          labels[ingredient] = item.label or "null"
        end
      end
    end
    for k, v in pairs(Config.Workbenches) do
      if next(v.recipes) then
        for key, v2 in pairs(v.recipes) do
          labels[key] = items[key].label
          for ingredient, _ in pairs(v2.Ingredients) do
            if not labels[ingredient] then
              local item = items[ingredient] or {}
              labels[ingredient] = item.label or "null"
            end
          end
        end
      end
    end
  end

  if next(val) == nil then
    recipes = Config.Recipes
  else
    recipes = val
  end

  SendNUIMessage({
    type = "open",
    recipes = recipes,
    names = labels,
    level = xp,
    ExperiancePerCraft = xpper,
    inventory = inv,
    job = job,
    grade = grade,
    hidecraft = Config.HideWhenCantCraft,
    categories = Config.Categories,
    blueprints = player.metadata.blueprints,
  })
end

-- Events
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  local player = QBCore.Functions.GetPlayerData()
  job = player.job.name
  grade = player.job.grade
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  job = JobInfo.name
  grade = JobInfo.grade
end)

CreateThread(function()
  local workbenchZones = {}
  for _, v in pairs(Config.Workbenches) do
    -- if v.blip then
    --     local blip = AddBlipForCoord(v.coords)

    --     SetBlipSprite(blip, Config.BlipSprite)
    --     SetBlipScale(blip, 0.8)
    --     SetBlipColour(blip, Config.BlipColor)
    --     SetBlipAsShortRange(blip, true)

    --     BeginTextCommandSetBlipName("STRING")
    --     AddTextComponentString(Config.BlipText)
    --     EndTextCommandSetBlipName(blip)
    -- end

    workbenchZones[#workbenchZones + 1] = BoxZone:Create(
      vector3(v.coords.x, v.coords.y, v.coords.z), v.length, v.width, {
        name = "box_zone",
        heading = v.coords.w,
        debugPoly = false,
        minZ = v.coords.z - 1,
        maxZ = v.coords.z + 1,
      })
  end

  local workbenchCombo = ComboZone:Create(workbenchZones, { name = "workbenchZones", debugPoly = false })
  workbenchCombo:onPlayerInOut(function(isPointInside, point)
    if isPointInside then
      inZone = true
      -- exports['qb-core']:DrawText('[E] Workbench', 'left')
    else
      inZone = false
      craftingQueue = {}
      SendNUIMessage(
        {
          type = "clear",
        }
      )
      -- exports['qb-menu']:closeMenu()
      -- exports['qb-core']:HideText()
    end
  end)
end)

CreateThread(function()
  Wait(1000)
  while true do
    if inZone then
      print('inZone')
      print(json.encode(craftingQueue))
      if craftingQueue[1] then
        if not Config.CraftingStopWithDistance or (Config.CraftingStopWithDistance and inZone) then
          craftingQueue[1].time = craftingQueue[1].time - 1
          print(json.encode(craftingQueue[1]))

          SendNUIMessage(
            {
              type = "addqueue",
              item = craftingQueue[1].item,
              time = craftingQueue[1].time,
              id = craftingQueue[1].id
            }
          )

          if craftingQueue[1].time == 0 then
            TriggerServerEvent("core_crafting:itemCrafted", craftingQueue[1].item, craftingQueue[1].count, craftingQueue[1].multiplier)
            table.remove(craftingQueue, 1)
          end
        end
      end
    end
    Wait(1000)
  end
end)

RegisterNetEvent("core_crafting:openCrafting", function()
  local coords = GetEntityCoords(cache.ped)
  local recipes = {}
  for key, value in pairs(Config.Workbenches) do
    if #(coords - vec3(value.coords.x, value.coords.y, value.coords.z)) < 4 then
      recipes = value.recipes
      break
    end
  end
  openWorkbench(recipes)
end)

RegisterNetEvent("core_crafting:craftStart", function(item, count, multiplier, recipe)
  local id = math.random(000, 999)
  table.insert(craftingQueue, { time = recipe.Time * multiplier, item = item, count = count, id = id, multiplier = multiplier })

  SendNUIMessage(
    {
      type = "crafting",
      item = item
    }
  )
  SendNUIMessage(
    {
      type = "addqueue",
      item = item,
      time = recipe.Time * multiplier,
      id = id
    }
  )
end)

RegisterNUICallback("close", function(data)
  TriggerScreenblurFadeOut(1000)
  SetNuiFocus(false, false)
end)

RegisterNUICallback("craft", function(data)
  local item = data["item"]
  TriggerServerEvent("core_crafting:craft", item, data["multiplier"], false)
end)

-- Crafting Function

Citizen.CreateThread(function()
  exports['qb-target']:AddTargetModel(Config.CraftingObject, {
    options = {
      {
        type = "client",
        event = "core_crafting:openCrafting",
        icon = "fas fa-hammer",
        label = "Use Crafting Table",
      },
    },
    distance = 1.6
  })
end)

-- Stationary location

-- testing benchs
-- Trevors House
local obj1 = CreateObject('gr_prop_gr_bench_02a', vector3(1967.6, 3819, 31.5), true)
PlaceObjectOnGroundProperly(obj1)
SetEntityHeading(obj1, -149.0)

-- Ace Liquor
local obj2 = CreateObject('gr_prop_gr_bench_02a', vector3(1399.34, 3602.66, 38.94), true)
PlaceObjectOnGroundProperly(obj2)
SetEntityHeading(obj2, 201.23)

-- The Island
local obj3 = CreateObject('gr_prop_gr_bench_01a', vector3(3612.99, 5023.06, 11.35), true)
PlaceObjectOnGroundProperly(obj3)
SetEntityHeading(obj3, 111.24)

-- Plaleto Barn
local obj4 = CreateObject('gr_prop_gr_bench_02a', vector3(424.41, 6476.86, 35.87), true)
PlaceObjectOnGroundProperly(obj4)
SetEntityHeading(obj4, 49.41)

-- Tunnel 1
local obj5 = CreateObject('gr_prop_gr_bench_02a', vector3(594.86, -430.38, 4.05), true)
PlaceObjectOnGroundProperly(obj5)
SetEntityHeading(obj5, 56.07)

-- Modshop type Building
local obj7 = CreateObject('gr_prop_gr_bench_02a', vector3(486.9, -1322, 29.2), true)
PlaceObjectOnGroundProperly(obj7)
SetEntityHeading(obj7, 300.0)

-- Mili Base
local obj8 = CreateObject('gr_prop_gr_bench_02a', vector3(-1810.97, 3105.13, 32.84), true)
PlaceObjectOnGroundProperly(obj8)
SetEntityHeading(obj8, 56.39)

-- Airport
local obj9 = CreateObject('gr_prop_gr_bench_02a', vector3(-1565.13, -3235.97, 26.34), true)
PlaceObjectOnGroundProperly(obj9)
SetEntityHeading(obj9, 60.84)

-- Island 2
local obj10 = CreateObject('gr_prop_gr_bench_02a', vector3(-2165.78, 5196.89, 16.88), true)
PlaceObjectOnGroundProperly(obj10)
SetEntityHeading(obj10, 281.4)

-- Life Invader building
local obj11 = CreateObject('gr_prop_gr_bench_02a', vector3(-1051.46, -232.04, 44.02), true)
PlaceObjectOnGroundProperly(obj11)
SetEntityHeading(obj11, 298.48)






































-- mafia test
local mafia = CreateObject('gr_prop_gr_bench_02a', vector3(-929.25177001953, -3061.7236328125, 12.94437789917), true)
PlaceObjectOnGroundProperly(mafia)
SetEntityHeading(mafia, 60.0)

-- vago  test
local vago = CreateObject('gr_prop_gr_bench_02a', vector3(-928.11157226563, -3059.6652832031, 12.94437789917), true)
PlaceObjectOnGroundProperly(vago)
SetEntityHeading(vago, 60.0)

-- baller test
local baller = CreateObject('gr_prop_gr_bench_02a', vector3(-926.84826660156, -3057.505859375, 12.94437789917), true)
PlaceObjectOnGroundProperly(baller)
SetEntityHeading(baller, 60.0)

-- Biker test
local biker = CreateObject('gr_prop_gr_bench_02a', vector3(-925.62963867188, -3055.357421875, 12.94437789917), true)
PlaceObjectOnGroundProperly(biker)
SetEntityHeading(biker, 60.0)


-- fulltest test
local fullbench = CreateObject('gr_prop_gr_bench_02a', vector3(-923.03967285156, -3061.2595214844, 12.94437789917), true)
PlaceObjectOnGroundProperly(fullbench)
SetEntityHeading(fullbench, 240.0)

-- Packable Crafting
Citizen.CreateThread(function()
  exports['qb-target']:AddTargetModel(Config.PackableObject, {
    options = {
      {
        type = "client",
        event = "core_crafting:openCrafting",
        icon = "fas fa-hammer",
        label = "Use Crafting Table",
      },
      {
        type = "client",
        event = "core_crafting:Pickupcraft1",
        icon = "fas fa-hand",
        label = "Pickup Crafting Table",
      },
    },
    distance = 4
  })
end)

local craft1 = 'gr_prop_gr_bench_04a'
RegisterNetEvent("core_crafting:Placecraft1", function()
  if not craft1Placed then
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)
    local objhead   = GetEntityHeading(playerPed)
    local vec3      = vector3(x, y, z)
    boxZone         = BoxZone:Create(vec3, 4, 5, {
      name = "placeablecrafting",
      debugPoly = false,
      heading = objhead,
      minZ = vec3.z - 2,
      maxZ = vec3.z + 2,
    })
    inZone          = true
    RequestModel(craft1)
    while (not HasModelLoaded(craft1)) do
      Wait(1)
    end
    craftprop1 = CreateObject(craft1, x, y, z, true, false, true)

    PlaceObjectOnGroundProperly(craftprop1)
    SetEntityAsMissionEntity(craftprop1)
    SetEntityHeading(craftprop1, objhead)

    TriggerEvent('animations:client:EmoteCommandStart', { "mechanic3" })
    QBCore.Functions.Progressbar('name_here', 'Placing Crafting Table...', 1, false, true, {
      disableMovement = true,
      disableCarMovement = true,
      disableMouse = false,
      disableCombat = true,
    }, {}, {}, {}, function()
      TriggerEvent('animations:client:EmoteCommandStart', { "c" })
      craft1Placed = true
      craft1PickedUp = false

      --DeleteEntity(prop1)

      TriggerServerEvent('core_crafting:server:Removecraft1')
      TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['craft1'], "remove")
    end)
  end
end)

RegisterNetEvent('core_crafting:Pickupcraft1')
AddEventHandler('core_crafting:Pickupcraft1', function()
  if not craft1PickedUp and craft1Placed then
    TriggerEvent('animations:client:EmoteCommandStart', { "mechanic" })
    QBCore.Functions.Progressbar('pick', 'Picking Crafting Table', 1, false, true, {
      disableMovement = true,
      disableCarMovement = true,
      disableMouse = false,
      disableCombat = true,
    }, {}, {}, {}, function()
      TriggerServerEvent("core_crafting:server:Pickupcraft1")
      Wait(200)
      TriggerEvent('animations:client:EmoteCommandStart', { "c" })
      DeleteEntity(craftprop1)
      boxZone:destroy()
      inZone = false
      QBCore.Functions.Notify('You Picked Up Crafting Table', 'primary', 500)
      craft1Placed = false
      craft1PickedUp = true
    end, function()
      QBCore.Functions.Notify('Cancelled', 'error', 500)
      craft1Placed = false
      craft1PickedUp = true
    end)
  end
end)

-- Animal Shitting
RegisterNetEvent('core_crafting:pickupshit')
AddEventHandler('core_crafting:pickupshit', function()
  TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", 0, true)
  Wait(7000)
  local shitObj = CreateObject(`prop_big_shit_01`, GetEntityCoords(PlayerPedId()), true)
  AttachEntityToEntity(shitObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 6286), 0.05, 0.05, 0.0, 0.0, -3.55, 0.0, false, false, false, false, 0, true)
  QBCore.Functions.Progressbar('pick', 'Picking up shit', 9000, false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
  }, {}, {}, {}, function()
    TriggerServerEvent("core_crafting:server:pickupshit")
    DeleteObject(shitObj)
    QBCore.Functions.Notify('You Picked Up Some Cow Shit', 'primary', 500)
  end, function()
    QBCore.Functions.Notify('Cancelled', 'error', 500)
    TriggerEvent('animations:client:EmoteCommandStart', { "c" })
  end)
end)

CreateThread(function()
  local pedModel = `A_C_Cow`
  RequestModel(pedModel)
  while not HasModelLoaded(pedModel) do Wait(10) end
  local rheading = math.random(260, 360)
  local rx0 = math.random(2370, 2385)
  local ry0 = math.random(5047, 5061)
  local ped = CreatePed(0, pedModel, vector4(rx0, ry0, 46, rheading), false, false)
  FreezeEntityPosition(ped, false)
  SetBlockingOfNonTemporaryEvents(ped, false)
  -- Target
  exports['qb-target']:AddTargetEntity(ped, {
    options = {
      {
        event = "core_crafting:pickupshit",
        icon = "fas fa-poop",
        label = "Pickup Shit",
        type = "client",
      },
    },
    distance = 5
  })
  local rheading1 = math.random(120, 230)
  local rx1 = math.random(2380, 2385)
  local ry1 = math.random(5055, 5061)
  local ped1 = CreatePed(0, pedModel, vector4(rx1, ry1, 46, rheading1), false, false)
  FreezeEntityPosition(ped1, false)
  SetBlockingOfNonTemporaryEvents(ped1, false)
  -- Target
  exports['qb-target']:AddTargetEntity(ped1, {
    options = {
      {
        event = "core_crafting:pickupshit",
        icon = "fas fa-poop",
        label = "Pickup Shit",
        type = "client",
      },
    },
    distance = 5
  })
  local rheading2 = math.random(0, 100)
  local rx2 = math.random(2375, 2385)
  local ry2 = math.random(5050, 5061)
  local ped2 = CreatePed(0, pedModel, vector4(rx2, ry2, 46, rheading2), false, false)
  FreezeEntityPosition(ped2, false)
  TaskStartScenarioInPlace(ped2, 'WORLD_COW_GRAZING', true)
  exports['qb-target']:AddTargetEntity(ped2, {
    options = {
      {
        event = "core_crafting:pickupshit",
        icon = "fas fa-poop",
        label = "Pickup Shit",
        type = "client",
      },
    },
    distance = 5
  })
end)

bones = {
  ["SKEL_ROOT"] = 0,
  ["FB_R_Brow_Out_000"] = 1356,
  ["SKEL_L_Toe0"] = 2108,
  ["MH_R_Elbow"] = 2992,
  ["SKEL_L_Finger01"] = 4089,
  ["SKEL_L_Finger02"] = 4090,
  ["SKEL_L_Finger31"] = 4137,
  ["SKEL_L_Finger32"] = 4138,
  ["SKEL_L_Finger41"] = 4153,
  ["SKEL_L_Finger42"] = 4154,
  ["SKEL_L_Finger11"] = 4169,
  ["SKEL_L_Finger12"] = 4170,
  ["SKEL_L_Finger21"] = 4185,
  ["SKEL_L_Finger22"] = 4186,
  ["RB_L_ArmRoll"] = 5232,
  ["IK_R_Hand"] = 6286,
  ["RB_R_ThighRoll"] = 6442,
  ["SKEL_R_Clavicle"] = 10706,
  ["FB_R_Lip_Corner_000"] = 11174,
  ["SKEL_Pelvis"] = 11816,
  ["IK_Head"] = 12844,
  ["SKEL_L_Foot"] = 14201,
  ["MH_R_Knee"] = 16335,
  ["FB_LowerLipRoot_000"] = 17188,
  ["FB_R_Lip_Top_000"] = 17719,
  ["SKEL_L_Hand"] = 18905,
  ["FB_R_CheekBone_000"] = 19336,
  ["FB_UpperLipRoot_000"] = 20178,
  ["FB_L_Lip_Top_000"] = 20279,
  ["FB_LowerLip_000"] = 20623,
  ["SKEL_R_Toe0"] = 20781,
  ["FB_L_CheekBone_000"] = 21550,
  ["MH_L_Elbow"] = 22711,
  ["SKEL_Spine0"] = 23553,
  ["RB_L_ThighRoll"] = 23639,
  ["PH_R_Foot"] = 24806,
  ["SKEL_Spine1"] = 24816,
  ["SKEL_Spine2"] = 24817,
  ["SKEL_Spine3"] = 24818,
  ["FB_L_Eye_000"] = 25260,
  ["SKEL_L_Finger00"] = 26610,
  ["SKEL_L_Finger10"] = 26611,
  ["SKEL_L_Finger20"] = 26612,
  ["SKEL_L_Finger30"] = 26613,
  ["SKEL_L_Finger40"] = 26614,
  ["FB_R_Eye_000"] = 27474,
  ["SKEL_R_Forearm"] = 28252,
  ["PH_R_Hand"] = 28422,
  ["FB_L_Lip_Corner_000"] = 29868,
  ["SKEL_Head"] = 31086,
  ["IK_R_Foot"] = 35502,
  ["RB_Neck_1"] = 35731,
  ["IK_L_Hand"] = 36029,
  ["SKEL_R_Calf"] = 36864,
  ["RB_R_ArmRoll"] = 37119,
  ["FB_Brow_Centre_000"] = 37193,
  ["SKEL_Neck_1"] = 39317,
  ["SKEL_R_UpperArm"] = 40269,
  ["FB_R_Lid_Upper_000"] = 43536,
  ["RB_R_ForeArmRoll"] = 43810,
  ["SKEL_L_UpperArm"] = 45509,
  ["FB_L_Lid_Upper_000"] = 45750,
  ["MH_L_Knee"] = 46078,
  ["FB_Jaw_000"] = 46240,
  ["FB_L_Lip_Bot_000"] = 47419,
  ["FB_Tongue_000"] = 47495,
  ["FB_R_Lip_Bot_000"] = 49979,
  ["SKEL_R_Thigh"] = 51826,
  ["SKEL_R_Foot"] = 52301,
  ["IK_Root"] = 56604,
  ["SKEL_R_Hand"] = 57005,
  ["SKEL_Spine_Root"] = 57597,
  ["PH_L_Foot"] = 57717,
  ["SKEL_L_Thigh"] = 58271,
  ["FB_L_Brow_Out_000"] = 58331,
  ["SKEL_R_Finger00"] = 58866,
  ["SKEL_R_Finger10"] = 58867,
  ["SKEL_R_Finger20"] = 58868,
  ["SKEL_R_Finger30"] = 58869,
  ["SKEL_R_Finger40"] = 58870,
  ["PH_L_Hand"] = 60309,
  ["RB_L_ForeArmRoll"] = 61007,
  ["SKEL_L_Forearm"] = 61163,
  ["FB_UpperLip_000"] = 61839,
  ["SKEL_L_Calf"] = 63931,
  ["SKEL_R_Finger01"] = 64016,
  ["SKEL_R_Finger02"] = 64017,
  ["SKEL_R_Finger31"] = 64064,
  ["SKEL_R_Finger32"] = 64065,
  ["SKEL_R_Finger41"] = 64080,
  ["SKEL_R_Finger42"] = 64081,
  ["SKEL_R_Finger11"] = 64096,
  ["SKEL_R_Finger12"] = 64097,
  ["SKEL_R_Finger21"] = 64112,
  ["SKEL_R_Finger22"] = 64113,
  ["SKEL_L_Clavicle"] = 64729,
  ["FACIAL_facialRoot"] = 65068,
  ["IK_L_Foot"] = 65245
}

object = nil;
editMode = false;

x = 0.0;
y = 0.0;
z = 0.0;
px = 0.0;
py = 0.0;
pz = 0.0;

bone = nil;

tol = 0.05;

RegisterCommand("co", function(source, args, rawCommand)
  local objectName = args[1];
  bone = args[2];

  local ped = PlayerPedId();

  local on = GetHashKey(objectName)
  RequestModel(on)
  while not HasModelLoaded(on) do
    Wait(100)
  end

  object = CreateObject(on, 1.0, 1.0, 1.0, true, true, false)

  AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, bones[bone]), x, y, z, px, py, pz, 1, 1, 0, 0, 2, 1);

  editMode = true;
end, false)

RegisterCommand("cb", function(source, args, rawCommand)
  bone = args[1];

  DetachEntity(object, true, false);
  AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, bones[bone]), x, y, z, px, py, pz, 1, 1, 0, 0, 2, 1);
end)

RegisterCommand("cout", function(source, args, rawCommand)
  print("--------------------------------------------------------");
  print("X: " .. x .. " Y: " .. y .. " Z: " .. z);
  print("PX: " .. px .. " PY: " .. py .. " PZ: " .. pz);
  print("Bone: " .. bone .. " Bone final: " .. bones[bone]);
  print("--------------------------------------------------------");
end)

RegisterCommand("cd", function(source, args, rawCommand)
  x = 0.0;
  y = 0.0;
  z = 0.0;
  px = 0.0;
  py = 0.0;
  pz = 0.0;

  DeleteObject(object)
end)

RegisterCommand("cst", function(source, args, rawCommand)
  tol = tonumber(args[1]);
end)

Citizen.CreateThread(function()
  while not NetworkIsSessionStarted() do
    Citizen.Wait(500)
  end
  while true do
    local sleep = 1500
    if object and editMode then
      sleep           = 1
      local playerPed = PlayerPedId()
      local Waiting   = 1500
      local changed   = false;

      while editMode and object do
        ---Base code from: https://forum.cfx.re/t/free-object-spawn-standalone/4757038
        Waiting = 1

        --- Numpad 8 > Altitude +
        if IsControlPressed(0, 111) then
          z = z + tol;
          changed = true;
        end

        ---Numpa 5 > Altitude -
        if IsControlPressed(0, 110) then
          z = z - tol;
          changed = true;
        end
        --- Arrow up - Move Y
        if IsControlPressed(0, 172) then
          y = y + tol;
          changed = true;
        end
        --- Arrow down - Move Y
        if IsControlPressed(0, 173) then
          y = y - tol;
          changed = true;
        end
        --- Arrow left - Move X
        if IsControlPressed(0, 174) then
          x = x - tol;
          changed = true;
        end
        --- Arrow right - Move X
        if IsControlPressed(0, 175) then
          x = x + tol;
          changed = true;
        end

        --- Numpad 7 - Z
        if IsControlPressed(0, 117) then
          pz = pz - tol;
          changed = true;
        end
        --- Numpad 9 - Z
        if IsControlPressed(0, 118) then
          pz = pz + tol;
          changed = true;
        end

        --- Numpad 4 - Y
        if IsControlPressed(0, 124) then
          py = py - tol;
          changed = true;
        end
        --- Numpad 6 - Y
        if IsControlPressed(0, 126) then
          py = py + tol;
          changed = true;
        end

        --- Numpad - - X
        if IsControlPressed(0, 315) then
          px = px - tol;
          changed = true;
        end
        --- Numpad + - X
        if IsControlPressed(0, 314) then
          px = px + tol;
          changed = true;
        end

        if (changed) then
          DetachEntity(object, true, false);
          AttachEntityToEntity(object, playerPed, GetPedBoneIndex(playerPed, bones[bone]), x, y, z, px, py, pz, 1, 1, 0, 0, 2, 1);
        end


        Citizen.Wait(Waiting)
      end
    end
    Citizen.Wait(sleep)
  end
end)

RegisterCommand("vehSpeed", function(source)
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  print("Max Speed: " .. GetVehicleModelEstimatedMaxSpeed(GetEntityModel(vehicle)) * 2.23694 .. "mp/h")
end)

PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  QBCore.Functions.GetPlayerData(function(PlayerData)
    PlayerJob = PlayerData.job
    if PlayerData.job.onduty then
      for _, v in pairs(Config.JobRoles) do if v == PlayerJob.name then havejob = true end end
      if havejob then TriggerServerEvent("QBCore:ToggleDuty") end
    end
  end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerJob = JobInfo
  onDuty = PlayerJob.onduty
end)
RegisterNetEvent('QBCore:Client:SetDuty', function(duty) onDuty = duty end)

AddEventHandler('onResourceStart', function(resource)
  if GetCurrentResourceName() ~= resource then return end
  QBCore.Functions.GetPlayerData(function(PlayerData)
    PlayerJob = PlayerData.job
    for _, v in pairs(Config.JobRoles) do if v == PlayerJob.name then havejob = true end end
    if havejob then onDuty = PlayerJob.onduty end
  end)
  Wait(500)
end)

local till = {}
local laptop = {}
local nos = {}
local parking = {}
local bench = {}
local Targets = {}

CreateThread(function()
  if Config.LocationRequired then
    for k in pairs(Config.Locations) do
      JobLocation = PolyZone:Create(Config.Locations[k].zones, { name = Config.Locations[k].job, debugPoly = Config.Debug })
      JobLocation:onPlayerInOut(function(isPointInside)
        if isPointInside then
          if Config.RequiresJob then
            if PlayerJob.name == tostring(Config.Locations[k].job) then
              injob = true
              if Config.Locations[k].autoClock.enter and not onDuty then TriggerServerEvent("QBCore:ToggleDuty") end
            end
          else
            injob = true
          end
        else
          if Config.RequiresJob then
            if PlayerJob.name == tostring(Config.Locations[k].job) then
              injob = false
              if Config.Locations[k].autoClock.exit and onDuty then TriggerServerEvent("QBCore:ToggleDuty") end
            end
          else
            injob = false
          end
        end
      end)
    end
  end
  for k, v in pairs(Config.Locations) do
    --Blip Creation
    if v.blip then
      if Config.LocationBlips then
        local blip = AddBlipForCoord(v.blip)
        SetBlipAsShortRange(blip, true)
        SetBlipSprite(blip, 446)
        SetBlipColour(blip, v.blipcolor)
        SetBlipScale(blip, 0.7)
        SetBlipDisplay(blip, 6)
        BeginTextCommandSetBlipName('STRING')
        if v.bliplabel then
          AddTextComponentString(v.bliplabel)
        else
          AddTextComponentString("Mechanic Shop")
        end
        EndTextCommandSetBlipName(blip)
      end
    end

    --Make Crafting Locations
    if Config.Crafting then
      if v.crafting then
        for l, b in pairs(v.crafting) do
          Targets["MechCraft: " .. k .. l] =
              exports['qb-target']:AddBoxZone("MechCraft: " .. k .. l, b.coords.xyz, b.w, b.d,
                { name = "MechCraft: " .. k .. l, heading = b.coords.w, debugPoly = Config.Debug, minZ = b.coords.z - 1.0, maxZ = b.coords.z + 1.0 },
                {
                  options = { { event = "jim-mechanic:client:Crafting:Menu", icon = "fas fa-cogs", label = Loc[Config.Lan]["crafting"].menuheader, job = v.job }, },
                  distance = 2.0
                })
        end
      end
    end

    --Make Store Locations
    if Config.Stores then
      if v.store then
        for l, b in pairs(v.store) do
          Targets["MechStore: " .. k .. l] =
              exports['qb-target']:AddBoxZone("MechStore: " .. k .. l, b.coords.xyz, b.w, b.d,
                { name = "MechStore: " .. k .. l, heading = b.coords.w, debugPoly = Config.Debug, minZ = b.coords.z - 1.0, maxZ = b.coords.z + 1.0 },
                {
                  options = { { event = "jim-mechanic:client:Store:Menu", icon = "fas fa-cogs", label = Loc[Config.Lan]["stores"].browse, job = v.job }, },
                  distance = 2.0
                })
        end
      end
    end

    --Make Cash Register Locations
    if v.payments then
      local v = v.payments
      Targets["MechReceipt: " .. k] =
          exports['qb-target']:AddBoxZone("MechReceipt: " .. k, v.coords.xyz, (v.w or 0.47), (v.d or 0.34),
            { name = "MechReceipt: " .. k, heading = v.coords.w, debugPoly = Config.Debug, minZ = v.coords.z - 0.1, maxZ = v.coords.z + 0.4 },
            {
              options = { { event = "jim-payments:client:Charge", icon = "fas fa-credit-card", label = Loc[Config.Lan]["payments"].charge, job = v.job, img = v.img }, },
              distance = 2.0
            })
      if v.prop then till[#till + 1] = makeProp({ prop = `prop_till_03`, coords = vec4(v.coords.x, v.coords.y, v.coords.z + 1.03, v.coords.w + 180.0) }, 1, false) end
    end

    --Make Mechanic Stash locations
    if ((Config.StashRepair and not Config.FreeRepair) or Config.StashCraft) or Config.ShowStash then
      if Config.RequiresJob then
        if v.stash then
          for l, b in pairs(v.stash) do
            Targets["MechSafe: " .. k .. l] =
                exports['qb-target']:AddBoxZone("MechSafe: " .. k .. l, b.coords.xyz, b.w, b.d,
                  { name = "MechSafe: " .. k .. l, heading = b.coords.w, debugPoly = Config.Debug, minZ = b.coords.z - 1.0, maxZ = b.coords.z + 1.0 },
                  {
                    options = { { event = "jim-mechanic:client:Safe", icon = "fas fa-cogs", label = Loc[Config.Lan]["repair"].browse, args = { job = v.job } }, },
                    distance = 2.0
                  })
          end
        end
      end
    end

    --Make Manual Clockin locations
    if v.clockin then
      for l, b in pairs(v.clockin) do
        if type(b) ~= "boolean" then
          local bossrole = {}
          for grade in pairs(QBCore.Shared.Jobs[v.job].grades) do
            if QBCore.Shared.Jobs[v.job].grades[grade].isboss == true then
              if bossrole[v.job] then
                if bossrole[v.job] > tonumber(grade) then bossrole[v.job] = tonumber(grade) end
              else
                bossrole[v.job] = tonumber(grade)
              end
            end
          end
          if b.prop then laptop[#laptop + 1] = makeProp({ prop = `prop_laptop_01a`, coords = vec4(b.coords.x, b.coords.y, b.coords.z + 1.03, b.coords.w + 180.0) }, 1, false) end

          Targets["MechClock: " .. k .. l] =
              exports['qb-target']:AddBoxZone("MechClock: " .. k .. l, b.coords.xyz, (b.w or 0.45), (b.d or 0.4),
                { name = "MechClock: " .. k .. l, heading = b.coords.w, debugPoly = Config.Debug, minZ = b.coords.z - 0.4, maxZ = b.coords.z + 0.1 },
                {
                  options = {
                    { type = "server",                       event = "QBCore:ToggleDuty", icon = "fas fa-clipboard", label = "Duty Toggle", job = v.job },
                    { event = "qb-bossmenu:client:OpenMenu", icon = "fas fa-list",        label = "Open Bossmenu",   job = bossrole, },
                  },
                  distance = 2.0
                })
        end
      end
    end

    --Manual Repair Bench
    if v.manualRepair then
      for l, b in pairs(v.manualRepair) do
        if b.prop then bench[#bench + 1] = makeProp({ coords = vec4(b.coords.x, b.coords.y, b.coords.z - 1.37, b.coords.w), prop = `gr_prop_gr_bench_03a` }, 1, 0) end
        Targets["RepairBench: " .. k .. l] = lib.zones.box({
          coords = b.zone.coords,
          size = b.zone.size,
          rotation = b.zone.rotation,
          onEnter = function()
            lib.addRadialItem({
              id = 'repair_station_' .. l,
              label = Loc[Config.Lan]["police"].userepair,
              icon = 'fas fa-cogs',
              onSelect = function()
                TriggerEvent('jim-mechanic:client:Manual:Menu', { society = v.job })
              end
            })
          end,
          onExit = function()
            lib.removeRadialItem('repair_station_' .. l)
          end,
        })
        -- Targets["RepairBench: " .. k .. l] =
        --     exports['qb-target']:AddBoxZone("RepairBench: " .. k .. l, b.coords.xyz, (b.w or 1.2), (b.w or 4.2),
        --       { name = "RepairBench: " .. k .. l, heading = b.coords.w, debugPoly = Config.Debug, minZ = b.coords.z - 1, maxZ = b.coords.z + 1.4, },
        --       { options = { { event = "jim-mechanic:client:Manual:Menu", icon = "fas fa-cogs", label = Loc[Config.Lan]["police"].userepair, society = v.job }, }, distance = 5.0 })
      end
    end

    --Garage Locations
    if v.garage then
      local out = v.garage.out

      if v.garage.prop then parking[#parking + 1] = makeProp({ prop = `prop_parkingpay`, coords = out }, 1, false) end
      Targets["MechGarage: " .. k] =
          exports['qb-target']:AddBoxZone("MechGarage: " .. k, vec3(out.x, out.y, out.z - 1.03), 0.8, 0.5,
            { name = "MechGarage: " .. k, heading = out[4] + 180.0, debugPoly = Config.Debug, minZ = (out.z - 1.03) - 0.1, maxZ = out.z - 1.03 + 1.3 },
            {
              options = {
                {
                  event = "jim-mechanic:client:Garage:Menu",
                  icon = "fas fa-clipboard",
                  label = Loc[Config.Lan]["garage"].jobgarage,
                  job = v.job,
                  coords = v.garage.spawn,
                  list = v.garage.list
                }, },
              distance = 2.0
            })
    end

    --NosRefill Locations
    if v.nosrefill then
      for l, b in pairs(v.nosrefill) do
        nos[#nos + 1] = makeProp({ prop = `prop_byard_gastank02`, coords = vec4(b.coords.x, b.coords.y, b.coords.z, b.coords.w + 180.0) }, 1, false)

        Targets["MechNos: " .. k .. l] =
            exports['qb-target']:AddBoxZone("MechNos: " .. k .. l, vec3(b.coords.x, b.coords.y, b.coords.z), 0.7, 0.7,
              { name = "MechNos: " .. k .. l, heading = b.coords[4], debugPoly = Config.Debug, minZ = b.coords.z - 1.05, maxZ = b.coords.z + 0.25 },
              {
                options = {
                  {
                    event = "jim-mechanic:client:NosRefill",
                    item = "noscan",
                    icon = "fas fa-gauge-high",
                    label = "NOS ($" .. Config.NosRefillCharge .. ")",
                    coords = b.coords,
                    tank = nos[#nos],
                    society = v.job
                  }, },
                distance = 2.0
              })
      end
    end
  end
end)

----- CRAFTING STUFF -------
RegisterNetEvent('jim-mechanic:client:Crafting:Menu', function()
  local Menu = {}
  Menu[#Menu + 1] = { isMenuHeader = true, header = Loc[Config.Lan]["crafting"].menuheader, txt = "", }
  Menu[#Menu + 1] = {
    icon = "fas fa-circle-xmark",
    header = "",
    txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
    params = { event = "jim-mechanic:client:Menu:Close" }
  }
  Menu[#Menu + 1] = {
    header = Loc[Config.Lan]["crafting"].toolheader,
    txt = #Crafting.Tools .. Loc[Config.Lan]["crafting"].numitems,
    params = { event = "jim-mechanic:Crafting", args = { craftable = Crafting.Tools, header = Loc[Config.Lan]["crafting"].toolheader, } }
  }
  Menu[#Menu + 1] = {
    header = Loc[Config.Lan]["crafting"].performheader,
    txt = #Crafting.Perform .. Loc[Config.Lan]["crafting"].numitems,
    params = { event = "jim-mechanic:Crafting", args = { craftable = Crafting.Perform, header = Loc[Config.Lan]["crafting"].performheader, } }
  }
  Menu[#Menu + 1] = {
    header = Loc[Config.Lan]["crafting"].cosmetheader,
    txt = #Crafting.Cosmetic .. Loc[Config.Lan]["crafting"].numitems,
    params = { event = "jim-mechanic:Crafting", args = { craftable = Crafting.Cosmetic, header = Loc[Config.Lan]["crafting"].cosmetheader, } }
  }
  exports['qb-menu']:openMenu(Menu)
end)

RegisterNetEvent('jim-mechanic:Crafting', function(data)
  local Menu = {}
  Menu[#Menu + 1] = { header = data.header, txt = "", isMenuHeader = true }
  Menu[#Menu + 1] = {
    icon = "fas fa-circle-arrow-left",
    header = "",
    txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""),
    params = { event = "jim-mechanic:client:Crafting:Menu" }
  }
  for i = 1, #data.craftable do
    for k, v in pairs(data.craftable[i]) do
      if k ~= "amount" and k ~= "job" then
        if data.craftable[i]["job"] then
          hasjob = false
          for l, b in pairs(data.craftable[i]["job"]) do
            if l == PlayerJob.name and PlayerJob.grade.level >= b then hasjob = true end
          end
        end
        if not QBCore.Shared.Items[k] then
          print("^5Debug^7: ^2Item not found in server^7: '^6" .. k .. "^7'")
        else
          if data.craftable[i]["job"] and hasjob == false then else
            local text = ""
            setheader = QBCore.Shared.Items[tostring(k)].label
            if data.craftable[i]["amount"] then setheader = setheader .. " x" .. data.craftable[i]["amount"] end
            local disable = false
            local checktable = {}
            for l, b in pairs(data.craftable[i][tostring(k)]) do
              if b == 1 then number = "" else number = " x" .. b end
              text = text .. "- " .. QBCore.Shared.Items[l].label .. number .. "<br>"
              settext = text
              if not Config.StashCraft then checktable[l] = HasItem(l, b) end
              Wait(0)
            end
            for _, v in pairs(checktable) do
              if v == false then
                disable = true
                break
              end
            end
            if not Config.StashCraft then if not disable then setheader = setheader .. " ✔️" end end
            Menu[#Menu + 1] = {
              disabled = disable,
              icon = k,
              header = setheader,
              txt = settext,
              params = { event = "jim-mechanic:Crafting:MakeItem", args = { item = k, craft = data.craftable[i], craftable = data.craftable, header = data.header } }
            }
            settext, setheader = nil
          end
        end
      end
    end
  end
  exports['qb-menu']:openMenu(Menu)
end)

RegisterNetEvent('jim-mechanic:Crafting:MakeItem', function(data)
  QBCore.Functions.TriggerCallback('jim-mechanic:Crafting:get', function(amount)
    if not amount then triggerNotify(nil, Loc[Config.Lan]["crafting"].ingredients, 'error') else TriggerEvent('jim-mechanic:Crafting:ItemProgress', data) end
  end, data.item, data.craft)
end)

RegisterNetEvent('jim-mechanic:Crafting:ItemProgress', function(data)
  QBCore.Functions.Progressbar('making_food', "Crafting " .. QBCore.Shared.Items[data.item].label, 7000, false, true,
    { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, },
    { animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, },
    {}, {}, function()
      qblog("Crafted `" .. data.item .. "`")
      TriggerServerEvent('jim-mechanic:Crafting:GetItem', data.item, data.craft)
      emptyHands(PlayerPedId())
      TriggerEvent("jim-mechanic:Crafting", data)
    end, function() -- Cancel
      TriggerEvent('inventory:client:busy:status', false)
      emptyHands(PlayerPedId())
    end, data.item)
end)

------ Nos Refill -------
local refilling = false
RegisterNetEvent('jim-mechanic:client:NosRefill', function(data)
  if refilling then return end
  local p = promise.new()
  QBCore.Functions.TriggerCallback('jim-mechanic:checkCash', function(cb) p:resolve(cb) end)
  local cash = Citizen.Await(p)
  if cash >= Config.NosRefillCharge then
    refilling = true
    local coords = GetOffsetFromEntityInWorldCoords(data.tank, 0, 0.5, 0.02)
    local prop = makeProp({ prop = `v_ind_cs_gascanister`, coords = vec4(coords.x, coords.y, coords.z + 1.03, data.coords.w) }, 1, 1)

    if not IsPedHeadingTowardsPosition(PlayerPedId(), coords, 20.0) then
      TaskTurnPedToFaceCoord(PlayerPedId(), coords, 1500)
      Wait(1500)
    end
    if #(coords - GetEntityCoords(PlayerPedId())) > 1.3 then
      TaskGoStraightToCoord(PlayerPedId(), coords, 0.5, 400, 0.0, 0)
      Wait(400)
    end

    UseParticleFxAssetNextCall('core')
    local gas = StartParticleFxLoopedOnEntity('ent_sht_steam', prop, 0.02, 0.00, 0.42, 0.0, 0.0, 0.0, 0.1, 0, 0, 0)

    QBCore.Functions.Progressbar('making_food', "Refilling " .. QBCore.Shared.Items["nos"].label, 7000, false, true,
      { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, },
      { task = "CODE_HUMAN_MEDIC_TEND_TO_DEAD" },
      {}, {}, function()
        qblog("Purchased a NOS refill")
        TriggerServerEvent("jim-mechanic:chargeCash", Config.NosRefillCharge, data.society)
        toggleItem(false, "noscan", 1)
        toggleItem(true, "nos", 1)
        DeleteObject(prop)
        prop = nil
        StopParticleFxLooped(gas)
        gas = nil
        emptyHands(PlayerPedId())
        refilling = false
      end, function() -- Cancel
        DeleteObject(prop)
        StopParticleFxLooped(gas)
        gas = nil
        emptyHands(PlayerPedId())
        prop = nil
        refilling = false
      end, "nos")
  else
    triggerNotify(nil, "Not enough cash", "error")
    return
  end
end)

------ Store Stuff ------
-- Menu to pick the store
RegisterNetEvent('jim-mechanic:client:Store:Menu', function(data)
  exports['qb-menu']:openMenu({
    { header = Loc[Config.Lan]["stores"].tools,    txt = "", params = { event = "jim-mechanic:client:Store", args = { id = 1, job = data.job } } },
    { header = Loc[Config.Lan]["stores"].perform,  txt = "", params = { event = "jim-mechanic:client:Store", args = { id = 2, job = data.job } } },
    { header = Loc[Config.Lan]["stores"].cosmetic, txt = "", params = { event = "jim-mechanic:client:Store", args = { id = 3, job = data.job } } },
  })
end)

-- Open the selected store
RegisterNetEvent('jim-mechanic:client:Store', function(data)
  local event = "inventory:server:OpenInventory"
  if Config.JimShops then event = "jim-shops:ShopOpen" end
  if data.id == 1 then
    TriggerServerEvent(event, "shop", data.job, Stores.ToolItems)
  elseif data.id == 2 then
    TriggerServerEvent(event, "shop", data.job, Stores.PerformItems)
  elseif data.id == 3 then
    TriggerServerEvent(event, "shop", data.job, Stores.StoreItems)
  end
end)

------ Repair Stash Stuff -----
RegisterNetEvent('jim-mechanic:client:Safe', function(data)
  exports.ox_inventory:openInventory('stash', "mechanic_safe")
end)

-------- Garage Stuff ---------
local currentVeh = { out = false, current = nil }
local garageBlip = nil

RegisterNetEvent('jim-mechanic:client:Garage:Menu', function(data)
  loadAnimDict("amb@prop_human_atm@male@enter")
  TaskPlayAnim(PlayerPedId(), 'amb@prop_human_atm@male@enter', "enter", 1.0, -1.0, 1500, 1, 1, true, true, true)
  local vehicleMenu = { { icon = "fas fa-car-tunnel", header = Loc[Config.Lan]["garage"].jobgarage, isMenuHeader = true } }
  if Config.JimMenu then
    vehicleMenu[#vehicleMenu + 1] = {
      icon = "fas fa-circle-xmark",
      header = "",
      txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
      params = { event = "jim-mechanic:client:Menu:Close" }
    }
  else
    vehicleMenu[#vehicleMenu + 1] = { header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "jim-mechanic:client:Menu:Close" } }
  end
  if currentVeh.out and DoesEntityExist(currentVeh.current) then
    local col1, col2 = GetVehicleColours(currentVeh.current)
    for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do if col1 == v.id then col1 = v.name end end
    vehicleMenu[#vehicleMenu + 1] = {
      icon = "fas fa-clipboard-list",
      header = Loc[Config.Lan]["garage"].vehout,
      txt = searchCar(currentVeh.current) ..
          Loc[Config.Lan]["paint"].primary .. ": " .. col1 .. "<br>" .. Loc[Config.Lan]["check"].plate .. trim(GetVehicleNumberPlateText(currentVeh.current)) .. "]",
      params = { event = "jim-mechanic:client:Garage:Blip", },
    }
    vehicleMenu[#vehicleMenu + 1] = { icon = "fas fa-car-burst", header = Loc[Config.Lan]["garage"].remveh, params = { event = "jim-mechanic:client:Garage:RemSpawn" } }
  else
    currentVeh = { out = false, current = nil }
    table.sort(data.list, function(a, b) return a:lower() < b:lower() end)
    for k, v in pairs(data.list) do
      local spawnName = v
      local v = string.lower(GetDisplayNameFromVehicleModel(GetHashKey(spawnName)))
      v = v:sub(1, 1):upper() .. v:sub(2) .. " " .. GetMakeNameFromVehicleModel(GetHashKey(tostring(spawnName)))
      for _, b in pairs(QBCore.Shared.Vehicles) do
        if tonumber(b.hash) == GetHashKey(spawnName) then
          if Config.Debug then
            print("^5Debug^7: ^2Vehicle^7: ^6" .. b.hash .. " ^7(^6" .. b.name .. " " .. b.brand .. "^7)")
          end
          v = b.name .. " " .. b.brand
        end
      end
      vehicleMenu[#vehicleMenu + 1] = { header = v, params = { event = "jim-mechanic:client:Garage:SpawnList", args = { spawnName = spawnName, coords = data.coords } } }
    end
  end
  exports['qb-menu']:openMenu(vehicleMenu)
  unloadAnimDict("amb@prop_human_atm@male@enter")
end)

RegisterNetEvent("jim-mechanic:client:Garage:SpawnList", function(data)
  local oldveh = GetClosestVehicle(data.coords.x, data.coords.y, data.coords.z, 2.5, 0, 71)
  if oldveh ~= 0 then
    local name = GetDisplayNameFromVehicleModel(GetEntityModel(oldveh)):lower()
    for k, v in pairs(QBCore.Shared.Vehicles) do
      if tonumber(v.hash) == GetEntityModel(oldveh) then
        if Config.Debug then print("^5Debug^7: ^2Vehicle^7: '^6" .. v.hash .. "^7' (^6" .. v.label .. "^7)") end
        name = QBCore.Shared.Vehicles[k].name
        break
      end
    end
    triggerNotify(nil, name .. Loc[Config.Lan]["garage"].cantspawn, "error")
  else
    QBCore.Functions.SpawnVehicle(data.spawnName, function(veh)
      currentVeh = { out = true, current = veh }
      SetVehicleModKit(veh, 0)
      NetworkRequestControlOfEntity(veh)
      SetEntityAsMissionEntity(veh, true, true)
      SetVehicleColours(veh, Loc[Config.Lan].vehicleResprayOptionsClassic[math.random(1, #Loc[Config.Lan].vehicleResprayOptionsClassic)].id,
        Loc[Config.Lan].vehicleResprayOptionsClassic[math.random(1, #Loc[Config.Lan].vehicleResprayOptionsClassic)].id)
      SetVehicleNumberPlateText(veh, string.sub(PlayerJob.label, 1, 5) .. tostring(math.random(100, 999)))
      SetEntityHeading(veh, data.coords.w)
      TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
      exports['LegacyFuel']:SetFuel(veh, 100.0)
      TriggerEvent("vehiclekeys:client:SetOwner", trim(GetVehicleNumberPlateText(veh)))
      SetVehicleEngineOn(veh, true, true)
      Wait(250)
      if GetNumVehicleMods(veh, 48) > 0 or GetVehicleLiveryCount(veh) > -1 then TriggerEvent("jim-mechanic:client:Preview:Livery", { close = true }) end
      triggerNotify(nil, GetDisplayNameFromVehicleModel(data.spawnName) .. " [" .. trim(GetVehicleNumberPlateText(currentVeh.current)) .. "]")
      qblog("`Garage - " .. GetDisplayNameFromVehicleModel(data.spawnName) .. "` spawned [**" .. trim(GetVehicleNumberPlateText(currentVeh.current)) .. "**]")
    end, data.coords, true)
  end
end)

RegisterNetEvent("jim-mechanic:client:Garage:RemSpawn", function(data)
  if Config.RemSpawn then
    SetVehicleEngineHealth(currentVeh.current, 200.0)
    SetVehicleBodyHealth(currentVeh.current, 200.0)
    for i = 0, 7 do
      SmashVehicleWindow(currentVeh.current, i)
      Wait(150)
    end
    PopOutVehicleWindscreen(currentVeh.current)
    for i = 0, 5 do
      SetVehicleTyreBurst(currentVeh.current, i, true, 0)
      Wait(150)
    end
    for i = 0, 5 do
      SetVehicleDoorBroken(currentVeh.current, i, false)
      Wait(150)
    end
  end
  Wait(800)
  DeleteEntity(currentVeh.current)
  currentVeh = { out = false, current = nil }
end)

local markerOn = false
RegisterNetEvent("jim-mechanic:client:Garage:Blip", function(data)
  triggerNotify(nil, Loc[Config.Lan]["garage"].marker)
  if markerOn then markerOn = not markerOn end
  markerOn = true
  local carBlip = GetEntityCoords(currentVeh.current)
  if not DoesBlipExist(garageBlip) then
    garageBlip = AddBlipForCoord(carBlip.x, carBlip.y, carBlip.z)
    SetBlipColour(garageBlip, 8)
    SetBlipRoute(garageBlip, true)
    SetBlipSprite(garageBlip, 85)
    SetBlipRouteColour(garageBlip, 3)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Loc[Config.Lan]["garage"].markername)
    EndTextCommandSetBlipName(garageBlip)
  end
  while markerOn do
    local time = 5000
    local carLoc = GetEntityCoords(currentVeh.current)
    local playerLoc = GetEntityCoords(PlayerPedId())
    if DoesEntityExist(currentVeh.current) then
      if #(carLoc - playerLoc) <= 30.0 then
        time = 100
      elseif #(carLoc - playerLoc) <= 1.5 then
        RemoveBlip(garageBlip)
        garageBlip = nil
        markerOn = not markerOn
      else
        time = 5000
      end
    else
      RemoveBlip(garageBlip)
      garageBlip = nil
      markerOn = not markerOn
    end
    Wait(time)
  end
end)

Config.Locations = {
  -- BENNYS NEXT TO PDM --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(-39.657638549805, -1026.12890625),
  --         vec2(-54.971218109131, -1066.3665771484),
  --         vec2(-20.210899353027, -1079.1593017578),
  --         vec2(-6.8900542259216, -1038.0417480469),
  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(-40.9, -1056.62, 28.4, 70.0), w = 3.6, d = 0.6 }, },
  --     store = { { coords = vec4(-37.53, -1036.11, 28.6, 340.0), w = 1.6, d = 0.6 }, },
  --     crafting = { { coords = vec4(-38.25, -1038.99, 28.6, 340.0), w = 4.0, d = 0.6 }, },
  --     clockin = { { coords = vec4(-34.95, -1040.71, 28.59, 8.0), prop = true, }, },
  --     manualRepair = { { coords = vec4(-45.11, -1048.54, 28.4, 249.94), prop = true, } },
  --     garage = {
  --         spawn = vec4(-49.14, -1031.25, 27.76, 339.67),
  --         out = vec4(-42.38, -1035.11, 28.52, 68.01),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true,
  --     },
  --     payments = {
  --         coords = vec4(-35.91, -1040.47, 28.6, 340.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/b/be/BennysOriginalMotorWorks-GTAO-Logo.png width=150px></p>",
  --         prop = true,
  --     },
  --     blip = vec3(-43.05, -1043.99, 28.76),
  --     bliplabel = "Bennys Workshop", -- Bennys Workshop next to PDM
  --     blipcolor = 1,
  --     discordlink = "",
  --     discordcolour = 16711680,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/b/be/BennysOriginalMotorWorks-GTAO-Logo.png",
  -- },
  -- ALTA STREET BENNYS --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(-189.07, -1311.31),
  --         vec2(-188.36, -1343.46),
  --         vec2(-217.37, -1343.54),
  --         vec2(-217.99, -1340.32),
  --         vec2(-244.44, -1342.33),
  --         vec2(-244.07, -1312.06)
  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(-216.86, -1318.25, 30.89, 0.0), w = 3.6, d = 0.6, }, },
  --     store = { { coords = vec4(-199.44, -1319.16, 31.11, 359.0), w = 0.85, d = 1.8 }, },
  --     crafting = { { coords = vec4(-198.74, -1314.46, 31.09, 270.0), w = 2.8, d = 1.0 }, },
  --     clockin = { { coords = vec4(-200.14, -1317.28, 31.08, 270.0), prop = true }, },
  --     manualRepair = { { coords = vec4(-213.98, -1333.99, 30.89, 358.43), prop = true, } },
  --     garage = {
  --         spawn = vec4(-182.74, -1317.61, 30.63, 357.23),
  --         out = vec4(-187.25, -1310.55, 31.3, 270.52),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true
  --     },
  --     payments = {
  --         coords = vec4(-200.68, -1314.53, 31.08, 0.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/b/be/BennysOriginalMotorWorks-GTAO-Logo.png width=150px></p>",
  --         prop = true
  --     },
  --     blip = vec3(-211.55, -1324.55, 30.9),
  --     bliplabel = "Bennys Workshop",
  --     blipcolor = 1,
  --     discordlink = "",
  --     discordcolour = 16711680,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/b/be/BennysOriginalMotorWorks-GTAO-Logo.png",
  -- },
  -- LS CUSTOMS IN CITY --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(-356.63, -137.9),
  --         vec2(-347.32, -111.48),
  --         vec2(-309.05, -128.79),
  --         vec2(-324.44, -148.96)
  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(-346.14, -130.52, 39.01, 340.0), w = 4.0, d = 1.0, }, },
  --     store = { { coords = vec4(-347.9, -133.19, 39.01, 340.0), w = 1.2, d = 0.25, }, },
  --     crafting = { { coords = vec4(-340.44, -141.9, 39.01, 255.0), w = 3.2, d = 1.0, }, },
  --     clockin = { { coords = vec4(-344.85, -140.35, 39.05, 157.0), prop = true }, },
  --     manualRepair = { { coords = vec4(-322.28, -140.38, 39.01, 68.35), prop = true, } },
  --     garage = {
  --         spawn = vec4(-361.48, -123.14, 38.03, 158.96),
  --         out = vec4(-356.2, -126.55, 39.43, 253.49),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true
  --     },
  --     payments = {
  --         coords = vec4(-343.75, -140.86, 39.02, 180.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>",
  --         prop = true,
  --     },
  --     blip = vec3(-336.84, -136.39, 39.01),
  --     bliplabel = "Los Santos Customs",
  --     blipcolor = 81,
  --     discordlink = "",
  --     discordcolour = 2571775,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
  -- },
  -- HAYES AUTOS --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(490.57400512695, -1302.0946044922),
  --         vec2(490.27529907227, -1305.3948974609),
  --         vec2(509.71032714844, -1336.8293457031),
  --         vec2(483.09429931641, -1339.0887451172),
  --         vec2(479.38552856445, -1330.6906738281),
  --         vec2(469.89437866211, -1309.5773925781)
  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(478.84, -1326.94, 29.21, 27.0), w = 1.6, d = 0.6, }, },
  --     store = { { coords = vec4(474.83, -1308.06, 29.21, 295.0), w = 1.6, d = 0.5, }, },
  --     crafting = { { coords = vec4(472.54, -1313.22, 29.21, 30.0), w = 3.2, d = 1.0, }, },
  --     clockin = { { coords = vec4(471.51, -1310.97, 29.22, 23.0), w = 0.45, d = 0.4, }, },
  --     manualRepair = { { coords = vec4(483.51, -1302.66, 29.3, 180.38), prop = true, } },
  --     garage = {
  --         spawn = vec4(487.67, -1308.78, 28.6, 233.44),
  --         out = vec4(483.06, -1311.35, 29.21, 298.78),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true
  --     },
  --     payments = {
  --         coords = vec4(485.88, -1319.49, 29.11, 284.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/0/0c/HayesAutoBodyShop-GTAV-Logo.png width=150px></p>",
  --         prop = true
  --     },
  --     blip = vec3(480.52, -1318.24, 29.2),
  --     bliplabel = "Hayes Autos",
  --     blipcolor = 57,
  --     discordlink = "",
  --     discordcolour = 39135,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/0/0c/HayesAutoBodyShop-GTAV-Logo.png",
  -- },
  -- LS CUSTOMS ROUTE 68 --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(1190.58, 2645.39),
  --         vec2(1190.72, 2634.46),
  --         vec2(1170.39, 2634.2),
  --         vec2(1170.33, 2645.83)
  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(1180.85, 2635.0, 37.75, 90.0), w = 1.6, d = 0.6 }, },
  --     store = { { coords = vec4(1171.64, 2635.84, 37.78, 45.0), w = 0.6, d = 0.5 }, },
  --     crafting = { { coords = vec4(1176.69, 2635.44, 37.75, 270.0), w = 3.2, d = 1.0 }, },
  --     clockin = { { coords = vec4(1183.89, 2635.29, 37.78, 185.0), prop = true, }, },
  --     manualRepair = { { coords = vec4(1162.75, 2622.96, 38.0, 1.32), prop = true, } },
  --     garage = {
  --         spawn = vec4(1165.92, 2642.87, 37.23, 358.2),
  --         out = vec4(1170.25, 2645.6, 37.81, 88.15),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true,
  --     },
  --     payments = {
  --         coords = vec4(1179.39, 2635.17, 37.75, 176.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>",
  --         prop = true,
  --     },
  --     blip = vec3(1177.62, 2640.83, 37.75),
  --     bliplabel = "Los Santos Customs",
  --     blipcolor = 81,
  --     discordlink = "",
  --     discordcolour = 2571775,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
  -- },
  -- BEEKERS GARAGE PALETO --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(117.79, 6625.31),
  --         vec2(102.88, 6611.96),
  --         vec2(95.51, 6619.93),
  --         vec2(108.8, 6633.98)
  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(105.98, 6628.84, 31.79, 315.0), w = 3.2, d = 1.0, }, },
  --     store = { { coords = vec4(109.9, 6632.02, 31.79, 270.0), w = 0.6, d = 0.5, }, },
  --     crafting = { { coords = vec4(102.7, 6626.23, 31.79, 315.0), w = 1.6, d = 0.6, }, },
  --     clockin = { { coords = vec4(100.61, 6623.84, 31.81, 74.0), prop = true, }, },
  --     manualRepair = { { coords = vec4(103.35, 6620.51, 31.79, 313.74), prop = true, } },
  --     garage = {
  --         spawn = vec4(109.92, 6608.11, 31.18, 313.99),
  --         out = vec4(107.43, 6614.64, 32.0, 226.54),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true,
  --     },
  --     payments = {
  --         coords = vec4(103.87, 6627.14, 31.79, 12.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/4/40/Beeker%27s_logo_GTA_V.png width=150px></p>",
  --         prop = true
  --     },
  --     blip = vec3(108.36, 6623.67, 31.79),
  --     bliplabel = "Beekers Garage",
  --     blipcolor = 52,
  --     discordlink = "",
  --     discordcolour = 23552,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/4/40/Beeker%27s_logo_GTA_V.png",
  -- },
  -- GABZ LS TUNER SHOP --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(154.69816589355, -3007.0153808594),
  --         vec2(120.64015197754, -3006.7275390625),
  --         vec2(120.48593902588, -3051.8874511719),
  --         vec2(154.61296081543, -3051.5419921875)
  --     },
  --     autoClock = { enter = true, exit = true, },
  --     stash = {
  --         { coords = vec4(144.38, -3051.3, 7.04, 0.0),  w = 0.6, d = 3.6, },
  --         { coords = vec4(128.45, -3007.83, 7.04, 0.0), w = 2.4, d = 3.5, },
  --     },
  --     store = { { coords = vec4(128.64, -3014.68, 7.04, 0.0), w = 1.6, d = 3.0, }, },
  --     crafting = { { coords = vec4(136.71, -3051.29, 7.04, 0.0), w = 0.6, d = 1.0, }, },
  --     clockin = {
  --         { coords = vec4(145.29, -3012.93, 6.94, 86.0),  prop = true, },
  --         { coords = vec4(125.55, -3007.25, 6.94, 350.0), w = 0.4,     d = 0.45, },
  --     },
  --     manualRepair = { { coords = vec4(121.0, -3047.69, 7.04, 270.11), prop = true, } },
  --     nosrefill = { { coords = vec4(121.17, -3044.73, 7.04, 268.96) } },
  --     garage = {
  --         spawn = vec4(163.22, -3009.31, 5.27, 89.72),
  --         out = vec4(157.37, -3016.57, 7.04, 179.58),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true,
  --     },
  --     payments = {
  --         coords = vec4(146.44, -3014.09, 6.94, 195.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>",
  --         prop = true,
  --     },
  --     blip = vec3(139.91, -3023.83, 7.04),
  --     bliplabel = "LS Tuner Shop",
  --     blipcolor = 81,
  --     discordlink = "",
  --     discordcolour = 2571775,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
  -- },
  -- GABZ ALTA STREET BENNYS --
  {
    job = "mechanic",
    zones = {
      vec2(-186.36999511719, -1309.6999511719),
      vec2(-232.05000305176, -1309.6600341797),
      vec2(-232.89999389648, -1342.7099609375),
      vec2(-185.57000732422, -1342.5400390625),
    },
    autoClock = { enter = false, exit = false, },
    stash = { { coords = vec4(-223.5, -1340.07, 31.3, 0.0), w = 3.6, d = 0.6, }, },
    --store = { { coords = vec4(-197.94169616699, -1317.2276611328, 30.069305419922, 359.0), w = 0.85, d = 1.8 }, },
    crafting = { { coords = vec4(-205.50827636719, -1334.7126464844, 30.301443099976, 271.64074707031), w = 2.8, d = 1.0 }, },
    clockin = { { coords = vec4(-191.69163513184, -1338.5560302734, 31.383405685425, 266.7751159668), prop = true }, },
    manualRepair = { {
      coords = vec4(-200.04934692383, -1311.4105224609, 31.2965259552, 0.40275111794472),
      prop = true,
      zone = {
        coords = vec3(-198.78, -1308.68, 31.95),
        size = vec3(8.85, 6.55, 3.15),
        rotation = 0.0,
      }
    } },
    -- garage = {
    --   spawn = vec4(-182.74, -1317.61, 30.63, 357.23),
    --   out = vec4(-187.25, -1310.55, 31.3, 270.52),
    --   list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
    --   prop = true
    -- },
    payments = {
      coords = vec4(-193.91430664063, -1338.3692626953, 34.969993591309, 87.811126708984),
      img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/b/be/BennysOriginalMotorWorks-GTAO-Logo.png width=150px></p>",
      prop = true
    },
    blip = vec3(-211.55, -1324.55, 30.9),
    bliplabel = "Bennys Workshop",
    blipcolor = 1,
    discordlink = "",
    discordcolour = 16711680,
    discordimg = "https://static.wikia.nocookie.net/gtawiki/images/b/be/BennysOriginalMotorWorks-GTAO-Logo.png",
  },

  -- AIRPORT LS CUSTOMS --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(-1118.5782470703, -2017.4730224609),
  --         vec2(-1143.9351806641, -2042.6685791016),
  --         vec2(-1172.8060302734, -2014.1071777344),
  --         vec2(-1147.3665771484, -1988.7028808594)
  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(-1141.11, -2004.79, 13.18, 45.0), w = 1.6, d = 0.6, }, },
  --     store = { { coords = vec4(-1144.2, -2003.91, 13.18, 45.0), w = 1.6, d = 0.6, }, },
  --     crafting = { { coords = vec4(-1158.71, -2002.37, 13.18, 45.0), w = 0.6, d = 3.8, }, },
  --     clockin = { { coords = vec4(-1155.69, -1998.91, 13.22, 62.0), prop = true, }, },
  --     manualRepair = { { coords = vec4(-1165.2, -2019.36, 13.18, 312.24), prop = true, } },
  --     garage = {
  --         spawn = vec4(-1154.63, -1986.95, 12.5, 315.29),
  --         out = vec4(-1147.87, -1989.09, 13.16, 45.01),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true,
  --     },
  --     payments = {
  --         coords = vec4(-1147.41, -2001.07, 13.18, 285.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>",
  --         prop = true,
  --     },
  --     blip = vec3(-1150.68, -2002.48, 13.18),
  --     bliplabel = "Los Santos Customs",
  --     blipcolor = 81,
  --     discordlink = "",
  --     discordcolour = 2571775,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
  -- },
  -- -- POPULAR STREET LS CUSTOMS --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(712.07940673828, -1092.9447021484),
  --         vec2(712.08245849609, -1052.4462890625),
  --         vec2(767.2265625, -1053.3394775391),
  --         vec2(770.71307373047, -1113.0911865234),
  --         vec2(741.73657226562, -1108.9860839844)
  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(736.25, -1063.52, 22.17, 87.0), w = 3.2, d = 0.6, heading = 87.0 }, },
  --     store = { { coords = vec4(738.35, -1073.36, 22.17, 359.0), w = 3.8, d = 0.6, heading = 359.0 }, },
  --     crafting = { { coords = vec4(724.49, -1075.09, 22.17, 91.0), w = 0.8, d = 1.0, heading = 91.0 }, },
  --     clockin = { { coords = vec4(738.26, -1087.66, 21.97, 276.0), prop = true, }, },
  --     manualRepair = { { coords = vec4(732.89, -1093.79, 22.17, 351.08), prop = true, } },
  --     garage = {
  --         spawn = vec4(716.22, -1069.58, 21.6, 1.08),
  --         out = vec4(719.63, -1068.84, 22.24, 89.2),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true
  --     },
  --     payments = {
  --         coords = vec4(738.34, -1090.52, 21.97, 220.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>",
  --         prop = true,
  --     },
  --     blip = vec3(731.69, -1088.84, 22.17),
  --     bliplabel = "Los Santos Customs",
  --     blipcolor = 81,
  --     discordlink = "",
  --     discordcolour = 2571775,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
  -- },
  -- -- LA MESA IMPORT SHOP --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(912.01, -987.16),
  --         vec2(911.06, -973.9),
  --         vec2(903.25, -974.3),
  --         vec2(909.76, -957.19),
  --         vec2(909.58, -955.95),
  --         vec2(903.27, -956.28),
  --         vec2(902.61, -945.22),
  --         vec2(923.9, -943.79),
  --         vec2(924.5, -956.21),
  --         vec2(932.85, -956.09),
  --         vec2(933.32, -952.66),
  --         vec2(941.05, -952.19),
  --         vec2(940.58, -944.6),
  --         vec2(932.12, -944.41),
  --         vec2(931.48, -934.47),
  --         vec2(961.09, -932.64),
  --         vec2(962.56, -955.52),
  --         vec2(964.37, -983.87),

  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(948.48, -972.38, 39.5, 5.0), w = 1.5, d = 1.0, }, },
  --     store = { { coords = vec4(951.14, -979.1, 39.5, 4.0), w = 4.2, d = 1.0, }, },
  --     crafting = { { coords = vec4(921.14, -986.24, 39.5, 4.0), w = 1.0, d = 4.0, }, },
  --     clockin = { { coords = vec4(952.1, -968.39, 39.31, 273.2), }, prop = true, },
  --     manualRepair = { { coords = vec4(911.67, -978.21, 39.5, 274.64), prop = true, } },
  --     garage = {
  --         spawn = vec4(937.02, -990.27, 38.34, 93.92),
  --         out = vec4(936.81, -987.17, 38.34, 184.37),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true
  --     },
  --     payments = {
  --         coords = vec4(949.46, -968.68, 39.31, 92.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>",
  --         prop = true
  --     },
  --     blip = vec3(932.49, -970.83, 39.5),
  --     bliplabel = "Import Garage",
  --     blipcolor = 81,
  --     discordlink = "",
  --     discordcolour = 2571775,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
  -- },
  -- -- OTTOS AUTOS --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(824.64721679688, -802.48284912109),
  --         vec2(838.40698242188, -802.47802734375),
  --         vec2(837.53460693359, -830.51928710938),
  --         vec2(823.86810302734, -830.36676025391)
  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(836.97, -814.73, 26.33, 90.0), w = 0.6, d = 3.6, }, },
  --     store = { { coords = vec4(837.02, -808.22, 26.33, 90.0), w = 1.0, d = 1.4, }, },
  --     crafting = { { coords = vec4(837.03, -811.74, 26.33, 90.0), w = 1.4, d = 2.2, }, },
  --     clockin = { { coords = vec4(834.63, -829.76, 26.13, 197.67), prop = true, }, },
  --     manualRepair = { { coords = vec4(835.0, -801.06, 26.27, 0.25), prop = true, } },
  --     garage = {
  --         spawn = vec4(826.59, -793.63, 26.21, 84.34),
  --         out = vec4(824.3, -801.2, 26.37, 0.65),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
  --         prop = true
  --     },
  --     payments = {
  --         coords = vec4(833.96, -826.79, 26.13, 0.35),
  --         img = "<center><p><img src=https://i.imgur.com/74UVnCb.jpeg width=150px></p>",
  --         prop = true
  --     },
  --     blip = vec3(831.03, -813.01, 26.33),
  --     bliplabel = "Otto's Autos",
  --     blipcolor = 1,
  --     discordlink = "",
  --     discordcolour = 16711680,
  --     discordimg = "https://i.imgur.com/74UVnCb.jpeg",
  -- },
  -- -- HAYES AUTOS --
  -- {
  --     job = "mechanic",
  --     zones = {
  --         vec2(-1439.9047851563, -443.4548034668),
  --         vec2(-1426.0206298828, -466.5227355957),
  --         vec2(-1400.1343994141, -451.71572875977),
  --         vec2(-1414.7999267578, -427.64019775391)
  --     },
  --     autoClock = { enter = false, exit = false, },
  --     stash = { { coords = vec4(-1414.94, -452.35, 35.91, 302.0), w = 4.0, d = 1.0, }, },
  --     store = { { coords = vec4(-1408.04, -448.04, 35.91, 302.0), w = 5.5, d = 1.0, }, },
  --     crafting = { { coords = vec4(-1407.68, -442.32, 35.91, 302.0), w = 0.6, d = 1.0, }, },
  --     clockin = { { coords = vec4(-1427.19, -457.51, 35.71, 300.0), prop = true, }, },
  --     manualRepair = { { coords = vec4(-1421.91, -455.41, 35.91, 33.32), prop = true, } },
  --     garage = {
  --         spawn = vec4(-1379.84, -451.82, 34.44, 124.0),
  --         out = vec4(-1401.57, -451.19, 34.48, 212.71),
  --         list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" }
  --     },
  --     payments = {
  --         coords = vec4(-1429.02, -453.6, 35.97, 350.0),
  --         img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/0/0c/HayesAutoBodyShop-GTAV-Logo.png width=150px></p>",
  --         prop = true,
  --     },
  --     blip = vec3(-1417.12, -445.9, 35.91),
  --     bliplabel = "Hayes Autos",
  --     blipcolor = 57,
  --     discordlink = "",
  --     discordcolour = 39135,
  --     discordimg = "https://static.wikia.nocookie.net/gtawiki/images/0/0c/HayesAutoBodyShop-GTAV-Logo.png",
  -- },
}

AddEventHandler('onResourceStop', function(r)
  if r ~= GetCurrentResourceName() then return end
  for k in pairs(Targets) do exports["qb-target"]:RemoveZone(k) end
  for i = 1, #till do DeleteEntity(till[i]) end
  for i = 1, #bench do DeleteEntity(bench[i]) end
  for i = 1, #laptop do DeleteEntity(laptop[i]) end
  for i = 1, #nos do DeleteEntity(nos[i]) end
  for i = 1, #parking do DeleteEntity(parking[i]) end
  emptyHands(PlayerPedId())
end)

local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local JobsDone = 0
local LocationsDone = {}
local CurrentLocation = nil
local CurrentBlip = nil
local hasBox = false
local isWorking = false
local currentCount = 0
local selectedVeh = nil
local TruckVehBlip = nil
local TruckerBlip = nil
local Delivering = false
local returningToStation = false
local RandomLocations = {}

-- Functions

local function getRandomLocations()
  for i = 1, 10 do
    local index = math.random(#Config.Locations["stores"])
    RandomLocations[#RandomLocations + 1] = Config.Locations["stores"][index]
  end
end

local function returnToStation()
  SetBlipRoute(TruckVehBlip, true)
  returningToStation = true
end

local function hasDoneLocation(locationId)
  if LocationsDone and table.type(LocationsDone) ~= "empty" then
    for _, v in pairs(LocationsDone) do
      if v == locationId then
        return true
      end
    end
  end
  return false
end

local function getNextLocation()
  local current = 1

  if Config.FixedLocation then
    local pos = GetEntityCoords(PlayerPedId(), true)
    local dist = nil
    for k, v in pairs(RandomLocations) do
      local dist2 = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
      if dist then
        if dist2 < dist then
          current = k
          dist = dist2
        end
      else
        current = k
        dist = dist2
      end
    end
  else
    while hasDoneLocation(current) do
      current = #LocationsDone + 1
    end
  end

  return current
end

local function isTruckerVehicle(vehicle)
  for k in pairs(Config.Vehicles) do
    if GetEntityModel(vehicle) == joaat(k) then
      return true
    end
  end
  return false
end

local function RemoveTruckerBlips()
  ClearAllBlipRoutes()
  if TruckVehBlip then
    RemoveBlip(TruckVehBlip)
    TruckVehBlip = nil
  end

  if TruckerBlip then
    RemoveBlip(TruckerBlip)
    TruckerBlip = nil
  end

  if CurrentBlip then
    RemoveBlip(CurrentBlip)
    CurrentBlip = nil
  end
end

local function OpenMenuGarage()
  local truckMenu = {}
  for k in pairs(Config.Vehicles) do
    truckMenu[#truckMenu + 1] = {
      title = Config.Vehicles[k],
      event = "qb-trucker:client:TakeOutVehicle",
      args = {
        vehicle = k
      }
    }
  end
  lib.registerContext({
    id = 'trucker_veh_menu',
    title = Lang:t("menu.header"),
    options = truckMenu
  })
  lib.showContext('trucker_veh_menu')
end

local function SetDelivering(active)
  if PlayerJob.name ~= 'trucker' then return end
  Delivering = active
end

local function CreateZone(type, number)
  local coords
  local size
  local rotation
  local boxName
  local icon
  local debug

  if type == 'main' then
    exports.ox_target:addBoxZone({
      coords = Config.Locations["main"].coords,
      size = Config.Locations["main"].size,
      rotation = Config.Locations["main"].rotation,
      debug = Config.Locations["main"].debug,
      options = {
        {
          name = Config.Locations["main"].label,
          event = 'qb-truckerjob:client:PaySlip',
          icon = Config.Locations["main"].icon,
          label = Config.Locations["main"].label,
          distance = 2,
        },
        {
          onSelect = function()
            OpenMenuGarage()
          end,
          label = "Get Vehicle",
          icon = "fa-solid fa-car",
        },
      }
    })
  else
    if number == nil then return end
    local targetZone = exports.ox_target:addBoxZone({
      coords = RandomLocations[number].coords,
      size = vec3(1.5, 3, 1),
      rotation = RandomLocations[number].rotation,
      debug = false,
      options = {
        {
          label = 'Deliver',
          icon = 'fa-solid fa-box',
          onSelect = function()
            Deliver()
          end,
          canInteract = function()
            if lib.progressActive() then return false end
            if Delivering and hasBox then
              return true
            end
            return false
          end,
        },
      }
    })

    local boxZones = lib.zones.box({
      name = RandomLocations[number].boxName,
      coords = RandomLocations[number].coords,
      size = RandomLocations[number].size,
      rotation = RandomLocations[number].rotation,
      debug = RandomLocations[number].debug,
      onEnter = function()
        if type == 'stores' then
          lib.notify({
            type = 'info',
            title = 'Store Delivery Tip',
            description = 'Store reached, you should check the back for a box. Open the back doors with the \'vehicle\' option in your radial menu while in the driver seat.',
            duration = 5000
          })

          SetDelivering(true)
        end
      end,
      onExit = function()
        if type == 'stores' then
          SetDelivering(false)
        end
      end
    })
    if type == 'stores' then
      CurrentLocation.zoneCombo.box = boxZones
      CurrentLocation.zoneCombo.target = targetZone
    end
  end
end

local function getNewLocation()
  local location = getNextLocation()
  if location ~= 0 then
    CurrentLocation = {}
    CurrentLocation.zoneCombo = {}
    CurrentLocation.id = location
    CurrentLocation.dropcount = math.random(1, 3)
    CurrentLocation.store = RandomLocations[location].name
    CurrentLocation.x = RandomLocations[location].coords.x
    CurrentLocation.y = RandomLocations[location].coords.y
    CurrentLocation.z = RandomLocations[location].coords.z
    CreateZone('stores', location)

    CurrentBlip = AddBlipForCoord(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z)
    SetBlipColour(CurrentBlip, 3)
    SetBlipRoute(CurrentBlip, true)
    SetBlipRouteColour(CurrentBlip, 3)
  else
    lib.notify({ title = 'Store Delivery', description = Lang:t("success.payslip_time"), duration = 5000, type = 'success' })
    if CurrentBlip ~= nil then
      RemoveBlip(CurrentBlip)
      ClearAllBlipRoutes()
      CurrentBlip = nil
    end
  end
end

local function CreateElements()
  TruckVehBlip = AddBlipForCoord(Config.Locations['vehicle'].coords.x, Config.Locations['vehicle'].coords.y, Config.Locations['vehicle'].coords.z)
  SetBlipSprite(TruckVehBlip, 326)
  SetBlipDisplay(TruckVehBlip, 4)
  SetBlipScale(TruckVehBlip, 0.6)
  SetBlipAsShortRange(TruckVehBlip, true)
  SetBlipColour(TruckVehBlip, 5)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(Config.Locations['vehicle'].label)
  EndTextCommandSetBlipName(TruckVehBlip)

  TruckerBlip = AddBlipForCoord(Config.Locations['main'].coords.x, Config.Locations['main'].coords.y, Config.Locations['main'].coords.z)
  SetBlipSprite(TruckerBlip, 479)
  SetBlipDisplay(TruckerBlip, 4)
  SetBlipScale(TruckerBlip, 0.6)
  SetBlipAsShortRange(TruckerBlip, true)
  SetBlipColour(TruckerBlip, 5)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(Config.Locations['main'].label)
  EndTextCommandSetBlipName(TruckerBlip)

  CreateZone('main')
  CreateZone('vehicle')
end

local function BackDoorsOpen(vehicle) -- This is hardcoded for the rumpo currently
  return GetVehicleDoorAngleRatio(vehicle, 2) > 0.0 and GetVehicleDoorAngleRatio(vehicle, 3) > 0.0
end

local function GetInTrunk()
  if IsPedInAnyVehicle(cache.ped, false) then
    return lib.notify({ title = 'Store Delivery', description = Lang:t("error.get_out_vehicle"), duration = 5000, type = 'error' })
  end
  local pos = GetEntityCoords(cache.ped, true)
  local vehicle = GetVehiclePedIsIn(cache.ped, true)
  if not isTruckerVehicle(vehicle) or CurrentVeh ~= vehicle then
    return lib.notify({ title = 'Store Delivery', description = Lang:t("error.vehicle_not_correct"), duration = 5000, type = 'error' })
  end
  if not BackDoorsOpen(vehicle) then
    return lib.notify({ title = 'Store Delivery', description = Lang:t("error.backdoors_not_open"), duration = 5000, type = 'error' })
  end
  local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
  if #(pos - vector3(trunkpos.x, trunkpos.y, trunkpos.z)) > 1.5 then
    return lib.notify({ title = 'Store Delivery', description = Lang:t("error.too_far_from_trunk"), duration = 5000, type = 'error' })
  end

  if isWorking then return end
  isWorking = true
  if lib.progressCircle({
        duration = 2000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
          car = true,
          mouse = false,
          combat = true,
          move = true,
        },
        anim = {
          dict = 'anim@gangops@facility@servers@',
          clip = 'hotwire'
        },
      }) then
    isWorking = false
    StopAnimTask(cache.ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
    exports.scully_emotemenu:playEmoteByCommand('box')
    hasBox = true

    lib.notify({
      type = 'info',
      title = 'Store Delivery Tip',
      description = 'Deliver the box inside or around the store.',
      duration = 2500
    })
  else
    isWorking = false
    StopAnimTask(cache.ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
    lib.notify({ title = 'Store Delivery', description = Lang:t("error.cancelled"), duration = 5000, type = 'error' })
  end
end

function Deliver()
  if lib.progressActive() then return end
  isWorking = true
  exports.scully_emotemenu:cancelEmote()
  Wait(500)
  exports.scully_emotemenu:playEmoteByCommand('bumbin')
  if lib.progressCircle({
        duration = 3000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
          car = true,
          mouse = false,
          combat = true,
          move = true,
        },
      }) then
    exports.scully_emotemenu:cancelEmote()
    isWorking = false
    ClearPedTasks(cache.ped)
    hasBox = false
    currentCount = currentCount + 1
    if currentCount == CurrentLocation.dropcount then
      LocationsDone[#LocationsDone + 1] = CurrentLocation.id
      TriggerServerEvent("qb-shops:server:RestockShopItems", CurrentLocation.store)
      exports['qb-core']:HideText()
      Delivering = false
      if CurrentBlip ~= nil then
        RemoveBlip(CurrentBlip)
        ClearAllBlipRoutes()
        CurrentBlip = nil
      end
      CurrentLocation.zoneCombo.box:remove()
      exports.ox_target:removeZone(CurrentLocation.zoneCombo.target)
      CurrentLocation = nil
      currentCount = 0
      JobsDone = JobsDone + 1
      if JobsDone == Config.MaxDrops then
        lib.notify({ title = 'Store Delivery', description = Lang:t("mission.return_to_station"), duration = 5000, type = 'info' })
        returnToStation()
      else
        lib.notify({ title = 'Store Delivery', description = Lang:t("mission.goto_next_point"), duration = 5000, type = 'info' })
        getNewLocation()
      end
    elseif currentCount ~= CurrentLocation.dropcount then
      lib.notify({ title = 'Store Delivery', description = Lang:t("mission.another_box"), duration = 5000, type = 'info' })
    else
      isWorking = false
      ClearPedTasks(cache.ped)
      lib.notify({ title = 'Store Delivery', description = Lang:t("error.cancelled"), duration = 5000, type = 'error' })
    end
  end
end

-- Events

AddEventHandler('onResourceStart', function(resource)
  if resource ~= GetCurrentResourceName() then return end
  PlayerJob = QBCore.Functions.GetPlayerData().job
  CurrentLocation = nil
  CurrentBlip = nil
  hasBox = false
  isWorking = false
  JobsDone = 0
  if PlayerJob.name ~= 'trucker' then return end
  CreateElements()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  PlayerJob = QBCore.Functions.GetPlayerData().job
  CurrentLocation = nil
  CurrentBlip = nil
  hasBox = false
  isWorking = false
  JobsDone = 0
  if PlayerJob.name ~= 'trucker' then return end
  CreateElements()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  RemoveTruckerBlips()
  CurrentLocation = nil
  CurrentBlip = nil
  hasBox = false
  isWorking = false
  JobsDone = 0
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  local OldPlayerJob = PlayerJob.name
  PlayerJob = JobInfo
  if OldPlayerJob == 'trucker' then
    RemoveTruckerBlips()
    if CurrentLocation and CurrentLocation.zoneCombo then
      CurrentLocation.zoneCombo.box:remove()
      exports.ox_target:removeZone(CurrentLocation.zoneCombo.target)
    end
    exports['qb-core']:HideText()
    Delivering = false
    showMarker = false
  elseif PlayerJob.name == 'trucker' then
    CreateElements()

    lib.notify({
      type = 'info',
      title = 'Store Delivery Tip',
      description = ('Drive to the Truck Storage that was marked on your map and start your job. There is a $%d deposit for the Dumbo Delivery vehicle'):format(Config.BailPrice),
      duration = 5000
    })
    SetNewWaypoint(Config.Locations['main'].coords.x, Config.Locations['main'].coords.y)
  end
end)

RegisterNetEvent('qb-trucker:client:SpawnVehicle', function()
  local netId = lib.callback.await('qb-trucker:server:spawnVehicle', false, selectedVeh)

  repeat
    Wait(10)
  until NetworkDoesEntityExistWithNetworkId(netId)

  local veh = NetToVeh(netId)
  SetVehicleLivery(veh, 1)
  SetVehicleColours(veh, 122, 122)
  SetVehicleEngineOn(veh, true, true, false)
  CurrentVeh = veh
  getRandomLocations()
  getNewLocation()

  exports.ox_target:addLocalEntity({ veh }, {
    {
      name = 'truckerjob:grabBox',
      icon = 'fa-solid fa-box',
      label = 'Grab Box',
      onSelect = function()
        GetInTrunk()
      end,
      canInteract = function(entity)
        if lib.progressActive() then return false end
        if Delivering then
          return true
        end
        return false
      end,
    }
  })

  lib.notify({
    type = 'info',
    title = 'Store Delivery Tip',
    description = 'Drive to the Store that has been marked on your map.',
    duration = 5000
  })
end)

RegisterNetEvent('qb-trucker:client:TakeOutVehicle', function(data)
  local vehicleInfo = data.vehicle
  TriggerServerEvent('qb-trucker:server:DoBail', true, vehicleInfo)
  selectedVeh = vehicleInfo
end)

RegisterNetEvent('qb-truckerjob:client:Vehicle', function()
  if IsPedInAnyVehicle(cache.ped, false) and isTruckerVehicle(GetVehiclePedIsIn(cache.ped, false)) then
    if GetPedInVehicleSeat(GetVehiclePedIsIn(cache.ped, false), -1) == cache.ped then
      if isTruckerVehicle(GetVehiclePedIsIn(cache.ped, false)) then
        DeleteVehicle(GetVehiclePedIsIn(cache.ped, false))
        TriggerServerEvent('qb-trucker:server:DoBail', false)
        if CurrentBlip ~= nil then
          RemoveBlip(CurrentBlip)
          ClearAllBlipRoutes()
          CurrentBlip = nil
        end
        if returningToStation or CurrentLocation then
          ClearAllBlipRoutes()
          returningToStation = false
          lib.notify({ title = 'Store Delivery', description = Lang:t("mission.job_completed"), duration = 5000, type = 'success' })
        end
      else
        lib.notify({ title = 'Store Delivery', description = Lang:t("error.vehicle_not_correct"), duration = 5000, type = 'error' })
      end
    else
      lib.notify({ title = 'Store Delivery', description = Lang:t("error.no_driver"), duration = 5000, type = 'error' })
    end
  else
    OpenMenuGarage()
  end
end)

RegisterNetEvent('qb-truckerjob:client:PaySlip', function()
  if JobsDone > 0 then
    TriggerServerEvent("qb-trucker:server:01101110", JobsDone)
    TriggerServerEvent('qb-trucker:server:DoBail', false, NetworkGetNetworkIdFromEntity(CurrentVeh))
    JobsDone = 0
    if #LocationsDone == #Config.Locations['stores'] then
      LocationsDone = {}
    end
    if CurrentBlip ~= nil then
      RemoveBlip(CurrentBlip)
      ClearAllBlipRoutes()
      CurrentBlip = nil
    end
  else
    lib.notify({ title = 'Store Delivery', description = Lang:t("error.no_work_done"), duration = 5000, type = 'error' })
  end
end)

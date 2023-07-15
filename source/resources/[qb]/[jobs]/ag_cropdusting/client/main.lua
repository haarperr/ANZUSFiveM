lib.locale()

local QBCore = exports['qb-core']:GetCoreObject()
local veh = nil
local JobLocations = {}
local currentLoc = 0
local currentBlip = nil
local currentZone = nil
local jobmodel = nil
local IsInside = false
local currentSmoke = nil
local IsControlPressed = false

local function ReturnVehicle()
  if DoesEntityExist(veh) then
    local coords = GetEntityCoords(veh)
    if #(coords - vector3(Config.StartJob.vehcoords.x, Config.StartJob.vehcoords.y, Config.StartJob.vehcoords.z)) < 10 then
      DeleteVehicle(veh)
      TriggerServerEvent('ag_cropdusting:server:ReturnVehicle')
    else
      lib.notify({ type = 'error', description = locale('park_veh') })
    end
  else
    lib.notify({ type = 'error', description = locale('damage_veh') })
  end
end

local function startSmoke(bool)
  if not bool then return StopParticleFxLooped(currentSmoke, 0) end
  RequestNamedPtfxAsset(Config.SmokeDict)
  while not HasNamedPtfxAssetLoaded(Config.SmokeDict) do
    Wait(0)
  end
  local min, max = GetModelDimensions(GetEntityModel(veh))
  UseParticleFxAssetNextCall(Config.SmokeDict)
  currentSmoke = StartParticleFxLoopedOnEntityBone_2(Config.SmokeName, veh, vector3(0.0, min.y, 0.0), 0.0, 0.0, 0.0, -1, 1.0, vector3(0.0, min.y, 0.0))
  SetParticleFxLoopedScale(currentSmoke, 1.0)
  SetParticleFxLoopedRange(currentSmoke, 1000.0)
  SetParticleFxLoopedColour(currentSmoke, 47.0, 35.0, 0.0, 0)
end

local function ListenForKeyPress()
  CreateThread(function()
    if IsInside then return end
    IsInside = true
    while IsInside do
      Wait(1)
      if IsControlJustPressed(0, 38) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle == veh then
          lib.hideTextUI()
          JobLocations[currentLoc].HasDone = true
          RemoveBlip(currentBlip)
          currentBlip = nil
          IsControlPressed = true
          TriggerServerEvent('ag_cropdusting:server:UpdateVal', currentLoc)
          startSmoke(true)
          IsInside = false
          break
        else
          lib.notify({ type = 'error', description = locale('no_plane') })
        end
      end
    end
  end)
end

local function CreateZone(data)
  local function onEnter(self)
    currentZone = self
    lib.showTextUI(locale('drop_fertilizer'), { position = 'left-center' })
    ListenForKeyPress()
  end
  local function onExit(self)
    if IsControlPressed then
      startSmoke(false)
      IsControlPressed = false
      self:remove()
    end
    currentZone = nil
    IsInside = false
    lib.hideTextUI()
  end
  local zone = lib.zones.box({
    coords = data.coords,
    size = data.size,
    rotation = data.rot,
    debug = false,
    onEnter = onEnter,
    onExit = onExit
  })
end

local function CreateJobBlip()
  currentLoc = currentLoc + 1
  if not JobLocations[currentLoc] then return lib.notify({ type = 'success', description = locale('job_complete') }) end

  local CropDusting = AddBlipForCoord(JobLocations[currentLoc].data.coords.x, JobLocations[currentLoc].data.coords.y, JobLocations[currentLoc].data.coords.z)
  SetBlipSprite(CropDusting, 423)
  SetBlipDisplay(CropDusting, 4)
  SetBlipScale(CropDusting, 0.6)
  SetBlipAsShortRange(CropDusting, true)
  SetBlipColour(CropDusting, 15)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(locale('delivery_blip_label'))
  EndTextCommandSetBlipName(CropDusting)

  SetBlipRoute(CropDusting, true)
  SetBlipRouteColour(CropDusting, 3)

  CreateZone(JobLocations[currentLoc].data)
  currentBlip = CropDusting
end

local function SpawnVehicle()
  local res = lib.callback.await('ag_cropdusting:server:HasJob', 500)
  if res then return lib.notify({ type = 'error', description = locale('active_job') }) end

  local vehCheck = lib.callback.await('ag_cropdusting:server:VehicleCheck', 500)
  if vehCheck then
    if DoesEntityExist(veh) then
      lib.notify({ type = 'error', description = locale('return_vehicle') })
    end
    return
  end

  local item = exports.ox_inventory:GetItemCount(Config.FertilizerName)
  if item < Config.RequiredFertilizerAmount then
    return lib.notify({ type = 'error', description = locale('no_sufficient_fertilizer', Config.RequiredFertilizerAmount) })
  end

  local hasMoney = lib.callback.await('ag_cropdusting:server:MoneyCheck', 500)
  if not hasMoney then
    return lib.notify({ type = 'error', description = locale('no_sufficient_money', Config.DepositAmount) })
  end

  local locations = lib.callback.await('ag_cropdusting:server:GetLocation', 500)
  local model = Config.JobVehicle
  RequestModel(model)
  while not HasModelLoaded(model) do
    Wait(1)
  end
  local netId = lib.callback.await('ag_cropdusting:server:SpawnVehicle', 500)
  veh = NetToVeh(netId)
  SetEntityAsMissionEntity(veh, true, true)
  TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
  SetVehicleEngineOn(veh, true, true)
  JobLocations = locations
  CreateJobBlip()
  lib.notify({ type = 'success', description = locale('deposit_success') })

  lib.notify({ type = 'info', title = 'Cropdusting Tip', description = locale('tip_2', Config.MaxLocations), duration = 10000 })
end

local function CreateJobElements()
  local point = lib.points.new({
    coords = vec3(Config.StartJob.coords.x, Config.StartJob.coords.y, Config.StartJob.coords.z),
    distance = 50,
    nearbyDone = false
  })

  local CropDusting = AddBlipForCoord(Config.StartJob.coords.x, Config.StartJob.coords.y, Config.StartJob.coords.z)
  SetBlipSprite(CropDusting, 423)
  SetBlipDisplay(CropDusting, 4)
  SetBlipScale(CropDusting, 0.6)
  SetBlipAsShortRange(CropDusting, true)
  SetBlipColour(CropDusting, 15)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(locale('blip_label'))
  EndTextCommandSetBlipName(CropDusting)

  function point:onExit()
    self.nearbyDone = false
  end

  function point:nearby()
    if self.nearbyDone then return end
    self.nearbyDone = true
    if DoesEntityExist(jobmodel) then
      DeletePed(jobmodel)
    end
    jobmodel = nil
    if PlayerJob.name == Config.JobName then
      local options = {
        {
          name = 'ag_cropdusting:client:SpawnVehicle',
          onSelect = SpawnVehicle,
          icon = 'fa-solid fa-road',
          label = 'Start Job',
        },
        {
          name = 'ag_cropdusting:client:ReturnVehicle',
          onSelect = ReturnVehicle,
          icon = 'fa-solid fa-road',
          label = 'Return Vehicle',
        },
        {
          name = 'ag_cropdusting:server:LostVehicle',
          onSelect = function()
            TriggerServerEvent('ag_cropdusting:server:LostVehicle')
          end,
          icon = 'fa-solid fa-road',
          label = 'Lost Vehicle',
        },
        {
          name = 'ag_cropdusting:server:JobComplete',
          onSelect = function()
            TriggerServerEvent('ag_cropdusting:server:JobComplete')
          end,
          icon = 'fa-solid fa-road',
          label = 'PayCheck',
        }
      }
      while not HasModelLoaded(Config.JobModel) do
        RequestModel(Config.JobModel)
        Wait(100)
      end
      jobmodel = CreatePed(3, Config.JobModel, Config.StartJob.coords.x, Config.StartJob.coords.y, Config.StartJob.coords.z, Config.StartJob.coords.w, false, true)
      FreezeEntityPosition(jobmodel, true)
      SetEntityInvincible(jobmodel, true)
      SetBlockingOfNonTemporaryEvents(jobmodel, true)
      SetModelAsNoLongerNeeded(Config.JobModel)
      exports.ox_target:addLocalEntity({ jobmodel }, options)
    end
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  PlayerJob = QBCore.Functions.GetPlayerData().job

  if PlayerJob.name == Config.JobName then
    CreateJobElements()
  end
end)

RegisterNetEvent('ag_cropdusting:client:UpdatedVal', function()
  CreateJobBlip()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerJob = JobInfo

  if PlayerJob.name == Config.JobName then
    lib.notify({ type = 'info', title = 'Employment Info', description = locale('tip', Config.RequiredFertilizerAmount, Config.DepositAmount), duration = 10000 })

    SetNewWaypoint(Config.StartJob.coords.x, Config.StartJob.coords.y)

    CreateJobElements()
  end
end)

RegisterNetEvent('ag_cropdusting:client:DestroyAll', function()
  if currentZone then
    currentZone:remove()
    currentZone = nil
  end
  RemoveBlip(currentBlip)
  SetWaypointOff()
  IsInside = false
  currentBlip = nil
  JobLocations = {}
  IsControlPressed = false
  DeleteVehicle(veh)
  veh = nil
  currentLoc = 0
end)

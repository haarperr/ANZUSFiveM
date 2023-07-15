local QBCore = exports['qb-core']:GetCoreObject()
local camZPlus1 = 1500
local camZPlus2 = 50
local pointCamCoords = 75
local pointCamCoords2 = 0
local cam1Time = 500
local cam2Time = 1000
local isChoosingSpawn = false
local Houses = {}
local cam = nil
local cam2 = nil

-- Functions

-- Stops player from moving while choosing spawn
local function launchDisableControlsThread()
  CreateThread(function()
    while isChoosingSpawn do
      Wait(0)
      DisableAllControlActions(0)
    end
  end)
end

---Displays the spawn UI and disables controls
---@param isShowing boolean
---@return void
local function setDisplay(isShowing)
  isChoosingSpawn = isShowing
  if isShowing then launchDisableControlsThread() end
  SetNuiFocus(isShowing, isShowing)
  SendNUIMessage({
    action = "showUi",
    status = isShowing
  })
end

-- Events

RegisterNetEvent('qb-spawn:client:openUI', function(value)
  SetEntityVisible(PlayerPedId(), false)
  DoScreenFadeOut(250)
  Wait(1000)
  DoScreenFadeIn(250)
  QBCore.Functions.GetPlayerData(function(PlayerData)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + camZPlus1, -85.00, 0.00, 0.00, 100.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
  end)
  Wait(500)
  setDisplay(value)
end)

RegisterNetEvent('qb-houses:client:setHouseConfig', function(houseConfig)
  Houses = houseConfig
end)

RegisterNetEvent('qb-spawn:client:setupSpawns', function(cData, new, apps)
  if not new then
    local houses = lib.callback.await('qb-spawn:server:getOwnedHouses', false, cData.citizenid)
    local myHouses = {}
    if houses then
      for i = 1, #houses do
        myHouses[#myHouses + 1] = {
          house = houses[i].camCoords,
          label = houses[i].label,
          id = houses[i].id
        }
      end
    end

    Wait(500)
    SendNUIMessage({
      action = "setupLocations",
      locations = QB.Spawns,
      houses = myHouses,
      isNew = new
    })
  elseif new then
    SendNUIMessage({
      action = "setupAppartements",
      locations = apps,
      isNew = new
    })
  end
end)

-- NUI Callbacks

RegisterNUICallback("exit", function(_, cb)
  SetNuiFocus(false, false)
  SendNUIMessage({
    action = "showUi",
    status = false
  })
  isChoosingSpawn = false
  cb("ok")
end)

local function SetCam(campos)
  cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus1, 300.00, 0.00, 0.00, 110.00, false, 0)
  PointCamAtCoord(cam2, campos.x, campos.y, campos.z + pointCamCoords)
  SetCamActiveWithInterp(cam2, cam, cam1Time, true, true)
  if DoesCamExist(cam) then
    DestroyCam(cam, true)
  end
  Wait(cam1Time)

  cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus2, 300.00, 0.00, 0.00, 110.00, false, 0)
  PointCamAtCoord(cam, campos.x, campos.y, campos.z + pointCamCoords2)
  SetCamActiveWithInterp(cam, cam2, cam2Time, true, true)
  SetEntityCoords(PlayerPedId(), campos.x, campos.y, campos.z)
end

RegisterNUICallback('setCam', function(data, cb)
  local location = tostring(data.posname)
  local type = tostring(data.type)
  DoScreenFadeOut(200)
  Wait(500)
  DoScreenFadeIn(200)
  if DoesCamExist(cam) then DestroyCam(cam, true) end
  if DoesCamExist(cam2) then DestroyCam(cam2, true) end
  if type == "current" then
    QBCore.Functions.GetPlayerData(function(PlayerData)
      SetCam(PlayerData.position)
    end)
  elseif type == "house" then
    local coords = json.decode(data.posname)
    SetCam(coords)
  elseif type == "normal" then
    SetCam(QB.Spawns[location].coords)
  elseif type == "appartment" then
    SetCam(Apartments.Locations[location].coords.enter)
  end
  cb('ok')
end)

RegisterNUICallback('chooseAppa', function(data, cb)
  local ped = PlayerPedId()
  local appaYeet = data.appType
  setDisplay(false)
  DoScreenFadeOut(500)
  Wait(5000)
  TriggerServerEvent("apartments:server:CreateApartment", appaYeet, Apartments.Locations[appaYeet].label)
  TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
  TriggerEvent('QBCore:Client:OnPlayerLoaded')
  FreezeEntityPosition(ped, false)
  RenderScriptCams(false, true, 500, true, true)
  SetCamActive(cam, false)
  DestroyCam(cam, true)
  SetCamActive(cam2, false)
  DestroyCam(cam2, true)
  SetEntityVisible(ped, true)
  cb('ok')
end)

local function PreSpawnPlayer()
  setDisplay(false)
  DoScreenFadeOut(500)
  Wait(2000)
end

local function PostSpawnPlayer(ped)
  FreezeEntityPosition(ped, false)
  RenderScriptCams(false, true, 500, true, true)
  SetCamActive(cam, false)
  DestroyCam(cam, true)
  SetCamActive(cam2, false)
  DestroyCam(cam2, true)
  SetEntityVisible(PlayerPedId(), true)
  Wait(500)
  DoScreenFadeIn(250)
end

RegisterNUICallback('spawnplayer', function(data, cb)
  local location = tostring(data.spawnloc)
  local type = tostring(data.typeLoc)
  local id = data.id
  local ped = PlayerPedId()
  local PlayerData = QBCore.Functions.GetPlayerData()
  local insideMeta = PlayerData.metadata["inside"]
  if type == "current" then
    PreSpawnPlayer()
    QBCore.Functions.GetPlayerData(function(pd)
      ped = PlayerPedId()
      SetEntityCoords(ped, pd.position.x, pd.position.y, pd.position.z)
      SetEntityHeading(ped, pd.position.a)
      FreezeEntityPosition(ped, false)
    end)

    if insideMeta.house ~= nil then
      local houseId = insideMeta.house
      TriggerEvent('nolag_properties:client:spawnAtProperty', houseId)
    elseif insideMeta.apartment.apartmentType ~= nil or insideMeta.apartment.apartmentId ~= nil then
      local apartmentType = insideMeta.apartment.apartmentType
      local apartmentId = insideMeta.apartment.apartmentId
      TriggerEvent('nolag_properties:client:spawnAtProperty', apartmentId)
    end
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    PostSpawnPlayer()
  elseif type == "house" then
    PreSpawnPlayer()
    TriggerEvent('nolag_properties:client:spawnAtProperty', id)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
    TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
    PostSpawnPlayer()
  elseif type == "normal" then
    local pos = QB.Spawns[location].coords
    PreSpawnPlayer()
    SetEntityCoords(ped, pos.x, pos.y, pos.z)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
    TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
    Wait(500)
    SetEntityCoords(ped, pos.x, pos.y, pos.z)
    SetEntityHeading(ped, pos.w)
    PostSpawnPlayer()
  end
  cb('ok')
end)

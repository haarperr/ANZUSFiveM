local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local inRangeCityhall, inRangeDrivingSchool = false, false
local pedsSpawned = false
local table_clone = table.clone
local blips = {}

-- Functions

local function getClosestHall()
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  local distance = #(playerCoords - Config.Cityhalls[1].coords)
  local closest = 1
  for i = 1, #Config.Cityhalls do
    local hall = Config.Cityhalls[i]
    local dist = #(playerCoords - hall.coords)
    if dist < distance then
      distance = dist
      closest = i
    end
  end
  return closest
end

local function pairsInOrder(object, _)
  local a = {}
  for n in pairs(object) do
    table.insert(a, n)
  end
  table.sort(a, _)
  local i = 0
  local iterator = function()
    i = i + 1
    if a[i] == nil then
      return nil
    else
      return a[i], object[a[i]]
    end
  end
  return iterator
end

local function OpenCityhallIdentityMenu(closestCityhall)
  local licensesMeta = PlayerData.metadata["licences"]
  local availableLicenses = table_clone(Config.Cityhalls[closestCityhall].licenses)
  for license, data in pairs(availableLicenses) do
    if data.metadata and not licensesMeta[data.metadata] then
      availableLicenses[license] = nil
    end

    if data.job and PlayerData.job.name ~= data.job then
      availableLicenses[license] = nil
    end
  end

  local identityOptions = {}
  for item, id in pairsInOrder(availableLicenses) do
    identityOptions[#identityOptions + 1] = {
      title = id.label,
      description = ('Price: $%s'):format(id.cost),
      disabled = (id.license and not licensesMeta[id.license]) or false,
      onSelect = function()
        TriggerServerEvent('qb-cityhall:server:requestId', item, closestCityhall)
        if not Config.UseTarget and inRangeCityhall then
          lib.showTextUI('[E] Open Cityhall')
        end
      end
    }
  end
  lib.registerContext({
    id = 'cityhall_identity_menu',
    title = 'Identity',
    menu = 'cityhall_menu',
    onExit = function()
      if not Config.UseTarget and inRangeCityhall then
        lib.showTextUI('[E] Open Cityhall')
      end
    end,
    options = identityOptions
  })
  lib.showContext('cityhall_identity_menu')
end

local function OpenCityhallEmploymentMenu(closestCityhall)
  lib.callback('qb-cityhall:server:receiveJobs', false, function(result)
    local jobOptions = {}
    for job, label in pairsInOrder(result) do
      jobOptions[#jobOptions + 1] = {
        title = label,
        onSelect = function()
          TriggerServerEvent('qb-cityhall:server:ApplyJob', job)
          if not Config.UseTarget and inRangeCityhall then
            lib.showTextUI('[E] Open Cityhall')
          end
        end
      }
    end
    lib.registerContext({
      id = 'cityhall_employment_menu',
      title = 'Employment',
      menu = 'cityhall_menu',
      onExit = function()
        if not Config.UseTarget and inRangeCityhall then
          lib.showTextUI('[E] Open Cityhall')
        end
      end,
      options = jobOptions
    })
    lib.showContext('cityhall_employment_menu')
  end)
end

local function OpenDMVMenu()
  lib.callback('qb-cityhall:retrievePlates', false, function(res)
    local options = {}

    for i = 1, #res, 1 do
      local r = res[i]
      options[#options + 1] = {
        title = ('Plate: %s'):format(r.plate),
        onSelect = function()
          TriggerServerEvent('qb-cityhall:buyNewPlate', { plate = r.plate })
        end,
      }
    end

    lib.registerContext({
      id = 'retrieve_plates',
      title = 'DMV',
      options = options
    })

    lib.showContext('retrieve_plates')
  end)
end

local function OpenCityhallMenu()
  local closestCityhall = getClosestHall()
  lib.registerContext({
    id = 'cityhall_menu',
    title = 'City Hall',
    onExit = function()
      if not Config.UseTarget and inRangeCityhall then
        lib.showTextUI('[E] Open Cityhall')
      end
    end,
    options = {
      {
        title = 'Identity',
        description = 'Obtain a physical licence',
        onSelect = function()
          OpenCityhallIdentityMenu(closestCityhall)
        end
      },
      {
        title = 'Employment',
        description = 'Select a new job',
        onSelect = function()
          OpenCityhallEmploymentMenu(closestCityhall)
        end
      },
      {
        title = 'DMV',
        description = 'Retrieve a new plate',
        onSelect = function()
          OpenDMVMenu()
        end
      }
    }
  })
  lib.showContext('cityhall_menu')
  if not Config.UseTarget or bool then return end
  inRangeCityhall = false
end

local function createBlip(options)
  if not options.coords or type(options.coords) ~= 'table' and type(options.coords) ~= 'vector3' then
    return error(('createBlip() expected coords in a vector3 or table but received %s')
      :format(options.coords))
  end
  local blip = AddBlipForCoord(options.coords.x, options.coords.y, options.coords.z)
  SetBlipSprite(blip, options.sprite or 1)
  SetBlipDisplay(blip, options.display or 4)
  SetBlipScale(blip, options.scale or 1.0)
  SetBlipColour(blip, options.colour or 1)
  SetBlipAsShortRange(blip, options.shortRange or false)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(options.title or 'No Title Given')
  EndTextCommandSetBlipName(blip)
  return blip
end

local function deleteBlips()
  if not next(blips) then return end
  for i = 1, #blips do
    local blip = blips[i]
    if DoesBlipExist(blip) then
      RemoveBlip(blip)
    end
  end
  blips = {}
end

local function initBlips()
  for i = 1, #Config.Cityhalls do
    local hall = Config.Cityhalls[i]
    if hall.showBlip then
      blips[#blips + 1] = createBlip({
        coords = hall.coords,
        sprite = hall.blipData.sprite,
        display = hall.blipData.display,
        scale = hall.blipData.scale,
        colour = hall.blipData.colour,
        shortRange = true,
        title = hall.blipData.title
      })
    end
  end
  -- for i = 1, #Config.DrivingSchools do
  --     local school = Config.DrivingSchools[i]
  --     if school.showBlip then
  --         blips[#blips + 1] = createBlip({
  --             coords = school.coords,
  --             sprite = school.blipData.sprite,
  --             display = school.blipData.display,
  --             scale = school.blipData.scale,
  --             colour = school.blipData.colour,
  --             shortRange = true,
  --             title = school.blipData.title
  --         })
  --     end
  -- end
end

local function setupZone(coords, index)
  local point = lib.points.new({
    coords = coords,
    distance = 40,
    pedSpawned = false
  })

  function point:onEnter()
    if self.pedSpawned then return end
    local current = Config.Peds[index]
    current.model = type(current.model) == 'string' and joaat(current.model) or current.model
    RequestModel(current.model)
    while not HasModelLoaded(current.model) do
      Wait(0)
    end
    local ped = CreatePed(0, current.model, current.coords.x, current.coords.y, current.coords.z, current.coords.w, false, false)
    Wait(1000)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, current.scenario, true, true)
    current.pedHandle = ped
    if Config.UseTarget then
      local opts = nil
      -- if current.drivingschool then
      --     exports.ox_target:addLocalEntity(ped, { {
      --         name = 'take_driving_test' .. i,
      --         icon = 'fa-solid fa-car-side',
      --         label = 'Take Driving Lessons',
      --         distance = 1.5,
      --         onSelect = function()
      --             TriggerServerEvent('qb-cityhall:server:sendDriverTest')
      --         end
      --     } })
      if current.cityhall then
        exports.ox_target:addLocalEntity(ped, { {
          name = 'open_cityhall' .. index,
          icon = 'fa-solid fa-city',
          label = 'Open Cityhall',
          distance = 1.5,
          debug = true,
          onSelect = function()
            inRangeCityhall = true
            OpenCityhallMenu()
          end
        } })
      end
    else
      local options = current.zoneOptions
      if options then
        local function onEnterZone(zone)
          if LocalPlayer.state.isLoggedIn then
            if current.drivingschool and zone.name == 'driving_school' then
              inRangeDrivingSchool = true
              lib.showTextUI('[E] Take Driving Lessons')
              CreateThread(function()
                while inRangeDrivingSchool do
                  Wait(0)
                  if IsControlJustPressed(0, 38) then
                    TriggerServerEvent('qb-cityhall:server:sendDriverTest')
                    Wait(500)
                    lib.hideTextUI()
                  end
                end
              end)
            elseif current.cityhall and zone.name == 'cityhall' then
              inRangeCityhall = true
              lib.showTextUI('[E] Open Job/City Services')
              CreateThread(function()
                while inRangeCityhall do
                  Wait(0)
                  if IsControlJustPressed(0, 38) then
                    OpenCityhallMenu()
                    Wait(500)
                    lib.hideTextUI()
                  end
                end
              end)
            end
          end
        end

        local function onExitZone(zone)
          if (zone.name == 'driving_school') or (zone.name == 'cityhall') then
            lib.hideTextUI()
            if current.drivingschool then
              inRangeDrivingSchool = false
            elseif current.cityhall then
              inRangeCityhall = false
            end
          end
        end

        local zone = lib.zones.box({
          name = current.drivingschool and 'driving_school' or 'cityhall',
          coords = current.coords.xyz,
          size = vec3(2, 2, 3),
          rotation = current.coords.w,
          debug = false,
          onEnter = onEnterZone,
          onExit = onExitZone
        })
      end
    end
    self.pedSpawned = true
  end
end

local function deletePeds()
  if not Config.Peds or not next(Config.Peds) or not pedsSpawned then return end
  for i = 1, #Config.Peds do
    local current = Config.Peds[i]
    if current.pedHandle then
      DeletePed(current.pedHandle)
    end
  end
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  PlayerData = QBCore.Functions.GetPlayerData()
  initBlips()
  for index, value in ipairs(Config.Peds) do
    setupZone(value.coords, index)
  end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  PlayerData = {}
  deleteBlips()
  deletePeds()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
  PlayerData = val
end)

-- RegisterNetEvent('qb-cityhall:client:sendDriverEmail', function(charinfo)
--     SetTimeout(math.random(2500, 4000), function()
--         local gender = Lang:t('email.mr')
--         if PlayerData.charinfo.gender == 1 then
--             gender = Lang:t('email.mrs')
--         end
--         TriggerServerEvent('qb-phone:server:sendNewMail', {
--             sender = Lang:t('email.sender'),
--             subject = Lang:t('email.subject'),
--             message = Lang:t('email.message', { gender = gender, lastname = charinfo.lastname, firstname = charinfo.firstname, phone = charinfo.phone }),
--             button = {}
--         })
--     end)
-- end)

AddEventHandler('onResourceStop', function(resource)
  if resource ~= GetCurrentResourceName() then return end
  deleteBlips()
  deletePeds()
end)

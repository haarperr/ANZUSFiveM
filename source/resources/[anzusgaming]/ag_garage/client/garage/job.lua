local zones = {}
local category = nil
local job = nil

local utils = require 'client.utils'

local function purchaseVehicleType(model)
  local options = {
    {
      title = 'Personal',
      onSelect = function()
        TriggerServerEvent('ag_garage:PurchaseVehicle', { model = model, garage = Garage, shared = false })
      end
    },
    {
      title = 'Shared',
      onSelect = function()
        TriggerServerEvent('ag_garage:PurchaseVehicle', { model = model, garage = Garage, shared = true })
      end
    }
  }

  lib.registerContext({
    id = 'purchase_vehicle_type',
    title = 'Vehicle Type',
    menu = 'purchase_vehicle',
    options = options
  })

  lib.showContext('purchase_vehicle_type')
end

---@param job string Type of job
---@param type string[]
local function ViewBuyableVehicles(job, type)
  local vehicles = lib.callback.await('ag_garage:ViewBuyableVehicles', 200, { job = job, type = type })
  local options = {}

  for key, value in pairs(vehicles) do
    local isRestricted = Config.GradeRestricted[job][key]
    if not isRestricted then goto skip end

    if isRestricted > LocalPlayer.state.job.grade.level then goto skip end

    local icon = 'car-side'
    if value.type == 'bike' then
      icon = 'motorcycle'
    elseif value.type == 'heli' then
      icon = 'helicopter'
    end

    options[#options + 1] = {
      title = value.name,
      description = ('Price: $%d'):format(value.price):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""),
      icon = icon,
      onSelect = function()
        lib.hideContext()
        purchaseVehicleType(key)
      end
    }

    ::skip::
  end

  lib.registerContext({
    id = 'purchase_vehicle',
    title = 'Job Vehicle Shop',
    menu = 'garage_menu',
    options = options
  })

  lib.hideRadial()
  lib.showContext('purchase_vehicle')
end

---Add open menu on radial
---@param pool 'public' | 'shared'
local function OpenPool(pool)
  local config = Config.Jobs[category][Garage]
  local res = lib.callback.await('ag_garage:GetVehiclesAtGarage', 500, { garage = Garage, pool = pool, type = config.type })

  if not res then return lib.notify({ type = 'error', description = locale('no_vehicles_stored_job') }) end

  local options = {}
  local restricted = Config.GradeRestricted[job.type]

  for i = 1, #res, 1 do
    local vehicle = res[i]
    if restricted[vehicle.model] and restricted[vehicle.model] > job.grade.level then goto skip end

    local data = vehicle.data
    local engine = (data.properties?.engineHealth or 0)/10
    local body = (data.properties?.bodyHealth or 0)/10
    local fuel = (data.properties?.fuelLevel or 0 )

    options[#options + 1] = {
      title = string.format('🚘 %s | %s', data.name, vehicle.plate),
      colorScheme = 'red',
      metadata = {
        {label = 'Fuel', value = fuel .. '%', progress = fuel},
        {label = 'Engine', value = engine .. '%', progress = engine},
        {label = 'Body', value = body .. '%', progress = body}
        },
      onSelect = function()
        utils.SpawnVehicle(vehicle.id, config.parking)
      end
    }

    ::skip::
  end

  local id = ('%s_%s'):format(Garage, pool)

  lib.registerContext({
    id = id,
    title = config.name,
    options = options,
    menu = 'garage_menu',
  })

  lib.showContext(id)
end

---Add open menu on radial
local function OpenGarage()
  local config = Config.Jobs[category][Garage]

  lib.registerContext({
    id = 'garage_menu',
    title = config.name,
    options = {
      {
        title = locale('shared_pool'),
        onSelect = function()
          OpenPool('shared')
        end
      },
      {
        title = locale('personal_pool'),
        onSelect = function()
          OpenPool('public')
        end
      },
      {
        title = locale('vehicle_shop'),
        onSelect = function()
          ViewBuyableVehicles(job.type, config.type)
        end
      }
    }
  })

  lib.hideRadial()
  lib.showContext('garage_menu')
end

local function onEnter()
  lib.showTextUI('Parking', { position = 'left-center' })

  lib.addRadialItem({
    id = 'garage_access',
    icon = 'warehouse',
    label = locale('garage'),
    onSelect = function()
      OpenGarage()
    end
  })
end

function SetupJobZones()
  if job == nil then return end

  for i = 1, #zones, 1 do
    local zone = zones[i]
    zone:remove()
  end

  for key, _ in pairs(Config.Jobs) do
    if key ~= job.type and key ~= job.name then goto skip end
    local conf = Config.Jobs[key]

    for k, v in pairs(conf) do
      if #v.zone.points == 0 then goto skip_zone end
      zones[#zones + 1] = lib.zones.poly({
        points = v.zone.points,
        thickness = v.zone.thickness,
        debug = false,
        onEnter = function()
          Inside = 'shared'
          Garage = k
          category = key
          GarageTypes = v.type
          onEnter()

          if cache.vehicle then
            lib.addRadialItem({
              id = 'park_vehicle',
              icon = 'square-parking',
              label = 'Park Vehicle',
              onSelect = function()
                utils.ParkVehicle(Inside, Garage)
              end
            })
          end
        end,
        onExit = function()
          Inside = nil
          Garage = nil
          category = nil
          GarageTypes = nil
          lib.removeRadialItem('garage_access')
          lib.removeRadialItem('park_vehicle')
          lib.hideTextUI()
        end,
      })
      ::skip_zone::
    end
    ::skip::
  end
end

AddStateBagChangeHandler('job', ('player:%s'):format(cache.serverId), function(_, _, value)
  if job == value then return end
  job = value

  SetupJobZones()
end)
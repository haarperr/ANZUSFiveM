local currentDealership = {}
local currentDealershipIndex = nil
local currentTestVehicle = nil
local testDriveTime = 0
local playerState = LocalPlayer.state
local currentCategoryId = nil
local originalCoords = nil
local currentDealershipVehicles = {}

local timeout = 0

local function checkJob(curJobs, requireOnDuty)
  local jobName = playerState.job.name
  local isOnDuty = playerState.job.onduty

  for _, v in ipairs(curJobs) do
    if jobName == v then
      if requireOnDuty and isOnDuty then
        return true
      elseif not requireOnDuty then
        return true
      end
    end
  end

  return false
end

local function checkJobGrade(curGrade)
  if playerState.job.grade.level >= curGrade then return true end
  return false
end

local function parseCommas(number)
  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  int = int:reverse():gsub("(%d%d%d)", "%1,")
  return minus .. int:reverse():gsub("^,", "") .. fraction
end

local function createBlip(label, coords, sprite, colour)
  local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
  SetBlipSprite(blip, sprite)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.60)
  SetBlipAsShortRange(blip, true)
  SetBlipColour(blip, colour)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(label)
  EndTextCommandSetBlipName(blip)
end

local function sellVehicleToNearestPlayer(res)
  local nearbyPlayers, n = lib.getNearbyPlayers(cache.coords, 2.0, true), 0

  if #nearbyPlayers == 0 then return lib.notify({type = 'error', title = 'Dealership', description = 'No one nearby'}) end

  for i = 1, #nearbyPlayers do
    local option = nearbyPlayers[i]
    local ped = GetPlayerPed(option.id)

    if ped > 0 and IsEntityVisible(ped) then
      local playerName = GetPlayerName(option.id)
      option.id = GetPlayerServerId(option.id)
      option.label = ('[%s] %s'):format(option.id, playerName)
      n += 1
      nearbyPlayers[n] = option
    end
  end

  local p = promise.new()

  lib.registerMenu({
    id = 'ag_dealership:givePlayerList',
    title = 'Choose Player',
    options = nearbyPlayers,
    onClose = function() p:resolve() end,
  }, function(selected) p:resolve(selected and nearbyPlayers[selected].id) end)

  lib.showMenu('ag_dealership:givePlayerList')

  local target = Citizen.Await(p)

  if not target then return lib.notify({type = 'error', title = 'Dealership', description = 'You did not select anyone'}) end

  TriggerServerEvent('ag_dealership:server:purchaseVehicle', res.model, currentDealershipIndex, {buyer = target})
end

---@param data {price: number, tax: number}
local function confirmPayment(data)
  local input = lib.inputDialog('Confirm Vehicle Purchase', {
    {type = 'input', default = '$'..parseCommas(data.price), disabled = true, description = 'Vehicle Price'},
    {type = 'input', default = '$'..parseCommas(data.price * (data.tax/100)), disabled = true, description = 'Vehicle Tax'},
    {type = 'input', default = '$'..parseCommas(math.floor(data.price * (1+(data.tax/100)))), disabled = true, description = 'Total Cost'},
    {type = 'select', label = 'Payment Option', options = {{value = 'bank', label = 'Bank'}, {value = 'cash', label = 'Cash'}}, required = true, default = 'cash'},
    {type = 'input', placeholder = 'confirm/cancel', description = 'Please type confim or cancel'}
  })

  if not input then return {confirm = false} end

  local payment = input[4]
  local confirm = input[5]

  return {payment = payment, confirm = confirm}
end

lib.callback.register('ag_dealership:confirmPayment', function(data)
  local res = confirmPayment(data)
  if res.confirm == 'confirm' then
    return {success = true, payment = res.payment}
  end

  return {success = false}
end)

---@param showroom string
---@param id string
local function dealerOption(showroom, id)
  local options = {}
  local vehTax = GlobalState.tax
  local dealersPart = vehTax * (1+(currentDealership.salesCommission/100))

  lib.callback('ag_dealership:getVehicleData', false, function(res)
    if not res then return lib.notify({type = 'error', description = 'This vehicle is not sold here'}) end

    local fullPrice = math.floor(res.price * (1+(vehTax/100)))
    options[#options + 1] = {
      title = 'Salesman Commission: ' .. currentDealership.salesCommission .. '% ($' .. dealersPart .. ')'
    }
    options[#options + 1] = {
      title = 'Current Vehicle Price: ' .. '$' .. fullPrice .. '',
    }

    options[#options + 1] = {
      title = 'Vehicle Tax: ' .. vehTax .. '',
    }

    if res.stock >= 1 then
      options[#options + 1] = {
        title = 'Sell Vehicle',
        description = 'Sell vehicle to nearest player',
        onSelect = function()
          sellVehicleToNearestPlayer(res)
        end,
      }

      -- options[#options + 1] = {
      --   title = 'Purchase Vehicle',
      --   description = 'Purchase the vehicle for yourself at cost',
      --   onSelect = function()
      --     purchaseVehicleDealer(entity, res, vehTax)
      --   end,
      -- }
    end

    lib.registerContext({
      id = 'ag_dealership_opendealer',
      title = 'Dealer Options',
      options = options
    })

    lib.showContext('ag_dealership_opendealer')
  end, showroom, id)
end

local function selectVehicleOptions(id, class, category)
  if GlobalState[('ag_dealership_%s_%s_busy'):format(currentDealershipIndex, class)] then return lib.notify({type = 'error', description = 'This catalog is already being viewed'}) end
  currentCategoryId = id

  local config = Config.dealerships[currentDealershipIndex]
  if #config.requiredJobs > 0 then
    if not checkJob(config.requiredJobs, true) then return end
    if not checkJobGrade(config.requiredJobGrade) then return end
  end

  lib.callback('ag_dealership:getOnlineDealerCount', false, function(count)
    -- if count < config.onlineRequirement then return lib.notify({type = 'error', description = 'Not enough dealers online'}) end
    SetNuiFocus(true, true)
    lib.callback('ag_dealership:getCategoryVehicles', false, function(res)
      SendNUIMessage({
        type = 'LoadVehicles',
        cars = res,
        currentTax = GlobalState.tax or 0,
        category = category,
        class = class,
        dealerState = count
      })
    end, currentDealershipIndex, class)
  end, currentDealershipIndex)
end

local function createDealerShips()
  for k, v in pairs(Config.dealerships) do
    if v.blipOptions then
      createBlip(v.label, v.dealerShipLocation, v.blipOptions.sprite, v.blipOptions.color)
    end

    lib.zones.sphere({
      coords = v.dealerShipLocation,
      radius = v.range,
      debug = false,
      onEnter = function()
        currentDealership = v
        currentDealershipIndex = k
      end,
      onExit = function()
        currentDealership = nil
        currentDealershipIndex = nil
      end
    })

    for _, v2 in pairs(v.showRoomCars) do
      if v2.zone then
      exports.ox_target:addBoxZone({
        coords = v2.zone.coords,
        size = v2.zone.size,
        rotation = v2.zone.rotation,
        debug = false,
        options = {
        {
          name = 'ag_dealership:vehicleOptions',
          label = '🚗 Vehicle Options ( ' .. v2.label .. ' )',
          icon = '',
          onSelect = function()
            selectVehicleOptions(v2.id, v2.class, v2.label)
          end
        },
        {
          name = 'ag_dealership:dealerOptions',
          label = '💲 Dealer Options',
          icon = '',
          groups = v.job,
          onSelect = function(data)
            dealerOption(k, v2.id)
          end
        }
      }
      })
    end
    end
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  Wait(1000)
  createDealerShips()
end)

createDealerShips()
RegisterNUICallback('exit', function(data, cb)
  cb(1)
  TriggerServerEvent('ag_dealership:server:resetCategoryState', currentDealershipIndex, currentCategoryId)
  currentCategoryId = nil
  SetNuiFocus(false, false)
end)

RegisterNUICallback('changeDisplayVehicle', function(data, cb)
  cb(1)

  if timeout > 0 then return lib.notify({type = 'error', description = 'You are unable to do that so quickly', }) end
  timeout = 5

  CreateThread(function()
    repeat
      timeout -= 1
      Wait(1000)
    until timeout == 0
  end)

  TriggerServerEvent('ag_dealership:server:changeDisplayVehicle', data.model, currentDealershipIndex, currentCategoryId)
end)

RegisterNUICallback('startTestDrive', function (data, cb)
  cb(1)
  if testDriveTime > 0 then return end
  local vehicleModel = data.model
  originalCoords = cache.coords

  lib.callback('ag_dealership:spawnTestVehicle', false, function(veh)
    testDriveTime = currentDealership.testDriveTime

    local timeouta = 0
    repeat
      Wait(10)
      timeouta +=1
    until NetworkDoesNetworkIdExist(veh) or timeouta == 50

    SetPedIntoVehicle(cache.ped, NetworkGetEntityFromNetworkId(veh), -1)

    CreateThread(function()
      while testDriveTime ~= 0 do
        Wait(1000)
        if testDriveTime > 10 then
          testDriveTime = testDriveTime - 1
        elseif testDriveTime > 1 then
          lib.notify({type = 'warning', description = ('Test drive ends in %d seconds'):format(testDriveTime)})
          testDriveTime = testDriveTime - 1
        elseif testDriveTime > 0 then
          lib.notify({type = 'warning', description = 'Test drive has ended'})
          TriggerServerEvent('ag_dealership:server:endTestDrive', originalCoords)
          originalCoords = nil
          testDriveTime = 0
        end
      end
    end)

  end, currentDealershipIndex, vehicleModel)
end)

RegisterNUICallback('purchaseVehicle', function (data, cb)
  cb(1)
  TriggerServerEvent('ag_dealership:server:purchaseVehicle', data.model, currentDealershipIndex)
end)
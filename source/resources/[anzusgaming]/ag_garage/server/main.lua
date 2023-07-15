lib.locale()

local db = require 'server.db'

lib.callback.register('ag_garage:GetVehicles', function(source)
  local player = Player(source).state
  local result = db.getVehiclesInGarage(player.citizenid, { pool = 'all' })

  if result == nil then return false end
  if result.data then result = { result } end

  return result
end)

---@param source any
---@param data {garage: string, pool: 'shared' | 'public', type: string[]} Garage info
lib.callback.register('ag_garage:GetVehiclesAtGarage', function(source, data)
  local player = Player(source).state
  local result = db.getVehiclesInGarage(player.citizenid, data)

  if result == nil then return false end

  -- Format into a table if singular result
  if result.data then result = { result } end

  for i = 1, #result, 1 do
    result[i].data = json.decode(result[i].data)
    local vData = result[i].data
    local impoundDate = vData.impound
    result[i].data.impound = {}
    result[i].data.impound.time = os.difftime(os.time(), impoundDate or os.time())
  end

  return result
end)

---@param source any
---@param id number
---@param coords vector4
lib.callback.register('ag_garage:SpawnVehicle', function(source, id, coords)
  local vehicle = AG.CreateVehicle(id, vec3(coords.x, coords.y, coords.z), coords.w)
  if vehicle == nil then return false end
  exports['qb-vehiclekeys']:GiveKeys(source, vehicle.plate)
  return vehicle.entity
end)


---@param source any
---@param data {garage: string, properties: any, pool: 'public' | 'shared'}
---@return boolean
lib.callback.register('ag_garage:ParkVehicle', function(source, data)
  local ped = GetPlayerPed(source)
  local veh = GetVehiclePedIsIn(ped, false)
  local player = Player(source).state

  local vehicle = AG.GetVehicle(veh)

  if not vehicle then return false end
  if data.pool == 'public' and vehicle.owner ~= player.citizenid then return false end

  vehicle.set('properties', data.properties)
  vehicle.setGarage(data.garage, true)
  vehicle.setOut(0, true)

  return true
end)

lib.callback.register('ag_garage:ViewBuyableVehicles', function(source, data)
  local res = AG.GetVehicleData({ class = 18, type = data.type })
  return res
end)


---@param data {model: string, garage: string, shared: boolean}
RegisterNetEvent('ag_garage:PurchaseVehicle', function(data)
  local src = source
  local player = Player(src).state
  if not Config.Jobs[player.job.type][data.garage] then return false end

  local res = AG.GetVehicleData(data.model)
  if not res then return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = locale('no_vehicle_data') }) end

  -- local _ <close> = defer(function()
  exports.pefcl:removeBankBalance(src, { amount = res.price, message = string.format('Purchased %s', res.name) })
  -- end)

  lib.logger(src, 'purchaseVehicle',
    {
      message = ('Purchased %s x%d for %d'):format(data.model, 1, res.price),
      vehicle = nil,
      model = data.model,
      amount = res.price,
      currency = 'bank',
      type = 'removed'
    }, 'economy:buy')


  AG.CreateVehicle({ model = data.model, owner = player.citizenid, garage = data.garage, shared = data.shared, properties = res.defaultProperties })
  TriggerClientEvent('ox_lib:notify', src, { type = 'success', title = 'Vehicle Purchase', description = locale('successful_purchase') })
end)

---@param source any
---@param data {cost: number, id: number, lot: string}
lib.callback.register('ag_garage:RetrieveFromImpound', function(source, data)
  local balance = exports.pefcl:getDefaultAccountBalance(source)

  if balance.data - data.cost < 0 then
    TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Impound', description = locale('not_enough_funds') })
    return false
  end

  local player = Player(source).state

  local res = exports.pefcl:forcePayInvoice(source, {
    to = 'Impound Lot',
    toIdentifier = player.citizenid,
    from = 'San Andreas Government',
    fromIdentifier = player.citizenid,
    amount = data.cost,
    message = 'Retrieved vehicle from impound',
    receiverAccountIdentifier = 'gov'
  })

  if res.status ~= "ok" then
    TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Impound', description = locale('oops') })
    return false
  end

  local coords = Config.Impound[data.lot].pullout or nil
  if not coords then
    TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Impound', description = locale('oops') })
    return false
  end

  local vehicle = AG.CreateVehicle(data.id, vec3(coords.x, coords.y, coords.z), coords.w)
  if not vehicle then
    TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Impound', description = locale('oops') })
    return false
  end

  lib.logger(source, 'RetrieveFromImpound', ('Retrieved %d from %s lot'):format(data.id, data.lot))

  vehicle.setGarage('legionsquare')
  vehicle.set('impound', nil)

  return true
end)

---@param source any
---@param data {netId: number}
lib.callback.register('ag_vehicle:takePlate', function(source, data)
  local entity = NetworkGetEntityFromNetworkId(data.netId)
  if not entity then return end

  local plate = GetVehicleNumberPlateText(entity)

  local success = exports.ox_inventory:AddItem(source, 'numberplate', 1, { description = ('Plate: %s'):format(plate), plate = plate })
  if not success then return false end

  local screwdriver = exports.ox_inventory:GetSlotWithItem(source, 'screwdriver')
  if not screwdriver then return false end

  local newDurability = (screwdriver.durability or 100) - 30

  if newDurability <= 0 then
    success = exports.ox_inventory:RemoveItem(source, 'screwdriver', 1, screwdriver.metadata, screwdriver.slot)
  else
    exports.ox_inventory:SetDurability(source, screwdriver.slot, newDurability)
  end

  SetVehicleNumberPlateText(entity, '')

  return true
end)

---@param source any
---@param data {netId: number, plate: string}
lib.callback.register('ag_vehicle:applyPlate', function(source, data)
  local numberplate = exports.ox_inventory:GetSlotWithItem(source, 'numberplate', { plate = data.plate })
  if not numberplate then return false end

  local success = exports.ox_inventory:RemoveItem(source, 'numberplate', 1, numberplate.metadata)
  if not success then return false end

  SetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(data.netId), data.plate)

  return true
end)

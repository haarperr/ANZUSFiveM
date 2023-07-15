---@type table<number, AGVehicle>
local VehicleRegistry = {}

---Returns an instance of Vehicle for the given entityId
---@param entityId number
---@return AGVehicle
function AG.GetVehicle(entityId)
    return VehicleRegistry[entityId]
end

---Return vehicle data for the given network id
---@param netId number
---@return AGVehicle
function AG.GetVehicleFromNetId(netId)
    return AG.GetVehicle(NetworkGetEntityFromNetworkId(netId))
end

---Return all vehicle data.
---@return AGVehicle[]
function AG.GetVehicles()
    local size = 0
    local vehicles = {}

    for _, v in pairs(VehicleRegistry) do
        size += 1
        vehicles[size] = v
    end

    return vehicles
end

return VehicleRegistry
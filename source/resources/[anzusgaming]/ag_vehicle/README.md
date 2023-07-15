---
title: Functions
---

## AG.GetVehicle

Return an instance of AGVehicle for the given entity.

```lua
local vehicle = AG.GetVehicle(entity)
print(json.encode(vehicle, { indent = true }))
```

## AG.GetVehicles

Returns an array containing all vehicles. Methods will not be applied if the first argument is false.

```lua
local vehicles = AG.GetVehicles(usemetatable)

for i = 1, #vehicles do
    local vehicle = vehicles[i]
    print(json.encode(vehicle, { indent = true }))
end
```

## AG.CreateVehicle

Spawns a vehicle and returns the instance of AGVehicle.
If the first argument is a number, it will attempt to spawn a vehicle from the database with a matching id.

```lua
local vehicleId = MySQL.scalar.await('SELECT id FROM character_vehicles WHERE owner = ? LIMIT 1', { player.citizenid })

if vehicleId then
    local coords = GetEntityCoords(cache.ped)
    local vehicle = AG.CreateVehicle(vehicleId, vector3(coords.x, coords.y + 1.0, coords.z) , GetEntityHeading(cache.ped))

    if vehicle then
        print(json.encode(vehicle, { indent = true }))
    end
end
```

If the first argument is a table and the owner property is a number, or nil, the vehicle will be added to the database.
Setting the owner as false creates a non-persistent vehicle.

```lua
local vehicle = AG.CreateVehicle({
    model = 'sultanrs',
    owner = player.citizenid,
}, GetEntityCoords(cache.ped), GetEntityHeading(player.ped))
```

---
title: Methods
---

These functions are inherited from the Vehicle class.

## vehicle.set

Sets the vehicle's metadata for key to the given value.

```lua
vehicle.set(key, value)
```

- key: `string`
- value: `any`

## vehicle.get

Get a value from the vehicles's metadata, or omit the argument to get all metadata.

```lua
vehicle.get(key)
```

- key: `string`

## vehicle.getState

Return the vehicle's statebag.

```lua
vehicle.getState()
```

## vehicle.despawn

Despawns the vehicle but doesn't save it or update the stored value.

## vehicle.delete

Remove the vehicle from the database and despawns the entity.

```lua
vehicle.delete()
```

## vehicle.setGarage

Updates the vehicle's garage value and optionally despawns it.

```lua
vehicle.setGarage(value, despawn)
```

- value: `string`
- despawn?: `boolean`

## vehicle.setOwner

Sets the vehicle's owner, matching a charid or nil to set it as unowned.

```lua
vehicle.setOwner(owner)
```

- owner?: `number`

## vehicle.setShared

Sets the vehicle's shared state

```lua
vehicle.setShared(bool)
```

- bool: `boolean`

## vehicle.setLock

Sets the vehicle's numeric lock

```lua
vehicle.setLock(lock)
```

- lock: `string`

## vehicle.setPlate

Sets the vehicle's plate, used in the database to ensure uniqueness. Does not necessarily match the plate property (i.e. fake plates).
Plate is always formatted to 8 characters.

```lua
vehicle.setPlate(plate)
```

- plate: `string`
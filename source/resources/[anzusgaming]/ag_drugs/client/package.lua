lib.locale()
local currentInterior = nil

local function TeleportToInterior(x, y, z, h)
  CreateThread(function()
    SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
    SetEntityHeading(PlayerPedId(), h)

    Wait(100)
  end)
end

local zones = {
  door = {},
  objects = {}
}

local function exitShell(objects)
  for _, v in pairs(objects) do
    DeleteEntity(v)
  end

  if #zones.objects == 0 then return end
  for _, v in pairs(zones.objects) do
    exports.ox_target:removeZone(v)
  end

  zones.objects = {}
end

local function packageWeed()
  local count = exports.ox_inventory:Search('count', 'weed')

  if count < 10 then
    return lib.notify({ type = 'error', description = 'I don\'t have enough weed..' })
  end

  local success = lib.progressCircle({
    duration = math.random(5000, 15000),
    label = 'Packaging Weed..',
    canCancel = true,
    disable = {
      move = true,
      car = true,
      combat = true
    },
    anim = {
      dict = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',
      clip = 'weed_crouch_checkingleaves_idle_01_inspector'
    }
  })

  if not success then return end

  TriggerServerEvent('ag_drugs:server:package', 'weed')
end

local function createWeedInterior(spawn)
  local objects = {}
  local POIOffsets = {}
  POIOffsets.exit = json.decode('{"x": -11.05, "y": -2.50, "z": 20.96, "h": 283.97}')
  RequestModel(`k4weed_shell`)
  while not HasModelLoaded(`k4weed_shell`) do
    Wait(20)
  end
  local house = CreateObject(`k4weed_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
  FreezeEntityPosition(house, true)
  objects[#objects + 1] = house
  TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)

  return { objects, POIOffsets }
end

local function enterShell(type)
  local coords = GetEntityCoords(cache.ped)

  if type == 'weed' then
    local res = createWeedInterior(coords)
    local POIOffsets = res[2]

    for _, v in pairs(currentInterior.tables) do
      local tableCoords = GetOffsetFromEntityInWorldCoords(res[1][1], v.x, v.y, v.z)
      zones.objects[#zones.objects + 1] = exports.ox_target:addSphereZone({
        coords = tableCoords,
        radius = 1.2,
        options = {
          {
            label = 'Package Weed',
            icon = 'fa-solid fa-cannabis',
            onSelect = packageWeed,
          }
        }
      })
    end

    zones.objects[#zones.objects + 1] = exports.ox_target:addSphereZone({
      coords = vec3(coords.x + POIOffsets.exit.x, coords.y + POIOffsets.exit.y, coords.z + POIOffsets.exit.z),
      radius = 1,
      options = {
        {
          label = 'Exit',
          icon = 'fa-solid fa-door-open',
          onSelect = function()
            exitShell(res[1])
            TeleportToInterior(currentInterior.exit.x, currentInterior.exit.y, currentInterior.exit.z, currentInterior.exit.w)
            currentInterior = nil
          end
        }
      }
    })
  end
end

local function createEnterZones()
  for _, v in pairs(Config.weed.packing) do
    zones.door[#zones.door + 1] = exports.ox_target:addSphereZone({
      coords = v.enter,
      radius = 1,
      options = {
        {
          label = 'Enter',
          icon = 'fa-solid fa-door-closed',
          onSelect = function()
            currentInterior = v
            enterShell('weed')
          end,
        }
      }
    })
  end
end

CreateThread(function()
  createEnterZones()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  createEnterZones()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  TeleportToInterior()
end)

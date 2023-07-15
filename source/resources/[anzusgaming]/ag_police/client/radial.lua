Radial = {}
local zones = {}

local function searchPlayer()
  local _, ped = lib.getClosestPlayer(GetEntityCoords(cache.ped))
  if not ped then return lib.notify({ type = 'error', description = 'No one is close enough to do this' }) end

  local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))

  local player = Player(playerId).state

  if not player.isCuffed then
    return lib.notify({
      type = 'error',
      title = 'Law Enforcement',
      description = 'You cannot search someone who is not cuffed'
    })
  end

  exports.ox_inventory:openNearbyInventory()
end

local function friskPlayer()
  ---@diagnostic disable-next-line: missing-parameter
  local _, ped = lib.getClosestPlayer(GetEntityCoords(cache.ped))

  if not ped then return lib.notify({ type = 'error', description = 'No one is close enough to do this' }) end

  local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
  local result = lib.callback.await('ag_police:FriskPlayer', 200, playerId)

  if not result then return lib.notify({ type = 'success', description = 'You didn\'t feel anything during the frisk' }) end

  lib.notify({ type = 'error', description = 'Something is sticking out' })
end

local function removeFaceCoverings()
  ---@diagnostic disable-next-line: missing-parameter
  local _, ped = lib.getClosestPlayer(GetEntityCoords(cache.ped))

  if not ped then return lib.notify({ type = 'error', description = 'No one is close enough to do this' }) end

  local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
  TriggerServerEvent("ag_police:server:RemoveMask", playerId)
end

local function openLocker()
  local res = lib.callback.await('ag_police:OpenLocker', 200)
  if not res then
    return lib.notify({
      type = 'error',
      title = 'Law Enforcement',
      description = 'Unable to open your locker at this time'
    })
  end

  exports.ox_inventory:openInventory('stash', string.format('policelocker_%s', LocalPlayer.state.citizenid))
end

local function OpenEvidenceDraw()
  local input = lib.inputDialog('Evidence Drawer', {
    { type = 'number', label = 'Drawer', description = 'Incident number', icon = 'hashtag' }
  })

  if not input then return end

  local res = lib.callback.await('ag_police:OpenEvidenceDraw', 200, input[1])

  if res then
    exports.ox_inventory:openInventory('stash', string.format('policeevidence_%s', input[1]))
  end
end

local function GetFingerprint()
  local success = lib.progressCircle({
    duration = 20000,
    position = 'bottom',
    useWhileDead = false,
    canCancel = true,
    disable = {
      car = true,
      move = true,
      combat = true
    },
    anim = {
      scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
  })

  if not success then return end

  ---@diagnostic disable-next-line: missing-parameter
  local _, ped = lib.getClosestPlayer(GetEntityCoords(cache.ped))

  if not ped then return lib.notify({ type = 'error', description = 'No one is close enough to do this' }) end

  local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
  local result = lib.callback.await('ag_police:FingerprintPlayer', 200, playerId)

  if result == nil then return lib.notify({ type = 'error', description = 'No results returned' }) end

  lib.notify({ type = 'info', description = string.format('%s (%s)', result.name, result.citizenid) })
end

function RemoveRadialMenu()
  lib.removeRadialItem('police')
  lib.removeRadialItem('police_radio')
end

function CreateRadialMenu()
  lib.addRadialItem({
    {
      id = 'police',
      label = 'Police',
      icon = 'shield-halved',
      menu = 'police_menu'
    }
  })

  lib.addRadialItem({
    {
      id = 'police_radio',
      label = 'Radio',
      icon = 'tower-cell',
      menu = 'police_radio_menu'
    }
  })

  lib.registerRadial({
    id = 'police_menu',
    items = {
      {
        label = 'Frisk',
        icon = 'mask',
        onSelect = function()
          friskPlayer()
        end
      },
      {
        label = 'Escort',
        icon = 'truck-pickup',
        onSelect = function()
          EscortPlayer()
        end
      },
      {
        label = 'UnCuff',
        icon = 'handcuffs',
        onSelect = function()
          unCuffPlayer()
        end
      },
      {
        label = 'Remove Mask',
        icon = 'mask',
        onSelect = function()
          removeFaceCoverings()
        end
      },
      {
        label = 'Search',
        icon = 'magnifying-glass',
        onSelect = function()
          searchPlayer()
        end
      },
      {
        label = 'MDT',
        icon = 'tablet-screen-button',
        onSelect = function()
          TriggerServerEvent('mdt:server:openMDT')
        end
      },
    }
  })

  lib.registerRadial({
    id = 'police_radio_menu',
    items = {
      {
        label = 'Channel 1',
        icon = 'wifi',
        onSelect = function()
          TriggerEvent('qb-radio:client:JoinRadioChannel', 1)
        end
      },
      {
        label = 'Channel 2',
        icon = 'wifi',
        onSelect = function()
          TriggerEvent('qb-radio:client:JoinRadioChannel', 2)
        end
      },
      {
        label = 'Channel 3',
        icon = 'wifi',
        onSelect = function()
          TriggerEvent('qb-radio:client:JoinRadioChannel', 3)
        end
      },
      {
        label = 'Channel 4',
        icon = 'wifi',
        onSelect = function()
          TriggerEvent('qb-radio:client:JoinRadioChannel', 4)
        end
      },
      {
        label = 'Channel 5',
        icon = 'wifi',
        onSelect = function()
          TriggerEvent('qb-radio:client:JoinRadioChannel', 5)
        end
      },
      {
        label = 'Channel 6',
        icon = 'wifi',
        onSelect = function()
          TriggerEvent('qb-radio:client:JoinRadioChannel', 6)
        end
      },
    }
  })
end

function CreateRadialOptions()
  CreateRadialMenu()
  for i = 1, #PD_Zones, 1 do
    local zone = PD_Zones[i]
    if not zone.building then
      -- print(string.format('Missing building configuration for %s', zone.name))
      goto skipBuilding
    end
    zones[#zones + 1] = lib.zones.poly({
      name = zone.name,
      points = zone.building.points,
      thickness = zone.building.thickness,
      onEnter = function()
        lib.addRadialItem({
          id = 'police_fingerprint',
          label = 'Fingerprint',
          icon = 'fingerprint',
          onSelect = function()
            GetFingerprint()
          end
        })
      end,
      onExit = function()
        lib.removeRadialItem('police_fingerprint')
      end,
    })

    ::skipBuilding::
    if not zone.lockers then
      -- print(string.format('Missing locker configuration for %s', zone.name))
      goto skipLockers
    end
    zones[#zones + 1] = lib.zones.poly({
      name = zone.name,
      points = zone.lockers.points,
      thickness = zone.lockers.thickness,
      onEnter = function()
        lib.addRadialItem({
          id = 'police_locker',
          label = 'Locker',
          icon = 'box-open',
          onSelect = function()
            openLocker()
          end
        })
      end,
      onExit = function()
        lib.removeRadialItem('police_locker')
      end,
    })
    ::skipLockers::

    if not zone.evidence then
      -- print(string.format('Missing evidence configuration for %s', zone.name))
      goto skipEvidence
    end

    zones[#zones + 1] = lib.zones.poly({
      name = string.format('%s_%s', zone.name, 'evidence'),
      points = zone.evidence.points,
      thickness = zone.evidence.thickness,
      onEnter = function()
        lib.addRadialItem({
          id = 'police_evidence',
          label = 'Evidence',
          icon = 'fingerprint',
          onSelect = function()
            OpenEvidenceDraw()
          end
        })
      end,
      onExit = function()
        lib.removeRadialItem('police_evidence')
      end,
    })
    ::skipEvidence::

    if not zone.repair_station then
      -- print(string.format('Missing repair station configuration for %s', zone.name))
      goto skipRepairStation
    end
    zones[#zones + 1] = lib.zones.box({
      name = zone.name,
      coords = zone.repair_station.coords,
      size = zone.repair_station.size,
      rotation = zone.repair_station.rotation,
      onEnter = function()
        lib.addRadialItem({
          id = 'repair_station_pd',
          label = 'Repair',
          icon = 'box-open',
          onSelect = function()
            TriggerEvent('jim-mechanic:client:Police:Menu')
          end
        })
      end,
      onExit = function()
        lib.removeRadialItem('repair_station_pd')
      end,
    })
    ::skipRepairStation::
  end
end

function RemoveRadialOptions()
  RemoveRadialMenu()

  if #zones == 0 then return end
  for i = 1, #zones, 1 do
    zones[i]:remove()
  end
end

RegisterNetEvent('ag_police:client:RemoveMask', function()
  local ad = "missheist_agency2ahelmet"
  while (not HasAnimDictLoaded(ad)) do
    RequestAnimDict(ad)
    Wait(5)
  end
  TaskPlayAnim(cache.ped, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, false, false, false)
  Wait(600)
  ClearPedSecondaryTask(cache.ped)
  SetPedComponentVariation(cache.ped, 1, 0, 0, 2)
  lib.notify({ type = 'info', description = 'Your mask was forcefull removed' })
end)

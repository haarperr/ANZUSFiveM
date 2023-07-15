---@param entity number
local function takePlate(entity)
  local success = lib.progressCircle({
    duration = 45000,
    label = 'Removing plate',
    canCancel = true,
    disable = {
      car = true,
      move = true,
      combat = true
    },
    anim = {
      dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
      clip = "machinic_loop_mechandplayer",
      flag = 1
    }
  })

  local state = Entity(entity).state

  if not success then return state:set('plateTaking', false, true) end

  lib.callback('ag_vehicle:takePlate', false, function(res)
    if not res then return lib.notify({ type = 'error', description = 'Unable to take plate' }) end

    lib.notify({ type = 'success', description = 'Successfully taken number plate' })
    state:set('plateTaking', false, true)
  end, { netId = NetworkGetNetworkIdFromEntity(entity) })
end

local function attachPlate(entity, plate)
  local success = lib.progressCircle({
    duration = 45000,
    label = 'Applying plate',
    canCancel = true,
    disable = {
      car = true,
      move = true,
      combat = true
    },
    anim = {
      dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
      clip = "machinic_loop_mechandplayer",
      flag = 1
    }
  })

  if not success then return end

  lib.callback('ag_vehicle:applyPlate', false, function(res)
    if not res then return lib.notify({ type = 'error', description = 'Unable to apply this plate' }) end

    lib.notify({ type = 'success', description = 'Successfully applied plate' })
  end, { netId = NetworkGetNetworkIdFromEntity(entity), plate = plate })
end

local function applyPlate(entity)
  local anim = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
  lib.requestAnimDict(anim)

  TaskPlayAnim(cache.ped, anim, "machinic_loop_mechandplayer", 1.0, 1.0, 80000, 1, 0, false, false, false)

  local items = exports.ox_inventory:GetSlotsWithItem('numberplate')

  local options = {}

  for i = 1, #items, 1 do
    local item = items[i]
    options[#options + 1] = {
      title = ('Plate: %s'):format(item.metadata.plate),
      onSelect = function()
        attachPlate(entity, item.metadata.plate)
      end
    }
  end

  lib.registerContext({
    id = 'apply_plate',
    title = 'Plate Modification',
    options = options,
    onExit = function()
      ClearPedTasksImmediately(cache.ped)
    end
  })

  lib.showContext('apply_plate')
end


exports.ox_target:addGlobalVehicle({
  {
    label = 'Remove Plate',
    name = 'ag_vehicle:grabplate',
    distance = 1,
    bones = { "numberplate", "platelight" },
    canInteract = function(entity)
      local state = Entity(entity).state
      if not state.owner then return false end
      if state.plateTaking then return false end

      local plate = GetVehicleNumberPlateText(entity)
      if plate == '        ' then return false end

      return true
    end,
    onSelect = function(data)
      local state = Entity(data.entity).state
      if not state.owner then return end
      ---@diagnostic disable-next-line: param-type-mismatch
      state:set('plateTaking', true, true)
      takePlate(data.entity)
    end
  },
  {
    label = 'Apply Plate',
    name = 'ag_vehicle:putplate',
    distance = 1,
    bones = { "numberplate", "platelight" },
    canInteract = function(entity)
      local state = Entity(entity).state
      if not state.owner then return false end

      local count = exports.ox_inventory:Search('count', 'numberplate')
      if count == 0 then return false end

      return true
    end,
    onSelect = function(data)
      local state = Entity(data.entity).state
      if not state.owner then return end
      applyPlate(data.entity)
    end
  }
})

-- CreateThread(function ()

-- end)

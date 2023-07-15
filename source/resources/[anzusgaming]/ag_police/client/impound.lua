---@param entity number
---@return boolean
local function canInteract(entity)
  local class = GetVehicleClass(entity)

  if class == 18 then return false end

  return true
end

---@param duration number
---@param label? string
---@return boolean?
local function progressCircle(duration, label)
  local res = lib.progressCircle({
    duration = duration,
    position = 'bottom',
    label = label,
    useWhileDead = false,
    canCancel = true,
    disable = {
      car = true,
      move = true,
      combat = true,
    },
  })

  return res
end

---@param netId number
---@return boolean
local function IsCivVehicle(netId)
  local res = lib.callback.await('ag_police:IsCivVehicle', 200, { netId = netId })
  if not res then
    lib.notify({ type = 'error', description = 'This is not a player owned vehicle' })
    return false
  end
  return true
end

local function getInputOptions(reasonsTable)
  ---@type table<number, {value: string, label: string}>
  local options = {}

  for key, value in pairs(reasonsTable) do
    options[#options + 1] = { value = key, label = value }
  end

  return options
end

---@param actionName string
---@param netId number
---@param actionTitle string
---@param actionDescription string
---@param successMessage string
local function performAction(actionName, netId, reasonsTable, actionTitle, actionDescription, successMessage)
  if actionName == 'ImpoundVehicle' and not IsCivVehicle(netId) then return end

  ---@type table<number, {value: string, label: string}>
  local reasons = getInputOptions(reasonsTable)

  ---@type table<number, string>
  local input = lib.inputDialog(actionTitle, {
    {
      type = 'select',
      label = 'Reason',
      description = actionDescription,
      options = reasons
    },
  })

  if not input then return end

  if progressCircle(4500) then
    local res = lib.callback.await('ag_police:' .. actionName, 200, { netId = netId })
    if not res then return lib.notify({ type = 'error', description = 'Unable to find the vehicle..' }) end

    lib.notify({ type = 'success', description = successMessage })
  else
    lib.notify({ type = 'error', description = 'Cancelled' })
  end
end

---@param netId number
local function Scuff(netId)
  local reasons = Config.Impound.reasons.scuff

  performAction('ImpoundScuff', netId, reasons, 'Tow Vehicle', 'Why are you towing this vehicle', 'Sent vehicle back to garage')
end

---@param netId number
local function ImpoundVehicle(netId)
  local reasons = Config.Impound.reasons.normal

  performAction('ImpoundVehicle', netId, reasons, 'Impound Vehicle', 'Why are you impounding this vehicle', 'Impounded vehicle')
end

function CreateImpoundOptions()
  exports.ox_target:removeGlobalVehicle({ 'agpolice:impoundScuff', 'agpolice:impound' })
  exports.ox_target:addGlobalVehicle({
    {
      name = 'agpolice:impound',
      label = 'Impound',
      icon = 'fa-solid fa-car-rear',
      canInteract = canInteract,
      onSelect = function(data)
        local netId = NetworkGetNetworkIdFromEntity(data.entity)
        ImpoundVehicle(netId)
      end,
    },
    {
      name = 'agpolice:impoundScuff',
      label = 'Tow Vehicle',
      icon = 'fa-solid fa-car-rear',
      canInteract = canInteract,
      onSelect = function(data)
        local netId = NetworkGetNetworkIdFromEntity(data.entity)
        Scuff(netId)
      end,
    }
  })
end

function RemoveImpoundOptions()
  exports.ox_target:removeGlobalVehicle({ 'agpolice:impoundScuff', 'agpolice:impound' })
end

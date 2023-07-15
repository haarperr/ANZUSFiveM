---@alias NotificationPosition 'top' | 'top-right' | 'top-left' | 'bottom' | 'bottom-right' | 'bottom-left' | 'center-right' | 'center-left'
---@alias NotificationType 'info' | 'warning' | 'success' | 'error'

---@class NotifyProps
---@field id? string
---@field title? string
---@field description? string
---@field duration? number
---@field position? NotificationPosition
---@field type? NotificationType
---@field style? { [string]: any }
---@field icon? string | {[1]: IconProp, [2]: string};
---@field iconColor? string;

---@param data NotifyProps
function lib.notify(data)
  local _type = data.type
  local icon = ''
  local iconColor = ''
  if _type == 'error' then
    icon = 'ban'
    iconColor = '#D30000'
  elseif _type == 'info' or _type == 'inform' then
    data.type = 'info'
    icon = 'circle-exclamation'
    iconColor = '#2ea4f7'
  elseif _type == 'success' then
    icon = 'check-circle'
    iconColor = '#33CC33'
  elseif _type == 'warning' then
    icon = 'exclamation-triangle'
    iconColor = '#FFCC00'
  end

  data.icon = icon
  data.iconColor = iconColor

  data.style = {
    backgroundColor = '#141517',
    color = '#d6d6d6'
  }

  if not data.duration then
    data.duration = 2500
  end

  SendNUIMessage({
    action = 'notify',
    data = data
  })
end

---@class DefaultNotifyProps
---@field title? string
---@field description? string
---@field duration? number
---@field position? NotificationPosition
---@field status? 'info' | 'warning' | 'success' | 'error'
---@field id? number

---@param data DefaultNotifyProps
function lib.defaultNotify(data)
  -- Backwards compat for v3
  data.type = data.status
  if data.type == 'inform' then data.type = 'info' end
  return lib.notify(data)
end

RegisterNetEvent('ox_lib:notify', lib.notify)
RegisterNetEvent('ox_lib:defaultNotify', lib.defaultNotify)

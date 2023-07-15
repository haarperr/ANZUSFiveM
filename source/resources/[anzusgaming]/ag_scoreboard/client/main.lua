local online = {}
local recentDisconnects = {}
local openedMenu = false

local function registerMenu()
  local disconnects = {}
  local disconnectToCID = {}

  for k, v in pairs(recentDisconnects) do
    disconnects[#disconnects + 1] = ('[%s] %s'):format(v.source, v.steam)
    disconnectToCID[#disconnectToCID + 1] = {
      steam = v.steam,
      citizenid = k
    }
  end

  local options = {
    {
      label = 'Recent Disconnects', values = disconnects
    }
  }

  for k, v in pairs(online) do
    options[#options + 1] = {
      label = ('[%s] %s'):format(v.source, v.steam), args = { citizenid = k, steam = v.steam }
    }
  end

  lib.registerMenu({
    id = 'ag_scoreboard:players',
    title = 'Players',
    position = 'top-right',
    options = options,
    onClose = function()
      openedMenu = false
    end
  }, function(selected, scrollIndex, args)
    if args and args.citizenid then
      lib.notify({ type = 'success', description = 'Copied Citizen ID and Steam to clipboard' })
      return lib.setClipboard(json.encode({ citizenid = args.citizenid, steam = args.steam }))
    end

    if scrollIndex and disconnectToCID[scrollIndex] then
      lib.notify({ type = 'success', description = 'Copied Citizen ID and Steam to clipboard' })
      return lib.setClipboard(json.encode({ citizenid = disconnectToCID[scrollIndex].citizenid, steam = disconnectToCID[scrollIndex].steam }))
    end
  end)

  lib.showMenu('ag_scoreboard:players')
end

local function getPlayers()
  lib.callback('ag_scoreboard:getPlayers', false, function(data)
    online = data.online
    recentDisconnects = data.recentDisconnects
    registerMenu()
  end)
end

local function DrawText3D(position, text, r, g, b)
  local onScreen, _x, _y = World3dToScreen2d(position.x, position.y, position.z + 1)
  local dist = #(GetGameplayCamCoords() - position)

  local scale = (1 / dist) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    if not useCustomScale then
      SetTextScale(0.0 * scale, 0.55 * scale)
    else
      SetTextScale(0.0 * scale, customScale)
    end
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(r, g, b, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end

local function openMenu()
  while openedMenu do
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _, id in ipairs(GetActivePlayers()) do
      local targetPed = GetPlayerPed(id)
      local targetPedCords = GetEntityCoords(targetPed)
      local distance = #(playerCoords - targetPedCords)
      if distance < 7 then
        if NetworkIsPlayerTalking(id) then
          DrawText3D(targetPedCords, GetPlayerServerId(id), 247, 124, 24)
        else
          DrawText3D(targetPedCords, GetPlayerServerId(id), 255, 255, 255)
        end
      end
    end
    Wait(0)
  end
end

local keybind = lib.addKeybind({
  name = 'open_players',
  description = 'View Scoreboard',
  defaultKey = 'DELETE',
  onPressed = function(self)
    if openedMenu then
      lib.hideMenu()
      openedMenu = false
      return
    end
    openedMenu = true
    getPlayers()
    openMenu()
  end,
})

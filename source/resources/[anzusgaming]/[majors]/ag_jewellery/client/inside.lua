local inside = false

local function onEnter()
  CreateThread(function()
    while inside do
      local sleep = 250
      if GasEnabled then
        if GetPedDrawableVariation(cache.ped, 1) ~= 46 then
          local health = GetEntityHealth(cache.ped)
          SetEntityHealth(cache.ped, health * 0.9)

          -- if GetSelectedPedWeapon(cache.ped) ~= -1569615261 then
          --   if not PoliceAlerted then

          --     TriggerServerEvent('ag_major:jewellery:alarm')
          --   end
          -- end
          sleep = 3000
        end
      end
      Wait(sleep)
    end
  end)
end

function SetupInsideZone()
  local config = Config.Jewellery.inside
  lib.zones.poly({
    points = config.points,
    thickness = config.thickness,
    onEnter = function()
      inside = true
      onEnter()
    end,
    onExit = function()
      inside = false
    end
  })
end

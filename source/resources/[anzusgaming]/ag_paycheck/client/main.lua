lib.locale()

local function setup()
  for i = 1, #Config.Locations, 1 do
    local loc = Config.Locations[i]

    local point = lib.points.new({
      coords = vec3(loc.x, loc.y, loc.z),
      distance = 50,
      ped = nil
    })

    function point:onEnter()
      local model = lib.requestModel(Config.Ped)

      local ret, z = GetGroundZAndNormalFor_3dCoord(loc.x, loc.y, loc.z)

      self.ped = CreatePed(0, model, loc.x, loc.y, ret and z or loc.z, loc.w, false, true)

      FreezeEntityPosition(self.ped, true)
      SetEntityInvincible(self.ped, true)
      SetBlockingOfNonTemporaryEvents(self.ped, true)

      exports.ox_target:addLocalEntity({ self.ped }, {
        {
          icon = 'fa-solid fa-money-check',
          label = locale('get_paycheck'),
          onSelect = function()
            TriggerServerEvent('ag_paycheck:server:claimPaycheck')
          end,
          distance = 2
        }
      })
    end

    function point:onExit()
      if DoesEntityExist(self.ped) then
        SetEntityAsMissionEntity(self.ped, false, true)
        DeleteEntity(self.ped)
      end
    end
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  setup()
end)

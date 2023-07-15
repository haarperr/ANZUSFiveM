local entity = nil
local point = nil

local function setup()
  local location = vec4(989.086, 31.365, 71.466, 62.956)

  point = lib.points.new({
    coords = vec3(location.x, location.y, location.z),
    distance = 60,
    type = 'Casino',
    id = 1
  })

  function point:onExit()
    exports.qtarget:RemoveTargetEntity(entity, 'Open Casino')

    if DoesEntityExist(entity) then
      SetEntityAsMissionEntity(entity, false, true)
      DeleteEntity(entity)
    end
  end

  function point:onEnter()
    local model = lib.requestModel('IG_TomCasino')

    local ret, z = GetGroundZAndNormalFor_3dCoord(location.x, location.y, location.z)

    entity = CreatePed(0, model, location.x, location.y, ret and z or location.z, location.w, false, true)

    SetModelAsNoLongerNeeded(model)
    FreezeEntityPosition(entity, true)
    SetEntityInvincible(entity, true)
    SetBlockingOfNonTemporaryEvents(entity, true)

    exports.qtarget:AddTargetEntity(entity, {
      options = {
        {
          icon = 'fas fa-shopping-basket',
          label = 'Open Casino',
          action = function()
            exports.ox_inventory:openInventory('shop', { id = self.id, type = self.type })
          end,
        },
        {
          icon = 'fa-solid fa-money-bill-trend-up',
          label = 'Hand In Chips',
          action = function()
            local count = exports.ox_inventory:Search('count', 'casinochips')
            if count == 0 then return lib.notify({ type = 'error', description = 'You do not have enough chips to trade in' }) end

            local input = lib.inputDialog('Cash In', {
              { type = 'number', max = count, required = true, icon = 'hashtag', description = 'Amount of Casino Chips', min = 1 }
            })

            if not input then return end
            local num = tonumber(input[1])
            TriggerServerEvent('ag_misc:server:cashIn', num)
          end,
        }
      },

      distance = 2.0
    })
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  setup()
end)

CreateThread(function()
  setup()
end)

local location = nil
local entity = nil
local point = nil

local function setup()
  location = lib.callback.await('ag_armsdealer:getLoc', false)

  point = lib.points.new({
    coords = vec3(location.x, location.y, location.z),
    distance = 60,
    type = 'BlackMarketArms',
    id = 1
  })

  function point:onExit()
    exports.qtarget:RemoveTargetEntity(entity, 'Open Black Market')

    if DoesEntityExist(entity) then
      SetEntityAsMissionEntity(entity, false, true)
      DeleteEntity(entity)
    end
  end

  function point:onEnter()
    local model = lib.requestModel('MP_M_ExArmy_01')

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
          label = 'Open Black Market',
          action = function()
            exports.ox_inventory:openInventory('shop', { id = self.id, type = self.type })
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

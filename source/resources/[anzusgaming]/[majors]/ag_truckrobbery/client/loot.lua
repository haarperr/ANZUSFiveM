local utils = require 'client.utils'

function GrabLoot(data)
  if utils.isBusy(data.entity) then return end
  utils.setBusy(data.entity, true)

  local coords = GetEntityCoords(cache.ped)
  local success = lib.progressCircle({
    duration = Config.LootDuration,
    label = locale('looting'),
    canCancel = true,
    disable = {
      move = true,
      combat = true,
      car = true
    },
    anim = {
      dict = "anim@heists@ornate_bank@grab_cash_heels",
      clip = "grab",
    },
    prop = {
      model = 'prop_cs_heist_bag_02',
      pos = coords,
      rot = vec3(250.0, -30.0, 0.0),
      bone = GetPedBoneIndex(cache.ped, 57005)
    }
  })

  if not success then return utils.setBusy(data.entity, false) end

  utils.setRobbed(data.entity, true)
  TriggerServerEvent('ag_truckrobbery:server:getReward', NetworkGetNetworkIdFromEntity(data.entity))
  utils.setBusy(data.entity, false)
end

lib.locale()

local PowerstationBlownUp = {
  paleto = false,
  city = false,
  east = false
}

local function thermiteCharge(key)
  local animDict = 'anim@heists@ornate_bank@thermal_charge'

  lib.requestAnimDict(animDict)
  lib.requestModel(`hei_p_m_bag_var22_arm_s`)
  local config = Config.PowerStations[key]
  local ped = cache.ped
  local pedCoords = GetEntityCoords(ped)
  local pos = vector3(config.animation.x, config.animation.y, config.animation.z)
  Wait(100)
  local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(ped)))
  local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
  local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z, true, true, false)
  SetEntityCollision(bag, false, true)
  local x, y, z = table.unpack(GetEntityCoords(ped))
  local charge = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2, true, true, true)
  SetEntityCollision(charge, false, true)
  AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
  NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
  SetPedComponentVariation(ped, 5, 0, 0, 0)
  NetworkStartSynchronisedScene(bagscene)
  Wait(5000)
  DetachEntity(charge, true, true)

  StartPlayerTeleport(cache.ped, pedCoords.x, pedCoords.y, pedCoords.z, 0.0, false, true, true)
  FreezeEntityPosition(charge, true)
  DeleteObject(bag)
  NetworkStopSynchronisedScene(bagscene)
  CreateThread(function()
    Wait(15000)
    DeleteEntity(charge)
  end)

  TriggerServerEvent('ag_major:sync', 'ptfx', { config.ptfx })
  TaskPlayAnim(ped, animDict, "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, false, false, false)
  TaskPlayAnim(ped, animDict, "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, false, false, false)
  Wait(2000)
  ClearPedTasks(ped)
  Wait(11000)
  TriggerServerEvent('ag_powerstation:server:StationStatus', { key = key, hit = true })
end

local function plantThermite(key)
  TriggerServerEvent('ag_powerstation:server:setState', { key = key, type = 'busy', bool = true })

  LocalPlayer.state:set("invBusy", true, true)
  exports['ps-ui']:Scrambler(function(success)
    if success then
      TriggerServerEvent('ag_powerstation:server:removeItem', 'thermite')
      thermiteCharge(key)
    else
      TriggerServerEvent('ag_powerstation:server:setState', { key = key, type = 'busy', bool = false })
    end
    LocalPlayer.state:set("invBusy", false, true)
  end, "greek", 15, 0)
end

local function ppExplosion(x, y, z)
  CreateThread(function()
    UseParticleFxAsset("core")
    local smoke = StartParticleFxLoopedAtCoord("exp_air_blimp", x, y, z, 0.0, 0.0, 0.0, 6.0, false, false, false, false)
    SetParticleFxLoopedAlpha(smoke, 0.8)
    SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, false)
    AddExplosion(x, y, z, 4, 0.0, true, false, 3.0)
  end)
end

RegisterNetEvent('ag_powerstation:client:cityBoom', function()
  ppExplosion(710.22, 125.44, 84.90)
  Wait(350)
  ppExplosion(707.13, 106.91, 84.479)
  Wait(350)
  ppExplosion(698.28, 101.89, 84.47)
  Wait(350)
  ppExplosion(664.408, 114.9, 84.47)
  Wait(350)
  ppExplosion(664.00, 133.15, 84.01)
  Wait(350)
  ppExplosion(673.67, 157.436, 85.47)
  Wait(350)
  ppExplosion(673.67, 157.436, 84.47)
end)

RegisterNetEvent('ag_powerstation:client:eastBoom', function()
  ppExplosion(2727.0825, 1477.4373, 35.695354)
  Wait(350)
  ppExplosion(2742.2595, 1507.0069, 35.695354)
  Wait(350)
  ppExplosion(2737.3876, 1536.5502, 35.6748)
  Wait(350)
  ppExplosion(2755.0556, 1571.2738, 39.294418)
  Wait(350)
  ppExplosion(2815.0053, 1512.393, 29.195352)
  Wait(350)
  ppExplosion(2830.6501, 1490.4455, 29.195352)
  Wait(350)
  ppExplosion(2839.4997, 1562.3775, 29.195352)
end)

RegisterNetEvent('ag_powerstation:client:paletoBoom', function()
  ppExplosion(229.831, 6401.052, 31.587)
  Wait(350)
  ppExplosion(239.335, 6400.109, 31.749)
  Wait(350)
  ppExplosion(234.157, 6398.93, 31.624)
end)

---@param data {index: string, bool: boolean}
RegisterNetEvent('ag_powerstation:client:syncBlown', function(data)
  if not data.index then return end

  PowerstationBlownUp[data.index] = data.bool
end)

---@param data {key: number, type: 'hit', bool: boolean}
RegisterNetEvent('ag_powerstation:client:setState', function(data)
  Config.PowerStations[data.key][data.type] = data.bool
end)

function SetupZones()
  for k, v in pairs(Config.PowerStations) do
    local label = locale('blow_fuse')

    if k == 3 or k == 4 then
      label = locale('destroy_generator')
    end

    exports.ox_target:addSphereZone({
      coords = v.coords,
      radius = 1,
      options = {
        {
          name = ('powerstation%s'):format(k),
          label = label,
          icon = 'fas fa-user-secret',
          items = 'thermite',
          canInteract = function()
            return not Config.PowerStations[k].busy
          end,
          onSelect = function()
            plantThermite(k)
          end,
          distance = 1
        }
      }
    })
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  Config.PowerStations = lib.callback.await('ag_powerstation:server:getConfig', false)

  SetupZones()
end)

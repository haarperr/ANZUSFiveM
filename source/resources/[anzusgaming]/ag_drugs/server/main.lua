RegisterNetEvent('ag_drugs:server:package', function(type)
  local src = source

  if type == 'weed' then
    local count = exports.ox_inventory:Search(src, 'count', 'weed')

    if count < 10 then return end

    exports.ox_inventory:RemoveItem(src, 'weed', 10)
    exports.ox_inventory:AddItem(src, 'weed_brick', 1)
  end
end)

function CreateObject(hash, coords, rotation)
  local obj = CreateObjectNoOffset(hash, coords.x, coords.y, coords.z, true, true, false)
  if coords.w then
    SetEntityHeading(obj, coords.w)
    Wait(10)
  end
  if rotation then
    if type(rotation) == 'number' then
      ---@diagnostic disable-next-line: missing-parameter
      SetEntityRotation(obj, rotation)
    else
      SetEntityRotation(obj, rotation.x, rotation.y, rotation.z, 2, true)
    end
  end

  FreezeEntityPosition(obj, true)
  return NetworkGetNetworkIdFromEntity(obj)
end

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then return end

  StopMeth()
end)

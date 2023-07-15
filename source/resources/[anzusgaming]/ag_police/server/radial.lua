lib.callback.register('ag_police:FingerprintPlayer', function(source, target)
  local playerState = Player(source).state
  if playerState.job.type ~= 'leo' then return false end

  local Target = QBCore.Functions.GetPlayer(target).PlayerData
  TriggerClientEvent('ox_lib:notify', target, { type = 'info', description = 'Your fingerprints have been taken' })

  return { citizenid = Target.citizenid, name = Target.fullname }
end)

lib.callback.register('ag_police:FriskPlayer', function(source, target)
  local playerState = Player(source).state
  if playerState.job.type ~= 'leo' then return end

  local items = exports.ox_inventory:GetInventoryItems(target)
  local hasWeapon = false
  for i = 1, #items, 1 do
      local item = items[i] or {}
      if not item.name then goto skip end
      if string.match(item.name:lower(), 'weapon') then
          hasWeapon = true
          break
      end

      ::skip::
  end

  return hasWeapon
end)

RegisterNetEvent('ag_police:server:RemoveMask', function(targetId)
  local playerState = Player(source).state
  if playerState.job.type ~= 'leo' then return false end

  local target = Player(targetId)?.state
  if not target then return end

  local isCuffed = target.isCuffed
  if not isCuffed then return end

  TriggerClientEvent("ag_police:client:RemoveMask", targetId)
end)
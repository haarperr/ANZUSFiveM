RegisterNetEvent('ag_police:server:setPlayerEscort', function(target, state)
  target = Player(target)?.state
  if not target then return end

  local isCuffed = target.isCuffed
  local isZiptied = target.isZiptied
  if not isCuffed and not isZiptied then return end

  target:set('isEscorted', state and source, true)
end)
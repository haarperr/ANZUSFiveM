lib.callback.register('ag_police:setPlayerUnCuff', function(source, target)
    local playerState = Player(source).state
    if playerState.job.type ~= 'leo' then return false end

    target = Player(target)?.state
    if not target then return end

    if target.cuffType == 'HARD' then
        target:set('cuffType', 'SOFT', true)
    elseif target.cuffType == 'SOFT' then
        target:set('cuffType', 'NONE', true)
        target:set('isCuffed', false, true)
    end

    return {isCuffed = target.isCuffed, cuffType = target.cuffType}
end)

lib.callback.register('ag_police:setPlayerRemoveZiptie', function(source, target)
    target = Player(target)?.state
    if not target then return end
    if target.isCuffed then return end

    if target.cuffType == 'HARD' then
        target:set('cuffType', 'SOFT', true)
    elseif target.cuffType == 'SOFT' then
        target:set('cuffType', 'NONE', true)
        target:set('isZiptied', false, true)
    end

    return {isZiptied = target.isZiptied, cuffType = target.cuffType}
end)

lib.callback.register('ag_police:setPlayerZiptie', function(source, target)
    target = Player(target)?.state
    if not target then return end

    local isZiptied = not target.isZiptied
    local cuffType = target.cuffType

    if cuffType == 'NONE' then
        target:set('cuffType', 'SOFT', true)
        target:set('isZiptied', isZiptied, true)
    elseif cuffType == 'SOFT' then
        target:set('cuffType', 'HARD', true)
    end

    return {isZiptied = isZiptied, cuffType = cuffType}
end)

lib.callback.register('ag_police:setPlayerCuffs', function(source, target)
    local playerState = Player(source).state
    if playerState.job.type ~= 'leo' then return false end

    target = Player(target)?.state
    if not target then return {isCuffed = nil, cuffType = nil } end

    local isCuffed = not target.isCuffed
    local cuffType = target.cuffType

    if cuffType == 'NONE' then
        target:set('cuffType', 'SOFT', true)
        target:set('isCuffed', isCuffed, true)
    elseif cuffType == 'SOFT' then
        target:set('cuffType', 'HARD', true)
    end

    return {isCuffed = isCuffed, cuffType = cuffType}
end)
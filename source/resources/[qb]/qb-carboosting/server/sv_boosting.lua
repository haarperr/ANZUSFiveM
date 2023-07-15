local peds = { -- You can add extra ped models in here
    `csb_g`,
    `csb_grove_str_dlr`,
    `csb_ortega`,
    `csb_ramp_mex`,
    `cs_stretch`,
    `g_m_y_ballaeast_01`,
    `g_m_y_famdnf_01`,
    `a_m_m_eastsa_01`,
    `a_m_m_eastsa_02`,
    `a_m_m_salton_03`,
    `a_m_m_soucent_03`,
    `a_m_y_clubcust_03`,
    `a_m_y_soucent_02`
}

--- Method to grab amount of cops on duty
--- @return number - Amount of cops on duty
function GetCopCount()
    return GlobalState?.duty?.leo or 0
    -- local amount = 0
    -- local players = Framework.Functions.GetQBPlayers()
    -- for _, Player in pairs(players) do
    --     if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then -- Player.PlayerData.job.type == "leo"
    --         amount += 1
    --     end
    -- end
    -- return amount
end

--- Generates a random vehicle license plate
--- @return string - String in uppercase chars
function GeneratePlate()
    return AG.GeneratePlate()
    -- local plate = Framework.Shared.RandomInt(1) .. Framework.Shared.RandomStr(2) .. Framework.Shared.RandomInt(3) .. Framework.Shared.RandomStr(2)
    -- -- local result = exports.oxmysql:scalarSync('SELECT plate FROM character_vehicles WHERE plate = ?', {plate})
    -- local result = MySQL.scalar.await('SELECT plate FROM character_vehicles WHERE plate = ?', { plate })
    -- if result then
    --     return GeneratePlate()
    -- else
    --     return plate:upper()
    -- end
end

--- Returns a random value of the peds table
--- @return string - Random model hash from peds table
local getRandomNPC = function()
    return peds[math.random(#peds)]
end

--- Generates a random contract tier based on the players current boosting class and probabilities
--- @param boostingClass string - Current class of the player
--- @return string - Tier for contract
GenerateTier = function(boostingClass)
    local random = math.random(100)
    if boostingClass == 'D' then     -- D
        return 'D'
    elseif boostingClass == 'C' then -- D or C
        if random <= 50 then
            return 'D'
        else
            return 'C'
        end
    elseif boostingClass == 'B' then -- D, C or B
        if random <= 33 then
            return 'D'
        elseif random > 33 and random <= 67 then
            return 'C'
        else
            return 'B'
        end
    elseif boostingClass == 'A' then -- D, C, B or A
        if random <= 25 then
            return 'D'
        elseif random > 25 and random <= 50 then
            return 'C'
        elseif random > 50 and random <= 75 then
            return 'B'
        else
            return 'A'
        end
    elseif boostingClass == 'S' then -- D, C, B, A or S
        if random <= 20 then
            return 'D'
        elseif random > 20 and random <= 40 then
            return 'C'
        elseif random > 40 and random <= 60 then
            return 'B'
        elseif random > 60 and random <= 80 then
            return 'A'
        else
            return 'S'
        end
    elseif boostingClass == 'S+' then -- D, C, B, A, S or S+
        if random <= 18 then
            return 'D'
        elseif random > 18 and random <= 36 then
            return 'C'
        elseif random > 36 and random <= 54 then
            return 'B'
        elseif random > 54 and random <= 72 then
            return 'A'
        elseif random > 72 and random <= 90 then
            return 'S'
        elseif random > 90 then
            return 'S+'
        end
    end
end

RegisterNetEvent('qb-carboosting:server:ActivateVehicle', function(licenseplate, tier, target)
    if Shared.Debug then print("^3[qb-carboosting] ^5Added " .. licenseplate .. " to active vehicles^7") end
    if tier ~= 'player' then
        activeVehicles[licenseplate] = {
            curHack = 0,
            maxHack = Shared.Contracts[tier].hacks
        }
        TriggerClientEvent('qb-carboosting:client:ActivateVehicle', -1, licenseplate, Shared.Contracts[tier].hacks)
        return
    end

    activeVehicles[licenseplate] = {
        curHack = 0,
        maxHack = Shared.PlayerContractHacks,
        owner = target
    }
    TriggerClientEvent('qb-carboosting:client:ActivateVehicle', -1, licenseplate, Shared.PlayerContractHacks)
    if not target then return end

    local Player = Framework.Functions.GetPlayerByCitizenId(target)
    TriggerClientEvent(Shared.CoreObject .. ':Notify', Player.PlayerData.source, Translations.error['stealing_your_vehicle'], 'error', '6000')
end)

RegisterNetEvent('qb-carboosting:server:DeactivateVehicle', function(licenseplate)
    activeVehicles[licenseplate] = nil
    if Shared.Debug then print("^3[qb-carboosting] ^5Removed " .. licenseplate .. " from active vehicles^7") end
    TriggerClientEvent('qb-carboosting:client:DeactivateVehicle', -1, licenseplate)
end)

RegisterNetEvent('qb-carboosting:server:UpdateTracker', function(licenseplate, success)
    if not activeVehicles[licenseplate] then return end

    local curAmount = activeVehicles[licenseplate].curHack
    local newAmount = curAmount + 1
    if not success then
        newAmount = curAmount - math.random(3) -- Removes 1 to 3
        if newAmount < 0 then newAmount = 0 end
    end

    activeVehicles[licenseplate].curHack = newAmount
    TriggerClientEvent('qb-carboosting:client:UpdateTracker', -1, licenseplate, newAmount)
    if Shared.Debug then print("^3[qb-carboosting] ^5Updated (Fail) " .. licenseplate .. " Current Hacks: " .. newAmount .. "^7") end
end)

RegisterNetEvent('qb-carboosting:server:SendLocation', function(coords, model, plate)
    local players = Framework.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if (Player.PlayerData.citizenid == activeVehicles[plate].owner) or (Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty) then -- Player.PlayerData.job.type == 'leo'
            TriggerClientEvent('qb-carboosting:client:ReceiveLocation', Player.PlayerData.source, coords, model, plate)
        end
    end
end)

RegisterNetEvent('qb-carboosting:server:DropOff', function(tier)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    if not Player then return end

    -- Reward
    local payout = math.random(Shared.Contracts[tier].reward.min, Shared.Contracts[tier].reward.max)
    TriggerClientEvent(Shared.CoreObject .. ':Notify', src, 'You received ' .. payout .. ' ' .. Shared.MoneyType, 'success', 2000)
    Player.Functions.AddMoney(Shared.MoneyType, payout)

    -- Update Exp
    local newRep = (Player.PlayerData.metadata["boostingrep"] + Shared.Contracts[tier].exp.payout)
    if newRep < 0 then newRep = 0 end
    if newRep > Shared.Contracts['S+'].maxRep then newRep = Shared.Contracts['S+'].maxRep end
    Player.Functions.SetMetaData("boostingrep", newRep)
    Player.Functions.SetMetaData("boostingclass", GetClass(newRep))

    -- Log
    if Shared.Debug then print("^3[qb-carboosting] ^5" .. Player.PlayerData.name .. ' completed boost, ' .. 'Tier: ' .. tier .. ' NewRep: ' .. newRep .. "^7") end
    TriggerEvent("qb-log:server:CreateLog", "carboosting", "Successful Dropoff", "green",
        "**" ..
        Player.PlayerData.name ..
        "** (citizenid: *" ..
        Player.PlayerData.citizenid ..
        "* | id: *" .. src .. "*) Completed drop-off: \n**Tier:** " .. tier .. " \n**Reward:** " .. payout .. " " ..
        Shared.MoneyType .. " \n**Rep:**" .. Shared.Contracts[tier].exp.payout)
end)

RegisterNetEvent('qb-carboosting:server:VinScratch', function(tier)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    -- Reward
    local payout = math.random(Shared.Contracts[tier].reward.min, Shared.Contracts[tier].reward.max)
    TriggerClientEvent(Shared.CoreObject .. ':Notify', src, 'You received ' .. payout .. ' ' .. Shared.MoneyType, 'success', 2000)
    Player.Functions.AddMoney(Shared.MoneyType, payout)
    -- Update Exp
    local newRep = (Player.PlayerData.metadata["boostingrep"] + Shared.Contracts[tier].exp.payout)
    if newRep < 0 then newRep = 0 end
    if newRep > Shared.Contracts['S+'].maxRep then newRep = Shared.Contracts['S+'].maxRep end
    Player.Functions.SetMetaData("boostingrep", newRep)
    Player.Functions.SetMetaData("boostingclass", GetClass(newRep))
    -- Log
    if Shared.Debug then print("^3[qb-carboosting] ^5" .. Player.PlayerData.name .. ' completed VIN, ' .. 'Tier: ' .. tier .. ' NewRep: ' .. newRep .. "^7") end
    TriggerEvent("qb-log:server:CreateLog", "carboosting", "Successful VIN", "black",
        "**" ..
        Player.PlayerData.name ..
        "** (citizenid: *" ..
        Player.PlayerData.citizenid ..
        "* | id: *" .. src .. "*) Completed drop-off: \n**Tier:** " .. tier .. " \n**Reward:** " .. payout ..
        " " .. Shared.MoneyType .. " \n**Rep:** " .. Shared.Contracts[tier].exp.payout)
end)

RegisterNetEvent('qb-carboosting:server:AddToGarage', function(model, plate, props, coords, heading)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    if not Player then return end
    AG.CreateVehicle({
        model = model,
        owner = Player.PlayerData.citizenid,
        plate = plate,
        properties = props,
    }, coords, heading)

    -- Log
    TriggerEvent("qb-log:server:CreateLog", "carboosting", "Added VIN Vehicle", "black",
        "**" ..
        Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" ..
        src .. "*) Added vehicle to garage: \n**Model:** " .. model .. " \n**Plate:** " .. plate)
    if Shared.Debug then print("^3[qb-carboosting] ^5" .. Player.PlayerData.name .. ' added VIN vehicle: ' .. model .. ' plate: ' .. plate .. "^7") end
end)

lib.callback.register('qb-carboosting:CheckVin', function(source, netid)
  local src = source
  local Player = Framework.Functions.GetPlayer(src)
  if not Player then return end

  if Player.PlayerData.job.type ~= 'leo' then return TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = Translations.error['for_police']}) end
  local vehicle = AG.GetVehicleFromNetId(netid)
  local isVinScratched = vehicle:get('vin_scratched')

  if type(isVinScratched) == 'table' then
    isVinScratched = false
    vehicle:set('vin_scratched', false)
  end

  local message = ('VIN: %s'):format(vehicle.vin)
  local vin = vehicle.vin
  local type = 'success'
  if isVinScratched then
    message = Translations.info['vin_scratched']
    vin = "Scratched"
    type = 'error'
  end

  return {message = message, type = type, vin = vin}
end)

Framework.Functions.CreateCallback('qb-carboosting:server:CanDropOff', function(source, cb, price, tier)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)

    if GetCopCount() < Shared.Contracts[tier].dropCops then
        TriggerClientEvent(Shared.CoreObject .. ':Notify', src, Translations.error['not_enough_cops'], 'error', '2500')
        cb(false)
    elseif Player then
        if Player.Functions.RemoveMoney(Shared.MoneyType, price) then
            local newRep = (Player.PlayerData.metadata["boostingrep"] - Shared.Contracts[tier].exp.buyin)
            if newRep < 0 then newRep = 0 end
            Player.Functions.SetMetaData("boostingrep", newRep)
            Player.Functions.SetMetaData("boostingclass", GetClass(newRep))
            cb(true)
        else
            TriggerClientEvent(Shared.CoreObject .. ':Notify', src, Translations.error['not_enough_crypto'], 'error', '2500')
            cb(false)
        end
    else
        cb(false)
    end
end)

Framework.Functions.CreateCallback('qb-carboosting:server:CanVinScratch', function(source, cb, price, tier)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)

    if GetCopCount() < Shared.Contracts[tier].vinCops then
        TriggerClientEvent(Shared.CoreObject .. ':Notify', src, Translations.error['not_enough_cops'], 'error', '2500')
        cb(false)
    elseif Player then
        if Player.Functions.RemoveMoney(Shared.MoneyType, price + Shared.Contracts[tier].vinPrice) then
            local newRep = (Player.PlayerData.metadata["boostingrep"] - Shared.Contracts[tier].exp.buyin)
            if newRep < 0 then newRep = 0 end
            Player.Functions.SetMetaData("boostingrep", newRep)
            Player.Functions.SetMetaData("boostingclass", GetClass(newRep))
            cb(true)
        else
            TriggerClientEvent(Shared.CoreObject .. ':Notify', src, Translations.error['not_enough_crypto'], 'error', '2500')
            cb(false)
        end
    else
        cb(false)
    end
end)

lib.callback.register('qb-carboosting:server:SpawnCar', function (source, model ,loc, plate)
  local veh = AG.CreateVehicle({model = model, plate = plate}, vec3(loc.x, loc.y, loc.z), loc.w)
  SetVehicleDoorsLocked(NetworkGetEntityFromNetworkId(veh.netid), 2)
  return veh.netid
end)

Framework.Functions.CreateCallback('qb-carboosting:server:SpawnNPC', function(source, cb, tier, loc)
    local netIds = {}
    local netId
    local npc
    local playerPed = GetPlayerPed(source)
    for i = 1, #Shared.Contracts[tier].locations[loc].peds, 1 do
        npc = CreatePed(30, getRandomNPC(), Shared.Contracts[tier].locations[loc].peds[i], true, false)
        while not DoesEntityExist(npc) do Wait(10) end
        GiveWeaponToPed(npc, `WEAPON_PISTOL`, 250, false, true)
        TaskCombatPed(npc, playerPed, 0, 16)
        netId = NetworkGetNetworkIdFromEntity(npc)
        netIds[#netIds + 1] = netId
    end
    cb(netIds)
end)

Framework.Functions.CreateCallback('qb-carboosting:server:GetPlayerVehicleLoc', function(source, cb, plate, target)
    local result = MySQL.scalar.await('SELECT garage FROM character_vehicles WHERE owner = ? AND plate = ?', { target, plate })
    cb(result)
end)

Framework.Functions.CreateUseableItem(Shared.LaptopItem, function(source, item)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    if not Player then return end

    if Shared.DisablePolice then
        if Player.PlayerData.job.type == 'leo' then -- Player.PlayerData.job.type == 'leo'
            TriggerClientEvent(Shared.CoreObject .. ':Notify', src, Translations.error['not_as_cop'], 'error', '2500')
        else
            TriggerClientEvent('qb-carboosting:client:UseLaptop', src)
        end
    else
        TriggerClientEvent('qb-carboosting:client:UseLaptop', src)
    end
end)

Framework.Functions.CreateUseableItem("boostingdisabler", function(source, item)
    local src = source
    TriggerClientEvent('qb-carboosting:client:UseDisabler', src)
end)

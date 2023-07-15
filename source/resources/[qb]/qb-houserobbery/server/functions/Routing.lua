Instances = {}

function GenerateBucket() end

function GetPlayersInHouse(houseid)
	if not houseid or not Instances[houseid] then
		return {}
	end
	return Instances[houseid].players
end


function SetRouting(src, houseid)
    local instance = Instances[houseid]
    if not instance then
        return
    end
    instance.players[src] = src
	SetPlayerRoutingBucket(src, tonumber(instance.bucket))
    Wait(100)
    DebugConsole(string.format("Set playersrc: %s routing to %s", src, instance.bucket))
end

function SetEntityRouting(networkid, houseid)
	if not Instances[houseid] then
		return print(("We don't find house id routing for %s"):format(houseid))
	end
	local entity = NetworkGetEntityFromNetworkId(networkid)
	local check = 0
	while not DoesEntityExist(entity) do
		Wait(500)
		check += 1
		if check > 10 then
			return print(("Can't find this entity, entity with NetID %s, Does this exist?"):format(networkid))
		end
	end
	Instances[houseid].entity[networkid] = networkid
	SetEntityRoutingBucket(entity, tonumber(Instances[houseid].bucket))
	DebugConsole(string.format("Set entity: %s routing to %s", networkid, Instances[houseid].bucket))
end

function ResetRouting(src, houseid)
	local instancesTable = Instances[houseid]
	if not instancesTable or not instancesTable.players[src] then
		return
	end
	instancesTable.players[src] = nil
	if next(instancesTable.players) == nil then
		local GState = HouseTable
		local HouseData = GState[houseid]
		if next(HouseData) ~= nil then
			for _, v in ipairs(HouseData.guards) do
				local entity = NetworkGetEntityFromNetworkId(v.netid)
				if entity and DoesEntityExist(entity) then
					FreezeEntityPosition(entity, true)
				end
			end
			if HouseData.dogs and HouseData.dogs.netid then
				local entity = NetworkGetEntityFromNetworkId(HouseData.dogs.netid)
				if entity and DoesEntityExist(entity) then
					FreezeEntityPosition(entity, true)
				end
			end
			HouseData.freeze = true
			HouseTable = GState
			Wait(100)
			TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
		end
	end
	SetPlayerRoutingBucket(src, 0)
	DebugConsole(string.format("Reset player routing: %s", src))
end

-- it triggered when start
function InitRouting(houseid, bucket)
		Instances[houseid] = {
			bucket = bucket,
			players = {},
			entity = {},
		}
end

local GetCurrentTarget = require 'server.functions.EntityHandler'.GetCurrentTarget

lib.callback.register("qb-houserobbery:server:getTarget", function (source, houseid)
	local target = GetCurrentTarget(houseid, source)
	if not target then
		return
	end
	return target
end)
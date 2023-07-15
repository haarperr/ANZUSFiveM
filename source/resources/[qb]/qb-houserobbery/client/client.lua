local Notify = require "client.functions.Utils".Notify

RegisterNetEvent("qb-houserobbery:client:refreshInside", function(house, objectid)
	RefreshInside()
end)

AddEventHandler("onResourceStop", function(resource)
	if resource ~= GetCurrentResourceName() then
		return
	end
end)

RegisterNetEvent("qb-houserobbery:client:setconfig", function()
	UpdateConfig()
end)

RegisterNetEvent("lockpicks:UseLockpick", function()
	if not TempHouseID then
		return
	end
	TriggerEvent("qb-houserobbery:client:useHackItem", "lockpick")
end)

RegisterNetEvent("qb-houserobbery:client:useHackItem", function(item)
	if not TempHouseID then return end
	if not item then return end
	local house = HouseData[TempHouseID]
	if not house then return end
	if not house?.locked then return end
	if house.cooldown then
		Notify(nil, "You can't use this item right now...", "error")
		return
	end
	local coords = GetEntityCoords(cache.ped)
	local dist = #(coords - house?.coords.xyz)
	if dist >= 2.5 then return end
	local houseid = TempHouseID
	local checkpolice = not Config.Debug and CurrentCops < Config.MinimumHouseRobberyPolice
	if checkpolice then
		Notify(nil, "There are not enough police in the city", "error")
		return
	end
	local success, reason = StartMinigame(item)
	if success and not reason then
		if lib.callback.await("qb-houserobbery:server:setHouseState", false, houseid) then
			Notify("Unlocked", "You just unlocked the door", "success")
		end
	elseif reason then
		Notify(nil, reason, "error")
	elseif not success and not reason then
		Notify(nil, "You failed", "error")
	end
end)


local UseTreat = require 'client.functions.LootHandle'.UseTreat
RegisterNetEvent("qb-houserobbery:client:useTreat", function()
	if not IsInside then
		return
	end
	UseTreat(CurrentHouseID)
end)

RegisterNetEvent("qb-houserobbery:client:endNoises", function()
	if not IsInside then return end
	SendNUIMessage({
		action = "open-progress",
		data = {
			value = false
		}
	})
end)

local Notify = require 'client.functions.Utils'.Notify

return {
	LootObject = function(_, houseid, ConfigNumber)
		QBCore.Functions.Progressbar("looting", "Taking item...", 3000, false, true, {
			-- Name | Label | Time | useWhileDead | canCancel
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
			anim = "machinic_loop_mechandplayer",
			flags = 16,
		}, {}, {}, function()
			local success = lib.callback.await("qb-houserobbery:server:setLootState", false, houseid, ConfigNumber, true)
			if success then
				Notify("Looted", "Succesfully loot", "success")
			end
			ClearPedTasks(PlayerPedId())
		end, function()
			ClearPedTasks(PlayerPedId())
		end)
	end,
	UseTreat = function(houseid)
		local hasitem = exports.ox_inventory:Search("count", "treat")
		if not hasitem or hasitem == 0 then
			return
				Notify(nil, "You don't have any treat", "error")
		end
		local GetConfigNumber = require 'client.functions.Utils'.GetConfigNumber
		local config = Config.HouseLocation[GetConfigNumber(houseid)]
		local dawgs = HouseData[houseid]
		local netid = dawgs.dogs.netid
		if not dawgs or not config or not netid then
			return DebugConsole("No ")
		end
		local entity = NetworkGetEntityFromNetworkId(netid)
		if not entity or entity == 0 then
			return
		end
		local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(entity))
		local state = Entity(entity).state
		if dist <= 1.5 and not state.istreated then
			QBCore.Functions.Progressbar("qb-treat-dog", "Giving the dog treat...", 2000, false, true, {
				-- Name | Label | Time | useWhileDead | canCancel
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "amb@medic@standing@tendtodead@base",
				anim = "base",
				flags = 1,
			}, {}, {}, function() -- Play When Done
				local chance = not Config.Debug and math.random(1, 100) or 100
				if chance >= 70 then
					local treatedanim = config.config.guards?.dog?.treatedanim
					if treatedanim and next(treatedanim) ~= nil then
						local animdict = treatedanim.animdict
						local animation = treatedanim.animation
						lib.requestAnimDict(animdict)
						TaskPlayAnim(
							entity,
							animdict,
							animation,
							8.0,
							8.0,
							-1,
							1,
							1.0,
							true,
							true,
							true
						)
					end
					TriggerServerEvent("qb-houserobbery:server:treatDog", houseid)
					state.istreated = true
					SendNUIMessage({
						action = "timer",
						data = {
							timer = 0,
						},
					})
					SetBlockingOfNonTemporaryEvents(entity, true)
					exports.ox_target:removeEntity(netid, ("qb-houserobbery:givetreat-%s"):format(houseid))
				else
					Notify(nil, "The dog don't want your treat", "error")
				end
				ClearPedTasks(cache.ped)
			end, function() -- Play When Cancel
				ClearPedTasks(cache.ped)
			end)
		else
			Notify("Too far", "You are too far away from the dog", "error")
		end
	end
}

local itemNames = {}

for item, data in pairs(exports.ox_inventory:Items()) do
	itemNames[item] = data.label
end



local notify = require 'client.functions.Utils'.Notify
local Hack = require 'shared.hack'
local MiniGame = Hack.minigame
local SendAlert = Hack.alert
local Items = Hack.items

local function ThermiteFX()
	local res = promise.new()
	local playerPos = GetEntityCoords(cache.ped)
	lib.requestNamedPtfxAsset("core")
	local playerHeading = GetEntityHeading(cache.ped)
	local distance = 0.6

	local headingRadians = math.rad(playerHeading + 90)


	local forwardX = math.cos(headingRadians)
	local forwardY = math.sin(headingRadians)

	local offsetX = distance * forwardX
	local offsetY = distance * forwardY
	local offsetZ = 0.0 -- Adjust the Z offset as needed

	local usecoords = vector3(playerPos.x + offsetX, playerPos.y + offsetY, playerPos.z + offsetZ)
	UseParticleFxAssetNextCall("core")
	local particle = StartParticleFxLoopedAtCoord("ent_amb_torch_fire", usecoords.x, usecoords.y, usecoords.z, 0.0, 0.0,
		0.0, 1.0,
		true,
		true, true, false)
	QBCore.Functions.Progressbar("melting-door", "Melting the door lock...", 5000, false, false, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function ()
		StopParticleFxLooped(particle, true)
		RemoveParticleFx(particle, true)
		res:resolve(true)
	end)
	return Citizen.Await(res)
end



function StartMinigame(item)
	local success = false
	local hasitem = exports.ox_inventory:Search("count", item)
	if item == "safe" then
		hasitem = 1
	end
	local iteminfo = Items[item]
	if not hasitem or hasitem == 0 then
		return success,
			itemNames[item] and string.format("You need %s to do this", itemNames[item]) or
			"You require some item to do this"
	end
	if not iteminfo then
		if item == "safe" then
			iteminfo = {
				minigame = {
					type = "safe"
				},
				probability = 0.7,
				initialanim = {
					scully = "picklock"
				}
			}
		else
			iteminfo = {
				minigame = {
					type = "lockpick",
				param = { 15, 7 }
			},
			probability = 0.8,
			initialanim = {
				scully = "picklock"
			}
		}
	    end
	end
	local minigametype = iteminfo.minigame?.type
	if iteminfo.initialanim then
		if iteminfo.initialanim.scully then
			exports.scully_emotemenu:playEmoteByCommand(iteminfo.initialanim.scully)
		else
			local anim = lib.requestAnimDict(iteminfo.initialanim.animDict)
			if anim then
				TaskPlayAnim(PlayerPedId(), iteminfo.initialanim.animDict, iteminfo.initialanim.anim, 8.0, 8.0, -1, 0,
					0, false, false, false)
			end
		end
	end
	if minigametype == "circle" then
		success = MiniGame("circle", table.unpack(iteminfo.minigame.param))
	elseif minigametype == "drill" then
		success = MiniGame("drill")
	elseif minigametype == "thermite" then
		success = MiniGame("thermite", table.unpack(iteminfo.minigame.param))
	elseif minigametype == "maze" then
		success = MiniGame("maze", table.unpack(iteminfo.minigame.param))
	elseif minigametype == "lockpick" then
		success = MiniGame("lockpick")
	elseif minigametype == "safe" then
		success = MiniGame("safe")
	elseif minigametype == "thermite" then
		success = MiniGame("thermite")
	end
	if iteminfo.afteranim and success then
		local anim = lib.requestAnimDict(iteminfo.afteranim.animDict)
		if anim then
			TaskPlayAnim(PlayerPedId(), iteminfo.afteranim.animDict, iteminfo.afteranim.anim, 8.0, 8.0, -1, 0, 0, false,
				false, false)
		end
	end
	if iteminfo?.initialanim?.scully then
		exports.scully_emotemenu:cancelEmote()
	end
	ClearPedTasks(cache.ped)
	if not IsInside then
		SendAlert(item, CurrentHouseID)
	end
	if iteminfo?.shouldremove and success then
		local res = lib.callback.await("qb-houserobbery:server:removeItem", false, item)
	end
	if minigametype == "thermite" and success then
		ThermiteFX()
	end
	return success
end

local LootObject = require 'client.functions.LootHandle'.LootObject
local Utils = require 'client.functions.Utils'
local TargetLabel, DrawOutline, Notify = Utils.TargetLabel, Utils.DrawOutline, Utils.Notify
local SendAlert = require "shared.hack".alert
CreatedZones = {}
EntityZones = {}
SingleLootZones = {}


---@param isobject boolean
---@param val table
function SetupIPLTarget(isobject, val, key, houseid)
	local house = HouseData[houseid]
	local stateData = house.loots[key]
	local coords = val.data.coords
	local rotation = val.data?.rotation
	local singleloot = (val.data?.itemname and not val?.items) and true or false
	if not stateData then
		return DebugConsole(("No state data for %s"):format(key))
	end
	local function updateState()
		if not lib.table.matches(house, HouseData[houseid]) then
			house = HouseData[houseid]
		end
		local newstate = house.loots[key]
		if lib.table.matches(newstate, stateData) then return end
		stateData = newstate
	end
	if isobject then
		local tofind =
				GetClosestObjectOfType(coords.x, coords.y, coords.z, 2.0, joaat(val.data.name), false, false, true)
		if tofind and DoesEntityExist(tofind) then
			if stateData.islooted then
				SetEntityAsMissionEntity(tofind, true, true)
				DeleteEntity(tofind)
			else
				local options = {
					{
						name = houseid .. tofind,
						icon = val.data.icon or "fas fa-hand",
						label = val.data.label or "Unknown",
						onSelect = function(data)
							if exports["Renewed-Weaponscarry"]:isCarryingObject() then
								return Notify("You can't do that...","error")
							end
							local entity = data.entity
							LootObject(entity, houseid, key)
						end,
						distance = 1.5,
					},
				}
				DrawOutline(tofind)
				table.insert(EntityZones, { name = houseid .. tofind, entity = tofind })
				exports.ox_target:addLocalEntity(tofind, options)
			end
		elseif not DoesEntityExist(tofind) then
			DebugConsole(("Spawning object for %s"):format(key))
			-- spawning object
			local model = lib.requestModel(val.data.name)
			if model then
				local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, false)
				FreezeEntityPosition(obj, true)
				if rotation then
					SetEntityRotation(obj, rotation.x, rotation.y, rotation.z, 2, true)
				end
				SetModelAsNoLongerNeeded(model)
				if val.data?.forceOnGround then
					PlaceObjectOnGroundProperly(obj)
				end
				local options = {}
				if singleloot then
					options = {
						{
							name = "loot:" .. obj,
							icon = val.data?.icon or "fas fa-hand",
							label = val.data?.label or "Loot",
							canInteract = function (_, distance)
								updateState()
								return distance <= 1.5 and not stateData.islooted
							end,
							onSelect = function ()
								if exports["Renewed-Weaponscarry"]:isCarryingObject() then
									return Notify(nil, "You can't do that", 'error')
								end
								if stateData.item and not stateData.islooted then
									if not HouseData[houseid].alerted then
										SendAlert("", houseid, true)
									end
									LootObject(obj, houseid, key)
								end
							end
						}
					}
				elseif not singleloot then
					options = {
						{
							name = "stash:" .. houseid .. ":" .. obj,
							icon = val.data?.icon or "fas fa-box-archive",
							label = val.data?.label or TargetLabel(val.minigame),
							canInteract = function (_, distance)
								updateState()
								return distance <= 1.5 and not stateData.isopen
							end,
							onSelect = function ()
								if exports["Renewed-Weaponscarry"]:isCarryingObject() then
									return Notify(nil, "You can't do that...", 'error')
								end
								local success, reason = StartMinigame(val.minigame)
								if success then
									if lib.callback.await("qb-houserobbery:server:setLootState", false, houseid, key, true) then
										Notify("Unlocked", "You've successfully unlocked the stash...", "success")
										SendAlert("", houseid, true)
									end
								else
									if reason then
										Notify(nil, "You don't have the item...", "error")
									else
										Notify(nil, "You failed...", "error")
									end
								end
							end
						},
						{
							name = "loot:" .. houseid .. ":" .. QBCore.Shared.RandomInt(2) .. ":" .. QBCore.Shared.RandomStr(5):upper(),
							icon = "fas fa-hand",
							label = val.data.openlabel or "Open Stash",
							canInteract = function (_, distance)
								return distance <= 1.5 and stateData.isopen
							end,
							onSelect = function ()
								if exports["Renewed-Weaponscarry"]:isCarryingObject() then
									return Notify(nil, "You can't do that...", 'error')
								end
								ox_inventory:openInventory("stash", stateData.id)
							end
						}
					}
				end
				table.insert(EntityZones, { name = "stash:" .. obj, entity = obj, spawned = true })
				DrawOutline(obj)
				exports.ox_target:addLocalEntity(obj, options)
			end
		end
	else
		local options = {}
		if singleloot then
			if stateData.islooted then return end
			DebugConsole(("Spawning single loot for %s %s"):format(key, val.data.label))
			options = {
				{
					name = string.format("boxzone:%s:%s:%s", houseid, key, QBCore.Shared.RandomInt(2)),
					icon = val.data.icon or "fas fa-hand",
					label = val.data.label or "Take Item",
					canInteract = function (_, distance)
						updateState()
						return not stateData.islooted and distance <= 1.5 
					end,
					onSelect = function ()
						if exports["Renewed-Weaponscarry"]:isCarryingObject() then
							return Notify(nil, "You can't do that", 'error')
						end
						LootObject(nil, houseid, key)
					end
				}
			}
		else
			DebugConsole(("Spawning stash for %s %s"):format(key, val.data.label))
			options = {
				{
					name = string.format(
						"stash:%s:%s:%s",
						houseid,
						QBCore.Shared.RandomInt(2),
						QBCore.Shared.RandomStr(5):upper()
					),
					icon = val.data.icon or "fas fa-box-archive",
					label = val.data?.label or TargetLabel(val.minigame),
					canInteract = function()
						stateData = HouseData[houseid].loots[key]
						return not stateData.isopen
					end,
					onSelect = function()
						if exports["Renewed-Weaponscarry"]:isCarryingObject() then
							return Notify(nil, "You can't do that", 'error')
						end
						stateData = HouseData[houseid].loots[key]
						local success, reason = StartMinigame(val.minigame)
						if success then
							if lib.callback.await("qb-houserobbery:server:setLootState", false, houseid, key, true) then
								Notify("Unlocked", "You've successfully unlocked the stash...", "success")
								SendAlert("", houseid, true)
							end
						else
							if reason then
								Notify(nil, "You don't have the item...", "error")
							else
								Notify(nil, "You failed...", "error")
							end
						end
					end,
					distance = 1.5,
				},
				{
					name = "loot:" .. houseid .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(5):upper(),
					icon = "fas fa-boxes-packing",
					label = val.data.openlabel or "Open Stash",
					canInteract = function()
						stateData = HouseData[houseid].loots[key]
						return stateData.isopen
					end,
					onSelect = function()
						if exports["Renewed-Weaponscarry"]:isCarryingObject() then
							return Notify(nil, "You can't do that...", "error")
						end
						stateData = HouseData[houseid].loots[key]
						if not stateData.generated then
							if lib.callback.await("qb-houserobbery:server:setLootState", false, houseid, key, true) then
								ox_inventory:openInventory("stash", stateData.id)
							end
						else
							ox_inventory:openInventory("stash", stateData.id)
						end
					end,
					distance = 1.5,
				},
			}
		end
		local id = 	exports.ox_target:addBoxZone({
			coords = coords,
			size = val.data.size,
			rotation = val.data.rotation,
			debug = Config.Debug,
			options = options,
		})
		table.insert(CreatedZones,id)
		if singleloot then
			table.insert(SingleLootZones, {
				key = key,
				id = id
			})
		end
		
	end
end


CreateThread(function ()
	DoScreenFadeIn(10)
end)

---@param isobject boolean
---@param val table
---@param key any
---@param houseid string
function SetupShellTarget(isobject, val, key, houseid)
	DebugConsole({isobject, val, key, houseid})
	local house = HouseData[houseid]
	local houseData = house and house?.loots[key]
	local function updateState()
		if lib.table.matches(house, HouseData[houseid]) then return end
		house = HouseData[houseid]
		houseData = house and house?.loots[key]
	end
	local ConfigNumber = house and house.number
	local singleloot = houseData.item and true or false
	local islooted, coords, rotation = houseData.islooted, val.data.coords, val.data.rotation
	if singleloot and islooted then return end
	if isobject then
		lib.requestModel(val.name)
		local objCoords = Config.HouseLocation[ConfigNumber].coords.xyz + vec3(0.0, 0.0, 30.0) + coords.xyz
		local obj = CreateObject(joaat(val.name), objCoords.x, objCoords.y, objCoords.z, false, true, false)
		if val.data.forceOnGround then
			PlaceObjectOnGroundProperly(obj)
		end
		FreezeEntityPosition(obj, true)
		SetEntityRotation(obj, rotation.x, rotation.y, rotation.z, 0, false)
		DrawOutline(obj)
		local opt = {}
		if singleloot then
			opt = {
				{
					name = "loot:" .. houseid .. ":" .. obj,
					icon = val.data.icon or "fas fa-hand",
					label = val.data.label or "Loot",
					canInteract = function(_, distance)
						updateState()
						return distance <= 1.5 and not houseData.islooted
					end,
					onSelect = function()
						if exports["Renewed-Weaponscarry"]:isCarryingObject() then
							return Notify(nil, "You can't do that", 'error')
						end
						if houseData.item and not houseData.islooted then
							if not HouseData[houseid].alerted then
								SendAlert("", houseid, true)
							end
							LootObject(obj, houseid, key)
						end
					end
				}
			}
		elseif not singleloot then
			opt = {
				{
					name = "stash:" .. houseid .. ":" .. QBCore.Shared.RandomInt(2) .. ":" .. QBCore.Shared.RandomStr(5):upper(),
					icon = val.data.icon or "fas fa-box-archive",
					label = val.data?.label or TargetLabel(val.minigame),
					canInteract = function(_, distance)
						updateState()
						return not houseData.isopen and distance <= 1.5
					end,
					onSelect = function ()
						if exports["Renewed-Weaponscarry"]:isCarryingObject() then
							return Notify(nil, "You can't do that...", 'error')
						end
						local success, reason = StartMinigame(val.minigame)
						if success then
							if lib.callback.await("qb-houserobbery:server:setLootState", false, houseid, key, true) then
								Notify("Unlocked", "You've successfully unlocked the stash...", "success")
								SendAlert("", houseid, true)
							end
						else
							if reason then
								Notify(nil, "You don't have the item...", "error")
							else
								Notify(nil, "You failed...", "error")
							end
						end
					end
				},
				{
					name = "loot:" .. houseid .. ":" .. QBCore.Shared.RandomInt(2) .. ":" .. QBCore.Shared.RandomStr(5):upper(),
					icon = "fas fa-hand",
					label = val.data.openlabel or "Open Stash",
					canInteract = function (_, distance)
						return distance <= 1.5 and houseData.isopen
					end,
					onSelect = function ()
						if exports["Renewed-Weaponscarry"]:isCarryingObject() then
							return Notify(nil, "You can't do that...", 'error')
						end
						if not HouseData[houseid].alerted then
							SendAlert("", houseid, true)
						end
						ox_inventory:openInventory("stash", houseData.id)
					end
				}
			}
		end
		table.insert(EntityZones, {
			name = houseid .. obj,
			entity = obj,
			spawned = true,
			id = key,
			model = val.name,
			singleloot = val?.data?.itemname and true or false
		})
		exports.ox_target:addLocalEntity(obj, opt)
	else
		local shellcoords = GetEntityCoords(ShellData.entity)
		local position = vec3(shellcoords.x - coords.x, shellcoords.y -coords.y, shellcoords.z - coords.z)
		local id = exports.ox_target:addBoxZone({
    		coords = position,
    		size = val.data.size,
    		rotation = rotation,
    		debug = Config.Debug,
    		options = {
    				{
							name = "stash:" .. houseid .. ":" .. QBCore.Shared.RandomInt(2) .. ":" .. QBCore.Shared.RandomStr(5):upper(),
							icon = val.data.icon or "fas fa-box-archive",
							label = val.data.label or TargetLabel(val.minigame),
							canInteract = function(_, distance)
								updateState()
								return not houseData.isopen and distance <= 1.5
							end,
							onSelect = function ()
								if exports["Renewed-Weaponscarry"]:isCarryingObject() then
									return Notify(nil, "You can't do that...", 'error')
								end
								local success, reason = StartMinigame(val.minigame)
								if success then
									if lib.callback.await("qb-houserobbery:server:setLootState", false, houseid, key, true) then
										Notify("Unlocked", "You've successfully unlocked the stash...", "success")
										SendAlert("", houseid, true)
									end
								else
									if reason then
										Notify(nil, "You don't have the item...", "error")
									else
										Notify(nil, "You failed...", "error")
									end
								end
							end
    				},
        		{
							name = "loot:" .. houseid .. ":" .. QBCore.Shared.RandomInt(2) .. ":" .. QBCore.Shared.RandomStr(5):upper(),
							icon = "fas fa-hand",
							label = val.data.openlabel or "Open Stash",
							canInteract = function (_, distance)
								return distance <= 1.5 and houseData.isopen
							end,
							onSelect = function ()
								if exports["Renewed-Weaponscarry"]:isCarryingObject() then
									return Notify(nil, "You can't do that...", 'error')
								end
								if not HouseData[houseid].alerted then
									SendAlert("", houseid, true)
								end
								if not houseData.generated then
									if lib.callback.await("qb-houserobbery:server:setLootState", false, houseid, key, true) then
										ox_inventory:openInventory("stash", houseData.id)
									end
								else
									ox_inventory:openInventory("stash", houseData.id)
								end
							end
        		}
    		}
		})
		table.insert(EntityZones, {
			zone = true,
			data = id
		})
	end
end

function SetupHouseTarget(houseid)
	if not houseid then
		return
	end

	local ConfigNumber = HouseData[houseid].number
	if not ConfigNumber then
		return
	end
	Wait(500)
	local houseData = Config.HouseLocation[ConfigNumber]
	local config, houseType = houseData.config, houseData.type
	local ExitCoords = config.exit

	local function createExitZone(coords, rotation)
		table.insert(
			CreatedZones,
			exports.ox_target:addBoxZone({
				coords = coords,
				size = vec3(1.5, 1.5, 2.3),
				rotation = rotation,
				debug = Config.Debug,
				options = {
					{
						label = "Exit House",
						icon = "fas fa-door-open",
						distance = 1.5,
						onSelect = function ()
							return pcall(LeaveHouse, houseid)
						end
					}
				}
			})
		)
	end

	if houseType == "ipl" then
		createExitZone(ExitCoords.xyz, ExitCoords.w)
	else
		local exactCoords = ExitCoords.xyz + houseData.coords.xyz + vec3(0.0, 0.0, 30.0)
		createExitZone(exactCoords, ExitCoords.w)
	end

	local targetSetupFunc = houseType == "ipl" and SetupIPLTarget or SetupShellTarget

	for k, v in pairs(config.loot) do
		DebugConsole("Setting up target for " .. k)
		targetSetupFunc(v.isobject, v, k, houseid)
	end
end

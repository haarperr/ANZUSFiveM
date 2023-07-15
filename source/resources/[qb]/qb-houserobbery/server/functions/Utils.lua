local GenerateLoots = require 'server.functions.LootHandle'.GenerateLoots

local function GenerateUniqueStash()
	return QBCore.Shared.RandomStr(2):upper() .. QBCore.Shared.RandomInt(4)
end

---@param orig any
---@param copies any
---@return any
local function DeepCopy(orig, copies)
	copies = copies or {} -- lookup table for copied tables
	local copy
	if type(orig) == "table" then
		if copies[orig] then
			copy = copies[orig]
		else
			copy = {}
			copies[orig] = copy
			if next(orig) == 1 and #orig > 0 then -- array part
				copy = table.move(orig, 1, #orig, 1, copy)
			else                         -- hash part
				for orig_key, orig_value in next, orig, nil do
					copy[DeepCopy(orig_key, copies)] = DeepCopy(orig_value, copies)
				end
			end
			setmetatable(copy, DeepCopy(getmetatable(orig), copies))
		end
	else
		copy = orig
	end
	return copy
end

local function FindConfig(id)
	for i = 1, #Config.HouseLocation do
		if Config.HouseLocation[i].id == id then
			return i
		end
	end
end

local function GenerateBucketNumber()
	return QBCore.Shared.RandomInt(5)
end

---@param id string
---@param force boolean
local function ResetHouseState(id, force)
	if not id then return end
	CreateThread(function()
		if not force then
			Wait(1 * 1000 * 60 * 60 * 2)
		end
		local Players = GetPlayersInHouse(id)
		if Players and next(Players) ~= nil then return ResetHouseState(id, false) end
		local housenumber = FindConfig(id)
		local house = Config.HouseLocation[housenumber]
		local GState = HouseTable
		local HouseData = GState[id]
		if not HouseData.cooldown then return end
		if HouseData and house then
			house.bucket = GenerateBucketNumber()
			house.cooldown = false
			table.wipe(HouseData)
			local loots = {}
			for sid, loot in ipairs(house.config.loot) do
				loots[sid] = GenerateLoots(loot, house.type)
			end
			HouseData = {
				type = house.type,
				number = housenumber,
				locked = true,
				guardAwake = false,
				dogAwake = false,
				dog = {
					treated = false
				},
				guards = {},
				loots = loots
			}
			HouseTable = GState
			Wait(100)
			TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
		end
	end)
end

---@param type "night" | "day"
local function SpawnChance(type)
	if type == "day" then
		return math.random(1, 10) > 7
	elseif type == "night" then
		return math.random(1, 10) > 2
	end
end

local function TimeCheck()
	local hour, minute = exports["qb-weathersync"]:getTime()
	local state = GlobalState.HouseRobberyTimeState
	if hour >= 19 or hour <= 6 then
		if state ~= "night" then
			DebugConsole(("Updating to %s"):format("night"))
			state = "night"
			TimeCycle("night")
			GlobalState.HouseRobberyTimeState = state
		end
	else
		if state ~= "day" then
			DebugConsole(("Updating to %s"):format("day"))
			state = "day"
			TimeCycle("day")
			GlobalState.HouseRobberyTimeState = state
		end
	end
	SetTimeout(1000 * 60, TimeCheck)
end

local function RandomTimestamp()
	local random_offset = math.random(20, 30)
	---@diagnostic disable-next-line: param-type-mismatch
	local current_utc_time = os.time(os.date('!*t'))
	local target_utc_time = current_utc_time + random_offset
	return os.date('!%Y-%m-%d %H:%M:%S', target_utc_time), random_offset
end

local function GetCurrentTime()
	---@diagnostic disable-next-line: param-type-mismatch
	return os.date('!%Y-%m-%d %H:%M:%S', os.time(os.date("!*t")))
end


---@param model string
---@param coords vector4
---@param houseid string
---@param animdict string
---@param animname string
local function SpawnGuard(model, coords, houseid, animdict, animname)
	local RandomWeapon = {
		"WEAPON_PISTOL",
		"WEAPON_BAT",
		"WEAPON_CROWBAR",
	}
	-- select random weapon
	local weapon = RandomWeapon[math.random(#RandomWeapon)]
	local ped = CreatePed(1, joaat(model), coords.x, coords.y, coords.z, coords.w, true, true)
	local netid = NetworkGetNetworkIdFromEntity(ped)
	FreezeEntityPosition(ped, false)
	SetEntityCoords(ped, coords.x, coords.y, coords.z, true, false, false, false)
	SetPedConfigFlag(ped, 100, true)
	SetPedArmour(ped, 100)
	GiveWeaponToPed(ped, joaat(weapon), 255, false, true)
	TaskPlayAnim(ped, animdict, animname, 8.0, 8.0, -1, 1, 0, false, false, false)
	DebugConsole("New ped spawned, netid: " .. netid .. " houseid: " .. houseid)
	Wait(100)
	return netid
end


---@param model string
---@param coords vector4
---@param animdict string
---@param anim string
---@param houseid string
---@return number
local function SpawnDog(model, coords, animdict, anim, houseid)
	local ped = CreatePed(1, joaat(model), coords.x, coords.y, coords.z, coords.w, true, true)
	local netid = NetworkGetNetworkIdFromEntity(ped)
	FreezeEntityPosition(ped, false)
	SetEntityCoords(ped, coords.x, coords.y, coords.z, true, false, false, false)
	SetPedArmour(ped, 100)
	SetPedConfigFlag(ped, 17, true)
	if animdict then
		TaskPlayAnim(ped, animdict, anim, 8.0, 8.0, -1, 1, 0, false, false, false)
	end
	SetEntityRouting(netid, houseid)
	return netid
end

return {
	GenerateUniqueStash = GenerateUniqueStash,
	DeepCopy = DeepCopy,
	FindConfig = FindConfig,
	ResetHouseState = ResetHouseState,
	SpawnChance = SpawnChance,
	TimeCheck = TimeCheck,
	RandomTimestamp = RandomTimestamp,
	GetCurrentTime = GetCurrentTime,
	GenerateBucketNumber = GenerateBucketNumber,
	SpawnGuard = SpawnGuard,
	SpawnDog = SpawnDog,
}

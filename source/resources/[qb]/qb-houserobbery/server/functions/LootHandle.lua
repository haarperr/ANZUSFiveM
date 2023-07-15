local function AddLootStash(id, name, value, metadata)
	local success, response = ox_inventory:AddItem(id, name, value, metadata or nil)
	if not success then
		print(("Error: %s"):format(response))
	end
end

function IsWeaponFireable(weaponName)
	local fireableWeapons = {
		"WEAPON_PISTOL",
		"WEAPON_PISTOL50",
	}

	for _, fireableWeapon in ipairs(fireableWeapons) do
		if weaponName:match(fireableWeapon) then
			return true
		end
	end

	return false
end

---@param numItems number
---@param itemType 'kitchen' | 'general' | 'weaponry' | 'bedroom' | 'safe' | "fridge"
---@return table
local function GenerateItemList(numItems, itemType)
	local itemList = {}
	local itemNames = {
		kitchen = {
			"wine",
			"kurkakola",
			"snikkel_candy",
			"cleaningkit",
			"coffee",
			"burger",
		},
		general = {
			"bandage",
			"black_money",
			"water",
			"weed_ak47_seed",
			"electronickit",
		},
		weaponry = {
			"WEAPON_BAT",
			"WEAPON_BATTLEAXE",
			"WEAPON_BOTTLE",
			"WEAPON_CROWBAR",
			"WEAPON_FLASHLIGHT",
			"WEAPON_HATCHET",
			"WEAPON_KNIFE",
			"WEAPON_PISTOL",
			"WEAPON_PISTOL50",
			"ammo-9",
			"ammo-50",
		},
		bedroom = {
			"wine",
			"black_money",
			"cola",
			"whiskey",
			"advancedrepairkit",
			"weed_purple-haze_seed",
			"goldbar",
		},
		safe = {
			"diamond_ring",
			"black_money",
		},
		fridge = {
			"beer",
			"cola",
			"water",
			"wine",
			"whiskey",
			"kurkakola",
			"mustard",
			"burger",
			"twerks_candy"
		}
	}
	for i = 1, numItems do
		local itemName = itemNames[itemType][math.random(1, #itemNames[itemType])]
		local amount = itemType == "weaponry" and math.random(1, 2) or math.random(1, 5)
		itemList[itemName] = amount
	end
	if math.random() < 0.2 then
		itemList["money"] = itemType == "safe" and math.random(300, 1000) or math.random(50, 100)
	end
	return itemList
end

local function SetLootState(source, house, id, state)
	local data = HouseTable
	local housedata = data[house]
	if not housedata then return false end
	local stashnumber = housedata.loots[id]
	if not stashnumber then return false end
	local success = false

	-- This function has been created to remove redundant code
	local function updateHouseListAndRefresh()
		HouseTable = data
		Wait(100)
		TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
		local list = GetPlayersInHouse(house)
		for _, v in pairs(list) do
			TriggerClientEvent("qb-houserobbery:client:refreshInside", v, house, id)
		end
	end
	if housedata.type == "ipl" or housedata.type == "shell" then
		if not stashnumber.generated and state and stashnumber.items then
			stashnumber.generated = true
			stashnumber.isopen = true
			ox_inventory:RegisterStash(stashnumber.id, string.format("House %s", stashnumber.id), 50, 100000)
			for k, v in pairs(stashnumber.items) do
				local metadata = {}
				if IsWeaponFireable(k) then
					metadata = {
						ammo = math.random(10, 100),
						serial = "Scratched Off",
						registered = "Unknown",
						components = {}
					}
				end
				AddLootStash(stashnumber.id, k, v, metadata)
			end
			success = true
		elseif state and (housedata.type == "ipl" or not stashnumber.islooted) and not stashnumber.items then
			stashnumber.islooted = true
			ox_inventory:AddItem(source, stashnumber.item, 1)
			success = true
		end
		updateHouseListAndRefresh()
	end
	return success
end

local function ResetAllStash()
	if not HouseTable then
		return
	end
	for _, v in pairs(HouseTable) do
		if not v.loots then return end
		for _, stash in ipairs(v.loots) do
			if stash.generated then
				print("Deleting ", stash.id)
				exports.ox_inventory:ClearInventory(stash.id)
			end
		end
	end
end

local function LootObject(source, name)
	ox_inventory:AddItem(source, name, 1)
	return ItemList[name] or "Unknown"
end

-- Only trigger this once
local function GetItemData()
	table.wipe(ItemList)
	for item, data in pairs(exports.ox_inventory:Items()) do
		ItemList[item] = data.label
	end
end

local function GetLootState(house, id)
	local FindConfig = require 'server.functions.Utils'.FindConfig
	local config = Config.HouseLocation[FindConfig(house)].config.loot[id]
	if not config then
		return
	end
	return { isopen = config.isopen, id = config.id }
end

local function RemoveObject(NetID)
	if not NetID then
		return
	end
	local entity = NetworkGetEntityFromNetworkId(NetID)
	if not DoesEntityExist(entity) then
		return
	end
	DeleteEntity(entity)
	return true
end

local function generateLootItems(itemType)
	local itemCount = itemType == 'weaponry' and math.random(1, 2) or
		itemType == 'general' and math.random(1, 4) or
		itemType == 'kitchen' and math.random(2, 6) or
		itemType == 'bedroom' and math.random(1, 5) or
		math.random(1, 4)
	return GenerateItemList(itemCount, itemType)
end


---@class loot
---@field items {type: string}
---@field isobject boolean
---@field minigame string
---@field data {itemname: string}

---@param loot loot
---@param housetype "ipl" | "shell"
local function GenerateLoots(loot, housetype)
	local GenerateUniqueStash = require 'server.functions.Utils'.GenerateUniqueStash
	local defopen = loot.minigame ~= nil
	local items = nil
	if loot.items and loot.items.type and not loot.isobject then
		items = generateLootItems(loot.items.type)
	elseif loot.isobject then
		if loot.data.itemname then
			return {
				islooted = false,
				item = loot.data.itemname,
				isobject = true
			}
		elseif loot.items.type then
			items = generateLootItems(loot.items.type)
			return {
				isobject = true,
				isopen = not defopen,
				generated = false,
				id = GenerateUniqueStash(),
				items = items,
			}
		end
	elseif not loot.isobject and loot.data.itemname then
		return {
			islooted = false,
			item = loot.data.itemname,
			isobject = false
		}
	end
	if items then
		return {
			isopen = not defopen,
			id = GenerateUniqueStash(),
			generated = false,
			items = items,
			type = loot.items.type
		}
	end
end


return {
	AddLootStash = AddLootStash,
	GenerateItemList = GenerateItemList,
	SetLootState = SetLootState,
	ResetAllStash = ResetAllStash,
	LootObject = LootObject,
	GetLootState = GetLootState,
	RemoveObject = RemoveObject,
	GetItemData = GetItemData,
	GenerateLootItems = generateLootItems,
	GenerateLoots = GenerateLoots,
}

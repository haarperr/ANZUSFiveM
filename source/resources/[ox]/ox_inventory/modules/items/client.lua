if not lib then return end

local Items = require 'modules.items.shared' --[[@as table<string, OxClientItem>]]

local function displayMetadata(metadata, value)
	local data = metadata
	if type(metadata) == 'string' and value then data = { [metadata] = value } end
	SendNUIMessage({
		action = 'displayMetadata',
		data = data
	})
end
exports('displayMetadata', displayMetadata)

---@param _ table?
---@param name string?
---@return table?
local function getItem(_, name)
    if not name then return Items end

	if type(name) ~= 'string' then return end

    name = name:lower()

    if name:sub(0, 7) == 'weapon_' then
        name = name:upper()
    end

    return Items[name]
end

setmetatable(Items --[[@as table]], {
	__call = getItem
})

---@cast Items +fun(itemName: string): OxClientItem
---@cast Items +fun(): table<string, OxClientItem>

local function Item(name, cb)
	local item = Items[name]
	if item then
		if not item.client?.export and not item.client?.event then
			item.effect = cb
		end
	end
end

local ox_inventory = exports[shared.resource]
-----------------------------------------------------------------------------------------------
-- Clientside item use functions
-----------------------------------------------------------------------------------------------

Item('berkeleypack', function(data, slot)
    ox_inventory:useItem(data, function(data)
        ox_inventory:notify({text = 'You opened '..data.name})
    end)
end)

Item('cigarrete', function(data, slot)
	local count = ox_inventory:Search(source, 'count', {'lighter'})
	if count and count.lighter == 0 then
		return ox_inventory:notify({text = 'What are you lighting a cigarrete with?'})
	end

    ox_inventory:useItem(data, function(data)
		if not data then return end
		local playerPed = PlayerPedId()
		ox_inventory:notify({text = 'You are smoking '..data.name})
		if IsPedInAnyVehicle(playerPed, false) then
			TriggerEvent('animations:client:EmoteCommandStart', { "smoke3" })
		else
			TriggerEvent('animations:client:EmoteCommandStart', { "smoke" })
		end
		TriggerEvent('animations:client:SmokeCig')
    end)
end)

--- BOX AMMO ---

Item('pistol_boxammo', function(data, slot)
    ox_inventory:useItem(data, function(data)
        ox_inventory:notify({text = 'You opened '..data.name})
    end)
end)

Item('smg_boxammo', function(data, slot)
    ox_inventory:useItem(data, function(data)
        ox_inventory:notify({text = 'You opened '..data.name})
    end)
end)

Item('shotgun_boxammo', function(data, slot)
    ox_inventory:useItem(data, function(data)
        ox_inventory:notify({text = 'You opened '..data.name})
    end)
end)

Item('pistol_boxammo', function(data, slot)
    ox_inventory:useItem(data, function(data)
        ox_inventory:notify({text = 'You opened '..data.name})
    end)
end)

Item('rifle_boxammo', function(data, slot)
    ox_inventory:useItem(data, function(data)
        ox_inventory:notify({text = 'You opened '..data.name})
    end)
end)

Item('beanbag_boxammo', function(data, slot)
    ox_inventory:useItem(data, function(data)
        ox_inventory:notify({text = 'You opened '..data.name})
    end)
end)

Item('emp_boxammo', function(data, slot)
    ox_inventory:useItem(data, function(data)
        ox_inventory:notify({text = 'You opened '..data.name})
    end)
end)

Item('mg_boxammo', function(data, slot)
    ox_inventory:useItem(data, function(data)
        ox_inventory:notify({text = 'You opened '..data.name})
    end)
end)

--------------

Item('blue_keycard', function(data, slot)
	exports.ag_major:useItem('blue_keycard')
end)

Item('black_keycard', function(data, slot)
	exports.ag_major:useItem('black_keycard')
end)

Item('laptop_black', function(data, slot)
	exports.ag_major:useItem('laptop_black')
end)

Item('laser_drill', function(data, slot)
	exports.ag_major:useItem('laser_drill')
end)

Item('scissors', function(data, slot)
	exports.ag_major:useItem('scissors')
end)

Item('pink_keycard', function(data, slot)
	exports.ag_major:useItem('pink_keycard')
end)

--------------

Item('bandage', function(data, slot)
	local maxHealth = GetEntityMaxHealth(cache.ped)
	local health = GetEntityHealth(cache.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			if math.random(1, 100) < 50 then
				exports['qb-ambulancejob']:RemoveBleed(1)
			end
			if math.random(1, 100) < 7 then
				exports['qb-ambulancejob']:ResetPartial()
			end
			SetEntityHealth(cache.ped, math.min(maxHealth, math.floor(health + 10)))
			lib.notify({ description = 'You feel better already' })
		end
	end)
end)

Item('firstaid', function(data, slot)
	local maxHealth = GetEntityMaxHealth(cache.ped)
	local health = GetEntityHealth(cache.ped)
    if health < maxHealth then
		ox_inventory:useItem(data, function(data)
			SetEntityHealth(cache.ped, maxHealth)
			exports['qb-ambulancejob']:RemoveBleed(1)
			ox_inventory:notify({text = 'You used your first aid kit.'})
		end)
    else
        lib.notify({ description = 'You do not need healing right now.'})
    end
end)

Item('armour', function(data, slot)
	if GetPedArmour(cache.ped) < 100 then
		ox_inventory:useItem(data, function(data)
			if data then
				SetPlayerMaxArmour(PlayerData.id, 100)
				SetPedArmour(cache.ped, 100)
			end
		end)
	end
end)

client.parachute = false
Item('parachute', function(data, slot)
	if not client.parachute then
		ox_inventory:useItem(data, function(data)
			if data then
				local chute = `GADGET_PARACHUTE`
				SetPlayerParachuteTintIndex(PlayerData.id, -1)
				GiveWeaponToPed(cache.ped, chute, 0, true, false)
				SetPedGadget(cache.ped, chute, true)
				lib.requestModel(1269906701)
				client.parachute = CreateParachuteBagObject(cache.ped, true, true)
				if slot.metadata.type then
					SetPlayerParachuteTintIndex(PlayerData.id, slot.metadata.type)
				end
			end
		end)
	end
end)

Item('handcuffs', function(data, slot)
	exports.ag_police:cuffPlayer()
end)

Item('zipties', function(data, slot)
	exports.ag_police:ziptiePlayer()
end)

Item('knife', function(data, slot)
	exports.ag_police:removeZipties()
end)

Item('phone', function(data, slot)
	local success, result = pcall(function()
		return exports.npwd:isPhoneVisible()
	end)

	if success then
		exports.npwd:setPhoneVisible(not result)
	end
end)

Item('harness', function(data, slot)
    local class = GetVehicleClass(cache.vehicle)
    if cache.vehicle and class == 8 and class == 13 and class == 14 then return lib.notify({type = 'error', description = 'You are not in a automobile'}) end

    exports.ox_inventory:useItem(data, function(data)
        -- The server has verified the item can be used.
        if data then
            exports.ag_misc:ToggleHarness()
        end
    end)
end)

Item('clothing', function(data, slot)
	local metadata = slot.metadata

	if not metadata.drawable then return print('Clothing is missing drawable in metadata') end
	if not metadata.texture then return print('Clothing is missing texture in metadata') end

	if metadata.prop then
		if not SetPedPreloadPropData(cache.ped, metadata.prop, metadata.drawable, metadata.texture) then
			return print('Clothing has invalid prop for this ped')
		end
	elseif metadata.component then
		if not IsPedComponentVariationValid(cache.ped, metadata.component, metadata.drawable, metadata.texture) then
			return print('Clothing has invalid component for this ped')
		end
	else
		return print('Clothing is missing prop/component id in metadata')
	end

	ox_inventory:useItem(data, function(data)
		if data then
			metadata = data.metadata

			if metadata.prop then
				local prop = GetPedPropIndex(cache.ped, metadata.prop)
				local texture = GetPedPropTextureIndex(cache.ped, metadata.prop)

				if metadata.drawable == prop and metadata.texture == texture then
					return ClearPedProp(cache.ped, metadata.prop)
				end

				-- { prop = 0, drawable = 2, texture = 1 } = grey beanie
				SetPedPropIndex(cache.ped, metadata.prop, metadata.drawable, metadata.texture, false);
			elseif metadata.component then
				local drawable = GetPedDrawableVariation(cache.ped, metadata.component)
				local texture = GetPedTextureVariation(cache.ped, metadata.component)

				if metadata.drawable == drawable and metadata.texture == texture then
					return -- item matches (setup defaults so we can strip?)
				end

				-- { component = 4, drawable = 4, texture = 1 } = jeans w/ belt
				SetPedComponentVariation(cache.ped, metadata.component, metadata.drawable, metadata.texture, 0);
			end
		end
	end)
end)

Item('methtable', function(data, slot)
  exports.ox_inventory:useItem(data, function(data) end)
end)

Item('fishingrod', function(data, slot)
  exports.ag_fishing:useFishingRod(slot)
end)

Item('lockpick', function(data, slot)
  exports.ox_inventory:useItem(data, function(data)
    TriggerEvent('lockpicks:UseLockpick', false)
  end)
end)

Item('advancedlockpick', function(data, slot)
  exports.ox_inventory:useItem(data, function(data)
    TriggerEvent('lockpicks:UseLockpick', true)
  end)
end)

Item('fishingrod', function(data, slot)
	exports.ag_fishing:useFishingRod(slot)
end)

Item('megaphone', function(data, slot)
  TriggerEvent("megaphone:Toggle")
end)
-----------------------------------------------------------------------------------------------

exports('Items', function(item) return getItem(nil, item) end)
exports('ItemList', function(item) return getItem(nil, item) end)

return Items

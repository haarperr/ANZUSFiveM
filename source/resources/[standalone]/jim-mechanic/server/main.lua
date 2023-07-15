QBCore = exports['qb-core']:GetCoreObject()
QBCore.Shared.Items = exports.ox_inventory:Items()

--Create Usable Items
QBCore.Functions.CreateUseableItem("car_armor", function(source, item) TriggerClientEvent('jim-mechanic:client:applyArmour', source) end)
QBCore.Functions.CreateUseableItem("turbo", function(source, item) TriggerClientEvent("jim-mechanic:client:applyTurbo", source) end)
QBCore.Functions.CreateUseableItem("headlights", function(source, item) TriggerClientEvent("jim-mechanic:client:applyXenons", source) end)
QBCore.Functions.CreateUseableItem("underglow_controller", function(source, item) TriggerClientEvent('jim-mechanic:client:neonMenu', source) end)
QBCore.Functions.CreateUseableItem("toolbox", function(source, item) TriggerClientEvent('jim-mechanic:client:Menu', source) end)
QBCore.Functions.CreateUseableItem("mechanic_tools", function(source, item) TriggerClientEvent('jim-mechanic:client:Repair:Check', source) end)
QBCore.Functions.CreateUseableItem("seat", function(source, item) TriggerClientEvent('jim-mechanic:client:Seat:Check', source) end)
QBCore.Functions.CreateUseableItem("internals", function(source, item) TriggerClientEvent('jim-mechanic:client:Interior:Check', source) end)
QBCore.Functions.CreateUseableItem("externals", function(source, item) TriggerClientEvent('jim-mechanic:client:Exterior:Check', source) end)
QBCore.Functions.CreateUseableItem("rims", function(source, item) TriggerClientEvent('jim-mechanic:client:Rims:Check', source) end)
QBCore.Functions.CreateUseableItem("exhaust", function(source, item) TriggerClientEvent('jim-mechanic:client:Exhaust:Check', source) end)
QBCore.Functions.CreateUseableItem("horn", function(source, item) TriggerClientEvent('jim-mechanic:client:Horn:Check', source) end)
QBCore.Functions.CreateUseableItem("paintcan", function(source, item) TriggerClientEvent('jim-mechanic:client:Paints:Check', source) end)
QBCore.Functions.CreateUseableItem("livery", function(source, item) TriggerClientEvent('jim-mechanic:client:Livery:Check', source) end)
QBCore.Functions.CreateUseableItem("tires", function(source, item) TriggerClientEvent('jim-mechanic:client:Tires:Check', source) end)
QBCore.Functions.CreateUseableItem("skirts", function(source, item) TriggerClientEvent('jim-mechanic:client:Skirts:Check', source) end)
QBCore.Functions.CreateUseableItem("spoiler", function(source, item) TriggerClientEvent('jim-mechanic:client:Spoilers:Check', source) end)
QBCore.Functions.CreateUseableItem("roof", function(source, item) TriggerClientEvent('jim-mechanic:client:Roof:Check', source) end)
QBCore.Functions.CreateUseableItem("rollcage", function(source, item) TriggerClientEvent('jim-mechanic:client:RollCage:Check', source) end)
QBCore.Functions.CreateUseableItem("hood", function(source, item) TriggerClientEvent('jim-mechanic:client:Hood:Check', source) end)
QBCore.Functions.CreateUseableItem("bumper", function(source, item) TriggerClientEvent('jim-mechanic:client:Bumpers:Check', source) end)
QBCore.Functions.CreateUseableItem("customplate", function(source, item) TriggerClientEvent('jim-mechanic:client:Plates:Check', source) end)
QBCore.Functions.CreateUseableItem("cleaningkit", function(source, item) TriggerClientEvent('jim-mechanic:client:cleanVehicle', source, true) end)
QBCore.Functions.CreateUseableItem("tint_supplies", function(source, item) TriggerClientEvent('jim-mechanic:client:Windows:Check', source) end)
QBCore.Functions.CreateUseableItem("ducttape", function(source, item) TriggerClientEvent("jim-mechanic:quickrepair", source) end)
QBCore.Functions.CreateUseableItem("bprooftires", function(source, item) TriggerClientEvent("jim-mechanic:client:applyBulletProof", source) end)
QBCore.Functions.CreateUseableItem("drifttires", function(source, item) TriggerClientEvent("jim-mechanic:client:applyDrift", source) end)
QBCore.Functions.CreateUseableItem("nos", function(source, item) TriggerClientEvent("jim-mechanic:client:applyNOS", source) end)

for i = 1, 5 do
	QBCore.Functions.CreateUseableItem("suspension"..i, function(source, item) TriggerClientEvent("jim-mechanic:client:applySuspension", source, i-1) end)
	QBCore.Functions.CreateUseableItem("engine"..i, function(source, item) TriggerClientEvent("jim-mechanic:client:applyEngine", source, i-1) end)
end
for i = 1, 4 do
	QBCore.Functions.CreateUseableItem("transmission"..i, function(source, item) TriggerClientEvent("jim-mechanic:client:applyTransmission", source, i-1) end)
end
for i = 1, 3 do
	QBCore.Functions.CreateUseableItem("brakes"..i, function(source, item) TriggerClientEvent("jim-mechanic:client:applyBrakes", source, i-1) end)
end

--Item Give/Remove (for performance items)
RegisterNetEvent('jim-mechanic:server:swapItem', function(level, current, item)
	local src = source
	if level then
		QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item..level+1, 1)
	end
	if current ~= -1 then
		if QBCore.Functions.GetPlayer(src).Functions.AddItem(item..current+1, 1) then
		end
	end
end)

function HasItem(source, items, amount)
	amount = amount or 1
  local Player = QBCore.Functions.GetPlayer(source)
  if not Player then return false end

	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player has required item^7 '^3"..tostring(items).."^7'") end
  local has = exports.ox_inventory:Search(source, 'count', items)
  return has >= amount
end


--General give take items
RegisterNetEvent('jim-mechanic:server:toggleItem', function(give, item, amount)
	local amount = amount or 1
	local remamount = amount
	local src = source
	if not give then
		if HasItem(src, item, amount) then -- check if you still have the item
			if QBCore.Functions.GetPlayer(src).Functions.GetItemByName(item).unique then -- If unique item, keep removing until gone
				while remamount > 0 do
					QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, 1)
					remamount -= 1
				end
				TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "remove", amount) -- Show removal item box when all are removed
				return
			end
			if QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, amount) then
				if Config.Debug then print("^5Debug^7: ^1Removing ^2from Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount)
			end
		else TriggerEvent("jim-mechanic:server:DupeWarn", item, src) end -- if not boot the player
	elseif give then
		if QBCore.Functions.GetPlayer(src).Functions.AddItem(item, amount) then
			if Config.Debug then print("^5Debug^7: ^4Giving ^2Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add", amount)
		end
	end
end)

AddEventHandler('onResourceStart', function(r)
  if GetCurrentResourceName() ~= r then return end
  exports.ox_inventory:RegisterStash('mechanic_safe', 'Mechanic Safe', 40, 4000000, nil, {mechanic = 0})
  local itemcheck = true
  --Check crafting recipes and their ingredients
  if Config.Crafting then
    for k, v in pairs(Crafting) do
      for i = 1, #v do
        for l, b in pairs(v[i]) do
          if l ~= "amount" and l ~= "job" then
            if not QBCore.Shared.Items[l] then
              print("^5Debug^7: ^3onResourceStart^7: ^2Missing Item from ^4Shared^7.^4Items^7: '^6"..l.."^7'")
              itemcheck = false
            end
            for j in pairs(b) do
              if not QBCore.Shared.Items[j] then
                print("^5Debug^7: ^3onResourceStart^7: ^2Missing Item from ^4Shared^7.^4Items^7: '^6"..j.."^7'")
                itemcheck = false
              end
            end
          end
        end
      end
    end
  end
	-- Check Stores for missing items
	if Config.Stores then
		for _, v in pairs(Stores) do
			for i = 1, #v.items do if not QBCore.Shared.Items[v.items[i].name] then print("^5Debug^7: ^3onResourceStart^7: ^2Missing Item from ^4Shared^7.^4Items^7: '^6"..v.items[i].name.."^7'") itemcheck = false end end
		end
	end
	-- Check if theres a missing item/mistake in the repair materials
	if not FreeRepair then
		if not QBCore.Shared.Items[Config.RepairEngine] then print("^5Debug^7: ^3onResourceStart^7: ^2Engine repair requested a item missing from the Shared^7: '"..Config.RepairEngine.."^7'") itemcheck = false end
		if not QBCore.Shared.Items[Config.RepairBody] then print("^5Debug^7: ^3onResourceStart^7: ^2Body repair requested a item missing from the Shared^7: '"..Config.RepairBody.."^7'") itemcheck = false end
		if useMechJob then
			if not QBCore.Shared.Items[Config.RepairRadiator] then print("^5Debug^7: ^3onResourceStart^7: ^2Radiator repair requested a item missing from the Shared^7: '^6"..Config.RepairRadiator.."^7'") itemcheck = false end
			if not QBCore.Shared.Items[Config.RepairAxle] then print("^5Debug^7: ^3onResourceStart^7: ^2Axle repair requested a item missing from the Shared^7: '^6"..Config.RepairAxle.."^7'") itemcheck = false end
			if not QBCore.Shared.Items[Config.RepairBrakes] then print("^5Debug^7: ^3onResourceStart^7: ^2Brakes repair requested a item missing from the Shared^7: '^6"..Config.RepairBrakes.."^7'") itemcheck = false end
			if not QBCore.Shared.Items[Config.RepairClutch] then print("^5Debug^7: ^3onResourceStart^7: ^2Clutch repair requested a item missing from the Shared^7: '^6"..Config.RepairClutch.."^7'") itemcheck = false end
			if not QBCore.Shared.Items[Config.RepairFuel] then print("^5Debug^7: ^3onResourceStart^7: ^2FuelTank repair requested a item missing from the Shared^7: '^6"..Config.RepairFuel.."^7'") itemcheck = false end
		end
	end
	-- Check for "mechboard" item
	if not QBCore.Shared.Items["mechboard"] then print("^5Debug^7: ^3onResourceStart^7: ^2Missing Item from ^4Shared^7.^4Items^7: '^6mechboard^7'") itemcheck = false end
	for k, v in pairs(Config.JobRoles) do
		if not QBCore.Shared.Jobs[v] then print("^5Debug^7: ^3onResourceStart^7: ^4Config^7.^4Jobroles ^2tried to find the missing job^7: '^6"..v.."^7'") end
	end
	--Success message if all there.
	if Config.Debug and itemcheck then print("^5Debug^7: ^3onResourceStart^7: ^2All items found in the shared^7!") end
end)
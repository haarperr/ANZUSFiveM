QBCore = exports["qb-core"]:GetCoreObject()
---@diagnostic disable-next-line: lowercase-global
ox_inventory = exports.ox_inventory
PlayerLoaded = false
PlayerData = {}
HouseData = {}
TempHouseID = nil
CurrentHouseID = nil
CurrentCops = 0
local IsReady = false

---@diagnostic disable-next-line: param-type-mismatch
AddStateBagChangeHandler("isLoggedIn", nil, function(_, _, value, _, _)
	if value then
		PlayerData = QBCore.Functions.GetPlayerData()
		if HouseData and next(HouseData) ~= nil then return end
		Init()
	else
		table.wipe(PlayerData)
	end
	PlayerLoaded = value
end)

AddEventHandler("onResourceStart", function(resourceName)
	if cache.resource ~= resourceName or not LocalPlayer.state.isLoggedIn then return end
	PlayerData = QBCore.Functions.GetPlayerData()
	PlayerLoaded = true
	Init()
end)

local IsDead = require "client.functions.Utils".IsDead

RegisterNetEvent("QBCore:Player:SetPlayerData", function(newPlayerData)
	PlayerData = newPlayerData
	if not IsInside then return end
	local houseid = CurrentHouseID
	if not houseid then return end
	local housedata = HouseData[houseid]
	if not housedata then return end
	if not housedata.target ~= GetPlayerServerId(PlayerId()) then return end
	if not IsDead() then return end
	TriggerServerEvent("qb-houserobbery:server:switchtarget", houseid)
end)

function UpdateConfig()
	HouseData = lib.callback.await("qb-houserobbery:server:getHousesConfig", false)
	Config.HouseLocation = lib.callback.await("qb-houserobbery:server:getConfig", false)
end

local Notify = require "client.functions.Utils".Notify

function Init()
	IsReady = lib.callback.await("qb-houserobbery:server:isconfigready", false)
	repeat
		Wait(100)
	until IsReady
	UpdateConfig()
	local list = {}
	for k, v in pairs(Config.Police) do
		if v then
			list[#list + 1] = k
		end
	end
	for _, v in pairs(Config.HouseLocation) do
		if Config.Debug then
			local function CreateBlip(x, y, z, sprite, color, text)
				local blip = AddBlipForCoord(x, y, z)
				SetBlipSprite(blip, sprite)
				SetBlipColour(blip, color)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(text)
				EndTextCommandSetBlipName(blip)
				return blip
			end
			CreateBlip(v.coords.x, v.coords.y, v.coords.z, 40, 2, string.format("House Robbery: %s", v.id))
		end
		local opts = {
			{
				label = "Enter House",
				icon = "fas fa-home",
				onSelect = function()
					print(v.id)
					if HouseData[v.id]?.locked then
						return Notify("Locked", "This house is locked", "error")
					else
						return EnterHouse(v.id)
					end
				end,
				distance = 1.5
			},
			{
				label = "Lock House",
				icon = "fas fa-lock",
				onSelect = function()
					TriggerServerEvent("qb-houserobbery:server:resetHouse", v.id)
					Notify("Locked", "Succesfully locked the house", 'success')
				end,
				canInteract = function()
					return PlayerData.job.onduty and not HouseData[v.id].locked
				end,
				distance = 1.5,
				groups = list
			}
		}
		exports.ox_target:addBoxZone({
			coords = v.coords.xyz,
			size = vec3(1.3, 1.3, 2.5),
			rotation = v.coords.w,
			debug = Config.Debug,
			drawSprite = false,
			options = opts
		})
	end
	CreateThread(function ()
		while true do
			local coords = GetEntityCoords(cache.ped)
			for k, v in pairs(HouseData) do
				local housecoords = v?.coords
				local dist = #(coords - housecoords.xyz)
				if dist <= 2.5 and TempHouseID ~= k then
					TempHouseID = k
					break;
				end
			end
			Wait(1000)
		end
	end)
end

RegisterNetEvent('police:SetCopCount', function(amount)
	CurrentCops = amount
end)

RegisterNetEvent("qb-houserobbery:client:configready", function(status)
	IsReady = status
end)

local QBCore = exports['qb-core']:GetCoreObject()
local currentJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
		currentJob = PlayerData.job
	end)
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
	TriggerServerEvent("qb-pefcl:server:UnloadPlayer")
end)

RegisterNetEvent("pefcl:newDefaultAccountBalance", function(balance)
	TriggerServerEvent("qb-pefcl:server:SyncMoney")
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(newJob)
	print(json.encode(newJob))
	TriggerServerEvent("qb-pefcl:server:OnJobUpdate", newJob)
	currentJob = newJob
end)

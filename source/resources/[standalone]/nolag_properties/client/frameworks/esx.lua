if Config.Framework.Active ~= 1 then return end



local esx_name = "es_extended"
OnPlayerLoadedEvent = "esx:playerLoaded"
OnPlayerUnloadedEvent = "esx:onPlayerLogout"
OnJobUpdateEvent = "esx:setJob"

Framework = {}
local ESX = exports[esx_name]:getSharedObject()
local ESXPlayerData = ESX.GetPlayerData()

PlayerData = {
    insideYards = {}, -- don't change this
    insideMlos = {}, -- don't change this
    insideProperty = false, -- don't change this
    currentProperty = nil, -- don't change this
    identifier = ESXPlayerData.identifier,
    job = ESXPlayerData.job,
}

Framework = {
    Notify = function(notifyData)
        lib.notify(notifyData)
    end,
    showTextUI = function(text, options)
        lib.showTextUI(text, options)
    end,
    hideTextUI = function()
        lib.hideTextUI()
    end,
    isPlayerAuthorized = function()
        for jobName, grade in pairs(Config.RealEstateJobs) do
            if jobName == PlayerData.job.name and PlayerData.job.grade >= grade then
                return true
            end
        end
        return false
    end,
    isPlayerAuthorizedToRaid = function()
        for jobName, grade in pairs(Config.PoliceRaid.Jobs) do
            if jobName == PlayerData.job.name and PlayerData.job.grade >= grade then
                return true
            end
        end
        return false
    end,
    isPlayerAuthorizedToDeleteProperty = function()
        return Framework.isPlayerAuthorized()
    end,
    isPlayerAuthorizedToLockdown = function()
        return Framework.isPlayerAuthorizedToRaid()
    end,
}

RegisterNetEvent(OnPlayerLoadedEvent, function(xPlayer)
    ESXPlayerData = xPlayer
    PlayerData.identifier = ESXPlayerData.identifier
    PlayerData.job = ESXPlayerData.job
end)

RegisterNetEvent(OnPlayerUnloadedEvent, function()
    PlayerData.identifier = nil
    PlayerData.job = nil
end)

RegisterNetEvent(OnJobUpdateEvent, function(PlayerJob)
    PlayerData.job = PlayerJob
end)

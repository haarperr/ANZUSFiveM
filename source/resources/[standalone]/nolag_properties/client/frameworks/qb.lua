if Config.Framework.Active ~= 2 then return end



local qb_name = "qb-core"
OnPlayerLoadedEvent = "QBCore:Client:OnPlayerLoaded"
OnPlayerUnloadedEvent = "QBCore:Client:OnPlayerUnload"
OnJobUpdateEvent = "QBCore:Client:OnJobUpdate"

Framework = {}
local QBCore = exports[qb_name]:GetCoreObject()
local QBPlayerData = QBCore.Functions.GetPlayerData()

PlayerData = {
    insideYards = {}, -- don't change this
    insideMlos = {}, -- don't change this
    insideProperty = false, -- don't change this
    currentProperty = nil, -- don't change this
    identifier = QBPlayerData.citizenid,
    job = QBPlayerData.job,
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
            if jobName == PlayerData.job.name and PlayerData.job.grade.level >= grade then
                return true
            end
        end
        return false
    end,
    isPlayerAuthorizedToRaid = function()
        for jobName, grade in pairs(Config.PoliceRaid.Jobs) do
            if jobName == PlayerData.job.name and PlayerData.job.grade.level >= grade then
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

RegisterNetEvent(OnPlayerLoadedEvent, function()
    QBPlayerData = QBCore.Functions.GetPlayerData()
    PlayerData.identifier = QBPlayerData.citizenid
    PlayerData.job = QBPlayerData.job
end)

RegisterNetEvent(OnPlayerUnloadedEvent, function()
    PlayerData.identifier = nil
    PlayerData.job = nil
end)

RegisterNetEvent(OnJobUpdateEvent, function(PlayerJob)
    PlayerData.job = PlayerJob
end)
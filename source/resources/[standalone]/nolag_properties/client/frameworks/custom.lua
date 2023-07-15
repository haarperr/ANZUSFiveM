if Config.Framework.Active ~= 3 then return end



local framework_name = "custom-framework"
OnPlayerLoadedEvent = "esx:playerLoaded"
OnPlayerUnloadedEvent = "esx:onPlayerLogout"
OnJobUpdateEvent = "esx:setJob"

Framework = {}
local CustomFramework = exports[framework_name]:GetCoreObject()
local CustomPlayerData = CustomFramework.Functions.GetPlayerData()

PlayerData = {
    insideYards = {}, -- don't change this
    insideMlos = {}, -- don't change this
    insideProperty = false, -- don't change this
    currentProperty = nil, -- don't change this
    identifier = CustomPlayerData.citizenid,
    job = CustomPlayerData.job,
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

RegisterNetEvent(OnPlayerLoadedEvent, function()
    CustomPlayerData = CustomFramework.Functions.GetPlayerData()
    PlayerData.identifier = CustomPlayerData.citizenid
    PlayerData.job = CustomPlayerData.job
end)

RegisterNetEvent(OnPlayerUnloadedEvent, function()
    PlayerData.identifier = nil
    PlayerData.job = nil
end)

RegisterNetEvent(OnJobUpdateEvent, function()
    CustomPlayerData = CustomFramework.Functions.GetPlayerData()
    PlayerData.job = CustomPlayerData.job
end)
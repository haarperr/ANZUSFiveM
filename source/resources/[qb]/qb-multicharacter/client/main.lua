local QBCore = exports['qb-core']:GetCoreObject()
local PreviewCam
local RandomLocation = Config.Locations[math.random(1, #Config.Locations)]

local function SetupPreviewCam(bool)
    if bool then
        DoScreenFadeIn(1000)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        FreezeEntityPosition(cache.ped, false)
        PreviewCam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', RandomLocation.CamCoords.x, RandomLocation.CamCoords.y, RandomLocation.CamCoords.z, -6.0, 0.0, RandomLocation.CamCoords.w, 40.0, false, 0)
        SetCamActive(PreviewCam, true)
        SetCamUseShallowDofMode(PreviewCam, true)
        SetCamNearDof(PreviewCam, 0.4)
        SetCamFarDof(PreviewCam, 1.8)
        SetCamDofStrength(PreviewCam, 0.7)
        RenderScriptCams(true, false, 1, true, true)
        while DoesCamExist(PreviewCam) do
            SetUseHiDof()
            Wait(0)
        end
    else
        SetTimecycleModifier('default')
        SetCamActive(PreviewCam, false)
        DestroyCam(PreviewCam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(cache.ped, false)
    end
end

local function toggleUI(bool)
    local Amount = lib.callback.await('qb-multicharacter:callback:GetNumberOfCharacters', false)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = 'ui',
        toggle = bool,
        nChar = Amount,
        enableDeleteButton = Config.EnableDeleteButton,
        translations = Translations.ui
    })
    SetupPreviewCam(bool)
end

local function RandomClothes(Entity)
    for i = 0, 11 do
        SetPedComponentVariation(Entity, i, 0, 0, 0)
    end
    for i = 0, 7 do
        ClearPedProp(Entity, i)
    end
    SetPedHeadBlendData(Entity, math.random(0, 45), math.random(0, 45), 0, math.random(0, 15), math.random(0, 15), 0, (math.random(0, 100) / 100), (math.random(0, 100) / 100), 0, true)
    SetPedComponentVariation(Entity, 4, math.random(0, 110), 0, 0)
    SetPedComponentVariation(Entity, 2, math.random(0, 45), 0, 0)
    SetPedHairColor(Entity, math.random(0, 45), math.random(0, 45))
    SetPedHeadOverlay(Entity, 2, math.random(0, 34), 1.0)
    SetPedHeadOverlayColor(Entity, 2, 1, math.random(0, 45), 0)
    SetPedComponentVariation(Entity, 3, math.random(0, 160), 0, 2)
    SetPedComponentVariation(Entity, 8, math.random(0, 160), 0, 2)
    SetPedComponentVariation(Entity, 11, math.random(0, 340), 0, 2)
    SetPedComponentVariation(Entity, 6, math.random(0, 78), 0, 2)
end

RegisterNetEvent('qb-multicharacter:client:closeNUIdefault', function() -- This event is only for no starting apartments
    SetNuiFocus(false, false)
    DoScreenFadeOut(500)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), Config.DefaultSpawn.x, Config.DefaultSpawn.y, Config.DefaultSpawn.z)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
    TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
    Wait(500)
    toggleUI()
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(250)
    TriggerEvent('qb-weathersync:client:EnableSync')
    TriggerEvent('qb-clothes:client:CreateFirstCharacter')
end)

lib.callback.register('qb-multicharacter:callback:defaultSpawn', function()
    SetNuiFocus(false, false)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(0) end
    toggleUI(false)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
    TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
    exports.spawnmanager:spawnPlayer()
    while not IsScreenFadedIn() do Wait(0) end
    return true
end)

RegisterNetEvent('qb-multicharacter:client:chooseChar', function()
    SetNuiFocus(false, false)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(0) end
    FreezeEntityPosition(cache.ped, true)
    Wait(1000)
    SetEntityCoords(cache.ped, RandomLocation.PedCoords.x, RandomLocation.PedCoords.y, RandomLocation.PedCoords.z, false, false, false, false)
    SetEntityHeading(cache.ped, RandomLocation.PedCoords.w)
    RandomClothes(cache.ped)
    Wait(1500)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    toggleUI(true)
end)

RegisterNUICallback('selectCharacter', function(data, cb)
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('qb-multicharacter:server:loadUserData', cData)
    toggleUI(false)
    cb('ok')
end)

RegisterNUICallback('setupCharacters', function(_, cb)
    local Result = lib.callback.await('qb-multicharacter:callback:GetCurrentCharacters', false)
    SendNUIMessage({
        action = 'setupCharacters',
        characters = Result
    })
    cb('ok')
end)

RegisterNUICallback('removeBlur', function(_, cb)
    SetTimecycleModifier('default')
    cb('ok')
end)

RegisterNUICallback('previewPed', function(Ped, cb)
    local CID = Ped.Data and Ped.Data.citizenid or nil
    Clothing, Model, Gender = lib.callback.await('qb-multicharacter:callback:UpdatePreviewPed', false, CID)
    if Model then
        local CurrentModel = GetEntityModel(cache.ped)
        if CurrentModel ~= `mp_m_freemode_01` and Gender == 0 then
            while not HasModelLoaded(Model) do RequestModel(Model) Wait(0) end
            SetPlayerModel(cache.playerId, Model)
        elseif CurrentModel ~= `mp_f_freemode_01` and Gender == 1 then
            while not HasModelLoaded(Model) do RequestModel(Model) Wait(0) end
            SetPlayerModel(cache.playerId, Model)
        end
        SetModelAsNoLongerNeeded(Model)
        cache:set('ped', PlayerPedId())
    end
    if Clothing then
        exports["illenium-appearance"]:setPedAppearance(cache.ped, json.decode(Clothing))
    else
        RandomClothes(cache.ped)
    end
    cb('ok')
end)

RegisterNUICallback('createNewCharacter', function(data, cb)
    local cData = data
    DoScreenFadeOut(150)
    if cData.gender == Lang:t('ui.male') then
        cData.gender = 0
    elseif cData.gender == Lang:t('ui.female') then
        cData.gender = 1
    end
    TriggerServerEvent('qb-multicharacter:server:createCharacter', cData)
    toggleUI(false)
    cb('ok')
end)

RegisterNUICallback('removeCharacter', function(data, cb)
    TriggerServerEvent('qb-multicharacter:server:deleteCharacter', data.citizenid)
    TriggerEvent('qb-multicharacter:client:chooseChar')
    cb('ok')
end)

CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsSessionStarted() then
            exports.spawnmanager:setAutoSpawn(false)
            Wait(250)
			TriggerEvent('qb-multicharacter:client:chooseChar')
            while not HasModelLoaded(`mp_m_freemode_01`) do RequestModel(`mp_m_freemode_01`) Wait(0) end
            while GetEntityModel(cache.ped) ~= `mp_m_freemode_01` do SetPlayerModel(cache.playerId, `mp_m_freemode_01`) Wait(0) end
            SetModelAsNoLongerNeeded(`mp_m_freemode_01`)
			break
		end
	end
end)

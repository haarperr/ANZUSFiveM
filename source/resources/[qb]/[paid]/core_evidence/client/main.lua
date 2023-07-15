--CORE EVIDENCE 0.1

local QBCore = exports['qb-core']:GetCoreObject()

local inAnalysisZone = false
local showingText = false
local showingReport = false

local bullets = {}
local casings = {}
local blood = {}

local update = true
local last = 0
local time = 0
local analyzing = false
local analyzingDone = false
local ignore = false
local lastWeapon = { hash = nil, cartridge = nil, weaponName = nil }

local job = ""

local canAccess = false
local evidence = {}

local CurrentWeapon = nil


local function getWeaponName(hash)
  local weaponTypeGroup = GetWeapontypeGroup(hash)
  if weaponTypeGroup == -957766203 then return 'SMG' end
  if weaponTypeGroup == 416676503 then return 'Pistol' end
  if weaponTypeGroup == 860033945 then return 'Shotgun' end
  if weaponTypeGroup == 970310034 then return 'Rifle' end
  if weaponTypeGroup == 1159398588 then return 'LMG' end
  if weaponTypeGroup == -1212426201 then return 'Sniper' end
  if weaponTypeGroup == -1569042529 then return 'Heavy' end

  return weaponTypeGroup
end

-- Get Impact of Bullet using Raycast
local function RotationToDirection(deg)
  local rad_x = deg['x'] * 0.0174532924
  local rad_z = deg['z'] * 0.0174532924

  local dir_x = -math.sin(rad_z) * math.cos(rad_x)
  local dir_y = math.cos(rad_z) * math.cos(rad_x)
  local dir_z = math.sin(rad_x)
  local dir = vector3(dir_x, dir_y, dir_z)
  return dir
end

local function RaycastFromPlayer()
  local playerPed = PlayerPedId()
  local camCoord = GetGameplayCamCoord()
  local camRot = GetGameplayCamRot(0)

  local rayHandle = StartShapeTestRay(camCoord, camCoord + RotationToDirection(camRot) * 1000, -1, playerPed)
  local status, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

  return hit, endCoords, surfaceNormal, entityHit
end


local function DrawText3D(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoord())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100

  if onScreen then
    SetTextColour(255, 255, 255, 255)
    SetTextScale(0.0 * scale, 0.35 * scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextCentre(true)

    SetTextDropshadow(1, 1, 1, 1, 255)

    BeginTextCommandWidth("STRING")
    AddTextComponentString(text)
    local height = GetTextScaleHeight(0.55 * scale, 4)
    local width = EndTextCommandGetWidth(4)

    SetTextEntry("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(_x, _y)
  end
end

local function LoadAnimation(dict)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Wait(1)
  end
end

CreateThread(function()
  while true do
    Wait(1)

    local playerid = PlayerId()

    if not IsPlayerFreeAiming(playerid) then
      update = true
      Wait(500)
    else
      local playerPed = PlayerPedId()

      if IsPlayerFreeAiming(playerid) and GetSelectedPedWeapon(playerPed) == `WEAPON_FLASHLIGHT` then
        if update then
          QBCore.Functions.TriggerCallback("core_evidence:getData", function(ans)
            bullets = ans.bullets
            casings = ans.casings
            blood = ans.blood
            time = ans.time
          end)
          update = false
        end
        local coords = GetEntityCoords(playerPed)
        for t, s in pairs(bullets) do
          local distance = #(s.coords - coords)
          if distance < 30 then
            DrawMarker(
              1,
              s.coords[1],
              s.coords[2],
              s.coords[3],
              0.0,
              0.0,
              0.0,
              0,
              0.0,
              0.0,
              0.2,
              0.2,
              0.2,
              255,
              41,
              41,
              100,
              false,
              true,
              2,
              false,
              false,
              false,
              false
            )
          end

          if distance < 5 then
            DrawText3D(s.coords[1], s.coords[2], s.coords[3] + 0.57, Config.Text["bullet_hologram"])

            local passed = time - t

            if passed > 300 and passed < 600 then
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] + 0.5, Config.Text["shell_after_5_minutes"])
            elseif passed > 600 then
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] + 0.5, Config.Text["shell_after_10_minutes"])
            else
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] + 0.5, Config.Text["shell_after_0_minutes"])
            end
          end

          if distance < 1.5 then
            local dict, anim = "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@", "plant_floor"
            if canAccess then
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] + 0.65, Config.Text["pick_up_evidence_text"])
              if IsControlJustReleased(0, Config.PickupEvidenceKey) then
                if #evidence < 10 then
                  LoadAnimation(dict)
                  TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                  Wait(1000)
                  bullets[t] = nil
                  evidence[#evidence + 1] = { type = "bullet", evidence = s.reportInfo }
                  TriggerServerEvent("core_evidence:server:removeBullet", t)
                  QBCore.Functions.Notify(string.gsub(Config.Text["evidence_colleted"], "{number}", #evidence), 'primary')
                  PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                else
                  QBCore.Functions.Notify(Config.Text["no_more_space"], 'error')
                end
              end
            else
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] + 0.65, Config.Text["remove_evidence"])
              if IsControlJustReleased(0, Config.PickupEvidenceKey) then
                if (time - t) > Config.TimeBeforeCrimsCanDestory then
                  LoadAnimation(dict)
                  TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                  Wait(1000)
                  bullets[t] = nil

                  TriggerServerEvent("core_evidence:server:removeBullet", t)
                  QBCore.Functions.Notify(Config.Text["evidence_removed"], 'success')
                  PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                else
                  QBCore.Functions.Notify(Config.Text["cooldown_before_pickup"], 'error')
                end
              end
            end
          end
        end

        for t, s in pairs(blood) do
          local distance = #(s.coords - coords)
          if distance < 30 then
            DrawMarker(
              1,
              s.coords[1],
              s.coords[2],
              s.coords[3] - 0.9,
              0.0,
              0.0,
              0.0,
              0,
              0.0,
              0.0,
              0.2,
              0.2,
              0.2,
              255,
              41,
              41,
              100,
              false,
              true,
              2,
              false,
              false,
              false,
              false
            )
          end

          if distance < 5 then
            DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.5, Config.Text["blood_hologram"])

            local passed = time - t

            if passed > 300 and passed < 600 then
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.57, Config.Text["blood_after_5_minutes"])
            elseif passed > 600 then
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.57, Config.Text["blood_after_10_minutes"])
            else
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.57, Config.Text["blood_after_0_minutes"])
            end
          end

          if distance < 1 then
            local dict, anim = "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@", "plant_floor"
            if canAccess then
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.65, Config.Text["pick_up_evidence_text"])
              if IsControlJustReleased(0, Config.PickupEvidenceKey) then
                if #evidence < 10 then
                  LoadAnimation(dict)
                  TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                  Wait(1000)
                  blood[t] = nil
                  evidence[#evidence + 1] = { type = "blood", evidence = s.reportInfo }
                  TriggerServerEvent("core_evidence:removeBlood", t)
                  QBCore.Functions.Notify(string.gsub(Config.Text["evidence_colleted"], "{number}", #evidence), 'primary')
                  PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                else
                  QBCore.Functions.Notify(Config.Text["no_more_space"], 'error')
                end
              end
            else
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.65, Config.Text["remove_evidence"])
              if IsControlJustReleased(0, Config.PickupEvidenceKey) then
                if (time - t) > Config.TimeBeforeCrimsCanDestory then
                  LoadAnimation(dict)
                  TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                  Wait(1000)
                  blood[t] = nil

                  TriggerServerEvent("core_evidence:removeBlood", t)
                  QBCore.Functions.Notify(Config.Text["evidence_removed"], 'success')
                  PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                else
                  QBCore.Functions.Notify(Config.Text["cooldown_before_pickup"], 'error')
                end
              end
            end
          end
        end

        for t, s in pairs(casings) do
          local distance = #(s.coords - coords)
          if distance < 30 then
            DrawMarker(
              3,
              s.coords[1],
              s.coords[2],
              s.coords[3] - 0.9,
              0.0,
              0.0,
              0.0,
              0,
              0.0,
              0.0,
              0.15,
              0.15,
              0.2,
              66,
              135,
              245,
              100,
              false,
              true,
              2,
              false,
              false,
              false,
              false
            )
          end

          if distance < 5 then
            DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.5, string.gsub(Config.Text["shell_hologram"], "{guncategory}", s.weapon))

            local passed = time - t
            if passed > 300 and passed < 600 then
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.57, Config.Text["shell_after_5_minutes"])
            elseif passed > 600 then
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.57, Config.Text["shell_after_10_minutes"])
            else
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.57, Config.Text["shell_after_0_minutes"])
            end
          end

          if distance < 1 then
            local dict, anim = "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@", "plant_floor"
            if canAccess then
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.65, Config.Text["pick_up_evidence_text"])
              if IsControlJustReleased(0, Config.PickupEvidenceKey) then
                if #evidence < 10 then
                  LoadAnimation(dict)
                  TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                  Wait(1000)
                  casings[t] = nil
                  evidence[#evidence + 1] = { type = "casing", evidence = s.reportInfo }
                  TriggerServerEvent("core_evidence:server:removeCasing", t)
                  QBCore.Functions.Notify(string.gsub(Config.Text["evidence_colleted"], "{number}", #evidence), 'primary')
                  PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                else
                  QBCore.Functions.Notify(Config.Text["no_more_space"], 'error')
                end
              end
            else
              DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.65, Config.Text["remove_evidence"])
              if IsControlJustReleased(0, Config.PickupEvidenceKey) then
                if (time - t) > Config.TimeBeforeCrimsCanDestory then
                  LoadAnimation(dict)
                  TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
                  Wait(1000)
                  casings[t] = nil

                  TriggerServerEvent("core_evidence:server:removeCasing", t)
                  QBCore.Functions.Notify(Config.Text["evidence_removed"], 'success')
                  PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                else
                  QBCore.Functions.Notify(Config.Text["cooldown_before_pickup"], 'error')
                end
              end
            end
          end
        end
      end
    end
  end
end)

RegisterNUICallback("close", function(data)
  local ped = PlayerPedId()
  SetNuiFocus(false, false)
  ClearPedTasks(ped)
end)

RegisterNUICallback("remove", function(data)
  local e = data["evidence"]

  TriggerServerEvent("core_evidence:deleteEvidenceFromStorage", e)
  QBCore.Functions.Notify(Config.Text["evidence_deleted_from_archive"], 'success')
end)

local function openWeaponSerialInput()
  local input = lib.inputDialog('Weapon Serial Lookup', {
    { type = "input", label = "Serial Number", placeholder = "1Ad3-n1Ax" },
  })

  if not input then return end
  local serial = input[1]

  if serial == nil then return end

  QBCore.Functions.TriggerCallback('core_evidence:findWeaponOwner', function(data)
    if data then
      QBCore.Functions.Notify('This firearm is registered to ' .. data.citizenid .. ' - ' .. data.name, 'success', 10000)
    else
      QBCore.Functions.Notify('That serial does not come back to a registered firearm', 'error', 10000)
    end
  end, serial)
end

CreateThread(function()
  local EvidenceAnalysisZones = {}
  for k, v in ipairs(Config.EvidenceAnalysisLocations) do
    EvidenceAnalysisZones[#EvidenceAnalysisZones + 1] = BoxZone:Create(vector3(v.coords.x, v.coords.y, v.coords.z), v.length, v.width,
      {
        name = "evidence_analysis_" .. k,
        heading = v.coords.w,
        debugPoly = false,
        minZ = v.coords.z - 1,
        maxZ = v.coords.z + 1,
      })
  end
  local EvidenceAnalysisCombo = ComboZone:Create(EvidenceAnalysisZones, { name = "EvidenceAnalysisZones", debugPoly = false })
  EvidenceAnalysisCombo:onPlayerInOut(function(isPointInside, point)
    if canAccess then
      if isPointInside then
        inAnalysisZone = true
      else
        inAnalysisZone = false
        showingText = false
        exports['qb-core']:HideText()
      end
    end
  end)

  for k, v in ipairs(Config.ComputerSearch) do
    exports['qb-target']:AddBoxZone('computer_lookup_' .. k, vector3(v.coords.x, v.coords.y, v.coords.z), v.length, v.width, {
      name = 'computer_lookup_' .. k,
      heading = v.coords.w,
      debugPoly = false,
      minZ = v.coords.z - 1,
      maxZ = v.coords.z + 1,
    }, {
      options = {
        {
          type = "client",
          action = function()
            openWeaponSerialInput()
          end,
          icon = "fa-light fa-folder-magnifying-glass",
          label = "Search Serial Number",
          job = { ["lspd"] = 0, ["bcso"] = 0 }
        },
      },
      distance = 2,
    })
  end
end)

CreateThread(function()
  while true do
    local sleep = 250
    if inAnalysisZone then
      sleep = 5
      if not showingText then
        showingText = true
        if not analyzing and not analyzingDone then
          exports['qb-core']:DrawText(Config.Text["analyze_evidence"], 'left')
        elseif analyzingDone then
          exports['qb-core']:DrawText(Config.Text["read_evidence_report"], 'left')
        else
          exports['qb-core']:DrawText(Config.Text["evidence_being_analyzed_hologram"], 'left')
        end
      end

      if IsControlJustReleased(0, 38) and not analyzing then
        if not analyzingDone then
          if #evidence > 0 then
            CreateThread(function()
              QBCore.Functions.Notify(Config.Text["evidence_being_analyzed"], 'primary')

              analyzing = true
              Wait(Config.TimeToAnalyze)

              analyzingDone = true
              analyzing = false
            end)
          else
            QBCore.Functions.Notify(Config.Text["no_evidence_to_analyze"], 'primary')
          end
        elseif analyzingDone then
          TriggerServerEvent("core_evidence:addEvidenceToStorage", json.encode(evidence))
          if Config.PlayClipboardAnimation then
            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
          end
          analyzingDone = false
          evidence = {}
        end
      end
    end
    Wait(sleep)
  end
end)


CreateThread(function()
  while true do
    Wait(1)

    if canAccess then
      local ped = PlayerPedId()
      local veh = GetVehiclePedIsTryingToEnter(ped)
      local seat = GetSeatPedIsTryingToEnter(ped)

      if veh ~= 0 then
        local lastped = GetLastPedInVehicleSeat(veh, seat)
        local gloves = GetPedDrawableVariation(lastped, 3)

        if lastped ~= ped then
          if gloves > 15 and gloves ~= 112 and gloves ~= 113 and gloves ~= 114 then
            last = 0
          else
            last = lastped
          end
        end
      end
    end
  end
end)

if Config.RainRemovesEvidence then
  CreateThread(function()
    while true do
      Wait(5000)
      if GetRainLevel() > 0.3 then
        TriggerServerEvent("core_evidence:removeEverything")
        Wait(10000)
      end
    end
  end)
end


CreateThread(function()
  while true do
    Wait(10)

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    if HasPedBeenDamagedByWeapon(ped, 0, 2) then
      ClearEntityLastDamageEntity(ped)
      if Config.ShowBloodSplatsOnGround then
        local stain = CreateObject(GetHashKey("p_bloodsplat_s"), coords[1], coords[2], coords[3] - 2.0, true, true, false)

        PlaceObjectOnGroundProperly(stain)
        local stainCoords = GetEntityCoords(stain)
        SetEntityCoords(stain, stainCoords[1], stainCoords[2], stainCoords[3] - 0.25)
        SetEntityAsMissionEntity(stain, true, true)
        SetEntityRotation(stain, -90.0, 0.0, 0.0, 2, false)
        FreezeEntityPosition(stain, true)
      end

      local var1, var2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
      local hash1 = GetStreetNameFromHashKey(var1)
      local hash2 = GetStreetNameFromHashKey(var2)

      TriggerServerEvent("core_evidence:saveBlood", hash1 .. ' ' .. hash2, coords, GetInteriorFromEntity(ped))
      Wait(2000)
    end

    if IsPedShooting(ped) and not ignore then
      local var1, var2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
      local hash1 = GetStreetNameFromHashKey(var1)
      local hash2 = GetStreetNameFromHashKey(var2)
      local selectedWeapon = GetSelectedPedWeapon(ped)
      local weaponName = getWeaponName(selectedWeapon)

      local hit, endcoords, surfaceNormal, entityHit = RaycastFromPlayer()
      if hit == 1 then
        TriggerServerEvent('core_evidence:server:saveBullet', hash1 .. ' ' .. hash2, endcoords, CurrentWeapon.metadata.cartridge, GetInteriorFromEntity(ped),
          CurrentWeapon.metadata.serial)
      end
      TriggerServerEvent("core_evidence:server:saveCasing", hash1 .. ' ' .. hash2, coords, CurrentWeapon.metadata.cartridge, GetInteriorFromEntity(ped), weaponName,
        CurrentWeapon.metadata.serial)
    end
  end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  job = QBCore.Functions.GetPlayerData().job.name
  for k, _ in pairs(Config.JobRequired) do
    if job == k then
      canAccess = true
    end
  end
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(j)
  job = j.name

  for k, _ in pairs(Config.JobRequired) do
    if job == k then
      canAccess = true
    end
  end
end)

RegisterNetEvent("core_evidence:addFingerPrint", function(report)
  CreateThread(function()
    QBCore.Functions.Notify(Config.Text["analyzing_car"], 'primary')

    local dict, anim = "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle"
    LoadAnimation(dict)
    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)

    Wait(Config.TimeToFindFingerprints)

    if #evidence < 10 then
      evidence[#evidence + 1] = { type = "fingerprint", evidence = report }

      QBCore.Functions.Notify(string.gsub(Config.Text["evidence_colleted"], "{number}", #evidence), 'success')
      PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    else
      QBCore.Functions.Notify(Config.Text["no_more_space"], 'error')
    end
  end)
end)

RegisterNetEvent("core_evidence:unmarkedBullets", function(value)
  ignore = value
end)

RegisterNetEvent("core_evidence:checkForFingerprints", function()
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    TriggerServerEvent("core_evidence:LastInCar", NetworkGetNetworkIdFromEntity(last))
  else
    QBCore.Functions.Notify(Config.Text["not_in_vehicle"], 'error')
  end
end)

RegisterNetEvent('core_evidence:client:OpenReport', function(result)
  if not result.data then return end
  if showingReport then return end

  SendNUIMessage({ type = "showReport", evidence = json.decode(result.data) })

  CreateThread(function()
    local ped = PlayerPedId()
    showingReport = true
    while showingReport do
      if IsControlJustReleased(0, Config.CloseReportKey) then
        SendNUIMessage({ type = "close" })
        ClearPedTasks(ped)
        showingReport = false
        break
      end
      Wait(1)
    end
  end)
end)

AddEventHandler('ox_inventory:currentWeapon', function(currentWeapon)
  CurrentWeapon = currentWeapon
end)

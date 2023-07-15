local QBCore = exports['qb-core']:GetCoreObject()
local availableJobs = {
  unemployed = "Unemployed",
  trucker = "Trucker",
  taxi = "Taxi",
  -- tow = "Tow Truck",
  -- reporter = "News Reporter",
  garbage = "Garbage Collector",
  bus = "Bus Driver",
  cropdusting = "Crop Dusting",
  -- hotdog = "Hot Dog Stand",
}

-- Functions

local function getClosestHall(pedCoords)
  local distance = #(pedCoords - Config.Cityhalls[1].coords)
  local closest = 1
  for i = 1, #Config.Cityhalls do
    local hall = Config.Cityhalls[i]
    local dist = #(pedCoords - hall.coords)
    if dist < distance then
      distance = dist
      closest = i
    end
  end
  return closest
end

-- local function getClosestSchool(pedCoords)
--     local distance = #(pedCoords - Config.DrivingSchools[1].coords)
--     local closest = 1
--     for i = 1, #Config.DrivingSchools do
--         local school = Config.DrivingSchools[i]
--         local dist = #(pedCoords - school.coords)
--         if dist < distance then
--             distance = dist
--             closest = i
--         end
--     end
--     return closest
-- end

-- Callbacks

lib.callback.register('qb-cityhall:server:receiveJobs', function(source)
  return availableJobs
end)

lib.callback.register('qb-cityhall:retrievePlates', function(source)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)

  local res = MySQL.query.await([[
    SELECT mdtv.plate from `mdt_vehicleinfo` mdtv JOIN `character_vehicles` cv ON mdtv.`plate` = cv.`plate` WHERE mdtv.`plate_stolen` = 1 AND cv.`owner` = ?
  ]], { Player.PlayerData.citizenid })

  return res
end)

---@param data {plate: string}
RegisterNetEvent('qb-cityhall:buyNewPlate', function(data)
  local src = source
  if not data.plate then return end
  local Player = QBCore.Functions.GetPlayer(src)

  local success = Player.Functions.RemoveMoney('cash', Config.NewPlateCost)
  if not success then return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'You do not have enough cash on you' }) end

  success = exports.ox_inventory:AddItem(src, 'numberplate', 1, { description = ('Plate: %s'):format(data.plate), plate = data.plate })
  if not success then return TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'You do not have enough space to carry a numberplate' }) end

  MySQL.update.await('UPDATE `mdt_vehicleinfo` mdtv SET `plate_stolen` = 0 WHERE plate = ?', { data.plate })

  TriggerClientEvent('ox_lib:notify', src, { type = 'success', description = 'Successfully purchased a new plate' })
end)

-- Events

RegisterNetEvent('qb-cityhall:server:requestId', function(item, hall)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end
  local itemInfo = Config.Cityhalls[hall].licenses[item]
  if not Player.Functions.RemoveMoney("cash", itemInfo.cost) then
    return TriggerClientEvent('ox_lib:notify', src, { description = ('You don\'t have enough money on you, you need %s cash'):format(itemInfo.cost), type = 'error' })
  end

  if item == "id_card" then
    exports['um-idcard']:CreateMetaLicense(src, 'id_card')
  elseif item == "driver_license" then
    exports['um-idcard']:CreateMetaLicense(src, 'driver_license')
  elseif item == "firearm_license" then
    exports['um-idcard']:CreateMetaLicense(src, 'firearm_license')
  elseif item == "lspd_id" then
    exports['um-idcard']:CreateMetaLicense(src, 'lspd_id')
  elseif item == "casino_license" then
    if not Player.PlayerData.metadata.licences['casino'] then
      Player.PlayerData.metadata.licences['casino'] = true
      Player.Functions.SetMetaData('licences', Player.PlayerData.metadata.licences)
    end
    exports['um-idcard']:CreateMetaLicense(src, 'casino_license')
  else
    return false -- DropPlayer(src, 'Attempted exploit abuse')
  end

  TriggerClientEvent('ox_lib:notify', src, { description = ('You have received your license for $%s'):format(itemInfo.cost), type = 'success' })
end)

-- RegisterNetEvent('qb-cityhall:server:sendDriverTest', function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     if not Player then return end
--     local ped = GetPlayerPed(src)
--     local pedCoords = GetEntityCoords(ped)
--     local closestDrivingSchool = getClosestSchool(pedCoords)
--     local instructors = Config.DrivingSchools[closestDrivingSchool].instructors
--     for i = 1, #instructors do
--         local citizenid = instructors[i]
--         local SchoolPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
--         if SchoolPlayer then
--             TriggerClientEvent("qb-cityhall:client:sendDriverEmail", SchoolPlayer.PlayerData.source, Player.PlayerData.charinfo)
--         else
--             local mailData = {
--                 sender = "Township",
--                 subject = "Driving lessons request",
--                 message = "Hello,<br><br>We have just received a message that someone wants to take driving lessons.<br>If you are willing to teach, please contact them:<br>Name: <strong>" .. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. "<br />Phone Number: <strong>" .. Player.PlayerData.phone_number .. "</strong><br><br>Kind regards,<br>Township Los Santos",
--                 button = {}
--             }
--             TriggerEvent("qb-phone:server:sendNewMailToOffline", citizenid, mailData)
--         end
--     end
--     TriggerClientEvent('ox_lib:notify', source, { description = "An email has been sent to driving schools, and you will be contacted automatically", type = 'success' })
-- end)

RegisterNetEvent('qb-cityhall:server:ApplyJob', function(job)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end
  local ped = GetPlayerPed(src)
  local pedCoords = GetEntityCoords(ped)
  local closestCityhall = getClosestHall(pedCoords)
  local cityhallCoords = Config.Cityhalls[closestCityhall].coords
  local JobInfo = QBCore.Shared.Jobs[job]
  if #(pedCoords - cityhallCoords) >= 20.0 or not availableJobs[job] then
    return DropPlayer(source, "Attempted exploit abuse")
  end
  Player.Functions.SetJob(job, 0)
  TriggerClientEvent('ox_lib:notify', source, { description = Lang:t('info.new_job', { job = JobInfo.label }), type = 'success' })
end)

-- Commands

-- QBCore.Commands.Add("drivinglicense", "Give a drivers license to someone", { { "id", "ID of a person" } }, true, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
--     local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--     if SearchedPlayer then
--         if not SearchedPlayer.PlayerData.metadata.licences["driver"] then
--             for i = 1, #Config.DrivingSchools do
--                 for id = 1, #Config.DrivingSchools[i].instructors do
--                     if Config.DrivingSchools[i].instructors[id] == Player.PlayerData.citizenid then
--                         SearchedPlayer.PlayerData.metadata.licences["driver"] = true
--                         SearchedPlayer.Functions.SetMetaData("licences", SearchedPlayer.PlayerData.metadata.licences)
--                         TriggerClientEvent('ox_lib:notify', SearchedPlayer.PlayerData.source, { description = "You have passed! Pick up your drivers license at the town hall", type = 'success' })
--                         TriggerClientEvent('ox_lib:notify', source, { description = ("Player with ID %s has been granted access to a driving license"):format(SearchedPlayer.PlayerData.source), type = 'success' })
--                         break
--                     end
--                 end
--             end
--         else
--             TriggerClientEvent('ox_lib:notify', source, { description = "Can't give permission for a drivers license, this person already has permission", type = 'error' })
--         end
--     else
--         TriggerClientEvent('ox_lib:notify', source, { description = "Player Not Online", type = 'error' })
--     end
-- end)

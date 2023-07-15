QBCore.Players = {}
QBCore.Player = {}

-- On player login get their data or set defaults
-- Don't touch any of this unless you know what you are doing
-- Will cause major issues!

function QBCore.Player.Login(source, citizenid, newData)
    if source and source ~= '' then
        if citizenid then
            local identifiers = QBCore.Functions.GetIdentifiers(source)
            local PlayerData = MySQL.prepare.await('SELECT p.*, u.license2, u.license, u.premium FROM characters p INNER JOIN users u ON p.userid = u.userid WHERE p.citizenid = ?', { citizenid })
            if PlayerData and (identifiers.license2 == PlayerData.license2 or identifiers.license == PlayerData.license) then
                PlayerData.money = json.decode(PlayerData.money)
                PlayerData.job = json.decode(PlayerData.job)
                PlayerData.position = json.decode(PlayerData.position)
                PlayerData.metadata = json.decode(PlayerData.metadata)
                PlayerData.charinfo = json.decode(PlayerData.charinfo)

                if PlayerData.gang then
                    PlayerData.gang = json.decode(PlayerData.gang)
                else
                    PlayerData.gang = {}
                end

                QBCore.Player.CheckPlayerData(source, PlayerData)
            else
                lib.logger(source, 'Login', 'Player tried to join as a character which they cannot')
                DropPlayer(source, Lang:t("info.exploit_dropped"))
            end
        else
            QBCore.Player.CheckPlayerData(source, newData)
        end
        return true
    else
        QBCore.ShowError(GetCurrentResourceName(), 'ERROR QBCORE.PLAYER.LOGIN - NO SOURCE GIVEN!')
        return false
    end
end

function QBCore.Player.GetOfflinePlayer(citizenid)
    if citizenid then
        local PlayerData = MySQL.Sync.prepare('SELECT * FROM characters p INNER JOIN users u ON p.userid = u.id WHERE p.citizenid = ?', {citizenid})
        if PlayerData then
            PlayerData.money = json.decode(PlayerData.money)
            PlayerData.job = json.decode(PlayerData.job)
            PlayerData.position = json.decode(PlayerData.position)
            PlayerData.metadata = json.decode(PlayerData.metadata)
            PlayerData.charinfo = json.decode(PlayerData.charinfo)
            if PlayerData.gang then
                PlayerData.gang = json.decode(PlayerData.gang)
            else
                PlayerData.gang = {}
            end

            return QBCore.Player.CheckPlayerData(nil, PlayerData)
        end
    end
    return nil
end

function QBCore.Player.CheckPlayerData(source, PlayerData)
    PlayerData = PlayerData or {}
    local Offline = true
    if source then
        PlayerData.source = source
        PlayerData.license = PlayerData.license or QBCore.Functions.GetIdentifier(source, 'license')
        PlayerData.license2 = PlayerData.license2 or QBCore.Functions.GetIdentifier(source, 'license2')
        PlayerData.steam = PlayerData.steam or QBCore.Functions.GetIdentifier(source, 'steam')
        PlayerData.name = GetPlayerName(source)
        Offline = false
    end

    PlayerData.userid = PlayerData.userid or 0
    PlayerData.premium = PlayerData.premium or 0

    PlayerData.fullname = PlayerData.fullname or "Not found, report issue to developers"
    local firstname, _ = string.strsplit(' ', PlayerData.fullname)
    local lastname = string.gsub(PlayerData.fullname, firstname .. " ", "")
    PlayerData.firstname = firstname or "Firstname"
    PlayerData.lastname = lastname or "Lastname"

    PlayerData.citizenid = PlayerData.citizenid or QBCore.Player.CreateCitizenId()
    PlayerData.cid = PlayerData.charinfo?.cid or 1
    PlayerData.money = PlayerData.money or {}
    PlayerData.optin = PlayerData.optin or true
    for moneytype, startamount in pairs(QBCore.Config.Money.MoneyTypes) do
        PlayerData.money[moneytype] = PlayerData.money[moneytype] or startamount
    end

    PlayerData.phone_number = PlayerData.phone_number or QBCore.Functions.CreatePhoneNumber()

    -- Charinfo
    PlayerData.charinfo = PlayerData.charinfo or {}

    PlayerData.charinfo.firstname = firstname or "Firstname"
    PlayerData.charinfo.lastname = lastname or "Lastname"

    PlayerData.cid = PlayerData.charinfo.cid or 1
    PlayerData.charinfo.birthdate = PlayerData.charinfo.birthdate or '00-00-0000'
    PlayerData.charinfo.gender = PlayerData.charinfo.gender or 0
    PlayerData.charinfo.nationality = PlayerData.charinfo.nationality or 'UK'

    -- Metadata
    PlayerData.metadata = PlayerData.metadata or {}
    PlayerData.metadata.weapon_serials = PlayerData.metadata.weapon_serials or {}

    PlayerData.metadata['boostingrep'] = PlayerData.metadata['boostingrep'] or 0
    PlayerData.metadata['boostingclass'] = PlayerData.metadata['boostingclass'] or 'D'
    --StarterKit
    PlayerData.metadata.starterkit = PlayerData.metadata.starterkit or 0


    -- Crafting
    PlayerData.metadata.craftingrep = PlayerData.metadata.craftingrep or 0

    PlayerData.metadata.farmingrep = PlayerData.metadata.farmingrep or 0


    --Perks
    PlayerData.metadata.perksystem = PlayerData.metadata.perksystem or {
        exp = 0,
        level = 0,
        perkPoints = 0,
        perks = {},
        effects = {}
    }

    PlayerData.metadata.blueprints = PlayerData.metadata.blueprints or {}

    -- New Payslip System
    PlayerData.metadata.payslip = PlayerData.metadata.payslip or 0

    -- Car Boosting
    PlayerData.metadata.carboostclass = PlayerData.metadata.carboostclass or 'D'
    PlayerData.metadata.carboostrep = PlayerData.metadata.carboostrep or 0
    PlayerData.metadata.laptopdata = PlayerData.metadata.laptopdata or {
        wallpaper = 'default',
        apps = {}
    }
    ---------------------------------------------------------------------------------------
    PlayerData.metadata.health = PlayerData.metadata.health or 200
    PlayerData.metadata.armor = PlayerData.metadata.armor or 0

    PlayerData.metadata.cuffType = PlayerData.metadata.cuffType or 'NONE'

    PlayerData.metadata.hunger = PlayerData.metadata.hunger or 100
    PlayerData.metadata.thirst = PlayerData.metadata.thirst or 100
    PlayerData.metadata.stress = PlayerData.metadata.stress or 0

    PlayerData.metadata.isdead = PlayerData.metadata.isdead or false
    PlayerData.metadata.inlaststand = PlayerData.metadata.inlaststand or false
    PlayerData.metadata.ishandcuffed = PlayerData.metadata.ishandcuffed or false
    PlayerData.metadata.isziptied = PlayerData.metadata.isziptied or false
    PlayerData.metadata.injail = PlayerData.metadata.injail or 0
    PlayerData.metadata.jailitems = PlayerData.metadata.jailitems or {}

    PlayerData.metadata.tracker = PlayerData.metadata.tracker or false

    PlayerData.metadata.status = PlayerData.metadata.status or {}
    PlayerData.metadata.phone = PlayerData.metadata.phone or {}
    PlayerData.metadata.dealerrep = PlayerData.metadata.dealerrep or 0
    PlayerData.metadata.currentapartment = PlayerData.metadata.currentapartment or nil

    PlayerData.metadata.callsign = PlayerData.metadata.callsign or 'NO CALLSIGN'
    PlayerData.metadata.fingerprint = PlayerData.metadata.fingerprint or QBCore.Player.CreateFingerId()
    -- PlayerData.metadata.walletid = PlayerData.metadata.walletid or QBCore.Player.CreateWalletId()
    PlayerData.metadata.licences = PlayerData.metadata.licences or {
        driver = true,
        business = false,
        firearm = false,
        casino = false,
        pilot = false
    }
    PlayerData.metadata.inside = PlayerData.metadata.inside or {
        house = nil,
        apartment = {
            apartmentType = nil,
            apartmentId = nil,
        }
    }
    -- Job
    if PlayerData.job and PlayerData.job.name and not QBCore.Shared.Jobs[PlayerData.job.name] then PlayerData.job = nil end
    PlayerData.job = PlayerData.job or {}
    PlayerData.job.name = PlayerData.job.name or 'unemployed'

    local sharedJob = QBCore.Shared.Jobs[PlayerData.job.name]

    PlayerData.job.label = sharedJob.label or 'Civilian'
    PlayerData.job.type = sharedJob.type or 'civ'

    if (QBCore.Shared.ForceJobDefaultDutyAtLogin and PlayerData.job.type ~= 'leo') or PlayerData.job.onduty == nil then
        PlayerData.job.onduty = sharedJob.defaultDuty
    end

    PlayerData.job.isboss = PlayerData.job.isboss or false
    PlayerData.job.licences = PlayerData.job.licences or {}
    PlayerData.job.grade = PlayerData.job.grade or {}
    PlayerData.job.grade.name = PlayerData.job.grade.name or 'Freelancer'
    PlayerData.job.grade.level = PlayerData.job.grade.level or 0
    PlayerData.job.callsign = PlayerData.job.callsign or nil
    PlayerData.job.onduty = PlayerData.job.onduty or false

    if PlayerData.job.onduty then PlayerData.job.dutyTime = os.time() end

    -- Gang
    if PlayerData.gang and PlayerData.gang.name and not QBCore.Shared.Gangs[PlayerData.gang.name] then PlayerData.gang = nil end
    PlayerData.gang = PlayerData.gang or {}
    PlayerData.gang.name = PlayerData.gang.name or 'none'
    PlayerData.gang.label = PlayerData.gang.label or 'No Gang Affiliaton'
    PlayerData.gang.isboss = PlayerData.gang.isboss or false
    PlayerData.gang.grade = PlayerData.gang.grade or {}
    PlayerData.gang.grade.name = PlayerData.gang.grade.name or 'none'
    PlayerData.gang.grade.level = PlayerData.gang.grade.level or 0
    -- Other
    PlayerData.position = PlayerData.position or QBConfig.DefaultSpawn
    PlayerData.items = GetResourceState('qb-inventory') ~= 'missing' and exports['qb-inventory']:LoadInventory(PlayerData.source, PlayerData.citizenid) or {}
    return QBCore.Player.CreatePlayer(PlayerData, Offline)
end

-- On player logout

function QBCore.Player.Logout(source)
    TriggerClientEvent('QBCore:Client:OnPlayerUnload', source)
    TriggerEvent('QBCore:Server:OnPlayerUnload', source)

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    local newHunger = Player.PlayerData.metadata.hunger - QBCore.Config.Player.HungerRate
    local newThirst = Player.PlayerData.metadata.thirst - QBCore.Config.Player.ThirstRate
    if newHunger <= 0 then
        newHunger = 0
    end
    if newThirst <= 0 then
        newThirst = 0
    end
    Player.Functions.SetMetaData('thirst', newThirst)
    Player.Functions.SetMetaData('hunger', newHunger)
    TriggerClientEvent('hud:client:UpdateNeeds', source, newHunger, newThirst)
    Player.Functions.Save()

    Wait(200)
    QBCore.Players[source] = nil
end

-- Create a new character
-- Don't touch any of this unless you know what you are doing
-- Will cause major issues!

function QBCore.Player.CreatePlayer(PlayerData, Offline)
    local self = {}
    self.Functions = {}
    self.PlayerData = PlayerData
    self.Offline = Offline

    function self.Functions.UpdatePlayerData()
        if self.Offline then return end -- Unsupported for Offline Players
        TriggerEvent('QBCore:Player:SetPlayerData', self.PlayerData)
        TriggerClientEvent('QBCore:Player:SetPlayerData', self.PlayerData.source, self.PlayerData)
    end


    function self.Functions.SetJob(job, grade, licences)
        job = job or ''
        grade = tonumber(grade) or 0
        licences = licences or {}
        if not QBCore.Shared.Jobs[job] then return false end
        self.PlayerData.job.name = job
        self.PlayerData.job.label = QBCore.Shared.Jobs[job].label
        self.PlayerData.job.onduty = QBCore.Shared.Jobs[job].defaultDuty
        self.PlayerData.job.type = QBCore.Shared.Jobs[job].type or 'none'
        self.PlayerData.job.licences = licences

        if QBCore.Shared.Jobs[job].grades[grade] then
            local jobgrade = QBCore.Shared.Jobs[job].grades[grade]
            self.PlayerData.job.grade = {}
            self.PlayerData.job.grade.name = jobgrade.name
            self.PlayerData.job.grade.level = grade
            self.PlayerData.job.payment = jobgrade.payment or 30
            self.PlayerData.job.isboss = jobgrade.isboss or false
        else
            self.PlayerData.job.grade = {}
            self.PlayerData.job.grade.name = 'No Grades'
            self.PlayerData.job.grade.level = 0
            self.PlayerData.job.payment = 30
            self.PlayerData.job.isboss = false
        end

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            TriggerEvent('QBCore:Server:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
            TriggerClientEvent('QBCore:Client:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
        end

        return true
    end

    function self.Functions.SetGang(gang, grade)
        gang = gang or ''
        grade = tonumber(grade) or 0
        if not QBCore.Shared.Gangs[gang] then return false end
        self.PlayerData.gang.name = gang
        self.PlayerData.gang.label = QBCore.Shared.Gangs[gang].label
        if QBCore.Shared.Gangs[gang].grades[grade] then
            local ganggrade = QBCore.Shared.Gangs[gang].grades[grade]
            self.PlayerData.gang.grade = {}
            self.PlayerData.gang.grade.name = ganggrade.name
            self.PlayerData.gang.grade.level = grade
            self.PlayerData.gang.isboss = ganggrade.isboss or false
        else
            self.PlayerData.gang.grade = {}
            self.PlayerData.gang.grade.name = 'No Grades'
            self.PlayerData.gang.grade.level = 0
            self.PlayerData.gang.isboss = false
        end

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            TriggerEvent('QBCore:Server:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
            TriggerClientEvent('QBCore:Client:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
        end

        return true
    end

    function self.Functions.SetJobDuty(onDuty)
        self.PlayerData.job.onduty = not not onDuty -- Make sure the value is a boolean if nil is sent
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.SetPlayerData(key, val)
        if not key or type(key) ~= 'string' then return end
        self.PlayerData[key] = val
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.SetMetaData(meta, val)
        if not meta or type(meta) ~= 'string' then return end
        if meta == 'hunger' or meta == 'thirst' then
            val = val > 100 and 100 or val
        end
        self.PlayerData.metadata[meta] = val
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.GetMetaData(meta)
        if not meta or type(meta) ~= 'string' then return end
        return self.PlayerData.metadata[meta]
    end

    function self.Functions.AddJobReputation(amount)
        if not amount then return end
        amount = tonumber(amount)
        self.PlayerData.metadata.jobrep[self.PlayerData.job.name] = self.PlayerData.metadata.jobrep[self.PlayerData.job.name] + amount
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.AddMoney(moneytype, amount, reason, taxed)
        reason = reason or 'unknown'
        amount = tonumber(amount)
        taxed = taxed or false
        if amount < 0 then return end
        local old = self.PlayerData.money[moneytype]
        if moneytype == 'bank' then
            local data = {}
            data.amount = amount
            data.message = reason
            exports.pefcl:addBankBalance(self.PlayerData.source, data)
        else
            if not self.PlayerData.money[moneytype] then return false end
            self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount
        end

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
              lib.logger(self.PlayerData.source, 'AddMoney', ('Received %s (%s) they had %d and now they have %d with reason %s'):format(amount,moneytype,old, tonumber(old+amount), reason))
            else
              lib.logger(self.PlayerData.source, 'AddMoney', ('Received %s (%s) they had %d and now they have %d with reason %s'):format(amount,moneytype,old, tonumber(old+amount), reason))
            end
            TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, "add", reason)
            TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, "add", reason)
        end

        if taxed then
            exports.pefcl:addBankBalanceByIdentifier(self.PlayerData.source, { identifier = 'governor', amount = (amount * 0.05), message = 'Legal Sell Tax' })
        end

        return true
    end

    function self.Functions.RemoveMoney(moneytype, amount, reason, taxed)
        reason = reason or 'unknown'
        amount = tonumber(amount)
        taxed = taxed or false
        if amount < 0 then return end
        if not self.PlayerData.money[moneytype] then return false end
        local old = self.PlayerData.money[moneytype]

        for _, mtype in pairs(QBCore.Config.Money.DontAllowMinus) do
            if mtype == moneytype then
                if (self.PlayerData.money[moneytype] - amount) < 0 then
                    return false
                end
            end
            if moneytype == 'bank' then
                if (exports.pefcl:getDefaultAccountBalance(self.PlayerData.source).data - amount) < 0 then
                    return false
                end
            end
        end

        if moneytype == 'bank' then
            local data = {}
            data.amount = amount
            data.message = reason
            exports.pefcl:removeBankBalance(self.PlayerData.source, data)
        else

            self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount
        end

        if not self.Offline then
            self.Functions.UpdatePlayerData()

            if amount > 100000 then
              lib.logger(self.PlayerData.source, 'RemoveMoney', ('Removed %s (%s) they had %d and now they have %d with reason %s'):format(amount,moneytype,old, tonumber(old-amount), reason))
            else
              lib.logger(self.PlayerData.source, 'RemoveMoney', ('Removed %s (%s) they had %d and now they have %d with reason %s'):format(amount,moneytype,old, tonumber(old-amount), reason))
            end
            TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, "remove", reason)
            TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, "remove", reason)
        end

        if taxed then
            exports.pefcl:addBankBalanceByIdentifier(self.PlayerData.source, { identifier = 'governor', amount = (amount * (1 + (GlobalState.tax/100))), message = 'Legal Purchase Tax' })
        end

        return true
    end

    function self.Functions.SetMoney(moneytype, amount, reason)
        reason = reason or 'unknown'
        amount = tonumber(amount)
        if amount < 0 then return false end
        if not self.PlayerData.money[moneytype] then return false end
        local old = self.PlayerData.money[moneytype]

        if moneytype == 'bank' then
            local data = {}
            data.amount = amount
            exports.pefcl:setBankBalance(self.PlayerData.source, data)
            self.PlayerData.money[moneytype] = exports.pefcl:getDefaultAccountBalance(self.PlayerData.source).data or 0
        else
            self.PlayerData.money[moneytype] = amount
        end

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            lib.logger(self.PlayerData.source, 'SetMoney', ('Set %s (%s) they had %d and now they have %d with reason %s'):format(amount,moneytype,old, tonumber(amount), reason))
            TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, "set", reason)
            TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, "set", reason)
        end

        return true
    end

    function self.Functions.GetMoney(moneytype)
        if not moneytype then return false end
        if moneytype == 'bank' then
            self.PlayerData.money[moneytype] = exports.pefcl:getDefaultAccountBalance(self.PlayerData.source).data or 0
            return exports.pefcl:getDefaultAccountBalance(self.PlayerData.source).data
        end
        return self.PlayerData.money[moneytype]
    end

    function self.Functions.SyncMoney()
        local money = exports.pefcl:getDefaultAccountBalance(self.PlayerData.source).data
        self.PlayerData.money['bank'] = money
        if not self.Offline then
            self.Functions.UpdatePlayerData()
        end
    end

    function self.Functions.AddWeaponSerial(serial)
        self.PlayerData.metadata.weapon_serials[#self.PlayerData.metadata.weapon_serials + 1] = serial
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.SetCreditCard(cardNumber)
        self.PlayerData.charinfo.card = cardNumber
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.GetCardSlot(cardNumber, cardType)
        local item = tostring(cardType)
        local slots = exports['qb-inventory']:GetSlotsByItem(self.PlayerData.items, item)
        for _, slot in pairs(slots) do
            if slot then
                if self.PlayerData.items[slot].info.cardNumber == cardNumber then
                    return slot
                end
            end
        end
        return nil
    end

    function self.Functions.Save()
        if self.Offline then
            QBCore.Player.SaveOffline(self.PlayerData)
        else
            QBCore.Player.Save(self.PlayerData.source)
        end
    end

    function self.Functions.Logout()
        if self.Offline then return end -- Unsupported for Offline Players
        QBCore.Player.Logout(self.PlayerData.source)
    end

    function self.Functions.AddMethod(methodName, handler)
        self.Functions[methodName] = handler
    end

    function self.Functions.AddField(fieldName, data)
        self[fieldName] = data
    end

    if self.Offline then
        return self
    else
        QBCore.Players[self.PlayerData.source] = self
        QBCore.Player.Save(self.PlayerData.source)

        -- At this point we are safe to emit new instance to third party resource for load handling
        TriggerEvent('QBCore:Server:PlayerLoaded', self)
        self.Functions.UpdatePlayerData()
    end
end

-- Add a new function to the Functions table of the player class
-- Use-case:
--[[
    AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
        QBCore.Functions.AddPlayerMethod(Player.PlayerData.source, "functionName", function(oneArg, orMore)
            -- do something here
        end)
    end)
]]

function QBCore.Functions.AddPlayerMethod(ids, methodName, handler)
    local idType = type(ids)
    if idType == "number" then
        if ids == -1 then
            for _, v in pairs(QBCore.Players) do
                v.Functions.AddMethod(methodName, handler)
            end
        else
            if not QBCore.Players[ids] then return end

            QBCore.Players[ids].Functions.AddMethod(methodName, handler)
        end
    elseif idType == "table" and table.type(ids) == "array" then
        for i = 1, #ids do
            QBCore.Functions.AddPlayerMethod(ids[i], methodName, handler)
        end
    end
end

-- Add a new field table of the player class
-- Use-case:
--[[
    AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
        QBCore.Functions.AddPlayerField(Player.PlayerData.source, "fieldName", "fieldData")
    end)
]]

function QBCore.Functions.AddPlayerField(ids, fieldName, data)
    local idType = type(ids)
    if idType == "number" then
        if ids == -1 then
            for _, v in pairs(QBCore.Players) do
                v.Functions.AddField(fieldName, data)
            end
        else
            if not QBCore.Players[ids] then return end

            QBCore.Players[ids].Functions.AddField(fieldName, data)
        end
    elseif idType == "table" and table.type(ids) == "array" then
        for i = 1, #ids do
            QBCore.Functions.AddPlayerField(ids[i], fieldName, data)
        end
    end
end

-- Save player info to database (make sure citizenid is the primary key in your database)

function QBCore.Player.Save(source)
    local ped = GetPlayerPed(source)
    local pcoords = GetEntityCoords(ped)
    local PlayerData = QBCore.Players[source].PlayerData
    if PlayerData then
        local identifiers = QBCore.Functions.GetIdentifiers(source)
        local userId = QBCore.Functions.getUserFromIdentifier(identifiers.license2, false)
        if not userId then
            local name = GetPlayerName(source)
            userId = QBCore.Functions.CreateUser(name, identifiers)
        end

        PlayerData.firstname = PlayerData.firstname or nil
        PlayerData.lastname = PlayerData.firstname or nil

        MySQL.insert('INSERT INTO characters (`userid`, `fullname`, `citizenid`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `phone_number`) VALUES (:userid, :fullname, :citizenid, :money, :charinfo, :job, :gang, :position, :metadata, :phone_number) ON DUPLICATE KEY UPDATE money = :money, charinfo = :charinfo, job = :job, gang = :gang, position = :position, metadata = :metadata, phone_number = :phone_number', {
            userid = userId,
            fullname = PlayerData.fullname,
            citizenid = PlayerData.citizenid,
            money = json.encode(PlayerData.money),
            charinfo = json.encode(PlayerData.charinfo),
            job = json.encode(PlayerData.job),
            gang = json.encode(PlayerData.gang),
            position = json.encode(pcoords),
            metadata = json.encode(PlayerData.metadata),
            phone_number = PlayerData.phone_number
        })
        if GetResourceState('qb-inventory') ~= 'missing' then exports['qb-inventory']:SaveInventory(source) end
        QBCore.ShowSuccess(GetCurrentResourceName(), PlayerData.name .. ' PLAYER SAVED!')
    else
        QBCore.ShowError(GetCurrentResourceName(), 'ERROR QBCORE.PLAYER.SAVE - PLAYERDATA IS EMPTY!')
    end
end

function QBCore.Player.SaveOffline(PlayerData)
    if PlayerData then
        local identifiers = QBCore.Functions.GetIdentifiers(source)
        local userId = QBCore.Functions.getUserFromIdentifier(identifiers.license2, false)
        if not userId then
            local name = PlayerData.name
            userId = QBCore.Functions.CreateUser(name, identifiers)
        end

        MySQL.insert('INSERT INTO characters (`userid`, `fullname`, `citizenid`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `phone_number`) VALUES (:userid, :fullname, :citizenid, :money, :charinfo, :job, :gang, :position, :metadata, :phone_number) ON DUPLICATE KEY UPDATE money = :money, charinfo = :charinfo, job = :job, gang = :gang, position = :position, metadata = :metadata, phone_number = :phone_number', {
          userid = userId,
          fullname = PlayerData.fullname,
          citizenid = PlayerData.citizenid,
          money = json.encode(PlayerData.money),
          charinfo = json.encode(PlayerData.charinfo),
          job = json.encode(PlayerData.job),
          gang = json.encode(PlayerData.gang),
          position = json.encode(pcoords),
          metadata = json.encode(PlayerData.metadata),
          phone_number = PlayerData.phone_number
      })

        if GetResourceState('qb-inventory') ~= 'missing' then exports['qb-inventory']:SaveInventory(PlayerData, true) end
        QBCore.ShowSuccess(GetCurrentResourceName(), PlayerData.name .. ' OFFLINE PLAYER SAVED!')
    else
        QBCore.ShowError(GetCurrentResourceName(), 'ERROR QBCORE.PLAYER.SAVEOFFLINE - PLAYERDATA IS EMPTY!')
    end
end

-- Delete character

function QBCore.Player.DeleteCharacter(source, citizenid)
    local license = QBCore.Functions.GetIdentifier(source, 'license2')
    local prefix, identifier = string.strsplit(':', (license or ''))
    local player = Player(source).state

    local result = MySQL.scalar.await('SELECT u.license2 FROM characters c INNER JOIN users u ON u.userid = c.userid where c.citizenid = ?', { citizenid })
    if identifier == result then
        MySQL.prepare.await('DELETE FROM characters WHERE citizenid = ?', {citizenid})
        lib.logger(source, 'DeleteCharacter', ('Player deleted %s character'):format(citizenid))
    else
        lib.logger(source, 'DeleteCharacter', ('Player tried to delete a character (%s) which they cannot'):format(citizenid))

        DropPlayer(source, Lang:t("info.exploit_dropped"))
    end
end

function QBCore.Player.ForceDeleteCharacter(citizenid)
    local result = MySQL.scalar.await('SELECT userid FROM characters where citizenid = ?', { citizenid })
    if result then
        local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)

        if Player then
            DropPlayer(Player.PlayerData.source, "An admin deleted the character which you are currently using")
        end

        MySQL.prepare.await('DELETE FROM characters WHERE citizenid = ?', {citizenid})
    end
end

-- Inventory Backwards Compatibility

function QBCore.Player.SaveInventory(source)
    if GetResourceState('qb-inventory') == 'missing' then return end
    exports['qb-inventory']:SaveInventory(source, false)
end

function QBCore.Player.SaveOfflineInventory(PlayerData)
    if GetResourceState('qb-inventory') == 'missing' then return end
    exports['qb-inventory']:SaveInventory(PlayerData, true)
end

function QBCore.Player.GetTotalWeight(items)
    if GetResourceState('qb-inventory') == 'missing' then return end
    return exports['qb-inventory']:GetTotalWeight(items)
end

function QBCore.Player.GetSlotsByItem(items, itemName)
    if GetResourceState('qb-inventory') == 'missing' then return end
    return exports['qb-inventory']:GetSlotsByItem(items, itemName)
end

function QBCore.Player.GetFirstSlotByItem(items, itemName)
    if GetResourceState('qb-inventory') == 'missing' then return end
    return exports['qb-inventory']:GetFirstSlotByItem(items, itemName)
end

-- Util Functions

function QBCore.Player.CreateCitizenId()
    local CitizenId = 1000
    local result = MySQL.Sync.fetchSingle('SELECT MAX(citizenid) as count FROM characters')
    if result['count'] then
        CitizenId = tonumber(result['count']) + 1
    end
    return CitizenId
end

function QBCore.Functions.CreateAccountNumber()
    local UniqueFound = false
    local AccountNumber = nil
    while not UniqueFound do
        AccountNumber = math.random(1111, 9999) .. math.random(1111, 9999) .. math.random(11, 99)
        local query = '%' .. AccountNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(citizenid) as count FROM characters WHERE charinfo LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return AccountNumber
end

function QBCore.Functions.CreatePhoneNumber()
    local UniqueFound = false
    local foundPrefix = false
    local PhoneNumber = nil
    local prefix = 222

    while not foundPrefix do
        local q = '(' .. prefix .. ')%'
        local res = MySQL.prepare.await('SELECT DISTINCT COUNT(citizenid) FROM characters WHERE phone_number LIKE ?', { q })
        if res then
            if tonumber(res) < 3000 then
                foundPrefix = true
            else
                prefix = prefix + 1
            end
        end
    end

    while not UniqueFound do
        PhoneNumber = '('..prefix ..') ' .. math.random(1000, 9999)
        local query = PhoneNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(citizenid) as count FROM characters WHERE phone_number LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
            return PhoneNumber
        end
    end
    return PhoneNumber
end

function QBCore.Player.CreateFingerId()
    local UniqueFound = false
    local FingerId = nil
    while not UniqueFound do
        FingerId = tostring(QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(4))
        local query = '%' .. FingerId .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM `characters` WHERE `metadata` LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return FingerId
end

function QBCore.Player.CreateWalletId()
    local UniqueFound = false
    local WalletId = nil
    while not UniqueFound do
        WalletId = math.random(11111111, 99999999)
        local query = '%' .. WalletId .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM characters WHERE metadata LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return WalletId
end

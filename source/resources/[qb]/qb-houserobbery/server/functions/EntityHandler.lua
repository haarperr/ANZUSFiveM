local function IsDead(src)
    if not src then return end
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end
    local metadata = player.PlayerData.metadata
    return metadata.isdead or metadata.inlaststand
end

---@param houseid string
---@return unknown | nil
local function ChangeTarget(houseid)
    local Houses = HouseTable
    local House = Houses[houseid]
    if not House then return end
    local players = GetPlayersInHouse(houseid)
    if not players or next(players) == nil then return end
    local target
    for _, v in pairs(players) do
        if not target and House.target ~= v then
            if not IsDead(v) then
                target = v
                break
            end
        end
    end
    if not target then return end
    House.target = target
    HouseTable = Houses
    Wait(100)
    TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
    return target
end


local function RemoveTarget(houseid)
    local Houses = HouseTable
    local House = Houses[houseid]
    if not House then return end
    local target = House.target
    if not target then return end
    local players = GetPlayersInHouse(houseid)
    if not players or next(players) == nil then return end
    for _, v in pairs(players) do
        if v == target then
            House.target = nil
            HouseTable = Houses
            Wait(100)
            TriggerClientEvent("qb-houserobbery:client:setconfig", -1)
            return
        end
    end
end

local function GetCurrentTarget(houseid, src)
    local Houses = HouseTable
    local House = Houses[houseid]
    if not House then return end
    local target = House.target
    if not target then
        target = ChangeTarget(houseid)
    end
    return target
end

return {
    ChangeTarget = ChangeTarget,
    RemoveTarget = RemoveTarget,
    GetCurrentTarget = GetCurrentTarget,
    IsDead = IsDead
}

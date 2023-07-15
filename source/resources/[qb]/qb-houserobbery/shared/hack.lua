---@class HouseRobberyHackItem
---@field initialanim {scully: string, animDict: string, anim: string}
---@field afteranim table
---@field probability number
---@field minigame table

---@type table<string, HouseRobberyHackItem>
local items = {
    ["screw_driver"] = {
        initialanim = {
            scully = "picklock",
        },
        probability = 0.2,
        minigame = {
            type = "circle",
            param = {
                10, 20
            }
        }
    },
    ["hammer"] = {
        initialanim = {
            scully = "hammer"
        },
        probability = 0.8,
        minigame = {
            type = "circle",
            param = {
                15, 25
            }
        }
    },
    ["thermite"] = {
        initialanim = {
            scully = "picklock",
        },
        probability = 0.5,
        minigame = {
            type = "thermite",
            param = {
                10, 5, 3
            }
        },
        shouldremove = true
    },
    ["drill"] = {
        probability = 0.1,
        minigame = {
            type = "drill"
        }
    },
}


--- @param type "circle" | "maze" | "thermite" | "drill" | "lockpick" | string
---@param ... unknown
---@return unknown
local function minigame(type, ...)
    ---@diagnostic disable-next-line: missing-return-value
    if IsDuplicityVersion() then return end
    if not type then type = "lockpick" end
    local res = promise:new()
    local result
    if type == "circle" then
        local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 2}, 'hard'}, {'w', 'a', 's', 'd'})
        res:resolve(success)
    elseif type == "maze" then
        exports["ps-ui"]:Maze(function(success)
            res:resolve(success)
        end, ...) -- Hack Time Limit
    elseif type == "thermite" then
        exports["ps-ui"]:Thermite(function(success)
            res:resolve(success)
        end, ...)
    elseif type == "drill" then
        Drilling.Start(function (cb)
            res:resolve(cb)
        end)
    elseif type == "lockpick" then
        local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 2}, 'hard'}, {'w', 'a', 's', 'd'})
        res:resolve(success)
    end
    result = Citizen.Await(res)
    return result
end

local GetConfigNumber = require 'client.functions.Utils'.GetConfigNumber
---@param param string
---@param houseid any
---@param force? boolean
local function alert(param, houseid, force)
    if IsDuplicityVersion() then return end

    local defChance = param and items[param]?.probability or 1.0
    if GlobalState.HouseRobberyTimeState == "day" then
        defChance = defChance * 0.5
    end
    local sendalert = force or math.random() < defChance
    if sendalert then
        local currentPos = GetEntityCoords(cache.ped)
        if houseid then
            currentPos = Config.HouseLocation[GetConfigNumber(houseid)]?.coords
        end
        local joblist = {}
        for k, v in pairs(Config.Police) do
            if v then
                joblist[#joblist+1] = k
            end
        end
        DebugConsole("Alerting")
        local House = HouseData[houseid]
        if not House or House.alerted then return end
        exports["ps-dispatch"]:CustomAlert({
            dispatchcodename = "houserobbery",
            dispatchCode = "10-90",
            coords = currentPos.xyz,
            priority = 2,
            message = "House Robbery",
            sprite = 40,
            color = 5,
            scale = 1.5,
            length = 2,
            job = joblist -- type or jobs that will get the alerts
        })
        TriggerServerEvent("qb-houserobbery:server:registerAlert", houseid)
    end
end


return {
    alert = alert,
    minigame = minigame,
    items = items
}

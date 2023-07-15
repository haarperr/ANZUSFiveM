Made by Lionh34rt#4305
Discord: https://discord.gg/AWyTUEnGeN
Tebex: https://lionh34rt.tebex.io/
GitHub: https://github.com/Lionh34rt/

# Dependencies
* [QBCore Framework](https://github.com/qbcore-framework)
* [PolyZone by mkafrin](https://github.com/mkafrin/PolyZone)
* [qb-target by BerkieBb](https://github.com/BerkieBb/qb-target)
* [boostinghack](https://github.com/Lionh34rt/boostinghack)

# Installation
* **Install qb-carboosting and boostinghack (optional, can replace with another minigame)**
* **Run the included SQL script to create the databases**
* **Add the items to your shared**
* **Add the metadata to your qb-core**
* **Replace the qb-phone scanplate callback (optional)**
* **Create a log for your carboosting**
* **Edit the shared config to your liking**

# Shared.lua items
```lua
-- Carboosting
["boostinglaptop"] 		 	 	 = {["name"] = "boostinglaptop",           		["label"] = "Boosting Laptop",	 		["weight"] = 1000, 		["type"] = "item", 		["image"] = "boostinglaptop.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "A laptop used for boosting contracts."},
["boostingdisabler"] 		 	 = {["name"] = "boostingdisabler",           	["label"] = "Tracking Disabler",	 	["weight"] = 1000, 		["type"] = "item", 		["image"] = "boostingdisabler.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "This small tool can disable these pesky trackers."},
```

# qb-core > server > player: Add to meta data
```lua
PlayerData.metadata['boostingrep'] = PlayerData.metadata['boostingrep'] or 0
PlayerData.metadata['boostingclass'] = PlayerData.metadata['boostingclass'] or 'D'
```

# Database
```sql
ALTER TABLE `character_vehicles` 
ADD COLUMN `vinscratched` INT(11) NOT NULL DEFAULT 0 AFTER `financetime`;
```

# Phone: Adjust scan plate callback so that vinscratched vehicle return a random name and not the owner in qb-phone > server > main.lua
```lua
QBCore.Functions.CreateCallback('qb-phone:server:ScanPlate', function(source, cb, plate)
    local src = source
    local vehicleData = {}
    if plate ~= nil then
        local result = MySQL.Sync.fetchAll('SELECT * FROM character_vehicles WHERE plate = ?', {plate})
        if result[1] and result[1].vinscratched == 0 then
            local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ?', {result[1].citizenid})
            local charinfo = json.decode(player[1].charinfo)
            vehicleData = {
                plate = plate,
                status = true,
                owner = charinfo.firstname .. " " .. charinfo.lastname,
                citizenid = result[1].citizenid
            }
        elseif GeneratedPlates ~= nil and GeneratedPlates[plate] ~= nil then
            vehicleData = GeneratedPlates[plate]
        else
            local ownerInfo = GenerateOwnerName()
            GeneratedPlates[plate] = {
                plate = plate,
                status = true,
                owner = ownerInfo.name,
                citizenid = ownerInfo.citizenid
            }
            vehicleData = {
                plate = plate,
                status = true,
                owner = ownerInfo.name,
                citizenid = ownerInfo.citizenid
            }
        end
        cb(vehicleData)
    else
        TriggerClientEvent('QBCore:Notify', src, 'No Vehicle Nearby', 'error')
        cb(nil)
    end
end)
```
# Make a log webhook for the 'carboosting' in qb-smallresources > server > logs.lua:
['carboosting'] = 'discord webhook'

# Useable commands:
'makeboost' --> requires ace perms, gives a random boost to first in queue (forces queue)
'boosting_debug' --> requires ace perms, toggles debug mode on/off
'boosting_queue' --> requires ace perms, prints position and player name of players in queue
'createboost' --> create a seperate boost for a specific playerId (Shared.Permission)
'setboostingrep' --> set the boosting rep of a given playerId (Shared.Permission)
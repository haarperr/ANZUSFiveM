# qb-farming

-- Add this to shared.lua (if you dont already have it)

```lua
	["weed_insecticide"] 			 	   = {["name"] = "weed_insecticide", 					["label"] = "Insecticide", 				["weight"] = 100, 		["type"] = "item", 		["image"] = "insecticides.png", 	  	  ["unique"] = false, 	  ["useable"] = true, 	   ["shouldClose"] = true,    ["combinable"] = nil,    ["description"] = "Insecticides for marijuana"},
	["acid_bottle"] 			 	   	   = {["name"] = "acid_bottle", 						["label"] = "Acid", 					["weight"] = 500, 		["type"] = "item", 		["image"] = "acid.png", 	  	  		  ["unique"] = false, 	  ["useable"] = false, 	   ["shouldClose"] = true,    ["combinable"] = nil,    ["description"] = "Bottle of acid solution"},
	["alkaline_bottle"] 			 	   = {["name"] = "alkaline_bottle", 					["label"] = "Alkaline", 				["weight"] = 500, 		["type"] = "item", 		["image"] = "alkaline.png", 	  	  	  ["unique"] = false, 	  ["useable"] = false, 	   ["shouldClose"] = true,    ["combinable"] = nil,    ["description"] = "Bottle of alkaline solution"},
```


-- Add this to qb-core/server/player.lua

```lua
 PlayerData.metadata['phonedata'] = PlayerData.metadata['phonedata'] or {
        SerialNumber = QBCore.Player.CreateSerialNumber(),
        InstalledApps = {},
    } -- this line already exists

    PlayerData.metadata['farmingrep'] = PlayerData.metadata['farmingrep'] or 0 -- add this line
```


-- Steps to take while replicating the script

1. Make sure to change the folder name to something different. For eg. qb-farming, qb-farming2, qb-teafarming, qb-testfarming, qb-test, qb-genericfarming. Make sure these folder names are unique
2. Config.RequiredRep -- reputation required to plant this seed
3. Config.RepGiven  -- rep added after they harvest the plant
4. Config.Foldername  -- folder name if you replicate the folder to make a new farming
5. Config.ZOffset -- offset that you can play with the plant is floating or inside the ground
6. Config.Prop -- plant prop (more props can be found on https://forge.plebmasters.de/). Also you cannot use the same prop for 2 farmings. Each prop has to be unique for the target to work fine or else it will tell you "Not the Right Plant!"
7.  This will be edited to new seed, return item. Read Config Properly!

```lua
Config.Seed = {
    ["tea_seed"] = {
        label = "Tea",
        returnItems = {
            [1] = {itemName = "tea_seed", amount = math.random(1,10), probability = 10, basedOnHealth = false},
            [2] = {itemName = "tea", amount = 10, probability = 100, basedOnHealth = true},
        }
    },
}
```

If you have one script working perfectly fine and then you replicate, these are the changes you need to make so that the new script works fine.
There are bunch of comments in Config. Make sure to read through it properly.
Config = {}

Config.Ped = `IG_DrugDealer`

Config.PawnLocation = {
    vec4(175.155, -1323.956, 29.364, 329.138)
}

Config.BankMoney = false -- Set to true if you want the money to go into the players bank
Config.UseTimes = false  -- Set to false if you want the pawnshop open 24/7
Config.TimeOpen = 7      -- Opening Time
Config.TimeClosed = 17   -- Closing Time
Config.SendMeltingEmail = true

Config.UseTarget = true

Config.PawnItems = {
    [1] = {
        item = 'watch_1',
        price = math.random(450, 550)
    },
    [2] = {
        item = 'watch_2',
        price = math.random(360, 440)
    },
    [3] = {
        item = 'watch_3',
        price = math.random(540, 660)
    },
    [4] = {
        item = 'earring_1',
        price = math.random(180, 220)
    },
    [5] = {
        item = 'earring_2',
        price = math.random(270, 330)
    },
    [6] = {
        item = 'earring_3',
        price = math.random(360, 440)
    },
    [7] = {
        item = 'ring_1',
        price = math.random(360, 440)
    },
    [8] = {
        item = 'ring_2',
        price = math.random(450, 550)
    },
    [9] = {
        item = 'ring_3',
        price = math.random(540, 660)
    },
    [10] = {
        item = 'necklace_1',
        price = math.random(270, 330)
    },
    [11] = {
        item = 'necklace_2',
        price = math.random(360, 440)
    },
    [12] = {
        item = 'necklace_3',
        price = math.random(450, 550)
    },
    [13] = {
        item = 'necklace_4',
        price = math.random(540, 660)
    },
    [14] = {
        item = 'necklace_5',
        price = math.random(630, 770)
    },
    [15] = {
        item = 'artg_painting10',
        price = math.random(2700, 3300)
    },
    [16] = {
        item = 'artg_painting9',
        price = math.random(2700, 3300)
    },
    [17] = {
        item = 'artg_painting8',
        price = math.random(1800, 2200)
    },
    [18] = {
        item = 'artg_painting7',
        price = math.random(1575, 1925)
    },
    [19] = {
        item = 'artg_painting6',
        price = math.random(1350, 1650)
    },
    [20] = {
        item = 'artg_painting5',
        price = math.random(900, 1100)
    },
    [21] = {
        item = 'artg_painting4',
        price = math.random(675, 825)
    },
    [22] = {
        item = 'artg_painting3',
        price = math.random(450, 550)
    },
    [23] = {
        item = 'artg_painting2',
        price = math.random(405, 495)
    },
    [24] = {
        item = 'artg_painting1',
        price = math.random(270, 330)
    },
    [25] = {
        item = 'faberge_egg',
        price = math.random(4500, 5500)
    },
    [26] = {
        item = 'diamond',
        price = math.random(500, 800)
    },
}

Config.MeltingItems = {
    -- meltTime is amount of time in minutes per item
    [1] = {
        item = 'goldchain',
        rewards = {
            [1] = {
                item = 'goldbar',
                amount = 2
            }
        },
        meltTime = 0.15
    },
    [2] = {
        item = 'diamond_ring',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 0.15
    },
    [3] = {
        item = 'rolex',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            },
            [3] = {
                item = 'electronickit',
                amount = 1
            }
        },
        meltTime = 0.15
    },
    [4] = {
        item = '10kgoldchain',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 5
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 0.15
    },
}

Loc = {}

Config = {
    Debug = false,                    -- enable debug mode
    Blips = true,                     -- Enable Blips?
    BlipNamer = false,                -- Enable to Name Blips different things, disable if you already have too many blips as this will group them together
    img = "ox_inventory/web/images/", --Set this to the image directory of your inventory script or "nil" if using newer qb-menu
    CheckMarks = true,                -- shows checkmarks if user has the materials to craft an item, set false if causing lag.
    Lan = "en",                       -- Pick your language here
    JimMenu = true,                   -- Set this to true if using update qb-menu with icons
    JimShops = false,                 -- Set this to true if using jim-shops
    Job = nil,                        -- set this to a job role eg "miner" or nil for no job
    Notify = "qb",
    K4MB1 = true,
    K4MB1Only = false,

    --Lighting for mines
    HangingLights = false, -- if false, will spawn work lights. if true will spawn hanging lights

    Timings = {
        -- Time it takes to do things
        Cracking = math.random(9000, 11500),    -- 9 to 11.5 Seconds
        Washing = math.random(10000, 12000),    -- 10 to 12 Seconds
        Panning = math.random(25000, 30000),    -- 25 to 30 Seconds
        Pickaxe = math.random(25000, 30000),    -- 25 to 30 Seconds
        Mining = math.random(15000, 20000),     -- 15 to 20 Seconds
        Laser = math.random(5000, 10000),      -- 5 to 10 Seconds
        OreRespawn = math.random(55000, 75000), -- 55 to 75 Seconds (1 minute 15 seconds)
        Crafting = 8000,
    },

    Locations = {
        MineStore = {
            {
                name = "Mine",
                coords = vector4(-594.96, 2091.3, 131.47, 67.65),
                sprite = 527,
                col = 81,
                blipTrue = true,
                model = `G_M_M_ChemWork_01`,
                scenario =
                "WORLD_HUMAN_CLIPBOARD",
            }, -- The location where you enter the mine
            {
                name = "Quarry",
                coords = vector4(2960.9, 2754.14, 43.71, 204.58),
                sprite = 527,
                col = 81,
                blipTrue = true,
                model = `G_M_M_ChemWork_01`,
                scenario =
                "WORLD_HUMAN_CLIPBOARD",
            },
            {
                name = "Foundary Store",
                coords = vector4(1074.89, -1988.19, 30.89, 235.07),
                sprite = 436,
                col = 1,
                blipTrue = true,
                model = `G_M_M_ChemWork_01`,
                scenario =
                "WORLD_HUMAN_CLIPBOARD",
            },
        },
        Smelter = { -- The location of the smelter
            { name = "Foundary", coords = vector3(1112.29, -2009.9, 31.46), sprite = 436, col = 1, blipTrue = false, },
        },
        Washing = {
            { name = "Stone Washing", coords = vector3(1840.18, 412.42, 160.49), sprite = 467, col = 3, disp = 6,        blipTrue = true }, -- Mountains
            { name = "Stone Washing", coords = vector3(1869.05, 390.05, 160.53),  sprite = 467, col = 3, disp = 6,        blipTrue = false },
            { name = "Stone Washing", coords = vector3(-432.59, 2936.84, 13.87), sprite = 467, col = 3, disp = 6,        blipTrue = true }, -- Stream Blip
            { name = "Stone Washing", coords = vector3(-422.37, 2946.18, 13.77), sprite = 467, col = 3, blipTrue = false },
            { name = "Stone Washing", coords = vector3(-443.21, 2926.5, 13.62),  sprite = 467, col = 3, blipTrue = false },
            { name = "Stone Washing", coords = vector3(-455.48, 2917.16, 13.52), sprite = 467, col = 3, blipTrue = false },
            { name = "Stone Washing", coords = vector3(2500.64, 6129.4, 162.46), sprite = 467, col = 3, disp = 6,        blipTrue = true }, -- Gordo

            { name = "Stone Washing", coords = vector3(908.21, 4383.37, 30.55),  sprite = 467, col = 3, disp = 6,        blipTrue = true }, -- Alamo Sea
            { name = "Stone Washing", coords = vector3(895.64, 4392.89, 30.8),  sprite = 467, col = 3, blipTrue = false },
            { name = "Stone Washing", coords = vector3(893.12, 4370.74, 30.35),  sprite = 467, col = 3, blipTrue = false },
            { name = "Stone Washing", coords = vector3(912.88, 4365.7, 30.39),   sprite = 467, col = 3, blipTrue = false },
        },
        Panning = {
            { name = "Gold Panning", coords = vector3(-1608.577, 2098.689, 64.607),  sprite = 467, col = 5, disp = 6,        blipTrue = true }, -- Two Hoot Falls
            { name = "Gold Panning", coords = vector3(-1620.057, 2091.852, 64.449),  sprite = 467, col = 5, blipTrue = false },                 -- Two Hoot Falls
            { name = "Gold Panning", coords = vector3(-1672.06, 2070.89, 91.68),  sprite = 467, col = 5, blipTrue = false },
            { name = "Gold Panning", coords = vector3(-1273.16, 1898.19, 100.82), sprite = 467, col = 5, disp = 6,        blipTrue = true }, -- Tongva

            { name = "Gold Panning", coords = vector3(-1551.31, 1444.15, 116.44), sprite = 467, col = 5, disp = 6,        blipTrue = true }, -- Tongva
            { name = "Gold Panning", coords = vector3(-1565.47, 1431.46, 117.1),  sprite = 467, col = 5, blipTrue = false },
            { name = "Gold Panning", coords = vector3(-1578.39, 1419.59, 118.13), sprite = 467, col = 5, blipTrue = false },
            { name = "Gold Panning", coords = vector3(-847.55, 4428.01, 15.54),   sprite = 467, col = 5, disp = 6,        blipTrue = true },                       -- Wilderness
        },
        Cracking = {                                                                                                                                               -- The location of the smelter
            { name = "Stone Cracking", coords = vector4(1109.19, -1992.8, 30.98, 146.88),  sprite = 566, col = 81, blipTrue = false, prop = `prop_vertdrill_01` }, -- Foundary
            { name = "Stone Cracking", coords = vector4(1105.56, -1992.53, 30.94, 238.19), sprite = 566, col = 81, blipTrue = false, prop = `prop_vertdrill_01` }, -- Foundary
        },
        OreBuyer = {                                                                                                                                               -- The Locations of the ore buyers
            {
                name = "Ore Buyer",
                coords = vector4(1090.18, -1999.51, 30.93, 146.24),
                sprite = 568,
                col = 81,
                blipTrue = false,
                model = `G_M_M_ChemWork_01`,
                scenario = "WORLD_HUMAN_CLIPBOARD",
            },
        },
        JewelCut = { -- The Location of the jewel cutting bench. Couldn't decide so left in smeltery
            { name = "Jewel Cutting", coords = vector4(1077.11, -1984.22, 31.02, 235.8),  sprite = 566, col = 81, blipTrue = false, prop = `gr_prop_gr_speeddrill_01c` },
            { name = "Jewel Cutting", coords = vector4(1075.19, -1985.45, 30.92, 144.89), sprite = 566, col = 81, blipTrue = false, prop = `gr_prop_gr_speeddrill_01c` },
        },
        JewelBuyer = { -- The Location of the jewel buyer, I left this as Vangelico, others will proabably change to pawn shops
            {
                name = "Jewel Buyer",
                coords = vector4(-629.86, -240.35, 38.16, 110.05),
                sprite = 527,
                col = 617,
                blipTrue = false,
                model = `S_M_M_HighSec_03`,
                scenario = "WORLD_HUMAN_CLIPBOARD",
            },
        },
    },

    ------------------------------------------------------------
    --Ores and Props
    OrePositions = {
        ---MineShaft Locations
        vector4(-588.49, 2048.05, 129.95 + 1.03, 0.0),
        vector4(-580.10, 2037.82, 128.8 + 1.03, 180.0),
        vector4(-572.28, 2022.37, 127.93 + 1.03, 90.0),
        vector4(-562.8, 2011.85, 127.25 + 1.03, 90.0),
        vector4(-548.99, 1996.56, 127.08 + 1.03, 210.95),

        --Deeper Mineshaft locations
        vector4(-534.22, 1982.9, 126.98 + 1.03, 210.95),
        vector4(-531.43, 1979.08, 127.15 + 1.03, 90.95),
        vector4(-523.71, 1981.21, 126.75 + 1.03, 250.95),
        vector4(-516.25, 1977.32, 126.49 + 1.03, 250.95),
        vector4(-506.58, 1980.66, 126.14 + 1.03, 210.95),
        vector4(-499.52, 1981.87, 125.08 + 1.03, 210.95),
        vector4(-488.44, 1982.74, 124.64 + 1.03, 250.95),
        vector4(-469.78, 1993.57, 123.26 + 1.03, 250.95),
        vector4(-458.53, 2003.33, 123.33 + 1.03, 250.95),
        --Quarry Locations
        vector4(3000.77, 2754.15, 43.5 + 1.03, 0.0),
        vector4(2990.38, 2750.4, 43.46 + 1.03, 0.0),
        vector4(2985.77, 2751.19, 43.06 + 1.03, 0.0),
        vector4(2980.37, 2748.4, 43.0 + 1.03, 0.0),
        vector4(2977.74, 2741.16, 44.54 + 1.03, 180.0),
        vector4(3004.49, 2761.98, 43.54 + 1.03, 180.0),
        vector4(3006.38, 2768.63, 42.59 + 1.03, 180.0),
        vector4(3005.44, 2773.78, 43.11 + 1.03, 180.0),
        vector4(2907.605, 2719.614, 45.57, 358.88),
        vector4(2925.691, 2703.325, 46.022, 297.601),
        vector4(2917.398, 2688.037, 46.376, 167.616),
        vector4(2914.123, 2669.616, 43.529, 280.734),
        vector4(2864.708, 2667.906, 49.165, 22.91),
        vector4(2869.584, 2698.307, 47.811, 37.547),
        vector4(2886.82, 2706.86, 50.485, 332.233),
        vector4(2853.639, 2686.238, 46.212, 345.357),
        vector4(2844.668, 2674.34, 41.371, 113.967),
        vector4(2846.453, 2677.069, 42.02, 12.824),
        vector4(2845.528, 2657.286, 40.382, 129.761),
        vector4(2843.509, 2642.192, 38.86, 176.341),
        vector4(2841.465, 2640.564, 38.601, 130.18),
        vector4(2832.954, 2639.746, 37.475, 49.454),
        vector4(2849.41, 2624.92, 36.702, 275.08),
        vector4(2857.352, 2630.305, 37.607, 326.012),
        vector4(2857.404, 2632.56, 37.705, 139.814),
        vector4(2828.184, 2624.734, 39.062, 95.624),
        vector4(2828.851, 2624.178, 40.025, 217.882),
        vector4(2829.188, 2626.002, 39.857, 58.058),
    },

    -----------------------------------------------------------

    CrackPool = {
        { item = "metalscrap",                  weight = 50, max = 1 },
        { item = "sulfer",                      weight = 40, max = 1 },
        { item = "ironore",                     weight = 20, max = 1 },
        { item = "copperore",                   weight = 20, max = 1 },
        { item = "aluminum",                    weight = 12, max = 1 },
        { item = "carbon",                      weight = 10, max = 1 },
    },

    WashPool = {
        -- Filler items
        { item = "pebbles",                     weight = 50, max = 10},
        { item = "sulfer",                      weight = 40, max = 1 },
        -- Gemstones from rarest to most common
        { item = "uncut_citrinequartz",         weight = 35, max = 1 },
        { item = "uncut_onyx",                  weight = 28, max = 1 }, 
        { item = "uncut_amethyst",              weight = 20, max = 1 }, 
        { item = "uncut_diamond",               weight = 15, max = 1 }, 
        { item = "uncut_emerald",               weight = 12, max = 1 }, 
        { item = "uncut_sapphire",              weight = 8, max = 1  }, 
        { item = "uncut_ruby",                  weight = 5, max = 1  },
        { item = "uncut_opal",                  weight = 2, max = 1  },
    
    },

    PanPool = {
        { item = "pebbles",                     weight = 50, max = 10 }, 
        { item = "bottle",                      weight = 30, max = 1 }, 
        { item = "goldflakes",                  weight = 30, max = 20 }, 
        { item = "sulfer",                      weight = 28, max = 1 },
        { item = "can",                         weight = 25, max = 1 }, 
        { item = "silverore",                   weight = 20, max = 3 }, 
        { item = "stone",                       weight = 8, max = 1 }, 
        { item = "goldore",                     weight = 4, max = 1 }, 
    },

    ------------------------------------------------------------
    SellItems = {
        -- Selling Prices
        metalscrap = 10,
        sulfer = 11,
        copperore = 12,
        goldore = 100,
        silverore = 100,
        ironore = 12,
        aluminum = 14,
        carbon = 15,

        goldingot = 115,
        silveringot = 45,

        opal = 200,
        ruby = 60,
        sapphire = 40,
        emerald = 30,
        diamond = 20,
        amethyst = 15,
        onyx = 10,
        citrinequartz = 5,

        opal_ring_gold = 420,
        opal_necklace_gold = 420,
        opal_earring_gold = 420,
        opal_ring_silver = 276,
        opal_necklace_silver = 276,
        opal_earring_silver = 276,

        ruby_ring_gold = 224,
        ruby_necklace_gold = 224,
        ruby_earring_gold = 224,
        ruby_ring_silver = 108,
        ruby_necklace_silver = 108,
        ruby_earring_silver = 108,

        sapphire_ring_gold = 196,
        sapphire_necklace_gold = 196,
        sapphire_earring_gold = 196,
        sapphire_ring_silver = 84,
        sapphire_necklace_silver = 84,
        sapphire_earring_silver = 84,
        
        emerald_ring_gold = 182,
        emerald_necklace_gold = 182,
        emerald_earring_gold = 182,
        emerald_ring_silver = 72,
        emerald_necklace_silver = 72,
        emerald_earring_silver = 72,

        diamond_ring_gold = 168,
        diamond_necklace_gold = 168,
        diamond_earring_gold = 168,
        diamond_ring_silver = 60,
        diamond_necklace_silver = 60,
        diamond_earring_silver = 60,

        amethyst_ring_gold = 161,
        amethyst_necklace_gold = 161,
        amethyst_earring_gold = 161,
        amethyst_ring_silver = 54,
        amethyst_necklace_silver = 54,
        amethyst_earring_silver = 54,
        
        onyx_ring_gold = 154,
        onyx_necklace_gold = 154,
        onyx_earring_gold = 154,
        onyx_ring_silver = 48,
        onyx_necklace_silver = 48,
        onyx_earring_silver = 48,
        
        citrinequartz_ring_gold = 147,
        citrinequartz_ring_silver = 42,
        citrinequartz_necklace_gold = 147,
        citrinequartz_necklace_silver = 42,
        citrinequartz_earring_gold = 147,
        citrinequartz_earring_silver = 42,

    },

    ------------------------------------------------------------
    --Added mine lighting for my first world NVE problems
    --Light Up at Night..or sometimes not at all :(
    MineLights = {
        vector4(-595.52, 2086.38, 132.90 + 1.03, 0.0),
        vector4(-594.30, 2082.89, 132.95 + 1.03, 0.0),
        vector4(-591.85, 2073.95, 132.95 + 1.03, 0.0),
        vector4(-589.98, 2066.16, 132.52 + 1.03, 0.0),
        vector4(-588.92, 2059.21, 132.17 + 1.03, 0.0),
        vector4(-588.69, 2054.36, 131.83 + 1.03, 0.0),
        vector4(-587.11, 2048.25, 131.20 + 1.03, 0.0),
        vector4(-584.51, 2041.63, 130.76 + 1.03, 0.0),
        vector4(-580.87, 2035.56, 130.22 + 1.03, 0.0),
        vector4(-576.07, 2028.91, 129.66 + 1.03, 0.0),
        vector4(-571.74, 2023.9, 129.31 + 1.03, 0.0),
        vector4(-565.44, 2017.63, 128.97 + 1.03, 0.0),
        vector4(-561.39, 2012.64, 128.78 + 1.03, 0.0),
        vector4(-558.24, 2008.18, 128.66 + 1.03, 0.0),
        vector4(-553.94, 2001.05, 128.66 + 1.03, 0.0),
        vector4(-549.67, 1994.23, 128.66 + 1.03, 0.0),
        vector4(-545.35, 1986.81, 128.63 + 1.03, 0.0),
        vector4(-543.0, 1982.82, 128.63 + 1.03, 0.0),
        vector4(-534.72, 1981.34, 128.72 + 1.03, 0.0),
        vector4(-526.63, 1979.63, 128.64 + 1.03, 0.0),
        vector4(-515.62, 1979.07, 128.01 + 1.03, 0.0),
        vector4(-506.55, 1979.26, 127.44 + 1.03, 0.0),
        vector4(-499.81, 1980.19, 126.88 + 1.03, 0.0),
        vector4(-490.67, 1983.73, 126.01 + 1.03, 0.0),
        vector4(-479.18, 1987.91, 125.48 + 1.03, 0.0),
        vector4(-468.53, 1992.32, 125.1 + 1.03, 0.0),
        vector4(-462.7, 1996.76, 125.05 + 1.03, 0.0),
        vector4(-456.57, 2002.97, 125.02 + 1.03, 0.0),
        vector4(-450.79, 2009.94, 125.55 + 1.03, 0.0),
        vector4(-445.25, 2014.22, 125.57 + 1.03, 0.0),
    },
    WorkLights = {
        vector4(-593.9, 2076.57, 131.27, 233.24),
        vector4(-594.11, 2078.02, 131.3, 318.99),
        vector4(-592.11, 2069.46, 131.13, 224.91),
        vector4(-590.57, 2062.08, 130.8, 214.27),
        vector4(-589.57, 2054.82, 130.27, 217.82),
        vector4(-588.04, 2047.13, 129.65, 230.42),
        vector4(-584.95, 2039.96, 129.06, 225.12),
        vector4(-580.74, 2033.34, 128.47, 237.95),
        vector4(-576.23, 2027.24, 127.98, 242.31),
        vector4(-570.87, 2021.57, 127.5, 244.01),
        vector4(-565.69, 2015.97, 127.33, 251.45),
        vector4(-561.05, 2010.26, 127.1, 248.45),
        vector4(-557.0, 2003.95, 127.05, 242.28),
        vector4(-553.02, 1997.25, 126.99, 237.0),
        vector4(-549.29, 1990.84, 126.94, 224.48),
        vector4(-537.3, 1980.52, 126.9, 278.19),
        vector4(-529.79, 1979.09, 126.86, 295.72),
        vector4(-522.13, 1978.13, 126.59, 282.3),
        vector4(-514.44, 1977.77, 126.29, 297.0),
        vector4(-506.72, 1978.01, 126.02, 296.09),
        vector4(-498.89, 1979.11, 125.65, 316.07),
        vector4(-491.77, 1981.93, 124.82, 320.17),
        vector4(-484.83, 1984.85, 124.17, 328.43),
        vector4(-477.71, 1987.12, 123.83, 290.95),
        vector4(-470.33, 1990.0, 123.57, 307.32),
        vector4(-463.85, 1994.29, 123.46, 327.1),
        vector4(-458.09, 1999.59, 123.47, 338.54),
        vector4(-445.97, 2011.57, 123.4, 308.83),
    },

    ------------------------------------------------------------
    --Mining Store Items
    Items = {
        label = "Mining Store",
        slots = 5,
        items = {
            { name = "goldpan",           price = 2500,        amount = 100, info = {}, type = "item", slot = 1, },
            { name = "pickaxe",           price = 100,         amount = 100, info = {}, type = "item", slot = 2, },
            { name = "miningdrill",       price = 18000,       amount = 50,  info = {}, type = "item", slot = 3, },
            { name = "mininglaser",       price = 60000,       amount = 5,   info = {}, type = "item", slot = 4, },
            { name = "drillbit",          price = 35,          amount = 100, info = {}, type = "item", slot = 5, },
        },
    },
}
Crafting = {
    SmeltMenu = {
    },
    -- Smelting
    GoldMenu = {
        { goldbar     = { goldingot        = 2 } },
        { goldingot   = { goldore          = 1 } },
        { goldingot   = { gold_ring        = 3 } },
        { goldingot   = { goldchain        = 3 } },
        { goldingot   = { goldearring      = 3 } },
    },
    SilverMenu = {
        { silverbar   = { silveringot      = 2 } },
        { silveringot = { silverore        = 1 } },
        { silveringot = { silver_ring      = 1 } },
        { silveringot = { silverchain      = 1 } },
        { silveringot = { silverearring    = 1 } },
    },
    IronMenu = {
        { iron = { ironore = 1 } },
    },
    SteelMenu = {
        { steel = { ironore = 2, carbon = 1 } },
        { steelbars = { steel = 10 } },
        { steelplates = { steelbars = 2 } },
    },
    MiscMenu = {
        { copper =   { copperore = 1 }, amount = 4 },
        { aluminum = { can = 3, },      amount = 2 },
        { glass =    { bottle = 2, },   amount = 2 },
    },

    -- Jewellery crafting
    GemCut = {
        
        { opal = { uncut_opal = 1 }, },
        { ruby = { uncut_ruby = 1 }, },
        { sapphire = { uncut_sapphire = 1 }, },
        { emerald = { uncut_emerald = 1 }, },
        { diamond = { uncut_diamond = 1 }, },
        { amethyst = { uncut_amethyst = 1 }, },
        { onyx = { uncut_onyx = 1 }, },
        { citrinequartz = { uncut_citrinequartz = 1 }, },
    },
    GoldRings = {
        { gold_ring = { goldbar = 1 },                            amount = 5 },
        { diamond_ring_gold = { gold_ring = 1, diamond = 1 }, },
        { emerald_ring_gold = { gold_ring = 1, emerald = 1 }, },
        { ruby_ring_gold = { gold_ring = 1, ruby = 1 }, },
        { sapphire_ring_gold = { gold_ring = 1, sapphire = 1 }, },
        { opal_ring_gold = { gold_ring = 1, opal = 1 }, },
        { amethyst_ring_gold = { gold_ring = 1, amethyst = 1 }, },
        { onyx_ring_gold = { gold_ring = 1, onyx = 1 }, },
        { citrinequartz_ring_gold = { gold_ring = 1, citrinequartz = 1 }, },
    },
    SilverRings = {
        { silver_ring = { silverbar = 1 },                        amount = 2 },
        { diamond_ring_silver = { silver_ring = 1, diamond = 1 }, },
        { emerald_ring_silver = { silver_ring = 1, emerald = 1 }, },  
        { ruby_ring_silver = { silver_ring = 1, ruby = 1 }, },
        { sapphire_ring_silver = { silver_ring = 1, sapphire = 1 }, },
        { opal_ring_silver = { silver_ring = 1, opal = 1 }, },
        { amethyst_ring_silver = { silver_ring = 1, amethyst = 1 }, },
        { onyx_ring_silver = { silver_ring = 1, onyx = 1 }, },
        { citrinequartz_ring_silver = { silver_ring = 1, citrinequartz = 1 }, },
    },
    GoldNecklace = {
        { goldchain = { goldbar = 1 },                                amount = 5 },
        { diamond_necklace_gold = { goldchain = 1, diamond = 1 }, },
        { ruby_necklace_gold = { goldchain = 1, ruby = 1 }, },
        { sapphire_necklace_gold = { goldchain = 1, sapphire = 1 }, },
        { emerald_necklace_gold = { goldchain = 1, emerald = 1 }, },
        { opal_necklace_gold = { goldchain = 1, opal = 1 }, },
        { amethyst_necklace_gold = { goldchain = 1, amethyst = 1 }, },
        { onyx_necklace_gold = { goldchain = 1, onyx = 1 }, },
        { citrinequartz_necklace_gold = { goldchain = 1, citrinequartz = 1 }, },
    },
    SilverNecklace = {
        { silverchain = { silverbar = 1 },                            amount = 2 },
        { diamond_necklace_silver = { silverchain = 1, diamond = 1 }, },
        { ruby_necklace_silver = { silverchain = 1, ruby = 1 }, },
        { sapphire_necklace_silver = { silverchain = 1, sapphire = 1 }, },
        { emerald_necklace_silver = { silverchain = 1, emerald = 1 }, },
        { opal_necklace_silver = { silverchain = 1, opal = 1 }, },
        { amethyst_necklace_silver = { silverchain = 1, amethyst = 1 }, },
        { onyx_necklace_silver = { silverchain = 1, onyx = 1 }, },
        { citrinequartz_necklace_silver = { silverchain = 1, citrinequartz = 1 }, },
    },
    GoldEarring = {
        { goldearring = { goldbar = 1 },                               amount = 5 },
        { diamond_earring_gold = { goldearring = 1, diamond = 1 }, },
        { ruby_earring_gold = { goldearring = 1, ruby = 1 }, },
        { sapphire_earring_gold = { goldearring = 1, sapphire = 1 }, },
        { emerald_earring_gold = { goldearring = 1, emerald = 1 }, },
        { opal_earring_gold = { goldearring = 1, opal = 1 }, },
        { amethyst_earring_gold = { goldearring = 1, amethyst = 1 }, },
        { onyx_earring_gold = { goldearring = 1, onyx = 1 }, },
        { citrinequartz_earring_gold = { goldearring = 1, citrinequartz = 1 }, },

        { diamond_earring_silver = { silverearring = 1, diamond = 1 }, },
        { ruby_earring_silver = { silverearring = 1, ruby = 1 }, },
        { sapphire_earring_silver = { silverearring = 1, sapphire = 1 }, },
        { emerald_earring_silver = { silverearring = 1, emerald = 1 }, },
        { opal_earring_silver = { silverearring = 1, opal = 1 }, },
        { amethyst_earring_silver = { silverearring = 1, amethyst = 1 }, },
        { onyx_earring_silver = { silverearring = 1, onyx = 1 }, },
        { citrinequartz_earring_silver = { silverearring = 1, citrinequartz = 1 }, },
    },
    SilverEarring = {
        { silverearring = { silverbar = 1 },                           amount = 2 },
        { diamond_earring_silver = { silverearring = 1, diamond = 1 }, },
        { ruby_earring_silver = { silverearring = 1, ruby = 1 }, },
        { sapphire_earring_silver = { silverearring = 1, sapphire = 1 }, },
        { emerald_earring_silver = { silverearring = 1, emerald = 1 }, },
        { opal_earring_silver = { silverearring = 1, opal = 1 }, },
        { amethyst_earring_silver = { silverearring = 1, amethyst = 1 }, },
        { onyx_earring_silver = { silverearring = 1, onyx = 1 }, },
        { citrinequartz_earring_silver = { silverearring = 1, citrinequartz = 1 }, },
    },
}

K4MB1 = {
    MineStore = {},
    Smelter  = {},
    Cracking = {},
    OreBuyer = {},
    JewelCut = {},
    OrePositions = {
        vector4(2906.33, 2736.05, 44.85, 56.09),
        vector4(2906.98, 2732.64, 43.97 + 1.03, 228.42),
        vector4(2895.52, 2718.07, 44.55 + 1.03, 102.59),
        vector4(2909.66, 2707.41, 45.23, 118.57),
        vector4(2930.71, 2693.23, 45.59 + 1.03, 246.69),
        vector4(2908.31, 2696.03, 47.1 + 1.03, 58.8),
        vector4(2908.64, 2692.78, 47.07 + 1.03, 121.55),
        vector4(2903.67, 2676.71, 45.94, 306.38),
        vector4(2890.67, 2679.4, 44.65 + 1, 105.51),
        vector4(2892.87, 2701.2, 49.69 + 1, 283.39),
        vector4(2876.53, 2707.35, 49.2 + 1, 31.29),
        vector4(2866.6, 2677.91, 47.55 + 1, 238.85),
        vector4(2859.34, 2668.93, 46.27, 260.51),
        vector4(2858.56, 2663.24, 46.0, 256.02),
        vector4(2865.12, 2664.62, 48.21 + 1.03, 0.18),
        vector4(2868.6, 2669.71, 48.78, 5.38),
        vector4(2901.05, 2684.32, 47.24, 313.73),
        vector4(2878.87, 2686.39, 47.72 + 1.03, 0),

        vector4(2888.54, 2634.12, 42.84, 207.17),
        vector4(2879.55, 2650.4, 43.69 + 1, 30.79),
        vector4(2896.32, 2648.31, 40.75 + 1, 301.66),
        vector4(2808.16, 2650.5, 38.6 + 1, 44.41),
        vector4(2792.43, 2640.55, 39.25 + 1, 77.72),
        vector4(2793.12, 2632.56, 38.74 + 1, 128.98),
        vector4(2799.6, 2629.53, 40.69 + 1, 189.92),
        vector4(2812.47, 2633.02, 41.19 + 0.6, 168.98),

        vector4(2817.65, 2590.74, 32.84 + 0.5, 121.44),
        vector4(2835.04, 2600.4, 35.23 + 0.2, 215.07),
        vector4(2837.77, 2605.3, 35.67 + 0.6, 296.09),

        vector4(2819.55, 2606.31, 37.98 + 0.5, 59.71),
        vector4(2823.73, 2611.07, 38.6 + 0.5, 49.71),
        vector4(2827.98, 2611.26, 34.45 + 0.5, 40.74),
        
    }
}

Config.Tiers.IPL.GTAOHouseLow1 = {
    ipl = "GTAOHouseLow1",
    exit = vector4(266.13, -1007.35, -101.01, 1.68),
    guards = {
        dog = {
            coords = vector4(265.93, -1002.76, -99.01, 181.32),                 -- dog coords
            model = "A_C_Rottweiler",                                           -- dog model
            anim = {
                animdict = "creatures@rottweiler@amb@world_dog_barking@idle_a", -- dog animdict
                animation = "idle_a",                                           -- dog animation name
            },
            treatedanim = {
                animdict = "creatures@rottweiler@amb@world_dog_sitting@base",
                animation = "base"
            }
        },
        human = {
            [1] = {
                model = "U_M_Y_SmugMech_01", -- guard model
                anim = {
                    animdict = "anim@amb@nightclub@lazlow@lo_sofa@",
                    animation = "lowsofa_dlg_notagain_laz",             -- guard animation name
                },
                coords = vector4(262.67, -1004.3, -98.27 - 1.0, 169.9), --guard coords
                netid = nil,
            },
        },
    },
    loot = {
        [1] = {
            isobject = true,
            data = {
                name = "prop_boombox_01",
                coords = vector3(263.35543823242, -994.68505859375, -98.803260803223),
                label = "Take Boombox",
                icon = "fas fa-headphones",
                itemname = "boombox"
            }
        },
        [2] = {
            isobject = true,
            isopen = false,     -- this one is only if the props is not single loot (stash)
            minigame = "drill", -- you can see all the minigame type on `shared/hack.lua` line 49
            -- REMEMBER! only put this one if the props is not single loot
            items = {
                type = "safe",
            },
            data = {
                name = "prop_ld_int_safe_01", -- our prop name
                coords = vec3(258.6966857910156, -999.2167358398438, -99.53580474853516),
                rotation = vec3(0, 0, 97.7616958618164),
                label = "Crack Safe",       -- target label when it's locked
                openlabel = "Open Safe",    -- target label when it's unlocked
                icon = "fas fa-lock",       -- target icon when locked
                openicon = "fas fa-unlock", -- target icon when unlocked
                forceOnGround = true,       -- to make it on ground properly
            }
        },
        [3] = {
            isobject = false,
            minigame = "lockpick", -- this one is optional, if there is no minigame, it mean the stash will be unlocked
            isopen = false,
            -- only use below if it's not a singleloot
            items = {
                type = "kitchen", -- you can see the item type in server/functions/LootHandle.lua line 24
            },
            data = {
                -- paste created zone data below
                name = "cabinet_1",
                coords = vec3(264.15, -994.65, -98.05),
                size = vec3(1.1, 0.5, 1),
                rotation = 0.0,
                ---
                label = "Lockpick Cabinet",
                openlabel = "Open Cabinet"
            },
        },
        [4] = {
            isobject = false,
            isopen = false,
            items = {
                type = "fridge"
            },
            data = {
                name = "fridge_1",
                coords = vec3(266.1, -997.6, -99.05),
                size = vec3(0.35, 0.8, 1.85),
                rotation = 0.0,
                label = "Search Fridge",
                openlabel = "Open Fridge",
                icon = "fas fa-utensils",
                openicon = "fas fa-utensils",
            }
        },
        [5] = {
            isobject = true,
            data = {
                name = "prop_tv_03",
                coords = vector3(256.73229980469, -995.44805908203, -98.860565185547),
                label = "Take TV",
                icon = "fas fa-tv",
                itemname = "tube_tv"
            }
        },
        [6] = {
            isobject = true,
            data = {
                name = "prop_tv_flat_03",
                coords = vec3(262.689453125, -1001.8477172852, -99.289253234863),
                label = "Take TV",
                icon = "fas fa-tv",
                itemname = "tv"
            }
        }
    },
}

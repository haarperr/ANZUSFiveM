Config.Tiers.Shell.v16low = {
    exit = vec4(4.6300048828125, -6.239990234375, -4.6519546508789 + 1.0, 3.87),
    shell = "shell_v16low",
    guards = {
        dog = {
            coords = vec4(4.550048828125, -1.5699462890625, -2.6519546508789, 183.75),
            model = "a_c_rottweiler",
            anim = {
                animdict = "creatures@rottweiler@amb@world_dog_barking@idle_a",
                animation = "idle_a",
            },
            treatedanim = {
                animdict = "creatures@rottweiler@amb@world_dog_sitting@base",
                animation = "base"
            }
        },
        human = {
            [1] = {
                model = "g_m_y_ballaorig_01",
                anim = {
                    animdict = "timetable@ron@ron_ig_2_alt1",
                    animation = "ig_2_alt1_base",
                },
                coords = vec4(-0.989990234375, 4.9400634765625, -0.6519546508789, 109.35),
            }
        }
    },
    furnitures = {
        [1] = {
            hashname = "miss_rub_couch_01",
            rotation = { x = 0, y = 0, z = -69.29768371582031 },
            position = vec3(-0.01806640625, 4.83447265625, -3.6932983398438),
            forceOnGround = true
        },
        [2] = {
            hashname = "prop_tv_cabinet_03",
            rotation = { x = 0, y = 0, z = 128.8037567138672 },
            position = vec3(-2.2982177734375, 2.874755859375, -3.654914855957),
            forceOnGround = true,
        },
        [3] = {
            hashname = "apa_mp_h_floorlamp_c",
            rotation = { x = 0, y = 0, z = 0 },
            position = vec3(-5.0361328125, 6.1195068359375, -3.6488265991211),
            forceOnGround = true,
        },
        [4] = {
            hashname = "prop_rub_cabinet03",
            rotation = { x = 0, y = 0, z = 91.517578125 },
            position = vec3(-5.20703125, 2.3541259765625, -3.6562576293945),
            forceOnGround = true
        },
        [5] = {
            hashname = "gr_prop_bunker_bed_01",
            rotation = { x = 0, y = 0, z = 78.7548828125 },
            position = vec3(-3.205810546875, 5.576904296875, -3.6543273925781),
            forceOnGround = true
        },
        [6] = {
            hashname = "prop_rub_boxpile_01",
            rotation = { x = 0, y = 0, z = -88.15953826904297 },
            position = vec3(2.9849853515625, -2.291259765625, -3.6543273925781),
            forceOnGround = true
        },
        [7] = {
            hashname = "prop_ld_tshirt_02",
            position = vec3(1.233154296875, 2.877685546875, -3.6241149902344),
            rotation = { x = 0, y = 0, z = -61.15003204345703 },
            forceOnGround = true,
        }
    },
    loot = {
        [1] = {
            isobject = true,
            name = "prop_tv_01",
            data = {
                coords = vec3(-2.2469482421875, 2.8480224609375, -2.7299575805664),
                rotation = {
                    x = 0, y = 0, z = 123.459
                },
                label = "Take TV",
                icon = "fas fa-tv",
                itemname = "tube_tv",
                islooted = false,
                forceOnGround = true,
            },
        },
        [2] = {
            isobject = true,
            name = "prop_microwave_1",
            data = {
                coords = vec3(2.15869140625, 6.3038330078125, -2.6948547363281),
                rotation = {
                    x = 0, y = 0, z = 4.35304403305053
                },
                label = "Take Microwave",
                icon = "fas fa-kitchen-set",
                itemname = "microwave",
                islooted = false,
                forceOnGround = true,
            }
        },
        [3] = {
            isobject = true,
            name = "hei_heist_sh_bong_01",
            data = {
                coords = vec3(-5.18017578125, 1.86572265625, -1.9571533203125),
                rotation = {
                    x = 0, y = 0, z = 0
                },
                label = "Take Bong",
                icon = "fas fa-cannabis",
                itemname = "bong",
                islooted = false,
                forceOnGround = true,
            }
        },
        [4] = {
            minigame = "lockpick", -- if this is commented out, that mean the cabinet will be unlocked
            isopen = false,
            isobject = true,
            name = "prop_rub_cabinet01",
            data = {
                coords = vec3(2.197509765625, -0.1278076171875, -3.6562576293945), -- the coords we get from `getoffset` command
                rotation = {
                    x = 0, y = 0, z = -180.0
                },                          -- the rotation that we copied from dolu tool
                forceOnGround = true,
                label = "Lockpick cabinet", -- label when it's locked
                openlabel = "Open Cabinet",
            },
            items = {
                type = "general", -- item type, you can see server/functions/LootHandle.lua line 24
            }
        },
        [5] = {
            isopen = false,
            isobject = false,
            items = {
                type = "fridge",
            },
            data = {
                name = "fridge_low_1",
                coords = vec3(-4.800048828125, -3.31005859375, -0.621955871582), -- Zones from offset (I've changed it a little bit because of the known issue)
                size = vec3(1.0, 1, 1.9),
                rotation = 0.0,
                label = "Open Fridge",
                openlabel = "Open Fridge",
                icon = "fas fa-hand",
                openicon = "fas fa-hand",
            }
        }
    }
}

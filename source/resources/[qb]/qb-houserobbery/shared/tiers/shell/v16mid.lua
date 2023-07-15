Config.Tiers.Shell.v16Mid = {
    exit = vec4(1.3900146484375, -14.2900390625, -3.4904556274414, 2.59),
    shell = "shell_v16mid",
    guards = {
        dog = {
            coords = vector4(1.6300048828125, -7.1199951171875, -0.0, 179.843704),
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
                    animdict = "anim@amb@nightclub@lazlow@lo_sofa@",
                    animation = "lowsofa_dlg_notagain_laz",
                },
                coords = vector4(-2.737854, 3.199341, -0.051323, 261.778961),
                netid = nil,
                sleep = true
            }
        }
    },
    furnitures = {
        [1] = {
            hashname = "apa_mp_h_bed_double_09",
            rotation = { x = 0, y = 0, z = 90.0 },
            position = vec3(3.2291259765625, 2.416748046875, -4.9919891357422),
            forceOnGround = true,
        },
        [2] = {
            hashname = "prop_rub_cabinet02",
            rotation = { x = 0, y = 0, z = 0 },
            position = vec3(3.6732177734375, 5.989013671875, -4.5),
            forceOnGround = true,
        },
        [3] = {
            hashname = "bkr_prop_fakeid_table",
            rotation = { x = 0, y = 0, z = 0 },
            position = vec3(2.673095703125, -14.141723632813, -4.4934921264648),
            forceOnGround = true,
        },
        [4] = {
            hashname = "apa_mp_h_acc_vase_flowers_03",
            rotation = { x = 0, y = 0, z = 0 },
            position = vec3(2.7259521484375, -14.247802734375, -3.6856918334961),
            forceOnGround = true,
        },
        [5] = {
            hashname = "prop_tv_cabinet_04",
            rotation = { x = 0, y = 0, z = 90.0 },
            position = vec3(0.5076904296875, -2.446044921875, -4.4897918701172),
            forceOnGround = true,
        },
        [6] = {
            hashname = "prop_tv_cabinet_03",
            rotation = { x = 0, y = 0, z = -90.0 },
            position = vec3(0.685546875, 3.31005859375, -4.4888153076172),
            forceOnGround = true,
        },
        [7] = {
            hashname = "prop_couch_lg_08",
            rotation = { x = 0, y = 0, z = 93.44673919677736 },
            position = vec3(-2.89453125, 2.146484375, -4.5902481079102),
            forceOnGround = true,
        },
        [8] = {
            hashname = "apa_mp_h_acc_rugwoolm_04",
            rotation = { x = 0, y = 0, z = 0 },
            position = vec3(-1.056884765625, 2.950927734375, -4.487678527832),
            forceOnGround = true,
        },
        [9] = {
            hashname = "prop_t_coffe_table",
            rotation = { x = 0, y = 0, z = 85.5800552368164 },
            position = vec3(-1.404296875, 3.0433349609375, -4.2384796142578),
            forceOnGround = true,
        },
        [10] = {
            hashname = "apa_mp_h_floorlamp_a",
            rotation = { x = 0, y = 0, z = 0 },
            position = vec3(0.5728759765625, 5.8170166015625, -4.4851837158203),
            forceOnGround = true,
        },

    },
    loot = {
        [1] = {
            minigame = "lockpick",
            isopen = false,
            isobject = true,
            name = "ex_prop_adv_case_sm_02",
            data = {
                coords = vec3(7.5816650390625, -1.1263427734375, -4.2705459594727),
                rotation = {
                    x = 0, y = 0, z = -90.0
                },
                forceOnGround = true,
                icon = "fas fa-lock",
                label = "Lockpick case",
                openlabel = "Open case",
                openicon = "fas fa-lock-open",
            },
            items = {
                type = "general",
            }
        },
        [2] = {
            minigame = "drill",
            isopen = false,
            isobject = true,
            name = "prop_ld_int_safe_01",
            data = {
                coords = vec3(7.424560546875, 5.6986083984375, -4.0204238891602),
                rotation = {
                    x = 0, y = 0, z = -32.23638916015625
                },
                forceOnGround = true,
                label = "Drill the safe",
                openlabel = "Open safe",
                icon = "fas fa-lock",
                openicon = "fas fa-lock-open",
            },
            items = {
                type = "safe",
            }
        },
        [3] = {
            isobject = true,
            islooted = false,
            name = "prop_bong_01",
            data = {
                coords = vec3(0.58984375, -2.23876953125, -3.8382415771484),
                rotation = {
                    x = 0, y = 0, z = 0
                },
                forceOnGround = true,
                label = "Take bong",
                icon = "fas fa-cannabis",
                itemname = "bong",
            }
        },
        [4] = {
            isobject = true,
            islooted = false,
            name = "prop_tv_01",
            data = {
                coords = vec3(0.697509765625, 3.32763671875, -3.5629196166992),
                rotation = {
                    x = 0, y = 0, z = -92.3553466796875
                },
                forceOnGround = true,
                label = "Take TV",
                icon = "fas fa-tv",
                itemname = "tube_tv",
            }
        },
        [5] = {
            isobject = true,
            isopen = false,
            minigame = "lockpick",
            name = "hei_heist_bed_chestdrawer_04",
            data = {
                coords = vec3(3.2938232421875, -3.3203125, -4.4911956787109),
                rotation = {
                    x = 0, y = 0, z = -90.0
                },
                forceOnGround = true,
                label = "Lockpick drawer",
                icon = "fas fa-lock",
                openlabel = "Open drawer",
                openicon = "fas fa-lock-open",
            },
            items = {
                type = "general",
            }
        }
    }
}

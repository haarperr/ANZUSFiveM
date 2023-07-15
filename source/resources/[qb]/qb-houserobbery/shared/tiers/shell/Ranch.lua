Config.Tiers.Shell.Ranch = {
    exit = vector4(-0.36, -5.89, -2.899, 358.21),
    shell = "shell_frankaunt",
    guards = {
        dog = {
            coords = vector4(-0.52001953125, -2.43994140625, -0.5736427307129, 182.438446),
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
                coords = vector4(-3.956787, -6.140015, -0.0, 263.383728),
                netid = nil,
                sleep = true
            }
        }
    },
    furnitures = {
        [1] = {
            hashname = "prop_couch_lg_02",
            rotation = { x = 0, y = 0, z = -270.451111 },
            position = vector3(-5.028564, 0.147583, -1.559914),
            forceOnGround = true,
        },
        [2] = {
            hashname = "hei_heist_stn_sofa3seat_06",
            rotation = {
                x = 0.0,
                y = -0.0,
                z = 270.325,
            },
            position = vec3(5.237670, 1.489746, -3.559962),
            forceOnGround = true,
        },
        [4] = {
            hashname = "v_res_tre_bed2",
            rotation = {
                x = -0.0,
                y = -0.0,
                z = -180.675,
            },
            position = vec3(-3.864502, -6.461518, -3.559964),
            forceOnGround = true,
        },
        [5] = {
            hashname = "prop_tv_cabinet_04",
            rotation = {
                x = -0.0,
                y = -0.0,
                z = -89.485,
            },
            position = vec3(5.293334, -4.255706, -3.559996),
            forceOnGround = true,
        },
        [6] = {
            hashname = "v_res_fh_coftbldisp",
            rotation = {
                x = 0.0,
                y = -0.0,
                z = -90.2,
            },
            position = vec3(3.252930, 1.630524, -3.559964),
            forceOnGround = true,
        },
        [7] = {
            hashname = "apa_mp_h_lit_floorlampnight_07",
            rotation = {
                x = 0.0,
                y = 0.0,
                z = -133.65,
            },
            position = vec3(5.250732, 3.345886, -3.552152),
            forceOnGround = true,
        },
        [8] = {
            hashname = "apa_mp_h_acc_rugwoolm_04",
            rotation = {
                x = 0.0,
                y = 0.0,
                z = 0.0,
            },
            position = vec3(4.590454, -4.379548, -3.560392),
            forceOnGround = true,
        },
        [11] = {
            hashname = "prop_el_guitar_03",
            rotation = {
                x = -11.825,
                y = 2.75,
                z = -94.875000000002,
            },
            position = vec3(5.623780, -3.150634, -2.969020 - 1.799),
            forceOnGround = true,
        },
        [12] = {
            hashname = "hei_heist_stn_sofa2seat_06",
            rotation = {
                x = 0.0,
                y = 0.0,
                z = 103.4,
            },
            position = vec3(2.630616, -4.423858, -3.575214),
            forceOnGround = true,
        },
    },
    loot = {
        [1] = {
            minigame = "drill",
            isopen = false,
            isobject = true,
            name = "prop_ld_int_safe_01",
            data = {
                coords = vec3(-5.227050, -3.447082, -3.087152),
                rotation = {
                    x = 0.0,
                    y = 0.0,
                    z = 90.75,
                },
                forceOnGround = true,
                icon = "fas fa-lock",
                label = "Crack the safe",
                openlabel = "Open safe",
                openicon = "fas fa-lock-open",
            },
            items = {
                type = "safe",
            },
        },
        [2] = {
            minigame = "lockpick",
            isopen = true,
            isobject = true,
            name = "v_res_d_sideunit",
            data = {
                coords = vec3(5.458130, -7.108460, -3.012738),
                rotation = {
                    x = 0.0,
                    y = 0.0,
                    z = -89.87,
                },
                forceOnGround = true,
                label = "Lockpick Drawers",
                openlabel = "Open Drawers",
            },
            items = {
                type = "general",
            },
        },
        [3] = {
            isobject = true,
            name = "prop_tv_flat_michael",
            data = {
                coords = vec3(5.569946, -4.287934, -1.933274 - 1.5),
                rotation = {
                    x = 0.0,
                    y = 0.0,
                    z = -89.375,
                },
                label = "Take TV",
                icon = "fas fa-tv",
                itemname = "tv",
                islooted = false,
            },
        },
        [4] = {
            items = {
                type = "fridge"
            },
            data = {
                name = "fridge",
                coords = vec3(-3.795532, -4.533325, 0.569931),
                size = vec3(1, 1, 2.4),
                rotation = 273.216980,
                openlabel = "Open Fridge"
            }
        },
        [5] = {
            minigame = "lockpick",
            items = {
                type = "kitchen"
            },
            data = {
                name = "your:name",
                coords = vec3(-2.273682, -6.739380, 0.469939),
                size = vec3(1.0, 0.8, 1.4),
                rotation = 0.860162,
                label = "Lockpick kitchen cabinet",
                openlabel = "Open Cabinet",
                icon = "fas fa-lock",
                openicon = "fas fa-lock-open",
            }
        },
    },
}

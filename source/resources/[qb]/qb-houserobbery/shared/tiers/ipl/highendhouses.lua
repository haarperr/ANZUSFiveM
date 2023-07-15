Config.Tiers.IPL.highendhouses = {
    ipl = "GTAOHouseHi1Object",
    exit = vector4(-174.41, 497.58, 137.67, 188.6),
    guards = {
        dog = {
            coords = vector4(-171.83, 492.25, 137.65, 20.79),
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
                model = "a_m_m_mexcntry_01",
                anim = {
                    animdict = "anim@amb@nightclub@lazlow@lo_sofa@",
                    animation = "lowsofa_dlg_notagain_laz",
                },
                coords = vector4(-163.55, 483.43, 134.56, 17.18),
                netid = nil,
                sleep = true,
            },
            [2] = {
                model = "a_m_m_mexcntry_01",
                anim = {
                    animdict = "timetable@ron@ig_3_couch",
                    animation = "base",
                },
                coords = vector4(-167.16, 482.78, 137.27, 286.2),
                netid = nil,
            },
        },
    },
    loot = {
        [1] = {
            minigame = "lockpick",
            isopen = false,
            items = {
                type = "general",
            },
            data = {
                name = "target:ipl",
                coords = vec3(-162.8, 485.2, 133.4),
                size = vec3(0.7, 0.9, 0.7),
                rotation = 10.5,
                label = "Loot Stash",
            },
        },
        [2] = {
            minigame = "lockpick",
            isopen = false,
            items = {
                type = "kitchen",
            },
            data = {
                name = "kitchen",
                coords = vec3(-170.35, 496.25, 137.8),
                size = vec3(1.7, 0.7, 2.25),
                rotation = 11.25,
                label = "Loot kitchen",
                openlabel = "Open Kitchen Stash",
            },
        },
        [3] = {
            minigame = "lockpick",
            isopen = false,
            items = {
                type = "bedroom",
            },
            data = {
                name = "bedroom:stash",
                coords = vec3(-170.95, 481.9, 133.4),
                size = vec3(0.9, 3.15, 1),
                rotation = 10.5,
                label = "Lockpick Stash",
                openlabel = "Open Bedroom Stash",
            },
        },
        [4] = {
            isobject = true,
            data = {
                name = "prop_laptop_01a",
                coords = vector3(-169.75, 490.14, 129.76),
                label = "Take Laptop",
                icon = "fas fa-laptop",
                itemname = "laptop",
                islooted = false,
            },
        },
        [5] = {
            minigame = "drill",
            isopen = false,
            items = {
                type = "weaponry",
            },
            data = {
                name = "ammunition",
                coords = vec3(-176.6, 491.95, 130.75),
                size = vec3(0.75, 1.5, 1.5),
                rotation = 11.0,
                label = "Drill Armory",
                openlabel = "Open Armory",
                icon = "fas fa-bolt",
            },
        },
        [6] = {
            isobject = true,
            data = {
                name = "prop_monitor_w_large",
                coords = vector3(-168.88, 492.27, 129.76),
                label = "Take Monitor",
                icon = "fas fa-laptop",
                itemname = "monitor",
                islooted = false,
            },
        },
        [7] = {
            isobject = true,
            data = {
                name = "prop_monitor_w_large",
                coords = vector3(-169.01, 493.11, 129.76),
                label = "Take Monitor",
                icon = "fas fa-laptop",
                itemname = "monitor",
                islooted = false,
            },
        },
        [8] = {
            isobject = true,
            data = {
                name = "prop_printer_01",
                coords = vector3(-175.6, 489.1, 129.77),
                label = "Take Printer",
                icon = "fas fa-laptop",
                itemname = "printer",
                islooted = false,
            }
        },
        [9] = {
            isobject = true,
            data = {
                name = "v_res_mm_audio",
                coords = vector3(-169.66, 495.14, 129.77),
                label = "Take Speaker",
                icon = "fas fa-volume-off",
                itemname = "speaker",
                islooted = false,
            }
        },
        [10] = {
            isobject = true,
            data = {
                name = "prop_micro_02",
                coords = vector3(-164.41, 494.48, 137.75),
                label = "Take Microwave",
                icon = "fas fa-kitchen-set",
                itemname = "microwave",
                islooted = false,
            }
        },
        [11] = {
            isobject = true,
            data = {
                name = "prop_player_phone_01",
                coords = vector3(-169.81, 495.08, 129.86),
                label = "Take Phone",
                icon = "fas fa-mobile-alt",
                itemname = "phone",
                islooted = false,
            }
        },
        [12] = {
            isobject = true,
            isopen = false,
            minigame = "drill",
            items = {
                type = "safe",
            },
            data = {
                name = "prop_ld_int_safe_01",
                coords = vec3(-174.5751953125, 489.0419921875, 129.5164031982422),
                rotation = vec3(0, 0, -167.33078002929688),
                label = "Crack Safe",
                openlabel = "Open Safe",
                forceOnGround = true,
            }
        },
        [13] = {
            isobject = true,
            data = {
                name = "apa_mp_h_lit_lamptablenight_24",
                coords = vec3(-162.61123657227, 485.24468994141, 133.46865844727),
                label = "Take Lamp",
                itemname = "lamp",
            }
        },
        [14] = {
            isobject = true,
            data = {
                name = "apa_mp_h_lit_lamptablenight_24",
                coords = vec3(-162.02590942383, 482.23342895508, 133.46865844727),
                label = "Take Lamp",
                itemname = "lamp",
            }
        },
        [15] = {
            isobject = true,
            data = {
                name = "prop_npc_phone",
                coords = vector3(-171.18971252441, 482.55899047852, 133.81552124023),
                label = "Take Phone",
                icon = "fas fa-mobile-alt",
                itemname = "phone",
                islooted = false,
            }
        },
        [16] = {
            isobject = true,
            data = {
                name = "prop_mp3_dock",
                coords = vector3(-171.25436401367, 482.55218505859, 133.80052185059),
                label = "Take Speaker",
                icon = "fas fa-volume-off",
                itemname = "speaker",
                islooted = false,
            }
        },
        [17] = {
            isobject = true,
            data = {
                name = "prop_wine_bot_01",
                coords = vector3(-169.84367370605, 494.10549926758, 137.60432434082),
                label = "Take Wine Bottle",
                icon = "fas fa-wine-bottle",
                itemname = "wine",
                islooted = false,
            }
        },
        [18] = {
            isobject = true,
            data = {
                name = "prop_keyboard_01b",
                coords = vec3(-169.31816101074, 492.84365844727, 129.7635345459),
                label = "Take Keyboard",
                icon = "fas fa-keyboard",
                itemname = "keyboard",
                islooted = false,
            }
        },
        [19] = {
            isobject = true,
            data = {
                name = "prop_bong_01",
                coords = vec3(-166.36999511719, 482.2737121582, 136.7180480957),
                label = "Take Bong",
                icon = "fas fa-cannabis",
                itemname = "bong",
                islooted = false,
            }
        },
        [20] = {
            minigame = "lockpick",
            isopen = false,
            items = {
                type = "general",
            },
            data = {
                name = "general",
                coords = vec3(-170.15, 490.25, 129.5),
                size = vec3(0.75, 0.75, 0.5),
                rotation = 12.0,
                label = "Lockpick Cabinet",
                openlabel = "Open Cabinet",
                icon = "fas fa-lock",
            },
        },

        [21] = {
            isobject = false,
            islooted = false,
            data = {
                name = "small_painting_1",
                coords = vec3(-171.9, 484.7, 134.9),
                size = vec3(1, 0.1, 1.0),
                rotation = 281.0,
                itemname = "small_painting",
                label = "Take Painting",
                icon = "fas fa-paint-brush",
            }
        },
        [22] = {
            isobject = false,
            islooted = false,
            data = {
                name = "small_painting_2",
                coords = vec3(-171.95, 484.7, 133.8),
                size = vec3(1, 0.1, 1.0),
                rotation = 281.0,
                itemname = "small_painting",
                label = "Take Painting",
                icon = "fas fa-paint-brush",
            }
        },
        [23] = {
            isobject = false,
            islooted = false,
            data = {
                name = "small_painting_2",
                coords = vec3(-169.1, 494.3, 131.0),
                size = vec3(0.8, 0.1, 1.0),
                rotation = 101.25,
                itemname = "small_painting",
                label = "Take Painting",
                icon = "fas fa-paint-brush",
            }
        },
        [24] = {
            isobject = false,
            islooted = false,
            data = {
                name = "small_painting_3",
                coords = vec3(-168.9, 493.2, 131.05),
                size = vec3(0.8, 0.1, 1.0),
                rotation = 101.0,
                itemname = "small_painting",
                label = "Take Painting",
                icon = "fas fa-paint-brush",
            }
        },
        [25] = {
            isobject = false,
            islooted = false,
            data = {
                name = "small_painting_4",
                coords = vec3(-168.65, 492.2, 131.05),
                size = vec3(0.8, 0.1, 1.0),
                rotation = 101.0,
                itemname = "small_painting",
                label = "Take Painting",
                icon = "fas fa-paint-brush",
            }
        },
        [26] = {
            isobject = false,
            islooted = false,
            data = {
                name = "small_painting_5",
                coords = vec3(-168.45, 491.2, 131.05),
                size = vec3(0.8, 0.1, 1.0),
                rotation = 101.0,
                itemname = "small_painting",
                label = "Take Painting",
                icon = "fas fa-paint-brush",
            }
        },
        [27] = {
            isobject = false,
            islooted = false,
            data = {
                name = "tv_big",
                coords = vec3(-162.0, 482.8, 137.65),
                size = vec3(0.25, 2.25, 1.35),
                rotation = 9.75,
                itemname = "tv",
                label = "Take TV",
                icon = "fas fa-tv"
            }
        }
    },
}

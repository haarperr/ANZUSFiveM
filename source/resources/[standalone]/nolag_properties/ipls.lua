
ExecApartmentsInfo = {
    prices = {
        ["Theme"] = 1000,
    },
    defaultValues = {
        Theme = 1,
    },
    Themes = {
        "Modern",
        "Moody",
        "Vibrant",
        "Sharp",
        "Monochrome",
        "Seductive",
        "Regal",
        "Aqua",
    }
}

OfficesInfo = {
    prices = {
        ["Title"] = 1000,
        ["TitleColor"] = 1000,
        ["TitleStyle"] = 1000,
        ["TitleFont"] = 1000,
        ["Theme"] = 1000,
        ["SafeLeftDoor"] = 1000,
        ["SafeRightDoor"] = 1000,
        ["Chairs"] = 1000,
        ["Booze"] = 1000,
        ["BoozeCigsA"] = 1000,
        ["BoozeCigsB"] = 1000,
        ["BoozeCigsC"] = 1000,
        ["CounterfeitA"] = 1000,
        ["CounterfeitB"] = 1000,
        ["CounterfeitC"] = 1000,
        ["GunsA"] = 1000,
        ["GunsB"] = 1000,
        ["GunsC"] = 1000,
        ["DrugBagsA"] = 1000,
        ["DrugBagsB"] = 1000,
        ["DrugBagsC"] = 1000,
        ["DrugStatueA"] = 1000,
        ["DrugStatueB"] = 1000,
        ["DrugStatueC"] = 1000,
        ["ElectronicA"] = 1000,
        ["ElectronicB"] = 1000,
        ["ElectronicC"] = 1000,
    },
    defaultValues = {
        Organization = {
            name = "Organization Name",
            style = "normal", -- normal, light
            color = 1, -- black, gray, yellow, blue, orange, red, green
            font = 1 -- 1-13
        },
        Safe = {
            leftdoor = false,
            rightdoor = false,
        },
        Chairs = false,
        Booze = false,
        BoozeCigs = {
            A = false,
            B = false,
            C = false,
        },
        Counterfeit = {
            A = false,
            B = false,
            C = false,
        },
        Guns = {
            A = false,
            B = false,
            C = false,
        },
        DrugBags = {
            A = false,
            B = false,
            C = false,
        },
        DrugStatue = {
            A = false,
            B = false,
            C = false,
        },
        Electronic = {
            A = false,
            B = false,
            C = false,
        },
        Theme = 1 -- 1-9
    },
    -- Do not touch this below unless you know what you are doing
    Organization = {
        colors = {
            "black",
            "gray",
            "yellow",
            "blue",
            "orange",
            "red",
            "green"
        },
        fonts = {
            "font1",
            "font2",
            "font3",
            "font4",
            "font5",
            "font6",
            "font7",
            "font8",
            "font9",
            "font10",
            "font11",
            "font12",
            "font13",
        },
    },
    Themes = {
        'Warm',
        'Classical',
        'Vintage',
        'Contrast',
        'Rich',
        'Cool',
        'Ice',
        'Conservative',
        'Polished'
    },
}

NightClubsInfo = {
    prices = {
        ["Name"] = 1000,
        ["Style"] = 1000,
        ["Podium"] = 1000,
        ["Speakers"] = 1000,
        ["Security"] = 1000,
    },
    defaultValues = {
        Name = 1,
        Style = 1,
        Podium = 1,
        Speakers = 1,
        Security = 1,
    },
    Names = {
        [1] = {
            name = "galaxy",
            label = "Galaxy",
        },
        [2] = {
            name = "studio",
            label = "Studio Los Santos",
        },
        [3] = {
            name = "omega",
            label = "Omega",
        },
        [4] = {
            name = "technologie",
            label = "Technologie",
        },
        [5] = {
            name = "gefangnis",
            label = "Gefängnis",
        },
        [6] = {
            name = "maisonette",
            label = "Maisonette Los Santos",
        },
        [7] = {
            name = "tony",
            label = "Tony's Fun House",
        },
        [8] = {
            name = "palace",
            label = "The Palace",
        },
        [9] = {
            name = "paradise",
            label = "Paradise",
        },
    },
    Styles = {
        [1] = {
            name = "trad",
            label = "Traditional",
        },
        [2] = {
            name = "edgy",
            label = "Edgy",
        },
        [3] = {
            name = "glam",
            label = "Glam",
        },
    },
    Podiums = {
        [1] = {
            name = "none",
            label = "No podiums",
        },
        [2] = {
            name = "trad",
            label = "Traditional",
        },
        [3] = {
            name = "edgy",
            label = "Edgy",
        },
        [4] = {
            name = "glam",
            label = "Glam",
        },
    },
    Speakers = {
        [1] = {
            name = "none",
            label = "No speakers",
        },
        [2] = {
            name = "basic",
            label = "Basic speakers",
        },
        [3] = {
            name = "upgrade",
            label = "Upgraded speakers",
        },
    },
    Security = {
        [1] = {
            name = "off",
            label = "No security",
        },
        [2] = {
            name = "on",
            label = "Enable security",
        },
    }
}

IPLsData = {
    ["FinanceOffice1"] = {
        label = "Arcadius Business Centre",
        price = {1000, 1000}, -- min, max
        export = "GetFinanceOffice1Object",
        insideCoords = vector3(-141.1987, -620.913, 168.8205),
        defaultValues = OfficesInfo.defaultValues,
        cams = {
            ["Reception"] = {
                camCoords = vec3(-134.580124, -628.887573, 170.869934),	camRotation = vec3(-9.842516, -0.000001, 141.223206)
            },
            ["SafeLeftDoor"] = {
                camCoords = vec3(-128.000916, -641.930115, 170.614883),	camRotation = vec3(-15.354338, 0.000001, -85.114815)
            },
            ["SafeRightDoor"] = {
                camCoords = vec3(-128.000916, -641.930115, 170.614883),	camRotation = vec3(-15.354338, 0.000001, -85.114815)
            },
            ["OrganizationName"] = {
                camCoords = vec3(-139.440582, -630.989685, 170.357407),	camRotation = vec3(-4.803154, -0.000002, -175.153549)
            },
            ["Chairs"] = {
                camCoords = vec3(-145.499649, -634.067810, 170.921738),	camRotation = vec3(-35.669819, -0.000020, 161.227173)
            },
            ["Booze"] = {
                camCoords = vec3(-127.607712, -635.640747, 169.797699),	camRotation = vec3(-24.724915, -0.000000, -140.581940)
            },
            ["BoozeCigsA"] = {
                camCoords = vec3(-142.571625, -643.574768, 169.605103),	camRotation = vec3(-36.141911, 0.000007, -42.604233)
            },
            ["BoozeCigsB"] = {
                camCoords = vec3(-132.879807, -641.481018, 170.547195),	camRotation = vec3(-36.614361, 0.000019, 67.867805)
            },
            ["BoozeCigsC"] = {
                camCoords = vec3(-145.024979, -638.440613, 170.411072),	camRotation = vec3(-33.307243, 0.000001, 49.519684)
            },
            ["CounterfeitA"] = {
                camCoords = vec3(-146.758377, -636.214966, 170.180710),	camRotation = vec3(-29.212824, 0.000010, -118.982132)
            },
            ["CounterfeitB"] = {
                camCoords = vec3(-145.612930, -642.840881, 170.464661),	camRotation = vec3(-33.543831, 0.000012, -136.773010)
            },
            ["CounterfeitC"] = {
                camCoords = vec3(-145.612671, -640.990723, 170.420471),	camRotation = vec3(-27.716904, 0.000018, 28.104204)
            },
            ["DrugBagsA"] = {
                camCoords = vec3(-140.174042, -642.210388, 169.768066),	camRotation = vec3(-25.905661, 0.000029, -26.588516)
            },
            ["DrugBagsB"] = {
                camCoords = vec3(-145.506134, -644.347473, 170.330231),	camRotation = vec3(-40.787472, 0.000007, 43.646732)
            },
            ["DrugBagsC"] = {
                camCoords = vec3(-143.840637, -643.866821, 170.217758),	camRotation = vec3(-31.496265, 0.000044, 154.905396)
            },
            ["DrugStatueA"] = {
                camCoords = vec3(-131.474777, -640.445007, 170.268631),	camRotation = vec3(-23.149389, 0.000088, -34.223415)
            },
            ["DrugStatueB"] = {
                camCoords = vec3(-147.471375, -637.049316, 170.722275),	camRotation = vec3(-31.023537, 0.000067, -52.886818)
            },
            ["DrugStatueC"] = {
                camCoords = vec3(-147.471375, -637.049316, 170.722275),	camRotation = vec3(-31.023537, 0.000067, -52.886818)
            },
            ["ElectronicA"] = {
                camCoords = vec3(-127.638908, -634.849670, 169.486343),	camRotation = vec3(-19.763672, 0.000122, -133.981888)
            },
            ["ElectronicB"] = {
                camCoords = vec3(-132.337784, -641.975891, 170.602432),	camRotation = vec3(-30.551044, 0.000120, 79.008522)
            },
            ["ElectronicC"] = {
                camCoords = vec3(-127.638908, -634.849670, 169.486343),	camRotation = vec3(-19.763672, 0.000122, -133.981888)
            },
            ["GunsA"] = {
                camCoords = vec3(-145.983963, -639.372925, 170.579865),	camRotation = vec3(-36.850010, 0.000218, 157.348770)
            },
            ["GunsB"] = {
                camCoords = vec3(-131.813904, -639.778992, 169.848755),	camRotation = vec3(-31.811020, 0.000011, -29.165077)
            },
            ["GunsC"] = {
                camCoords = vec3(-140.996155, -641.503296, 170.713608),	camRotation = vec3(-31.889353, 0.000204, 144.274979)
            },
        }
    },
    ["FinanceOffice2"] = {
        label = "Maze Bank Building",
        price = {1000, 5000}, -- min, max
        export = "GetFinanceOffice2Object",
        insideCoords = vector3(-75.8466, -826.9893, 243.3859),
        defaultValues = OfficesInfo.defaultValues,
        cams = {
            ["Reception"] = {
                camCoords = vec3(-78.303505, -816.852722, 245.530746),	camRotation = vec3(-13.228325, -0.000000, -62.880753)
            },
            ["SafeLeftDoor"] = {
                camCoords = vec3(-78.698204, -802.234375, 245.108414),	camRotation = vec3(-17.007881, -0.000005, 70.032280)
            },
            ["SafeRightDoor"] = {
                camCoords = vec3(-78.698204, -802.234375, 245.108414),	camRotation = vec3(-17.007881, -0.000005, 70.032280)
            },
            ["OrganizationName"] = {
                camCoords = vec3(-74.165543, -819.928589, 245.219543),	camRotation = vec3(-7.401577, 0.000002, -22.329498)
            },
            ["Chairs"] = {
                camCoords = vec3(-66.916451, -817.115295, 245.671051),	camRotation = vec3(-29.448765, -0.000005, -44.849163)
            },
            ["Booze"] = {
                camCoords = vec3(-81.277542, -808.585876, 244.098938),	camRotation = vec3(-16.456615, -0.000004, 31.291956)
            },
            ["BoozeCigsA"] = {
                camCoords = vec3(-65.140991, -806.522522, 244.670029),	camRotation = vec3(-35.433018, 0.000001, 129.008057)
            },
            ["BoozeCigsB"] = {
                camCoords = vec3(-74.480141, -805.042236, 244.929504),	camRotation = vec3(-32.913345, 0.000021, -127.604904)
            },
            ["BoozeCigsC"] = {
                camCoords = vec3(-64.112907, -812.592163, 245.293213),	camRotation = vec3(-32.126038, 0.000016, -164.846451)
            },
            ["CounterfeitA"] = {
                camCoords = vec3(-63.576008, -814.710693, 245.027512),	camRotation = vec3(-30.078749, 0.000016, 76.255516)
            },
            ["CounterfeitB"] = {
                camCoords = vec3(-61.659531, -810.531311, 245.436951),	camRotation = vec3(-32.598457, -0.000000, 22.318199)
            },
            ["CounterfeitC"] = {
                camCoords = vec3(-62.020241, -808.951477, 245.273132),	camRotation = vec3(-25.984203, 0.000013, -179.334335)
            },
            ["DrugBagsA"] = {
                camCoords = vec3(-67.830666, -806.302979, 244.024887),	camRotation = vec3(-15.747979, -0.000015, 140.350662)
            },
            ["DrugBagsB"] = {
                camCoords = vec3(-62.914028, -806.246277, 245.330978),	camRotation = vec3(-27.165295, 0.000001, -147.679810)
            },
            ["DrugBagsC"] = {
                camCoords = vec3(-63.924995, -809.362000, 245.291733),	camRotation = vec3(-29.527483, -0.000000, -31.774178)
            },
            ["DrugStatueA"] = {
                camCoords = vec3(-75.957825, -805.190735, 244.614502),	camRotation = vec3(-16.535345, 0.000005, 117.358475)
            },
            ["DrugStatueB"] = {
                camCoords = vec3(-63.214809, -814.936584, 245.249374),	camRotation = vec3(-27.244022, 0.000004, 112.397324)
            },
            ["DrugStatueC"] = {
                camCoords = vec3(-63.214809, -814.936584, 245.249374),	camRotation = vec3(-27.244022, 0.000004, 112.397324)
            },
            ["ElectronicA"] = {
                camCoords = vec3(-81.525276, -809.259216, 244.317322),	camRotation = vec3(-19.133776, 0.000005, 26.963499)
            },
            ["ElectronicB"] = {
                camCoords = vec3(-74.729118, -803.871338, 245.471130),	camRotation = vec3(-32.047104, -0.000002, -135.632767)
            },
            ["ElectronicC"] = {
                camCoords = vec3(-81.525276, -809.259216, 244.317322),	camRotation = vec3(-19.133776, 0.000005, 26.963499)
            },
            ["GunsA"] = {
                camCoords = vec3(-64.004333, -811.855164, 245.207748),	camRotation = vec3(-35.275547, -0.000000, -45.396149)
            },
            ["GunsB"] = {
                camCoords = vec3(-75.871719, -805.045288, 244.692993),	camRotation = vec3(-27.952719, -0.000014, 131.374252)
            },
            ["GunsC"] = {
                camCoords = vec3(-64.004333, -811.855164, 245.207748),	camRotation = vec3(-35.275547, -0.000000, -45.396149)
            },
        }
    },
    ["FinanceOffice3"] = {
        label = "Lom Bank",
        price = {1000, 5000}, -- min, max
        export = "GetFinanceOffice3Object",
        insideCoords = vector3(-1579.756, -565.0661, 108.523),
        defaultValues = OfficesInfo.defaultValues,
        cams = {
            ["Reception"] = {
                camCoords = vec3(-1577.702759, -574.232727, 110.736099),	camRotation = vec3(-14.645699, -0.000011, -98.614525)
            },
            ["SafeLeftDoor"] = {
                camCoords = vec3(-1558.475464, -577.185852, 110.276558),	camRotation = vec3(-16.456726, -0.000014, -54.519268)
            },
            ["SafeRightDoor"] = {
                camCoords = vec3(-1558.475464, -577.185852, 110.276558),	camRotation = vec3(-16.456726, -0.000014, -54.519268)
            },
            ["OrganizationName"] = {
                camCoords = vec3(-1574.119507, -570.833130, 109.976395),	camRotation = vec3(-6.535450, -0.000009, -145.150787)
            },
            ["Chairs"] = {
                camCoords = vec3(-1578.941406, -578.684387, 110.704926),	camRotation = vec3(-21.811066, -0.000016, -129.007446)
            },
            ["Booze"] = {
                camCoords = vec3(-1561.123901, -570.864197, 109.823265),	camRotation = vec3(-23.149696, -0.000014, -88.060822)
            },
            ["BoozeCigsA"] = {
                camCoords = vec3(-1570.683472, -584.706421, 110.579559),	camRotation = vec3(-39.134171, 0.000046, -34.440659)
            },
            ["BoozeCigsB"] = {
                camCoords = vec3(-1561.574341, -579.398010, 110.112648),	camRotation = vec3(-33.622299, 0.000033, 86.503731)
            },
            ["BoozeCigsC"] = {
                camCoords = vec3(-1571.380005, -584.784180, 110.091362),	camRotation = vec3(-23.701078, 0.000021, 76.030571)
            },
            ["CounterfeitA"] = {
                camCoords = vec3(-1576.757690, -581.330200, 110.274269),	camRotation = vec3(-31.496340, 0.000031, -84.284294)
            },
            ["CounterfeitB"] = {
                camCoords = vec3(-1573.531982, -585.837830, 110.456497),	camRotation = vec3(-32.520000, 0.000029, -103.023201)
            },
            ["CounterfeitC"] = {
                camCoords = vec3(-1572.906982, -585.001953, 109.670013),	camRotation = vec3(-19.370329, 0.000021, 55.952778)
            },
            ["DrugBagsA"] = {
                camCoords = vec3(-1566.886597, -584.675903, 109.685638),	camRotation = vec3(-18.031761, 0.000015, 5.323088)
            },
            ["DrugBagsB"] = {
                camCoords = vec3(-1570.952271, -586.517334, 109.810974),	camRotation = vec3(-29.449080, 0.000022, 108.944611)
            },
            ["DrugBagsC"] = {
                camCoords = vec3(-1570.952271, -586.517334, 109.810974),	camRotation = vec3(-30.157742, 0.000024, -150.582870)
            },
            ["DrugStatueA"] = {
                camCoords = vec3(-1560.342407, -577.454468, 110.144623),	camRotation = vec3(-21.181396, 0.000026, 6.661498)
            },
            ["DrugStatueB"] = {
                camCoords = vec3(-1576.671265, -581.517395, 110.155731),	camRotation = vec3(-27.716858, 0.000024, -26.724895)
            },
            ["DrugStatueC"] = {
                camCoords = vec3(-1576.671265, -581.517395, 110.155731),	camRotation = vec3(-27.716858, 0.000024, -26.724895)
            },
            ["ElectronicA"] = {
                camCoords = vec3(-1561.218018, -571.134033, 109.629471),	camRotation = vec3(-25.984453, 0.000034, -82.235123)
            },
            ["ElectronicB"] = {
                camCoords = vec3(-1560.158813, -578.467041, 110.669830),	camRotation = vec3(-30.236433, 0.000042, 101.937248)
            },
            ["ElectronicC"] = {
                camCoords = vec3(-1561.218018, -571.134033, 109.629471),	camRotation = vec3(-25.984453, 0.000034, -82.235123)
            },
            ["GunsA"] = {
                camCoords = vec3(-1574.648071, -582.682800, 110.083267),	camRotation = vec3(-29.921480, 0.000045, -159.796112)
            },
            ["GunsB"] = {
                camCoords = vec3(-1561.643921, -577.331482, 109.458801),	camRotation = vec3(-21.732534, 0.000041, 0.677528)
            },
            ["GunsC"] = {
                camCoords = vec3(-1569.981934, -582.451599, 110.282486),	camRotation = vec3(-33.701027, 0.000047, -163.259659)
            },
        }
    },
    ["FinanceOffice4"] = {
        label = "Maze Bank West",
        price = {1000, 5000}, -- min, max
        export = "GetFinanceOffice4Object",
        insideCoords = vector3(-1392.667, -480.4736, 72.04217),
        defaultValues = OfficesInfo.defaultValues,
        cams = {
            ["Reception"] = {
                camCoords = vec3(-1383.340942, -483.070007, 74.091957),	camRotation = vec3(-26.299292, -0.000017, -38.293190)
            },
            ["SafeLeftDoor"] = {
                camCoords = vec3(-1371.978516, -467.541443, 73.967995),	camRotation = vec3(-14.881968, -0.000018, 7.612357)
            },
            ["SafeRightDoor"] = {
                camCoords = vec3(-1371.978516, -467.541443, 73.967995),	camRotation = vec3(-14.881968, -0.000018, 7.612357)
            },
            ["OrganizationName"] = {
                camCoords = vec3(-1386.977417, -478.668701, 73.957253),	camRotation = vec3(-9.527653, -0.000020, -83.726776)
            },
            ["Chairs"] = {
                camCoords = vec3(-1380.058105, -486.455719, 74.411766),	camRotation = vec3(-22.283571, -0.000019, -70.812111)
            },
            ["Booze"] = {
                camCoords = vec3(-1379.553711, -466.522247, 73.137840),	camRotation = vec3(-23.464685, -0.000023, -43.173775)
            },
            ["BoozeCigsA"] = {
                camCoords = vec3(-1368.722412, -479.408142, 73.586929),	camRotation = vec3(-29.842714, -0.000026, 83.596901)
            },
            ["BoozeCigsB"] = {
                camCoords = vec3(-1371.300171, -470.363251, 73.468140),	camRotation = vec3(-25.669493, 0.000001, 156.666183)
            },
            ["BoozeCigsC"] = {
                camCoords = vec3(-1372.126831, -483.399475, 73.127457),	camRotation = vec3(-24.724640, -0.000001, 137.451874)
            },
            ["CounterfeitA"] = {
                camCoords = vec3(-1375.946167, -486.224335, 74.278557),	camRotation = vec3(-32.441238, 0.000022, 23.592850)
            },
            ["CounterfeitB"] = {
                camCoords = vec3(-1371.392578, -483.565521, 73.638336),	camRotation = vec3(-31.732544, 0.000025, -55.225895)
            },
            ["CounterfeitC"] = {
                camCoords = vec3(-1370.337402, -483.624329, 73.591484),	camRotation = vec3(-20.236515, 0.000036, 111.937408)
            },
            ["DrugBagsA"] = {
                camCoords = vec3(-1369.973999, -478.736145, 73.168404),	camRotation = vec3(-21.023918, 0.000030, 63.118408)
            },
            ["DrugBagsB"] = {
                camCoords = vec3(-1369.848511, -482.481323, 73.661011),	camRotation = vec3(-29.212902, 0.000027, 173.274490)
            },
            ["DrugBagsC"] = {
                camCoords = vec3(-1369.848511, -482.481323, 73.661011),	camRotation = vec3(-31.732578, 0.000026, -101.134460)
            },
            ["DrugStatueA"] = {
                camCoords = vec3(-1372.610596, -469.510010, 73.753448),	camRotation = vec3(-24.173479, 0.000031, 63.353199)
            },
            ["DrugStatueB"] = {
                camCoords = vec3(-1373.910156, -485.751526, 74.065582),	camRotation = vec3(-28.110424, 0.000038, 54.454163)
            },
            ["DrugStatueC"] = {
                camCoords = vec3(-1373.910156, -485.751526, 74.065582),	camRotation = vec3(-28.110424, 0.000038, 54.454163)
            },
            ["ElectronicA"] = {
                camCoords = vec3(-1379.412720, -466.951691, 72.832451),	camRotation = vec3(-18.189188, 0.000034, -27.277946)
            },
            ["ElectronicB"] = {
                camCoords = vec3(-1372.467407, -470.686188, 74.186699),	camRotation = vec3(-36.063202, 0.000038, 174.533371)
            },
            ["ElectronicC"] = {
                camCoords = vec3(-1379.412720, -466.951691, 72.832451),	camRotation = vec3(-18.189188, 0.000034, -27.277946)
            },
            ["GunsA"] = {
                camCoords = vec3(-1374.966675, -484.513031, 74.037132),	camRotation = vec3(-32.598686, 0.000036, -93.888176)
            },
            ["GunsB"] = {
                camCoords = vec3(-1372.555176, -471.053467, 72.941940),	camRotation = vec3(-18.976631, 0.000033, 59.891426)
            },
            ["GunsC"] = {
                camCoords = vec3(-1373.634766, -479.768433, 73.510284),	camRotation = vec3(-25.197111, 0.000037, -106.013611)
            },
        }
    },
    ["HLApartment1"] = {
        label = "Dell Perro Heights, Apt 4",
        price = {2300000, 247500}, -- min, max
        export = "GetHLApartment1Object",
        insideCoords = vector3(-1452.23, -540.68, 74.04),
        defaultValues = {}
    },
    ["HLApartment2"] = {
        label = "Richard Majestic, Apt 2",
        price = {2300000, 2475000}, -- min, max
        export = "GetHLApartment2Object",
        insideCoords = vector3(-912.48, -365.09, 114.27),
        defaultValues = {}
    },
    ["HLApartment3"] = {
        label = "Tinsel Towers, Apt 42",
        price = {2300000, 2475000}, -- min, max
        export = "GetHLApartment3Object",
        insideCoords = vector3(-602.95, 58.87, 98.2),
        defaultValues = {}
    },
    ["HLApartment4"] = {
        label = "EclipseTowers, Apt 3",
        price = {2300000, 2475000}, -- min, max
        export = "GetHLApartment4Object",
        insideCoords = vector3(-785.19, 323.7, 212.0),
        defaultValues = {}
    },
    ["HLApartment5"] = {
        label = "4 Integrity Way, Apt 28",
        price = {2300000, 2475000}, -- min, max
        export = "GetHLApartment5Object",
        insideCoords = vector3(-31.38, -594.93, 80.03),
        defaultValues = {}
    },
    ["GTAOApartmentHi1"] = {
        label = "High End Apartment 1 (4 Integrity Way, Apt 30)",
        price = {2300000, 2475000}, -- min, max
        export = "GetGTAOApartmentHi1Object",
        insideCoords = vector3(-18.24, -589.2, 90.11),
        defaultValues = {}
    },
    ["GTAOApartmentHi2"] = {
        label = "High End Apartment 2 (Dell Perro Heights, Apt 7)",
        price = {2300000, 2475000}, -- min, max
        export = "GetGTAOApartmentHi2Object",
        insideCoords = vector3(-1451.36, -524.57, 56.93),
        defaultValues = {}
    },
    ["GTAOHouseHi1"] = {
        label = "High End House 1 (3655 Wild Oats Drive)",
        price = {1000, 5000}, -- min, max
        export = "GetGTAOHouseHi1Object",
        insideCoords = vector3(-174.46, 497.8, 137.65),
        defaultValues = {}
    },
    ["GTAOHouseHi2"] = {
        label = "High End House 2 (2044 North Conker Avenue)",
        price = {1000, 5000}, -- min, max
        export = "GetGTAOHouseHi2Object",
        insideCoords = vector3(342.12, 437.93, 149.38),
        defaultValues = {}
    },
    ["GTAOHouseHi3"] = {
        label = "High End House 3 (2045 North Conker Avenue)",
        price = {1000, 5000}, -- min, max
        export = "GetGTAOHouseHi3Object",
        insideCoords = vector3(373.78, 423.85, 145.91),
        defaultValues = {}
    },
    ["GTAOHouseHi4"] = {
        label = "High End House 4 (2862 Hillcrest Avenue)",
        price = {1000, 5000}, -- min, max
        export = "GetGTAOHouseHi4Object",
        insideCoords = vector3(-682.51, 592.72, 145.38),
        defaultValues = {}
    },
    ["GTAOHouseHi5"] = {
        label = "High End House 5 (2868 Hillcrest Avenue)",
        price = {1000, 5000}, -- min, max
        export = "GetGTAOHouseHi5Object",
        insideCoords = vector3(-758.24, 619.1, 144.14),
        defaultValues = {}
    },
    ["GTAOHouseHi6"] = {
        label = "High End House 6 (2874 Hillcrest Avenue)",
        price = {1000, 5000}, -- min, max
        export = "GetGTAOHouseHi6Object",
        insideCoords = vector3(-860.03, 691.4, 152.86),
        defaultValues = {}
    },
    ["GTAOHouseHi7"] = {
        label = "High End House 7 (2677 Whispymound Drive)",
        price = {1000, 5000}, -- min, max
        export = "GetGTAOHouseHi7Object",
        insideCoords = vector3(117.18, 560.09, 184.3),
        defaultValues = {}
    },
    ["GTAOHouseHi8"] = {
        label = "High End House 8 (2133 Mad Wayne Thunder)",
        price = {1000, 5000}, -- min, max
        export = "GetGTAOHouseHi8Object",
        insideCoords = vector3(-1289.7, 449.83, 97.9),
        defaultValues = {}
    },
    ["GTAOHouseMid1"] = {
        label = "Middle End House",
        price = {1000, 5000}, -- min, max
        export = "GetGTAOHouseMid1Object",
        insideCoords = vector3(346.56, -1013.24, -99.2),
        defaultValues = {}
    },
    ["GTAOHouseLow1"] = {
        label = "Low End House",
        price = {1000, 5000}, -- min, max
        export = "GetGTAOHouseLow1Object",
        insideCoords = vector3(266.08, -1007.49, -101.01),
        defaultValues = {}
    },
    ["ExecApartment1"] = {
        label = "Penthouse 1 (EclipseTowers, Penthouse Suite 1)",
        price = {2300000, 2475000}, -- min, max
        export = "GetExecApartment1Object",
        insideCoords = vector3(-787.46, 315.83, 217.64),
        cams = {
            ["General"] = {
                camCoords = vec3(-790.979919, 323.135376, 219.773346),	camRotation = vec3(-20.944874, 0.000011, -42.599388)
            }
        },
        defaultValues = ExecApartmentsInfo.defaultValues
    },
    ["ExecApartment2"] = {
        label = "Penthouse 2 (EclipseTowers, Penthouse Suite 2)",
        price = {2300000, 2475000}, -- min, max
        export = "GetExecApartment2Object",
        insideCoords = vector3(-773.62, 342.06, 196.69),
        cams = {
            ["General"] = {
                camCoords = vec3(-769.925354, 334.753601, 198.724945),	camRotation = vec3(-18.110195, 0.000008, 134.882111)
            }
        },
        defaultValues = ExecApartmentsInfo.defaultValues
    },
    ["ExecApartment3"] = {
        label = "Penthouse 3 (EclipseTowers, Penthouse Suite 3)",
        price = {2300000, 2475000}, -- min, max
        export = "GetExecApartment3Object",
        insideCoords = vector3(-787.39, 315.78, 187.91),
        cams = {
            ["General"] = {
                camCoords = vec3(-790.867065, 323.242065, 190.075684),	camRotation = vec3(-24.645658, 0.000001, -49.056412)
            }
        },
        defaultValues = ExecApartmentsInfo.defaultValues
    },
    ["MpSecurityGarage"] = {
        label = "Mp Security Garage",
        price = {1000, 5000}, -- min, max
        export = "GetMpSecurityGarageObject",
        insideCoords = vector3(-1064.1027, -89.1963, -98.9999),
    },
    ["MpSecurityOffice1"] = {
        label = "Mp Security Office 1",
        price = {1000, 5000}, -- min, max
        export = "GetMpSecurityOffice1Object",
        insideCoords = vector3(368.7535, -58.8268, 103.3633),
    },
    ["MpSecurityOffice2"] = {
        label = "Mp Security Office 2",
        price = {1000, 5000}, -- min, max
        export = "GetMpSecurityOffice2Object",
        insideCoords = vector3(368.6718, -58.7228, 103.3631),
    },
    ["MpSecurityOffice3"] = {
        label = "Mp Security Office 3",
        price = {1000, 5000}, -- min, max
        export = "GetMpSecurityOffice3Object",
        insideCoords = vector3(-1000.1635, -775.4536, 61.8944),
    },
    ["MpSecurityOffice4"] = {
        label = "Mp Security Office 4",
        price = {1000, 5000}, -- min, max
        export = "GetMpSecurityOffice4Object",
        insideCoords = vector3(-573.6207, -712.8929, 113.0053),
    },
    ["MpSecurityStudio"] = {
        label = "Mp Security Studio",
        price = {1000, 5000}, -- min, max
        export = "GetMpSecurityStudioObject",
        insideCoords = vector3(-1021.7942, -92.6187, -99.4031),
    },
    ["CriminalEnterpriseWarehouse"] = {
        label = "Criminal Enterprise Warehouse",
        price = {1000, 5000}, -- min, max
        export = "GetCriminalEnterpriseWarehouseObject",
        insideCoords = vector3(844.6964, -3005.0125, -44.4000),
    },
    ["CriminalEnterpriseVehicleWarehouse"] = {
        label = "Criminal Enterprise Vehicle Warehouse",
        price = {1000, 5000}, -- min, max
        export = "GetCriminalEnterpriseVehicleWarehouseObject",
        insideCoords = vector3(782.4108, -2997.8538, -68.9960),
    },
    ["AfterHoursNightclubs"] = {
        label = "After Hours Nightclubs",
        price = {1000, 5000}, -- min, max
        export = "GetAfterHoursNightclubsObject",
        insideCoords = vector3(-1569.3857, -3017.5332, -74.4062),
        defaultValues = NightClubsInfo.defaultValues,
        cams = {
            ClubName = {
                camCoords = vec3(-1568.299927, -3015.404053, -73.417747),
                camRotation = vec3(-6.613426, 0.000000, 53.285656)
            },
            Podiums = {
                camCoords = vec3(-1600.721924, -3018.770264, -74.793808),
                camRotation = vec3(-42.536381, 0.000000, 326.851013)
            },
            Speakers1 = {
                camCoords = vec3(-1591.017700, -3018.945313, -74.646004),
                camRotation = vec3(-6.937236, 0.000000, 287.684601)
            },
            Speakers2 = {
                camCoords = vec3(-1590.894897, -3006.736816, -74.603516),
                camRotation = vec3(-8.905747, 0.000000, 243.747604)
            },
            Security = {
                camCoords = vec3(-1616.556763, -3007.374268, -72.267998),
                camRotation = vec3(-29.077557, 0.000000, 158.281799)
            }
        }
    },
}
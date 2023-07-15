-- default item settings
local item = {
    ["tv"] = {
        position = { x = 0.67, y = 0.5, z = 0.8 },
        propname = "prop_tv_flat_michael",
        bone = "exhaust",
    },
    ["monitor"] = {
        position = { x = 0.67, y = 0.5, z = 0.1 },
        propname = "prop_monitor_w_large",
        bone = "exhaust",
    },
    ["small_painting"] = {
        position = { x = 0.2, y = 0.5, z = 0.3 },
        propname = "h4_prop_h4_painting_01c",
        rotation = { x = -90.0, y = 90.0, z = 0.0 },
        bone = "exhaust",
    },
    ["tube_tv"] = {
        position = { x = 0.67, y = 0.5, z = 0.5 },
        propname = "prop_tv_01",
        bone = "exhaust",
    }
}


-- vehicle specific item settings
local veh_settings = {
    ["guardian"] = {
        ["tv"] = {
            position = { x = 0.0, y = -2.0, z = 0.2 },
            propname = "prop_tv_flat_michael",
            bone = "seat_dside_r",
            rotation = { x = -10.0, y = 0.0, z = 90.0 },
        },
        ["monitor"] = {
            position = { x = 1.0, y = -2.0, z = -0.3 },
            propname = "prop_monitor_w_large",
            bone = "seat_dside_r",
            rotation = { x = -10.0, y = 0.0, z = -90.0 },
        },
        ["small_painting"] = {
            position = { x = 0.2, y = -0.9, z = 0.0 },
            propname = "h4_prop_h4_painting_01c",
            rotation = { x = -30.0, y = 90.0, z = 0.0 },
            bone = "seat_dside_r",
        },
        ["tube_tv"] = {
            position = { x = 0.5, y = -2.0, z = 0.0 },
            propname = "prop_tv_01",
            bone = "seat_dside_r",
            rotation = { x = 0.0, y = 0.0, z = 0.0 },
        }
    }
}

-- list of banned vehicles (don't have trunk or can't be used for trunk)
local banned_vehicle = {
    "zentorno",
    "adder",
    "banshee",
    "bullet",
    "cheetah",
    "entityxf",
    "fmj",
    "infernus",
    "nero",
    "nero2",
    "osiris",
    "penetrator",
}


return {
    item = item,
    banned_vehicle = banned_vehicle,
    veh_setting = veh_settings,
}

Config = {}

Config.DebugSpikes = false -- change this to debug spike strips issue, if spikes are working, markers should be generated on the tires and polyzones be drawn on the spikes
Config.AdminAlert = true -- this generates admin log message in chat if player uses /spikestrips
Config.MaxDist = 3.0

Config.Objects = {
    cone = { label = "Cone", model = `prop_roadcone02a`, freeze = false, speedzone = true, speedlimit = 20.0, policeItem = true },
    barricade = { label = "Barricade", model = `prop_barrier_work05`, freeze = false, speedzone = true, speedlimit = 0.0, policeItem = true },
    roadblock = { label = "Roadblock", model = `prop_mp_barrier_02b`, freeze = false, speedzone = true, speedlimit = 0.0, policeItem = true },
    tent = { label = "Canopy", model = `prop_gazebo_02`, freeze = true },
    light = { label = "Mobile Lighting", model = `prop_worklight_03b`, freeze = true, zoffset = 0.1, ghostoff = 0.0, policeItem = true },
    medbag = { label = "Medical Bag", model = `xm_prop_x17_bag_med_01a`, freeze = true },
    stoppedvehicles = { label = "Caution Sign", model = `prop_consign_02a`, freeze = false, policeItem = true },
    generator = { label = "Generator", model = `ch_prop_ch_generator_01a`, freeze = true },
    cooler = { label = "Cooler", model = `prop_coolbox_01`, freeze = true, inventory = true, speedzone = true, speedlimit = 0.0, hidespeed = true },
    spikestrip = { label = "Spike Strips", model = `P_ld_stinger_s`, freeze = true, speedzone = true, speedlimit = 20.0, policeItem = true },
    bomb = { label = "Bomb", model = `ch_prop_ch_ld_bomb_01a`, hidespeed = true, rotation = vector3(-90.0, 0.0, 0.0), freeze = true, speedzone = true, speedlimit = 0.0, broken = 'diffusedbomb', zoffset = 0.0, ghostoff = 0.3 },
    stretcher = { label = "Stretcher", model = `prop_ld_binbag_01`, freeze = true, rotation = vector3(0.0, 0.0, 0.0), zoffset = -0.8, ghostoff = 0.8 },
    foldingchair = { label = "Folding Chair", model = `prop_skid_chair_01`, freeze = true },
    foldingchair2 = { label = "Folding Chair", model = `prop_skid_chair_02`, freeze = true },
    campfire = { label = "Campfire", model = `prop_beach_fire`, freeze = true, zoffset = 0.6, ghostoff = 0.1 },
    camptent = { label = "Tent", model = `prop_skid_tent_01`, freeze = true, zoffset = 1.0, ghostoff = 0.6 },
    camptent2 = { label = "Tent", model = `prop_skid_tent_03`, freeze = true, zoffset = 1.0, ghostoff = 0.6 },
    cdplayer = { label = "CD Player", model = `prop_portable_hifi_01`, freeze = true, ghostoff = 0.2 },
    picnictable = { label = "Picnic Table", model = `prop_picnictable_01`, freeze = true },
    umbrella = { label = "Beach Umbrella", model = `prop_beach_parasol_01`, rotation = vector3(10.0, 10.0, 0.0), zoffset = 0.2, ghostoff = -0.4, freeze = true },
    umbrella2 = { label = "Beach Umbrella", model = `prop_beach_parasol_02`, rotation = vector3(10.0, 10.0, 0.0), zoffset = 0.2, ghostoff = -0.4, freeze = true },
    umbrella3 = { label = "Beach Umbrella", model = `prop_beach_parasol_03`, rotation = vector3(10.0, 10.0, 0.0), zoffset = 0.2, ghostoff = -0.4, freeze = true },
    beachtowel = { label = "Beach Towel", model = `p_cs_beachtowel_01_s`, color = true, freeze = true },
    boombox = { label = "Boombox", model = `prop_boombox_01`, rotation = vector3(0.0, 0.0, -180.0), freeze = true, ghostoff = 0.4 },
    miniradio = { label = "Radio", model = `prop_radio_01`, freeze = true, ghostoff = 0.2 },
    monobloc = { label = "Monobloc Chair", model = `prop_table_03b_chr`, rotation = vector3(0.0, 0.0, 90.0), freeze = true },
    bbq = { label = "Grill", model = `prop_bbq_5`, freeze = true },
    camptent3 = { label = "Tent", model = `ba_prop_battle_tent_01`, freeze = true, zoffset = 0.3, ghostoff = 0.0 },
    camptent4 = { label = "Tent", model = `ba_prop_battle_tent_02`, freeze = true },
    foldingtable = { label = "Folding Table", model = `prop_ven_market_table1`, freeze = true },
}


-- = {label = , model = , freeze = true},

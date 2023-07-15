local Translations = {
    error = {
        ["already_mission"] = "You currently already have a passenger, drop them off first!",
        ["not_in_taxi"] = "You are not in a taxi",
        ["missing_meter"] = "This Vehicle Has no Taxi Meter",
        ["no_vehicle"] = "You're not in a vehicle",
        ["not_active_meter"] = "The Taxi Meter is not active",
        ["no_meter_sight"] = "No Taxi Meter In Sight",
        ["took_too_long"] = "Took too long, stopped"
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "Person was dropped off!",
        ["npc_on_gps"] = "The NPC has been marked on your GPS",
        ["go_to_location"] = "Take your passenger to their desired location",
        ["vehicle_parking"] = "[E] Park Vehicle",
        ["job_vehicles"] = "[E] Job Vehicles",
        ["drop_off_npc"] = "[E] Drop Off NPC",
        ["call_npc"] = "[E] Call NPC",
        ["blip_name"] = "Downtown Cab",
        ["taxi_label_1"] = "Standard Cab",
        ["no_spawn_point"] = "Unable to find a location to bring the cab",
        ["taxi_returned"] = "Cab Parked"
    },
    menu = {
        ["taxi_menu_header"] = "Taxi Vehicles",
        ["close_menu"] = "⬅ Close Menu",
        ['boss_menu'] = "Boss Menu"
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true,
})
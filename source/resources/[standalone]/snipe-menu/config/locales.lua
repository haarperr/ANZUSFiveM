Config.Locales = {
    ["fix_vehicle_exploit"] = "Tried to fix a vehicle without admin perms",
    ["fix_vehicle_exploit_event"] = "Tried to fix a vehicle by triggering event without admin perms",
    ["god_mode_exploit"] = "Tried to enable god mode without admin perms",
    ["fix_vehicle_used"] = "Used the fix vehicle command",
    ["god_mode_used"] = "Used the god mode command",
    ["invisible_used"] = "Used the invisible command",
    ["invisible_exploit"] = "Tried to enable invisible without admin perms",
    ["teleport_marker_used"] = "Used the teleport marker command",
    ["teleport_exploit"] = "Tried to enable teleport marker callback without admin perms",
    ["teleport_exploit_event"] = "Tried to teleport to marker event admin perms",
    ["super_jump_used"] = "Used the super jump command",
    ["super_jump_exploit"] = "Tried to enable super jump without admin perms",
    ["remove_stress_used"] = "Used the remove stress command",
    ["stress_exploit"] = "Tried to remove stress without admin perms",
    ["stress_exploit_event"] = "Tried to remove stress without admin perms and triggering the event",
    ["announce_exploit"] = "Tried to announce without admin perms",
    ["announce_used"] = "Used the announce command",
    ["give_clothes_exploit"] = "Tried to give clothes without admin perms",
    ["give_clothes_used"] = "Used the give clothes command on ", --the space is added to send the log with player who is given clothes menu
    ["clothes_exploit_event"] = "Tried to trigger the give clothes event",
    ["freeze_player_used"] = "Used the freeze player command on ",-- the space is added to send the log with player who is frozen
    ["freeze_player_exploit"] = "Tried to exploit freeze player command",
    ["revive_player_exploit"] = "Tried to exploit revive player command",
    ["revive_exploit_event"] = "Tried to trigger the revive player event",
    ["revive_player_used"] = "Used the revive player command on ", --the space is added to send the log with player who is revive,
    ["teleport_player_exploit"] = "Tried to exploit teleport to player command",
    ["teleport_player_event_exploit"] = "Tried to trigger the teleport to player event",
    ["teleport_player_used"] = "Used Teleport player command to teleport to player: ", --the space is added to send the log with player to whom it was teleported,
    ["inventory_open_exploit"] = "Tried to exploit inventory open for player command",
    ["inventory_open_used"] = "Used open inventory player command to open inventory on player: ",
    ["inventory_open_event_exploit"] = "Tried to trigger the inventory open event",
    ["noclip_used"] = "Use noclip command",
    ["noclip_exploit"] = "Tried to exploit noclip command",
    ["change_plate_exploit_event"] = "Tried to trigger change plate event",
    ["plate_change_used"] = "Changed the plate from ", -- the space is added to send the log with the plate,
    ["give_item_exploit_event"] = "Tried to trigger give item event",
    ["give_item_used"] = "Used the giveitem event ",
    ["kick_player_used"] = "Used the kick player command on ",
    ["kick_player_exploit_event"] = "Tried to trigger kick player event",
    ["ban_player_used"] = "Used the ban player command on ",
    ["ban_player_exploit_event"] = "Tried to trigger ban player event",
    ["give_car_exploit"] = "Tried to give car without admin perms",
    ["give_car_used"] = "Used Give car command to give ",
    ["give_car_exploit_event"] = "Give Car event was triggered",
    ["setjob_exploit"] = "Tried to do setjob without admin perms",
    ["set_job_used"] = "Used Setjob to change job for ",
    ["set_job_exploit_event"] = "Tried to trigger setjob event",
    ["give_money_exploit"] = "Tried to give money without admin perms",
    ["give_money_used"] = "Used Give money command to ",
    ["give_money_exploit_event"] = "Tried to trigger give money event",
    ["dev_mode_exploit"] = "Tried to trigger dev mode",
    ["dev_mode_enabled"] = "Enabled Dev mode",
    ["job_stash_exploit"] = "Tried to trigger Job stash event",
    ["get_vector3_exploit"] = "Tried to trigger get vector3",
    ["get_vector4_exploit"] = "Tried to trigger get vector4",
    ["get_json_exploit"] = "Tried to trigger get json coords",
    ["job_stash_created"] = "Created Job stash: ",
    ["prop_created"] = "Created a synced prop ",
    ["blips_exploit"] = "Tried to trigger show blips",
    ["blip_toggle_used"] = "Toggled Blips",
    ["bring_player_used"] = "Used bring player command on ",
    ["bring_player_exploit_event"] = "Tried to trigger bring player event",
    ["bring_player_exploit"] = "Tried to trigger bring player",
    ["clear_inventory_used"] = "Used clear inventory command on ",
    ["weather_change_exploit"] = "Tried to change weather without admin perms",
    ["time_change_exploit"] = "Tried to change time without admin perms",
    ["no_player_coords"] = "No Send back coords found",

    -- new added
    ['revive_radius_used'] = "Used the revive radius command",
    ['revive_radius_exploit_event'] = "Tried to trigger revive radius event",
    ["spectate_player_used"] = "Used the spectate player command on ",
    ["spectate_player_exploit_event"] = "Tried to trigger spectate player event",
    ["set_admin_roles_exploit"] = "Tried to trigger set admin roles event",
    

    -- added after 9/23
    ["changed_admin_perms"] = "Changed admin perms for ",
    ["toggle_benny_exploit"] = "Tried to exploit benny option",
    ["open_benny"] = "Opened Bennys",
    ["not_in_vehicle"] = "You are not in a vehicle",
    ["admin_car_used"] = "Used Admin car to add vehicle ",
    ["admin_car_exploit"] = "Tried to trigger admin car",
    ["car_already_owned"] = "Car is already owned",
    ["you_own_the_car"] = "You now own the car",
    ["vehicle_not_present"] = "Vehicle not present in vehicles.lua",

    ["debug_mode_enabled"] = "Debug Mode enabled",
    ["debug_mode_exploit"] = "Tried to trigger debug mode event",

    ["toggle_duty_exploit"] = "Tried to trigger toggle duty event",
    ["toggle_duty_used"] = "Used toggle duty option",

    ["unban_player_exploit"] = "Tried to trigger unban player event",
    ["unban_player_used"] = "Used unban player option to unban ",
    
    ["change_model_exploit"] = "Tried to trigger change model event",
    ["change_model_used"] = "Used change model option on ",

    ["revert_clothing_exploit"] = "Tried to trigger revert clothing event",
    ["revert_clothing_used"] = "Used revert clothing option on ",

    ["warn_player_used"] = "Used the warn player command on ",
    ["warn_player_exploit_event"] = "Tried to trigger warn player event",

    ["setgang_exploit"] = "Tried to do setjob without admin perms",
    ["set_gang_used"] = "Used Setjob to change job for ",
    ["set_gang_exploit_event"] = "Tried to trigger setjob event",

    -- added on Dec 11
    ["deleteprop_used"] = "Used Delete Prop button to delete model ", -- this prints the model name after the model
    ["deleteprop_exploited"] = "Tried to trigger delete model button event",

    -- added after Dec 19
    ["report_sent"] = "Report Sent", -- this prints the message after.
    ["report_replied"] = "replied", -- this prints the admin name before and then the username and message after

    -- Added after Jan 1 2023
    ["drunk_player_used"] = "Used drunk player option on ",
    ["drunk_player_exploit"] = "Tried to trigger drunk player event",
    ["slap_sky_player_exploit"] = "Tried to trigger slap sky player event",
    ["slap_sky_player_used"] = "Used slap sky player option on ",
    ["send_box_player_used"] =  "Used Send box player option on ", 
    ["send_box_player_exploit"] = "Tried to trigger send box player event",
    ["fire_player_exploit"] = "Tried to trigger set player on fire event",
    ["fire_player_used"] = "Used set player or fire option on ", 
    ["play_sound_player_used"] = "Used play sound on player option on ",
    ["play_sound_exploit"] = "Tried to trigger play sound ",
    ["changed_vehicle_state"] = "Used change vehicle state command to change state of vehicle with plate ",
    ["changed_vehicle_state_exploit"] = "Tried to trigger change vehicle state",
    ["forced_logout_player"] = "Used forced logout player option to logout ",
    ["forced_logout_player_exploit"] = "Tried to trigger forced logout player option",
    ["clothing_outfit_option"] = "Used outfit option on player ",
    ["clothing_outfit_option_exploit"] = "Tried to trigger clothing outfit option",

    -- Added After
    ["invalid_prop"] = "Invalid Prop",
    ["send_dm_used"] = "Used the send dm to player command on ",
    ["damage_vehicle_used"] = "Damage Vehicle option used on ",
    ["damage_vehicle_exploit"] = "Trued to trigger damage vehicle event",

    -- Added after Feb 19/2023
    ["started_resource"] = "Started resource ",
    ["tried_to_start_resource"] = "Tried to Start Resource ",
    ["stopped_resource"] = "Stopped Resource ",
    ["restarted_resource"] = "Restarted Resource ",

    ["AdminTag"] = "Admin",

    ["revive_all_used"] = "Used Revive All",
    ["revive_all_exploit"] = "Tried to exploit revive all",

    ["clear_vehicles_exploit"] = "Tried to trigger clear vehicle",
    ["clear_peds_exploit"] = "Tried to trigger clear peds",
    ["clear_object_exploit"] = "Tried to trigger clear objects",
    ["clear_inventory_exploit"] = "Tried to trigger clear inventory command",

    -- Added After 9th April

    ["heal_player_exploit"] = "Tried to exploit heal player command",
    ["heal_player_used"] = "Used the heal player command on ",

    -- Added after May 7th

    ["pee_player_used"] = "Pee player command used on ",
    ["pee_player_exploit"] = "Tried to exploit pee player command",
    ["poop_player_used"] = "Poop player command used on ",
    ["poop_player_exploit"] = "Tried to exploit poop player command",
    ["wiped_player"] = "Wiped all the information for player with identifier ",

    -- added after June 24th

    ["report_received_message"] = "Report Message from: ",
    ["admin_replied"] = "Admin Replied on your report"
}
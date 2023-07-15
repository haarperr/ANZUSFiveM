local Translations = {
    notify = {
        ["hud_settings_loaded"] = "HUD Settings Loaded!",
        ["hud_restart"] = "HUD is restarting!",
        ["hud_start"] = "HUD is now started!",
        ["hud_command_info"] = "This command resets your current HUD settings!",
        ["load_square_map"] = "Square map loading...",
        ["loaded_square_map"] = "Square map has loaded!",
        ["load_circle_map"] = "Circle map loading...",
        ["loaded_circle_map"] = "Circle map has loaded!",
        ["cinematic_on"] = "Cinematic Mode On!",
        ["cinematic_off"] = "Cinematic Mode Off!",
        ["engine_on"] = "Engine started!",
        ["engine_off"] = "Engine shut down!",
        ["low_fuel"] = "Fuel level low!",
        ["access_denied"] = "You are not Authorized!",
        ["stress_gain"] = "Feeling more stressed!",
        ["stress_removed"] = "Feeling more relaxed!"
    },
    info = {
        ["toggle_engine"] = "Toggle Engine",
        ["open_menu"] = "Open Menu",
        ["check_cash_balance"] = "Check Cash Balance",
        ["check_bank_balance"] = "Check Bank Balance",
        ["toggle_dev_mode"] = "Enable/Disable developer Mode",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

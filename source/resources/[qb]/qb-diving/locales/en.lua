local Translations = {
  error = {
    ["canceled"] = "Canceled",
    ["911_chatmessage"] = "911 MESSAGE",
    ["take_off"] = "/divingsuit to take off your diving suit",
    ["not_wearing"] = "You are not wearing a diving gear",
    ["no_coral"] = "You don't have any coral to sell",
    ["not_standing_up"] = "You need to be standing up to put on the diving gear",
    ["need_otube"] = "Please fill your oxygen before putting on your diving gear!",
    ["oxygenlevel"] = "You still have %{oxygenlevel} oxygen in your tank!",
  },
  success = {
    ["took_out"] = "You took your wetsuit off",
    ["tube_filled"] = "The tube has been filled successfully"
  },
  info = {
    ["collecting_coral"] = "Collecting coral",
    ["diving_area"] = "Diving Area",
    ["collect_coral"] = "Collect coral",
    ["collect_coral_dt"] = "[E] - Collect Coral",
    ["checking_pockets"] = "Checking Pockets To Sell Coral",
    ["sell_coral"] = "Sell Coral",
    ["sell_coral_dt"] = "[E] - Sell Coral",
    ["blip_text"] = "911 - Dive Site",
    ["put_suit"] = "Putting on diving gear",
    ["pullout_suit"] = "Taking off diving gear",
    ["cop_msg"] = "This coral may be stolen",
    ["cop_title"] = "Illegal diving",
    ["command_diving"] = "Take off your diving suit",
  },
  warning = {
    ["oxygen_one_minute"] = "You have less than 1 minute of air remaining",
    ["oxygen_running_out"] = "Your diving gear is running out of air",
  },
}

Lang = Lang or Locale:new({
  phrases = Translations,
  warnOnMissing = true
})

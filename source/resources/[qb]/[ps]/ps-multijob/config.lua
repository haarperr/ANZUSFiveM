Config = Config or {}

-- Side of the screen where you want the ui to be on. Can either be "left" or "right"
Config.Side = "right"

Config.MaxJobs = 3
Config.IgnoredJobs = {
  unemployed = true,
}

Config.DenyDuty = {
  bcso = true,
}

Config.WhitelistJobs = {
  lspd = true,
  ambulance = true,
  mechanic = true,
  lawyer = true,
  doj = true,
  killmore = true,
  burgershot = true,
  uwu = true
}

Config.Descriptions = {
  lspd = "Shoot some criminals or maybe be a good cop and arrest them",
  bcso = "Like LSPD but for cooler people",
  ambulance = "Fix the bullet holes",
  mechanic = "Fix the bullet holes",
  tow = "Pickup the tow truck and steal some vehicles",
  taxi = "Pickup people around the city and drive them to their destination",
  bus = "Pickup multiple people around the city and drive them to their destination",
  realestate = "Sell houses or something",
  killmore = "Sell some cars to civilians!",
  judge = "Decide if people are guilty",
  lawyer = "Help the good or the bad",
  reporter = "Lowkey useless",
  trucker = "Drive a truck",
  garbage = "Drive a garbage truck",
  vineyard = "Get them vines",
  hotdog = "Sell them glizzys",
  burgershot = "Sell some food",
  uwu = "Sell some food uwu",
}

-- Change the icons to any free font awesome icon, also add other jobs your server might have to the list
-- List: https://fontawesome.com/search?o=r&s=solid
Config.FontAwesomeIcons = {
  lspd = "fa-solid fa-handcuffs",
  bcso = "fa-solid fa-handcuffs",
  ambulance = "fa-solid fa-user-doctor",
  mechanic = "fa-solid fa-wrench",
  tow = "fa-solid fa-truck-tow",
  taxi = "fa-solid fa-taxi",
  bus = "fa-solid fa-bus",
  realestate = "fa-solid fa-sign-hanging",
  cardealer = "fa-solid fa-cards",
  judge = "fa-solid fa-gave",
  lawyer = "fa-solid fa-gavel",
  reporter = "fa-solid fa-microphone",
  trucker = "fa-solid fa-truck-front",
  garbage = "fa-solid fa-trash-can",
  vineyard = "fa-solid fa-wine-bottle",
  hotdog = "fa-solid fa-hotdog",
}

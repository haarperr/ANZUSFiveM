Config = {}

--[[ General Configs ]]
Config.RequirePolice = true    -- Set to true if you want to require police in order to rob stores
Config.PoliceCount = 0         -- If RequirePolice is true, how many must be online to rob stores?
Config.PoliceJobs = { 'lspd' } -- Add your police job names here

--[[ Register Configs ]]
Config.RegisterRobberyItem = 'lockpick'                                                                        -- The item name required to rob a cash register
Config.RegisterMinCooldown = 10                                                                                -- The minimum cooldown time for robbing registers once one has been robbed
Config.RegisterMaxCooldown = 20                                                                                -- The maximum cooldown time for robbing registers once one has been robbed
Config.RegisterDiffuculty = { 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy' } -- The skillcheck difficulty, can be 'easy', 'medium' or 'hard' in any order and any quantity
Config.RegisterInput = { 'W', 'A', 'S', 'D' }                                                                  -- The keys that are used for the skillcheck minigame, can be any keys
Config.RegisterRewardItem = 'markedbills'                                                                      -- The item that is rewarded upon a successful register robbery
Config.RegisterRewardRandom = true                                                                             -- Set true if you want to reward a random quantity of the above item, otherwise set false
Config.RegisterRewardQuantity = 1000                                                                           -- If RegisterRewardRandom = false then this is the quantity rewarded, if true then can be ignored
Config.RegisterRewardMinQuantity = 80                                                                          -- If RegisterRewardRandom = true then this is the minimum quantity, otherwise can be ignored
Config.RegisterRewardMaxQuantity = 200                                                                         -- If RegisterRewardRandom = true then this is the maximum quantity, otherwise can be ignored
Config.LockpickBreakChance = 50                                                                                -- The percentage chance the lockpick breaks when failing to lockpick a register
Config.CodeChance = 10                                                                                         -- The percentage chance a player receives a code from the register to skip the PC hack requirement

--[[ Safe Configs ]]
Config.SafeMinCooldown = 10           -- The minimum cooldown time for robbing safes once one has been robbed
Config.SafeMaxCooldown = 20           -- The maximum cooldown time for robbing safes once one has been robbed
Config.MaxCodeAttempts = 3            -- The maximum amount of attempts to input the correct code to unlock safe before having to restart robbery
Config.SafeRewardItem = 'markedbills' -- The item that is rewarded upon a successful safe robbery
Config.SafeRewardRandom = true        -- Set true if you want to reward a random quantity of the above item, otherwise set false
Config.SafeRewardQuantity = 2000      -- If SafeRewardRandom = false then this is the quantity rewarded, if true then can be ignored
Config.SafeRewardMinQuantity = 650    -- If SafeRewardRandom = true then this is the minimum quantity, otherwise can be ignored
Config.SafeRewardMaxQuantity = 900    -- If SafeRewardRandom = true then this is the maximum quantity, otherwise can be ignored

--[[ Computer Configs ]]
Config.MaxHackAttempts = 3                                                                                     -- The maximum amount of hack attempts to get the safe code before having to restart robbery
Config.EnableQuestionnaire = true                                                                              -- If true, the player will be asked a sequence of questions instead of the skillcheck below to hack the computer
Config.ComputerDifficulty = { 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy' } -- The skillcheck difficulty, can be 'easy', 'medium' or 'hard' in any order and any quantity (If EnableQuestionnaire is true, this can be ignored)
Config.ComputerInput = { 'W', 'A', 'S', 'D' }                                                                  -- The keys that are used for the skillcheck minigame, can be any keys (If EnableQuestionnaire is true, this can be ignored)

Config.Questions = {                                                                                           -- This is only used if Config.EnableQuestionnaire is true
  question1 = {
    question = 'What is a PSU?',
    icon = 'bolt',
    answer = 'power supply unit'
  },
  question2 = {
    question = 'What does "HTTPS" stand for?',
    icon = 'lock',
    answer = 'hypertext transfer protocol secure'
  },
  question3 = {
    question = 'What is a GPU?',
    icon = 'desktop',
    answer = 'graphics processing unit'
  },
  question4 = { -- This question is not typed but rather the player selects from a dropdown, the dropdown options displayed are below
    question = 'What does CTRL + A do?',
    icon = 'keyboard',
    options = {
      option1 = 'Copy text',
      option2 = 'Paste text',
      option3 = 'Select all',
      option4 = 'Print page'
    },
    answer = 'option3'
  },
  question5 = {
    question = 'Which of the following is the most common type of fuel sold at gas stations?',
    icon = 'gas-pump',
    otpions = {
      option1 = 'Diesel',
      option2 = 'Propane',
      option3 = 'Natural Gas',
      option4 = 'Unleaded Gasoline'
    },
    answer = 'option4'
  },
  question6 = {
    question = 'Name the largest planet in our solar system',
    icon = 'rocket',
    answer = 'jupiter'
  },
  question7 = {
    question = 'Which animal is known for its black and white stripes?',
    icon = 'horse',
    answer = 'zebra'
  },
  question8 = {
    question = 'What is the tallest mountain in San Andreas',
    icon = 'mountain',
    answer = 'mount chiliad'
  },
  question9 = {
    question = 'Which iconic vehicle manufacturer is known for producing sports cars in GTA V?',
    icon = 'car',
    options = {
      option1 = 'Benefactor',
      option2 = 'Albany',
      option3 = 'Dinka',
      option4 = 'Pfister'
    },
    answer = 'option4'
  },
  question10 = {
    question = 'What is the name of the desert area located in the northeastern part of the country?',
    icon = 'monument',
    options = {
      option1 = 'Los Santos County',
      option2 = 'Sandy Shores',
      option3 = 'Blaine County',
      option4 = 'Mount Chiliad'
    },
    answer = 'option2'
  },
  question11 = {
    question = 'Who painted the famous artwork "Mona Lisa"?',
    icon = 'paintbrush',
    answer = "leonardo de vinci"
  },
  question12 = {
    question = 'What is the capitcal city of Israel',
    icon = 'flag',
    answer = "jerusalem"
  },
  question13 = {
    question = 'What is the largest ocean in the world?',
    icon = 'water',
    answer = "pacific ocean"
  },
  question14 = {
    question = 'Who is known as the "Father of Modern Physics"?',
    icon = 'person',
    answer = "isaac newton"
  },
  question15 = {
    question = 'Which continent is known for being the coldest and driest on Earth?',
    icon = 'igloo',
    answer = "antarctica"
  },
  question16 = {
    question = 'Which animal is known as "the king of the jungle"?',
    icon = 'paw',
    options = {
      option1 = 'Lion',
      option2 = 'Elephant',
      option3 = 'Giraffe',
      option4 = 'Gorilla'
    },
    answer = 'option1'
  },
  question17 = {
    question = 'Which musical instrument is known as "the king of instruments"?',
    icon = 'music',
    options = {
      option1 = 'Violin',
      option2 = 'Guitar',
      option3 = 'Piano',
      option4 = 'Trumpet'
    },
    answer = 'option3'
  },
  question18 = {
    question = 'Which country is famous for its pyramids?',
    icon = 'cubes',
    options = {
      option1 = 'Egypt',
      option2 = 'Mexico',
      option3 = 'Greece',
      option4 = 'Italy'
    },
    answer = 'option1'
  },
  question19 = {
    question = 'Who wrote the play "Romeo and Juliet"?',
    icon = 'heart',
    options = {
      option1 = 'Oscar Wilde',
      option2 = 'William Shakespeare',
      option3 = 'Tennessee Williams',
      option4 = 'George Bernard Shaw'
    },
    answer = 'option2'
  },
  question20 = {
    question = 'What is the largest organ in the human body?',
    icon = 'snowman',
    options = {
      option1 = 'Brain',
      option2 = 'Heart',
      option3 = 'Liver',
      option4 = 'Skin'
    },
    answer = 'option4'
  },
  question21 = {
    question = 'What is the capital city of South Korea?',
    icon = 'city',
    options = {
      option1 = 'Seoul',
      option2 = 'Tokyo',
      option3 = 'Beijing',
      option4 = 'Bangkok'
    },
    answer = 'option1'
  },
  question22 = {
    question = 'What was Pablo Escobar occupation?',
    icon = 'syringe',
    options = {
      option1 = 'Athlete',
      option2 = 'Doctor',
      option3 = 'Politician',
      option4 = 'Drug lord'
    },
    answer = 'option4'
  },
  question23 = {
    question = 'Which drug cartel did Pablo Escobar lead?',
    icon = 'syringe',
    options = {
      option1 = 'Medellín Cartel',
      option2 = 'Cali Cartel',
      option3 = 'Sinaloa Cartel',
      option4 = 'Gulf Cartel'
    },
    answer = 'option1'
  },
  question24 = {
    question = 'Which of the following landmarks is NOT found in San Andreas',
    icon = 'monument',
    options = {
      option1 = 'Statue of Liberty',
      option2 = 'Del Perro Pier',
      option3 = 'Maze Bank Tower',
      option4 = 'Vinewood Sign'
    },
    answer = 'option1'
  },
  question25 = {
    question = 'How many bones do sharks have?',
    icon = 'fish',
    options = {
      option1 = '20',
      option2 = '128',
      option3 = '67',
      option4 = '0'
    },
    answer = 'option4'
  },
  question26 = {
    question = 'How long is an Olympic swimming pool (meters)?',
    icon = 'fish',
    options = {
      option1 = '25',
      option2 = '100',
      option3 = '70',
      option4 = '50'
    },
    answer = 'option4'
  },
  question27 = {
    question = 'In which country could you find the Leaning Tower of Pisa?',
    icon = 'building',
    options = {
      option1 = 'France',
      option2 = 'Italy',
      option3 = 'Spain',
      option4 = 'Greece'
    },
    answer = 'option2'
  },
  question28 = {
    question = 'What year did the Titanic sink?',
    icon = 'ship',
    options = {
      option1 = '1910',
      option2 = '1912',
      option3 = '1914',
      option4 = '1916'
    },
    answer = 'option2'
  },
  question29 = {
    question = 'What is a perfect score in bowling?',
    icon = 'ship',
    options = {
      option1 = '200',
      option2 = '250',
      option3 = '300',
      option4 = '350'
    },
    answer = 'option3'
  },
  question30 = {
    question = 'In which season is daytime the longest?',
    icon = 'sun',
    options = {
      option1 = 'Spring',
      option2 = 'Summer',
      option3 = 'Fall',
      option4 = 'Winter'
    },
    answer = 'option2'
  },
}

Config.TotalQuestions = 0
for _, _ in pairs(Config.Questions) do
  Config.TotalQuestions = Config.TotalQuestions + 1
end

--[[ Store Location Configs, For Gabz 24/7 ]]
Config.Locations = {
  Registers = {
    vec3(25.444454193115, -1345.6597900391, 29.745847702026),  -- Innocence Blvd
    vec3(25.463081359863, -1347.8608398438, 29.682579040527),  -- Innocence Blvd 2
    vec3(-3040.8388671875, 585.05688476563, 8.1577463150024),  -- Inseno Road
    vec3(-3038.7465820313, 585.64587402344, 8.0944776535034),  -- Inseno Road 2
    vec3(-3243.7705078125, 1001.1959838867, 13.124083518982),  -- Barbareno Road
    vec3(-3241.6328125, 1000.9240722656, 13.01625919342),      -- Barbareno Road 2
    vec3(1729.4234619141, 6416.1899414063, 35.286056518555),   -- Great Ocean Highway
    vec3(1728.5024414063, 6414.2900390625, 35.222789764404),   -- Great Ocean Highway 2
    vec3(1698.3787841797, 4923.2553710938, 42.241004943848),   -- Grape Seed Main Street -- Duplicate
    vec3(1696.6391601563, 4924.5385742188, 42.177738189697),   -- Grape Seed Main Street 2
    vec3(1960.1284179688, 3741.80078125, 32.592575073242),     -- Alhambra Drive
    vec3(1961.2247314453, 3740.0305175781, 32.529308319092),   -- Alhambra Drive 2
    vec3(548.267578125, 2669.6276855469, 42.405326843262),     -- Route 68
    vec3(548.00909423828, 2671.7553710938, 42.342060089111),   -- Route 68 2
    vec3(2677.1232910156, 3280.9897460938, 55.489967346191),   -- Senora Freeway
    vec3(2679.0026855469, 3280.0068359375, 55.426700592041),   -- Senora Freeway 2
    vec3(2555.6130371094, 381.68075561523, 108.84066009521),   -- Palomino Freeway
    vec3(2557.7993164063, 381.78701782227, 108.80851745605),   -- Palomino Freeway 2
    vec3(373.88784790039, 327.67803955078, 103.81518554688),   -- Clinton Avenue
    vec3(373.3883972168, 325.64428710938, 103.75191497803),    -- Clinton Avenue 2
    vec3(162.21070861816, 6642.0131835938, 31.94776725769),    -- Paleto Blvd
    vec3(160.8349609375, 6640.5224609375, 31.884498596191),    -- Paleto Blvd 2
    vec3(-1820.5584716797, 793.91729736328, 138.27656555176),  -- North Rockford Drive
    vec3(-1819.0909423828, 792.31512451172, 138.20573425293),  -- North Rockford Drive 2
    vec3(-47.225128173828, -1757.5423583984, 29.598356246948), -- Grove Street
    vec3(-48.507480621338, -1759.2290039063, 29.535087585449), -- Grove Street 2
    vec3(-706.71026611328, -913.56671142578, 19.392950057983), -- Ginger Street
    vec3(-706.63818359375, -915.72418212891, 19.329681396484), -- Ginger Street 2
    vec3(1164.1452636719, -322.78991699219, 69.382453918457),  -- Mirror Park Blvd
    vec3(1164.5595703125, -324.89474487305, 69.319183349609),  -- Mirror Park Blvd 2
    -- vec3(813.35162353516, -781.05291748047, 26.423851013184)   -- Otto's Grotto (uncomment if applicable)
  },
  Computers = {
    vec3(29.566600799561, -1340.5445556641, 29.540058135986),  -- Innocence Blvd
    vec3(-3046.97265625, 587.34857177734, 7.9698204994202),    -- Inseno Road
    vec3(-3248.560546875, 1005.7445068359, 12.87788105011),    -- Barbareno Road
    vec3(1735.4163818359, 6419.0268554688, 35.104454040527),   -- Great Ocean Highway
    vec3(1707.3872070313, 4921.6953125, 42.072231292725),      -- Grape Seed Main Street
    vec3(1961.1553955078, 3748.4353027344, 32.421352386475),   -- Alhambra Drive
    vec3(544.88702392578, 2663.9619140625, 42.164329528809),   -- Route 68
    vec3(2674.609375, 3287.1359863281, 55.379375457764),       -- Senora Freeway
    vec3(2550.6496582031, 386.17181396484, 108.6351852417),    -- Palomino Freeway
    vec3(379.07958984375, 331.7546081543, 103.63817596436),    -- Clinton Avenue
    vec3(168.8938293457, 6642.8100585938, 31.740690231323),    -- Paleto Blvd
    vec3(-1828.9333496094, 797.37933349609, 138.2624206543),   -- North Rockford Drive
    vec3(-44.780643463135, -1748.8189697266, 29.464208602905), -- Grove Street
    vec3(-710.47827148438, -905.28369140625, 19.271154403687), -- Ginger Street
    vec3(1158.9605712891, -315.26245117188, 69.274871826172),  -- Mirror Park Blvd
    -- vec3(817.54010009766, -775.82873535156, 26.271017074585)   -- Otto's Grotto (uncomment if applicable)
  },
  Safes = {
    vec3(31.55398941040039, -1339.2442626953125, 29.931884765625),    -- Innocence Blvd
    vec3(-3048.759765625, 588.841796875, 8.30871486663818),           -- Inseno Road
    vec3(-3249.63623046875, 1007.7283325195312, 13.26387023925781),   -- Barbareno Road
    vec3(1737.771728515625, 6419.2626953125, 35.44829177856445),      -- Great Ocean Highway
    vec3(1708.1695556640625, 4920.82080078125, 41.35140991210937),    -- Grape Seed Main Street
    vec3(1962.2239990234375, 3750.490966796875, 32.74391174316406),   -- Alhambra Drive
    vec3(543.0894165039062, 2662.470947265625, 42.55800628662109),    -- Route 68
    vec3(2674.51318359375, 3289.502685546875, 55.64091873168945),     -- Senora Freeway
    vec3(2549.481689453125, 388.2724304199219, 109.0129852294922),    -- Palomino Freeway
    vec3(381.3895263671875, 332.4351806640625, 103.9466552734375),    -- Clinton Avenue
    vec3(171.18128967285156, 6642.26416015625, 32.09161758422851),    -- Paleto Blvd
    vec3(-1829.5384521484375, 798.4634399414062, 137.5601043701172),  -- North Rockford Drive
    vec3(-43.80093765258789, -1748.0804443359375, 28.77762031555175), -- Grove Street
    vec3(-710.1920776367188, -904.14013671875, 18.57401466369629),    -- Ginger Street
    vec3(1159.0540771484375, -314.1202087402344, 68.56658172607422),  -- Mirror Park Blvd
    -- vec3(819.6384887695312, -774.578369140625, 26.54402732849121)     -- Otto's Grotto (uncomment if applicable)
  }
}

--[[ String Configs ]]
Notify = {
  title = 'Convenience Store', -- The title for all notifications
  icon = 'store',              -- The icon for all notifications
  position = 'top-right',      -- The position of all notifications
  registerCooldown = 'Stores cannot be robbed this often - please wait and try again later',
  notEnoughPolice = 'There is not enough Police available in the city to do this',
  missingItem = 'You are missing a required tool to rob this register',
  lockpickBroke = 'You broke the lockpick and failed to open the register',
  robberyCancel = 'You stop robbing the register',
  failedHack = 'You failed hacking into the computer',
  wrongPin = 'You input the wrong pin and the safe remains locked',
  errorOccured = 'Something went wrong - please try again',
  tooManyHackFails = 'You\'ve failed to hack the computer too many times and failed robbing the store',
  tooManySafeFails = 'You\'ve input the wrong PIN too many times and failed robbing the safe'
}

Target = {
  debugTargets = false,
  registerLabel = 'Rob Register',
  registerIcon = 'fas fa-lock',
  computerLabel = 'Login',
  computerIcon = 'fas fa-computer',
  safeLabel = 'Unlock',
  safeIcon = 'fas fa-key'
}

ProgressCircle = {
  position = 'bottom', -- The position for all progressCircle's
  registerLabel = 'Grabbing cash..',
  registerDuration = 30000,
  safeLabel = 'Looting safe..',
  safeDuration = 30000
}

AlertDialog = {
  registerHeader = 'Note Found',
  registerContent = 'You found an interesting note under the register with nothing but the following numbers written on it: ',
  registerCancelButton = 'Didn\'t ask',
  registerConfirmButton = 'Got it',
  computerHeader = 'Code Exposed',
  computerContent = 'You successfully hacked the computer and find the following code: ',
  computerConfirmButton = 'Got it'
}

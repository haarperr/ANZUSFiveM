QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved


--[[
        hire = false/true, -- Ability to hire nearby people
        fire = false/true, -- Ability to fire online or offline people
        demote = false/true, -- Ability to demote online or offline people
        promote = false/true, -- Ability to promote online or offline people
        storage = false/true, -- Ability to access management storage
        funds = {
            withdraw = false/true,  -- Ability to withdraw faction funds
            deposit = false/true -- Ability to deposit money into faction funds
        }
    }
--]]
QBShared.Jobs = {
  unemployed = {
    label = 'Civilian',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Freelancer',
        payment = 10,
      },
    },
  },
  -- // WHITELISTED JOBS // --

  lspd = {
    label = 'Los Santos Police Department',
    type = 'leo',
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Cadet',
        payment = 133,
      },
      [10] = {
        name = 'Officer',
        payment = 137,
      },
      [20] = {
        name = 'Senior Officer',
        payment = 140,
      },
      [30] = {
        name = 'Corporal',
        payment = 144,
      },
      [40] = {
        name = 'Sergeant',
        payment = 148,
      },
      [50] = {
        name = 'Lieutenant',
        payment = 152,
      },
      [60] = {
        name = 'Captain',
        payment = 155,
        isboss = true,
      },
      [100] = {
        name = 'High Command',
        payment = 159,
        isboss = true,
        bankAuth = true,
      },
      [110] = {
        name = 'Commissioner',
        payment = 162,
        isboss = true,
        bankAuth = true,
      },
    }
  },
  bcso = {
    label = 'Blaine County Sheriffs Office',
    type = 'leo',
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Deputy',
        payment = 50,
      },
      [10] = {
        name = 'Senior Deputy',
        payment = 75,
      },
      [20] = {
        name = 'Corporal',
        payment = 100,
      },
      [30] = {
        name = 'Sergeant',
        payment = 125,
      },
      [40] = {
        name = 'Lieutenant',
        payment = 150,
      },
      [50] = {
        name = 'Captain',
        payment = 175,
      },
      [60] = {
        name = 'Under Sheriff',
        payment = 200,
        isboss = true,
        bankAuth = true,
      },
      [70] = {
        name = 'Sheriff',
        payment = 225,
        isboss = true,
        bankAuth = true,
      },
    }
  },
  ambulance = {
    label = 'EMS',
    type = 'ems',
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Volunteer',
        payment = 140,
      },
      [10] = {
        name = 'Candidate',
        payment = 142,
      },
      [20] = {
        name = 'Junior EMT',
        payment = 144,
      },
      [30] = {
        name = 'EMT',
        payment = 146,
      },
      [40] = {
        name = 'Paramedic',
        payment = 148,
      },
      [50] = {
        name = 'Paramedic In Charge',
        payment = 150,
      },
      [60] = {
        name = 'Lieutenant',
        payment = 152,
      },
      [70] = {
        name = 'Captain',
        payment = 154,
      },
      [80] = {
        name = 'High Command',
        payment = 158,
        isboss = true,
        bankAuth = true,
      },
    },
  },
  doj = {
    label = 'Department of Justice',
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Judge',
        payment = 100,
      },
      [10] = {
        name = 'Chief Judge',
        payment = 100,
      },
      [20] = {
        name = 'Justice',
        payment = 100,
      },
      [30] = {
        name = 'Chief Justice',
        payment = 100,
        bankAuth = true,
      },
    }
  },
  -- Mayors Office
  gov = {
    label = 'San Andreas Government',
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Deputy Mayor',
        payment = 100,
      },
      [10] = {
        name = 'Mayor',
        payment = 100,
      },
      -- BUDGET ACCESS ONLY
      [20] = {
        name = 'Chief Justice',
        payment = 100,
        bankAuth = true,
      },
    }
  },
  -- District Attorney's Office
  dao = {
    label = 'District Attorney\'s Office',
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Prosecutor',
        payment = 100,
      },
      [10] = {
        name = 'Assistant District Attorney',
        payment = 100,
      },
      [20] = {
        name = 'District Attorney',
        payment = 100,
        isboss = true,
        bankAuth = true,
      },
    }
  },
  -- Public Defenders Office
  pdo = {
    label = 'Public Defenders Office',
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Public Defender',
        payment = 100,
      },
      [10] = {
        name = 'Chief Public Defender',
        payment = 100,
        isboss = true,
        bankAuth = true,
      },
    }
  },
  tow = {
    label = 'Towing',
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Member',
        payment = 50,
      },
      [10] = {
        name = 'Senior Member',
        payment = 50,
      },
      [20] = {
        name = 'Supervisor',
        payment = 50,
      },
      [30] = {
        name = 'Co Owner',
        payment = 50,
      },
      [40] = {
        name = 'Owner',
        payment = 50,
        isboss = true,
        bankAuth = true,
      },
    },
  },
  mechanic = {
    label = 'Mechanic',
    type = "mechanic",
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Trainee',
        payment = 50,
      },
      [10] = {
        name = 'Mechanic',
        payment = 50,
      },
      [20] = {
        name = 'Senior Mechanic',
        payment = 50,
      },
      [30] = {
        name = 'Shift Boss',
        payment = 50,
      },
      [40] = {
        name = 'Assistant Manager',
        payment = 50,
      },
      [50] = {
        name = 'Manager',
        payment = 50,
        isboss = true,
        bankAuth = true,
      },
    },
  },
  atom = {
    label = 'Up n Atom',
    defaultDuty = false,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'cashier',
        payment = 50
      },
      [10] = {
        name = 'cook',
        payment = 100
      },
      [20] = {
        name = 'manager',
        isboss = true,
        payment = 150
      },
      [30] = {
        name = 'owner',
        isboss = true,
        bankAuth = true,
        payment = 200
      },
    },
  },
  hornys = {
    label = 'Horny\'s',
    defaultDuty = false,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'cashier',
        payment = 50
      },
      [10] = {
        name = 'cook',
        payment = 100
      },
      [20] = {
        name = 'manager',
        isboss = true,
        payment = 150
      },
      [30] = {
        name = 'owner',
        isboss = true,
        bankAuth = true,
        payment = 200
      },
    },
  },
  pearls = {
    label = 'Pearls',
    defaultDuty = false,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'cashier',
        payment = 50
      },
      [10] = {
        name = 'cook',
        payment = 100
      },
      [20] = {
        name = 'manager',
        isboss = true,
        payment = 150
      },
      [30] = {
        name = 'owner',
        isboss = true,
        bankAuth = true,
        payment = 200
      },
    },
  },
  koi = {
    label = 'Koi',
    defaultDuty = false,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'cashier',
        payment = 50
      },
      [10] = {
        name = 'cook',
        payment = 100
      },
      [20] = {
        name = 'manager',
        isboss = true,
        payment = 150
      },
      [30] = {
        name = 'owner',
        isboss = true,
        bankAuth = true,
        payment = 200
      },
    },
  },
  burgershot = {
    label = 'Burger Shot',
    defaultDuty = false,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'cashier',
        payment = 50
      },
      [10] = {
        name = 'cook',
        payment = 100
      },
      [20] = {
        name = 'manager',
        isboss = true,
        payment = 150
      },
      [30] = {
        name = 'owner',
        isboss = true,
        bankAuth = true,
        payment = 200
      },
    },
  },
  pizzathis = {
    label = 'Pizza This',
    defaultDuty = false,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'cashier',
        payment = 50
      },
      [10] = {
        name = 'cook',
        payment = 100
      },
      [20] = {
        name = 'manager',
        isboss = true,
        payment = 150
      },
      [30] = {
        name = 'owner',
        isboss = true,
        bankAuth = true,
        payment = 200
      },
    },
  },
  uwu = {
    label = 'Uwu Cafe',
    defaultDuty = false,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Barista',
        payment = 50
      },
      [10] = {
        name = 'Waifu',
        payment = 100
      },
      [20] = {
        name = 'Heichou',
        isboss = true,
        bankAuth = true,
        payment = 200
      },
    },
  },
  lawyer = {
    label = 'Law Firm',
    type = 'lawyer',
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Associate',
        payment = 50,
      },
    },
  },
  -- DO NOT WHITELIST TO THIS
  realestate = {
    label = 'Real Estate',
    defaultDuty = false,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Recruit',
        payment = 50,
      },
      [1] = {
        name = 'House Sales',
        payment = 75,
      },
      [2] = {
        name = 'Business Sales',
        payment = 100,
      },
      [3] = {
        name = 'Broker',
        payment = 125,
      },
      [4] = {
        name = 'Manager',
        isboss = true,
        payment = 150,
      },
    },
  },
  killmore = {
    label = 'Killmore Automotive',
    defaultDuty = true,
    offDutyPay = false,
    gps = {
      x = 1,
      y = 1,
    },
    grades = {
      [0] = {
        name = 'Recruit',
        payment = 50,
      },
      [20] = {
        name = 'Showroom Sales',
        payment = 75,
      },
      [30] = {
        name = 'Business Sales',
        payment = 100,
      },
      [40] = {
        name = 'Finance',
        payment = 125,
        bankAuth = true,
      },
      [50] = {
        name = 'Manager',
        isboss = true,
        bankAuth = true,
        payment = 150,
      },
    },
  },
  -- // END OF WHITELISTED JOBS // --


  -- // PUBLIC JOBS // --

  taxi = {
    label = 'Taxi',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Driver',
        payment = 50,
      },
    },
  },
  bus = {
    label = 'Bus',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Driver',
        payment = 50,
      },
    },
  },
  reporter = {
    label = 'Reporter',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Journalist',
        payment = 50,
      },
    },
  },
  trucker = {
    label = 'Trucker',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Driver',
        payment = 50,
      },
    },
  },
  garbage = {
    label = 'Garbage',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Collector',
        payment = 50,
      },
    },
  },
  vineyard = {
    label = 'Vineyard',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Picker',
        payment = 50,
      },
    },
  },
  hotdog = {
    label = 'Hotdog',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Sales',
        payment = 50,
      },
    },
  },
  drugdealer = {
    label = 'Drug Dealer',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Dealer',
        payment = 10,
      },
    },
  },
  postop = {
    label = 'Post OP',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = "Employee",
        payment = 75,
      },
    },
  },
  cropdusting = {
    label = 'Crop Dusting',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
      [0] = {
        name = 'Duster',
        payment = 50,
      },
    },
  },
}

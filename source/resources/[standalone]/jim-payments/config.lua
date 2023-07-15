print("^2Jim^7-^2Payments ^7v^42^7.^48^7.^45 ^7- ^2Payments Script by ^1Jimathy^7")

-- If you need support I now have a discord available, it helps me keep track of issues and give better support.

-- https://discord.gg/xKgQZ6wZvS

Config = {
  Lan = "en",
  Debug = false,
  Notify = "qb",

  ---------------------------------
  -- Default Job Payment Systems --
  ---------------------------------

  RenewedBanking = false, -- Enable if using Renewed-Banking false if using QB-Management

  ApGov = false,          -- Toggle support for AP-Goverment Tax

  List = true,            -- "true" to use nearby player list feature in the cash registers, "false" for manual id entry
  PaymentRadius = 15,     -- This is how far the playerlist will check for nearby players (based on the person charging)

  Peds = true,            -- "true" to enable peds spawning in banks
  PedPool = {
    `IG_Bankman`,
    `U_M_M_BankMan`,
    `S_F_M_Shop_HIGH`,
    `S_M_M_HighSec_02`,
    `S_M_M_HighSec_03`,
    `S_M_M_HighSec_04`,
    `A_F_Y_Business_01`,
    `A_F_Y_Business_02`,
    `A_F_Y_Business_03`,
    `A_F_Y_Business_04`,
    `A_M_M_Business_01`,
    `A_M_Y_Business_02`,
    `A_M_Y_Business_03`,
    `U_F_M_CasinoShop_01`,
  },

  PhoneBank = false, -- Set this to false to use the popup payment system FOR CARD/BANK PAYMENTS instead of using phone invoices
  -- This doesn't affect Cash payments as they by default use confirmation now
  -- This is helpful for phones that don't support invoices well

  PhoneType = "qb", -- Change this setting to make invoices work with your phone script [still testing this currently]
  -- "qb" for qb-phone
  -- "gks"" for GKSPhone

  CashInLocation = vector4(252.23, 223.11, 106.29, 159.2), -- Default Third Window along in Pacific Bank

  TicketSystem = true,                                     -- Enable this if you want to use the ticket system false
  TicketSystemAll = false,                                 -- Enable this to give tickets to all workers clocked in

  Commission = false,                                      -- Set this to true to enable Commissions and give the person charging a percentage of the total
  CommissionAll = false,                                   -- Set this to true to give commission to workers clocked in
  CommissionDouble = false,                                -- Set this to true if you want the person charging to get double Commission
  CommissionLimit = false,                                 -- If true, this limits the Commission to only be given if over the "MinAmountForTicket".
  -- If false, Commission will be given for any amount

  -- MinAmountforTicket should be your cheapest item
  -- PayPerTicket should never be higher than MinAmountforTicket
  -- Commission is a percentage eg "0.10" becomes 10%
  Jobs = {
    ['burgershot'] = { MinAmountforTicket = 50, PayPerTicket = 50, Commission = 0.10, },
    ['uwu'] = { MinAmountforTicket = 50, PayPerTicket = 50, Commission = 0.10, },
    ['mechanic'] = { MinAmountforTicket = 1000, PayPerTicket = 500, Commission = 0.10, },
    ['lostmc'] = { MinAmountforTicket = 50, PayPerTicket = 50, Commission = 0.10, gang = true, }, -- Example of a gang being supported
  },

  ------------------------------
  -- Custom Job Cash Register --
  ------------------------------
  -- This adds the ability to add multiple locations for each job
  -- Basically adding ready made locations, all you need to a vector4 and to confrim if you need a new prop in that location
  CustomCashRegisters = {
    burgershot = {
      {
        coords = vec3(-1187.6, -893.6, 14.2),
        size = vec3(0.65, 0.55, 0.55),
        rotation = 304.5,
      },
      {
        coords = vec3(-1189.12, -894.59, 14.2),
        size = vec3(0.65, 0.55, 0.55),
        rotation = 304.5,
      },
      {
        coords = vec3(-1190.62, -895.64, 14.2),
        size = vec3(0.65, 0.55, 0.55),
        rotation = 304.5,
      },
      {
        coords = vec3(-1194.91, -905.97, 14.2),
        size = vec3(0.65, 0.55, 0.55),
        rotation = 259,
      }
    },
    uwu = {
      {
        coords = vec3(-584.06, -1058.69, 22.6),
        size = vec3(0.6, 0.45, 0.5),
        rotation = 180.0,
      },
      {
        coords = vec3(-584.05, -1061.4, 22.55),
        size = vec3(0.4, 0.75, 0.4),
        rotation = 270.5,
      }
    }
  },

  -- The /polcharge command requires specific jobs to be set
  -- No tickets for these, it's just commission (0.25 = 25%)
  FineJobs = {
    ['lspd'] = { Commission = 0.25, },
  },
  FineJobConfirmation = false, --"true" makes it so fines need confirmation, "false" skips this ands just removes the money
  FineJobList = true,          -- "true" to use nearby player list feature in the cash registers, "false" for manual id entry
}
-- If Gabz banks enabled, load these locations instead
if Config.Gabz then
  Config.CashInLocation = vector4(269.28, 217.24, 106.28, 69.0)
  Config.BankLocations = {
    ["legion"] = {
      vector4(149.5, -1042.08, 29.37, 342.74), -- Legion Fleeca
    },
    ["hawick"] = {
      vector4(313.81, -280.43, 54.16, 342.29), -- Hawick Fleeca
    },
    ["vinewood"] = {
      vector4(-351.4, -51.24, 49.04, 338.4), -- Vinewood Fleeca
    },
    ["delperro"] = {
      vector4(-1212.11, -332.01, 37.78, 25.33), -- Del Perro Fleeca
    },
    ["route1"] = {
      vector4(-2961.17, 482.9, 15.7, 84.68), -- Route 1 Fleeca
    },
    ["route68"] = {
      vector4(1175.03, 2708.2, 38.09, 180.0), -- Route 68 Fleeca
    },
    ["paleto"] = {
      vector4(-110.72, 6469.82, 31.63, 222.94), -- Paleto Bank (GABZ) - 1
      vector4(-108.98, 6471.56, 31.63, 222.92), -- Paleto Bank (GABZ) - 2
    },
    ["pacific"] = {
      vector4(258.55, 227.63, 106.28, 160.96), -- Pacficic Gabz 1+2
      vector4(263.21, 225.93, 106.28, 158.25), -- Pacficic Gabz 3+4
      vector4(267.95, 224.24, 106.28, 158.5),  -- Pacficic Gabz 5+6
      vector4(263.71, 212.63, 106.28, 337.53), -- Pacficic Gabz 7+8
      vector4(259.02, 214.32, 106.28, 337.82), -- Pacficic Gabz 9+10
      vector4(254.27, 216.06, 106.28, 336.37), -- Pacficic Gabz 11+12
    },
  }
  Config.ATMLocations = {
    vector3(239.02, 212.37, 106.28),
    vector3(239.46, 213.6, 106.28),
    vector3(239.9, 214.82, 106.28),
    vector3(240.35, 216.03, 106.28),
    vector3(241.42, 218.96, 106.28),
    vector3(241.86, 220.16, 106.28),
    vector3(242.3, 221.41, 106.28),
    vector3(242.76, 222.63, 106.28),
    vector3(263.46, 203.86, 106.28),
    vector3(263.96, 205.03, 106.28),
    vector3(264.37, 206.28, 106.28),
    vector3(264.77, 207.51, 106.28),
  }
end

Loc = {}

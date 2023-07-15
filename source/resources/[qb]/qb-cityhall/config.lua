Config = Config or {}

Config.UseTarget = true

Config.NewPlateCost = 200

Config.Cityhalls = {
  { -- Cityhall 1
    coords = vec3(-542.5, -197.15, 38.24),
    showBlip = true,
    blipData = {
      sprite = 487,
      display = 4,
      scale = 0.65,
      colour = 0,
      title = "Town Hall"
    },
    licenses = {
      id_card = {
        label = "ID Card",
        cost = 500,
      },
      driver_license = {
        label = "Driver License",
        cost = 500,
        metadata = "driver"
      },
      casino_license = {
        label = "Casino License",
        cost = 10000,
      },
      firearm_license = {
        license = 'firearm',
        cost = 1000,
        label = 'Firearm License'
      },
      lspd_id = {
        job = 'lspd',
        cost = 10,
        label = 'LSPD Badge'
      }
    }
  },
  { -- Cityhall 1
    coords = vec3(-245.816, -920.749, 32.312),
    showBlip = true,
    blipData = {
      sprite = 500,
      display = 4,
      scale = 0.65,
      colour = 2,
      title = "Job Centre"
    },
    licenses = {
      id_card = {
        label = "ID Card",
        cost = 50,
      },
      driver_license = {
        label = "Driver License",
        cost = 50,
        metadata = "driver"
      },
    }
  },
}

Config.DrivingSchools = {
  -- { -- Driving School 1
  --     coords = vec3(240.3, -1379.89, 33.74),
  --     showBlip = true,
  --     blipData = {
  --         sprite = 225,
  --         display = 4,
  --         scale = 0.65,
  --         colour = 3,
  --         title = "Driving School"
  --     },
  --     instructors = {
  --         "DJD56142",
  --         "DXT09752",
  --         "SRI85140",
  --     }
  -- },
}

Config.Peds = {
  -- Cityhall Ped
  [1] = {
    model = 'a_m_m_hasjew_01',
    coords = vec4(-543.904, -197.113, 38.226, 73.503),
    scenario = 'WORLD_HUMAN_STAND_MOBILE',
    cityhall = true,
    zoneOptions = { -- Used for when UseTarget is false
      length = 3.0,
      width = 3.0,
      debugPoly = false
    }
  },
  -- Job Centre PED (Near Apartments)
  [2] = {
    model = 'cs_josh',
    coords = vec4(-234.795, -920.253, 32.312, 332.76),
    scenario = 'WORLD_HUMAN_STAND_MOBILE',
    cityhall = true,
    zoneOptions = { -- Used for when UseTarget is false
      length = 3.0,
      width = 3.0,
      debugPoly = true
    }
  },
  -- Driving School Ped
  -- {
  --     model = 'a_m_m_eastsa_02',
  --     coords = vec4(240.91, -1379.2, 32.74, 138.96),
  --     scenario = 'WORLD_HUMAN_CLIPBOARD',
  --     drivingschool = true,
  --     zoneOptions = { -- Used for when UseTarget is false
  --         length = 3.0,
  --         width = 3.0
  --     }
  -- },

}

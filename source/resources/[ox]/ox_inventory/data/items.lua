return {
  ['testburger'] = {
    label = 'Test Burger',
    weight = 220,
    degrade = 60,
    client = {
      status = { hunger = 200000 },
      anim = 'eating',
      prop = 'burger',
      usetime = 2500,
      export = 'ox_inventory_examples.testburger'
    },
    server = {
      export = 'ox_inventory_examples.testburger',
      test = 'what an amazingly delicious burger, amirite?'
    },
    buttons = {
      {
        label = 'Lick it',
        action = function(slot)
          print('You licked the burger')
        end
      },
      {
        label = 'Squeeze it',
        action = function(slot)
          print('You squeezed the burger :(')
        end
      },
      {
        label = 'What do you call a vegan burger?',
        group = 'Hamburger Puns',
        action = function(slot)
          print('A misteak.')
        end
      },
      {
        label = 'What do frogs like to eat with their hamburgers?',
        group = 'Hamburger Puns',
        action = function(slot)
          print('French flies.')
        end
      },
      {
        label = 'Why were the burger and fries running?',
        group = 'Hamburger Puns',
        action = function(slot)
          print('Because they\'re fast food.')
        end
      }
    },
    consume = 0.3
  },

  ['berkeleypack'] = {
    label = 'Pack of Berkeley Superkings',
    weight = 200,
    stack = false,
    close = true,
    description = "Smoking seriously harms you and others around you",
    client = {
      anim = { dict = 'amb@world_human_clipboard@male@idle_a', clip = 'idle_c', flag = 49 },
      disable = { move = true, car = true, combat = true },
      usetime = 5000,
    },
  },
  ['cigarette'] = {
    label = 'Berkeley Cigarette',
    weight = 200,
    stack = true,
    close = true,
    description = "",
    client = {

    }
  },
  ['harness'] = {
    label = 'Race Harness',
    weight = 1000,
    stack = false,
    close = true,
    description = "",
    consume = 0.2
  },
  ------------------
  --- FOOD/DRINK ---
  ------------------

  ['cheese_pickle_sandwich'] = {
    label = 'Cheese and Pickle Sandwich',
    weight = 300,
    stack = true,
    close = true,
    consume = 1,
    description = "Cheeeese!",
    client = {
      status = { hunger = 200000 },
      anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
      prop = {
        model = 'prop_cs_burger_01',
        pos = { x = 0.02, y = 0.02, z = -0.02 },
        rot = { x = 0.0, y = 0.0, z = 0.0 }
      },
      usetime = 2500,
    }
  },
  ['ham_sandwich'] = {
    label = 'Ham Sandwich',
    weight = 300,
    stack = true,
    close = true,
    consume = 1,
    description = "Ordinary Ham Sandwich",
    client = {
      status = { hunger = 200000 },
      anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
      prop = {
        model = 'prop_cs_burger_01',
        pos = { x = 0.02, y = 0.02, z = -0.02 },
        rot = { x = 0.0, y = 0.0, z = 0.0 }
      },
      usetime = 2500,
    }
  },
  ['tikka_sandwich'] = {
    label = 'Chicken Tikka Sandwich',
    weight = 300,
    stack = true,
    close = true,
    consume = 1,
    description = "Chicken Tikka Sandwich, imported straight from the UK",
    client = {
      status = { hunger = 200000 },
      anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
      prop = {
        model = 'prop_cs_burger_01',
        pos = { x = 0.02, y = 0.02, z = -0.02 },
        rot = { x = 0.0, y = 0.0, z = 0.0 }
      },
      usetime = 2500,
    }
  },


  ['mustard'] = {
    label = 'Mustard',
    weight = 50,
    stack = true,
    close = true,
    consume = 1,
    description = "Awww Mustard",
    client = {
      status = { hunger = 25000, thirst = 25000 },
      anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
      prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
      usetime = 2500,
      notification = 'You.. drank mustard'
    }
  },
  ['water'] = {
    label = 'Water',
    weight = 100,
    stack = true,
    close = true,
    consume = 1,
    description = "This water contains uranium",
    client = {
      status = { thirst = 5 },
      anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
      prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
      usetime = 2500,
      cancel = true,
      notification = 'You drank some refreshing water'
    }
  },
  ['ecola'] = {
    label = 'eCola',
    weight = 100,
    stack = true,
    close = true,
    consume = 1,
    description = "Not derived from Sprunk, 100% different",
    client = {
      status = { thirst = 5 },
      anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
      prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
      usetime = 2500,
      notification = 'You quenched your thirst'
    }
  },
  ['sprunk'] = {
    label = 'Sprunk',
    weight = 100,
    stack = true,
    close = true,
    consume = 1,
    description = "100% better then eCola",
    client = {
      status = { thirst = 5 },
      anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
      prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
      usetime = 2500,
      notification = 'You quenched your thirst'
    }
  },
  ['twerks_candy'] = {
    label = 'Twerks Candy',
    weight = 100,
    stack = true,
    close = true,
    consume = 1,
    description = "Interesting Flavoured Candy",
    client = {
      status = { hunger = 200000 },
      usetime = 2500,
      notification = 'You quenched your hunger'
    }
  },
  ['snikkel_candy'] = {
    label = 'Slickers',
    weight = 100,
    stack = true,
    close = true,
    consume = 1,
    description = "Scribbled Note on Slickers *Fuck those damn Scavs*",
    client = {
      status = { hunger = 200000 },
      usetime = 2500,
      notification = 'You quenched your hunger'
    }
  },
  ['beer'] = {
    label = 'Beer',
    weight = 100,
    stack = true,
    close = true,
    consume = 1,
    description = "",
    client = {
      status = { thirst = 200000 },
      anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
      prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
      usetime = 2500,
      notification = 'You quenched your thirst'
    }
  },
  ['whiskey'] = {
    label = 'Whiskey',
    weight = 200,
    stack = true,
    close = true,
    consume = 1,
    description = "",
    client = {
      status = { thirst = 200000 },
      anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
      prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
      usetime = 2500,
      notification = 'You quenched your thirst'
    }
  },
  ['vodka'] = {
    label = 'Vodka',
    weight = 200,
    stack = true,
    close = true,
    consume = 1,
    description = "",
    client = {
      status = { thirst = 200000 },
      anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
      prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
      usetime = 2500,
      notification = 'You quenched your thirst'
    }
  },
  ----------------
  --- BOX AMMO ---
  ----------------

  ['pistol_boxammo'] = {
    label = 'Pistol Ammo Box',
    weight = 1000,
    stack = false,
    close = 1,
    description = 'A Box of Pistol Ammo',
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_ld_ammo_pack_01`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 2000,
    },
  },
  ['smg_boxammo'] = {
    label = 'SMG Ammo Box',
    weight = 1000,
    stack = false,
    close = 1,
    description = 'A Box of SMG Ammo',
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_ld_ammo_pack_01`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 2000,
    },
  },
  ['rifle_boxammo'] = {
    label = 'Rifle Ammo Box',
    weight = 1000,
    stack = false,
    close = 1,
    description = 'A Box of Rifle Ammo',
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_ld_ammo_pack_01`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 2000,
    },
  },
  ['shotgun_boxammo'] = {
    label = 'Shotgun Ammo Box',
    weight = 1000,
    stack = false,
    close = 1,
    description = 'A Box of Shotgun Ammo',
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_ld_ammo_pack_01`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 2000,
    },
  },
  ['sniper_boxammo'] = {
    label = 'Sniper Ammo Box',
    weight = 1000,
    stack = false,
    close = 1,
    description = 'A Box of Sniper Ammo',
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_ld_ammo_pack_01`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 2000,
    },
  },
  ['beanbag_boxammo'] = {
    label = 'Beanbag Ammo Box',
    weight = 1000,
    stack = false,
    close = 1,
    description = 'A Box of Beanbag Ammo',
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_ld_ammo_pack_01`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 2000,
    },
  },
  ['emp_boxammo'] = {
    label = 'EMP Ammo Box',
    weight = 1000,
    stack = false,
    close = 1,
    description = 'A Box of EMP Ammo',
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_ld_ammo_pack_01`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 2000,
    },
  },
  ['mg_boxammo'] = {
    label = 'MG Ammo Box',
    weight = 1000,
    stack = false,
    close = 1,
    description = 'A Box of MG Ammo',
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_ld_ammo_pack_01`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 2000,
    },
  },
  ['taser_ammo'] = {
    label = 'Taser Ammo Box',
    weight = 1000,
    stack = false,
    close = 1,
    description = 'A Box of Taser Ammo',
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_ld_ammo_pack_01`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 2000,
    },
  },
  ---------------
  --- CASINGS ---
  ---------------

  ['emptypistolcasing'] = {
    label = 'Pistol Casing',
    weight = 500,
    stack = true,
    close = true,
    description = nil
  },
  ['emptyshotguncasing'] = {
    label = 'Shotgun Casing',
    weight = 500,
    stack = true,
    close = true,
    description = nil
  },
  ['taser_boxammo'] = {
    label = 'Taser Ammo Box',
    weight = 1000,
    stack = false,
    close = 1,
    description = 'A Box of Taser Ammo',
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_ld_ammo_pack_01`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 2000,
    },
  },
  ['emptysnipercasing'] = {
    label = 'Sniper Casing',
    weight = 500,
    stack = true,
    close = true,
    description = nil
  },
  ['emptysmgcasing'] = {
    label = 'SMG Casing',
    weight = 500,
    stack = true,
    close = true,
    description = nil
  },
  ['emptyriflecasing'] = {
    label = 'Rifle Casing',
    weight = 500,
    stack = true,
    close = true,
    description = nil
  },
  ---------------

  ['bandage'] = {
    label = 'Bandage',
    weight = 100,
    consume = 1,
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = false, car = true, combat = true },
      usetime = 4000,
    }
  },
  ['black_money'] = {
    label = 'Dirty Money',
  },
  ['megaphone'] = {
    label = 'Megaphone',
    weight = 1,
    stack = false,
    close = true,
    description = "Insert Popular Song here"
  },
  ['parachute'] = {
    label = 'Parachute',
    weight = 8000,
    stack = false,
    client = {
      anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
      usetime = 1500
    }
  },
  ['garbage'] = {
    label = 'Garbage',
  },
  ['paperbag'] = {
    label = 'Paper Bag',
    weight = 1,
    stack = false,
    close = false,
    consume = 0
  },
  ['identification'] = {
    label = 'Identification',
  },
  ['dougmeal'] = {
    label = 'Doug Meals',
    weight = 1,
    stack = false,
    close = false,
    consume = 0
  },

  ['happymeal'] = {
    label = 'Happy Meals',
    weight = 1,
    stack = false,
    close = false,
    consume = 0
  },

  -------------------
  ----- Drugs -------
  -------------------
  ['coke_brick'] = {
    label = 'Coke Brick',
    weight = 1000,
    stack = false,
    close = true,
    description = "Don't spill this on yourself"
  },
  ['cokebaggy'] = {
    label = 'Bag of Coke',
    weight = 0,
    stack = true,
    close = true,
    description = ""
  },
  ['crack_baggy'] = {
    label = 'Bag of Crack',
    weight = 0,
    stack = true,
    close = true,
    description = ""
  },
  ['weed_purple-haze'] = {
    label = 'Purple Haze 2G',
    weight = 200,
    stack = true,
    close = false,
    description = "Weed Bag containing the Strain Purple Haze"
  },

  ['weed_skunk_seed'] = {
    label = 'Skunk Seed',
    weight = 0,
    stack = true,
    close = true,
    description = "A weed seed of Skunk Strain"
  },
  ['weed_skunk'] = {
    label = 'Skunk 2G',
    weight = 200,
    stack = true,
    close = false,
    description = "Weed Bag containing the strain Skunk"
  },
  ['weed_seed'] = {
    label = 'Weed Plant seed',
    weight = 100,
    stack = false,
    close = false,
    description = "Weed Seeds"
  },

  ['weed_amnesia_seed'] = {
    label = 'Aamnesia Seed',
    weight = 0,
    stack = true,
    close = true,
    description = "A weed seed of Amnesia Strain"
  },
  ['cocaine_processing_table'] = {
    label = 'Cocaine Processing Table',
    weight = 100,
    stack = false,
    close = true,
    description = "Process materials to drugs"
  },
  ['weed_nutrition'] = {
    label = 'Plant Fertilizer',
    weight = 2000,
    stack = true,
    close = true,
    description = "Contains some nutrition right?"
  },
  ['weed'] = {
    label = 'Weed',
    weight = 100,
    stack = false,
    close = false,
    description = "Weed bud"
  },
  ['high_purity_meth'] = {
    label = 'Meth',
    weight = 100,
    stack = true,
    close = true,
    description = ""
  },
  ['empty_weed_bag'] = {
    label = 'Empty Weed Bag',
    weight = 0,
    stack = true,
    close = true,
    description = "Quote from a unknown Sasquatch 'Mmmmm, I smell marijuana!'"
  },
  ['cocaine'] = {
    label = 'Cocaine',
    weight = 100,
    stack = false,
    close = false,
    description = ""
  },
  ['meth'] = {
    label = 'Meth',
    weight = 100,
    stack = true,
    close = true,
    description = ""
  },
  ['weed_amnesia'] = {
    label = 'Amnesia 2G',
    weight = 200,
    stack = true,
    close = false,
    description = "A weed bag with 2g Amnesia Weed Strain"
  },
  ['weed_og-kush'] = {
    label = 'OG Kush 2G',
    weight = 200,
    stack = true,
    close = false,
    description = "A 2G bag of the OG Kush"
  },
  ['weed_brick'] = {
    label = 'Weed Brick',
    weight = 1000,
    stack = true,
    close = true,
    description = "A lot of weed, this is illegal right?"
  },
  ['weed_white-widow'] = {
    label = 'White Widow 2G',
    weight = 200,
    stack = true,
    close = false,
    description = "Weed Bag containing the strain White Widow"
  },
  ['weed_ak47'] = {
    label = 'AK47 2G',
    weight = 200,
    stack = true,
    close = false,
    description = "A weed bag with 2g AK47 Weed Strain"
  },
  ['weed_purple-haze_seed'] = {
    label = 'Purple Haze Seed',
    weight = 0,
    stack = true,
    close = true,
    description = "A weed seed of Purple Haze Strain"
  },
  ['weed_ak47_seed'] = {
    label = 'AK47 Seed',
    weight = 0,
    stack = true,
    close = true,
    description = "A weed seed of AK47 Strain"
  },
  ['weed_white-widow_seed'] = {
    label = 'White Widow Seed',
    weight = 0,
    stack = true,
    close = false,
    description = "A weed seed of the Legendary White Widow Strain"
  },
  ['weed_insecticide'] = {
    label = 'Insecticide',
    weight = 100,
    stack = true,
    close = true,
    description = "Insecticides for marijuana"
  },
  ['barrel_methylamine'] = {
    label = 'Barrel of Methylamine',
    weight = 50000,
    stack = false,
    close = true,
    description = "High-purity chemical compound essential for industrial applications and synthesis processes"
  },
  ['open_barrel_methylamine'] = {
    label = 'Barrel of Methylamine',
    weight = 10,
    stack = false,
    close = true,
    description = "Unveiling a potent chemical resource for research, manufacturing, and scientific exploration"
  },
  ['low_purity_meth'] = {
    label = 'Meth',
    weight = 100,
    stack = true,
    close = true,
    description = ""
  },
  ['bottle_methylamine'] = {
    label = 'Bottle of Methylamine',
    weight = 350,
    stack = true,
    close = true,
    description = "A bottle full of methylamine"
  },
  ['oxy'] = {
    label = 'Prescription Oxy',
    weight = 0,
    stack = true,
    close = true,
    description = "The Prescription Label has been Ripped Off"
  },
  ----------------
  --- FOOD  ITEMS ---
  ----------------

  ["bleeder_burger"] = {
    label = "Bleeder Burger",
    weight = 200,
    stack = true,
    close = false,
    description = "Bleeder Burger",
    client = {
      status = { hunger = 25 },
      anim = 'eating',
      prop = 'burger',
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["german_burger"] = {
    label = "German Burger",
    weight = 200,
    stack = true,
    close = false,
    description = "German Burger",
    client = {
      status = { hunger = 15 },
      anim = 'eating',
      prop = 'burger',
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["chozzo_burger"] = {
    label = "Chozzo Burger",
    weight = 200,
    stack = true,
    close = false,
    description = "Chozzo Burger",
    client = {
      status = { hunger = 20 },
      anim = 'eating',
      prop = 'burger',
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["hearts_burger"] = {
    label = "Heartstopper Burger",
    weight = 200,
    stack = true,
    close = false,
    description = "Heartstopper Burger",
    client = {
      status = { hunger = 60, stress = -25000 },
      anim = 'eating',
      prop = 'burger',
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["vegan_burger"] = {
    label = "Vegan Burger",
    weight = 200,
    stack = true,
    close = false,
    description = "Vegan Burger, probably doesn't contain Meat",
    client = {
      status = { hunger = 10 },
      anim = 'eating',
      prop = 'burger',
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["chicken_burger"] = {
    label = "Chicken Burger",
    weight = 200,
    stack = true,
    close = false,
    description = "Chicken Burger",
    client = {
      status = { hunger = 25 },
      anim = 'eating',
      prop = 'burger',
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["small_fries"] = {
    label = "Small Fries",
    weight = 50,
    stack = true,
    close = false,
    description = "Small Fries",
    client = {
      status = { hunger = 10 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["medium_fries"] = {
    label = "Medium Fries",
    weight = 100,
    stack = true,
    close = false,
    description = "Medium Fries",
    client = {
      status = { hunger = 15 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["large_fries"] = {
    label = "Large Fries",
    weight = 200,
    stack = true,
    close = false,
    description = "Large Fries",
    client = {
      status = { hunger = 25 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["original_glazed_donut"] = {
    label = "Original Glazed Donut",
    weight = 100,
    stack = true,
    close = false,
    description = "OG Glazed Donut",
    client = {
      status = { hunger = 5 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["pink_glazed_donut"] = {
    label = "Pink Glazed Donut",
    weight = 100,
    stack = true,
    close = false,
    description = "Pink Glazed Donut",
    client = {
      status = { hunger = 3 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["plain_donut"] = {
    label = "Plain Donut",
    weight = 100,
    stack = true,
    close = false,
    description = "Plain Donut",
    client = {
      status = { hunger = 3 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["rainbow_donut"] = {
    label = "Rainbow Glazed Donut",
    weight = 100,
    stack = true,
    close = false,
    description = "Rainbow Glazed Donut",
    client = {
      status = { hunger = 7 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["blueberry_slushie"] = {
    label = "Blueberry Slushie",
    weight = 100,
    stack = true,
    close = false,
    description = "Blueberry Slushie",
    client = {
      status = { thirst = 40 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["strawberry_slushie"] = {
    label = "Strawberry Slushie",
    weight = 100,
    stack = true,
    close = false,
    description = "Strawberry Slushie",
    client = {
      status = { thirst = 40 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["ecola_light"] = {
    label = "Ecola Light",
    weight = 100,
    stack = true,
    close = false,
    description = "Ecola Light",
    client = {
      status = { thirst = 15 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["sprunk_light"] = {
    label = "Sprunk Light",
    weight = 100,
    stack = true,
    close = false,
    description = "Sprunk Light",
    client = {
      status = { thirst = 15 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["vanilla_milkshake"] = {
    label = "Vanilla Milkshake",
    weight = 100,
    stack = true,
    close = false,
    description = "Vanilla Milkshake",
    client = {
      status = { hunger = 5 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["cocaine_milkshake"] = {
    label = "Cocaine Milkshake",
    weight = 100,
    stack = true,
    close = false,
    description = "Cocaine Milkshake",
    client = {
      status = { stress = 15 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["banana_milkshake"] = {
    label = "Banana Milkshake",
    weight = 100,
    stack = true,
    close = false,
    description = "Banana Milkshake",
    client = {
      status = { hunger = 5 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["chocolate_milkshake"] = {
    label = "Chocolate Milkshake",
    weight = 100,
    stack = true,
    close = false,
    description = "Chocolate Milkshake",
    client = {
      status = { hunger = 5 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["lingon_milkshake"] = {
    label = "Lingon Milkshake",
    weight = 100,
    stack = true,
    close = false,
    description = "Lingon Milkshake",
    client = {
      status = { hunger = 5 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["tapioca_pearls"] = {
    label = 'Tapioca Pearls',
    weight = 25,
    stack = true,
    close = true,
    description = "Tapioca Pearls used for making Bubble Tea"
  },
  ["pink_bubble_tea"] = {
    label = "Pink Bubble Tea",
    weight = 100,
    stack = true,
    close = false,
    description = "Pink Bubble Tea",
    client = {
      status = { hunger = 30 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["green_bubble_tea"] = {
    label = "Green Bubble Tea",
    weight = 100,
    stack = true,
    close = false,
    description = "Green Bubble Tea",
    client = {
      status = { hunger = 25 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["blue_bubble_tea"] = {
    label = "Blue Bubble Tea",
    weight = 100,
    stack = true,
    close = false,
    description = "Blue Bubble Tea",
    client = {
      status = { hunger = 27 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["matcha_tea"] = {
    label = "Green Matcha Tea Latte",
    weight = 100,
    stack = true,
    close = false,
    description = "Green Matcha Tea",
    client = {
      status = { hunger = 25 },
      anim = 'drinking',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["matcha_powder"] = {
    label = 'Matcha Powder',
    weight = 25,
    stack = true,
    close = true,
    description = "Matcha Powder used for Tea"
  },
  ["chicken_cucumber_sandwich"] = {
    label = "Chicken and Cucumber Sandwich",
    weight = 200,
    stack = true,
    close = false,
    description = "A Sandwich containing Chicken and Cucumber",
    client = {
      status = { hunger = 35 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["cucumber"] = {
    label = 'Cucumber',
    weight = 25,
    stack = true,
    close = true,
    description = "A Vegetable"
  },
  ["breaded_chicken"] = {
    label = 'Breaded Chicken Cutlet',
    weight = 25,
    stack = true,
    close = true,
    description = "Used in Sandwiches"
  },
  ["raw_breaded_chicken"] = {
    label = 'Raw Breaded Chicken Cutlet',
    weight = 25,
    stack = true,
    close = true,
    description = "Raw Chicken Cutlet"
  },
  ["bread"] = {
    label = 'Bread',
    weight = 25,
    stack = true,
    close = true,
    description = "Plain Ol Bread"
  },





  ["green_mochi_ice_cream"] = {
    label = "Green Mochi Ice Cream",
    weight = 25,
    stack = true,
    close = false,
    description = "Ice Cream with Green Mochi",
    client = {
      status = { hunger = 5, thirst = 15 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["yellow_mochi_ice_cream"] = {
    label = "Yellow Mochi Ice Cream",
    weight = 100,
    stack = true,
    close = false,
    description = "Ice Cream with Yellow Mochi",
    client = {
      status = { hunger = 5, thirst = 17 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["pink_mochi_ice_cream"] = {
    label = "Pink Mochi Ice Cream",
    weight = 100,
    stack = true,
    close = false,
    description = "Ice Cream with Pink Mochi",
    client = {
      status = { hunger = 10, thirst = 10 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["milk"] = {
    label = 'Milk',
    weight = 50,
    stack = true,
    close = true,
    description = "Milk from a Cow"
  },
  ["green_mochi"] = {
    label = 'Green Mochi',
    weight = 25,
    stack = true,
    close = true,
    description = "Green Mochi, used in Ice Cream"
  },
  ["yellow_mochi"] = {
    label = 'Yellow Mochi',
    weight = 25,
    stack = true,
    close = true,
    description = "Yellow Mochi, used in Ice Cream"
  },
  ["pink_mochi"] = {
    label = 'Pink Mochi',
    weight = 25,
    stack = true,
    close = true,
    description = "Pink Mochi, used in Ice Cream"
  },
  ["lingon"] = {
    label = 'Bunch of Lingonberries',
    weight = 25,
    stack = true,
    close = true,
    description = "Lingonberries in a bunch"
  },
  ["flour"] = {
    label = 'Bag of Flour',
    weight = 25,
    stack = true,
    close = true,
    description = "Bag of Flour"
  },
  ["bottle_cream"] = {
    label = 'Bottle of Cream',
    weight = 25,
    stack = true,
    close = true,
    description = "Cream from Cows milk"
  },
  ["vanilla_ice_cream"] = {
    label = 'Tub of Vanilla Ice Cream',
    weight = 100,
    stack = true,
    close = true,
    description = "Ice Cream containing Vanilla Extract and Cream"
  },
  ["banana"] = {
    label = 'Plain Old Banana',
    weight = 50,
    stack = true,
    close = true,
    description = "Imported Bananas from China"
  },
  ["chocolate_powder"] = {
    label = 'Chocolate Powder',
    weight = 25,
    stack = true,
    close = true,
    description = "Used in making Milshakes / Hot Cholcolate"
  },

  ["bento_box"] = {
    label = "Bento Box",
    weight = 200,
    stack = true,
    close = false,
    description = "Bento Box containing Rice, Pickled Vegetables & Boiled Eggs",
    client = {
      status = { hunger = 45 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["pickled_vegetables"] = {
    label = 'Pickled Vegetables',
    weight = 100,
    stack = true,
    close = true,
    description = "A Combination of Vegetables pickled with Vinegar"
  },
  ["rice_ball"] = {
    label = 'Rice Ball',
    weight = 50,
    stack = true,
    close = true,
    description = "A ball of white rice"
  },
  ["boiled_egg"] = {
    label = 'Boiled Egg',
    weight = 25,
    stack = true,
    close = true,
    description = "A Boiled Chicken Egg"
  },
  ["strawberry_shortcake"] = {
    label = "Slice of Strawberry Shortcake",
    weight = 200,
    stack = true,
    close = false,
    description = "Shortcake containing Strawberry and Cream",
    client = {
      status = { hunger = 35 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["strawberry"] = {
    label = 'Strawberries',
    weight = 50,
    stack = true,
    close = true,
    description = "A Carton of Strawberries"
  },
  ["blueberry_shortcake"] = {
    label = "Slice of Blueberry Shortcake",
    weight = 200,
    stack = true,
    close = false,
    description = "Shortcake containing Blueberry and Cream",
    client = {
      status = { hunger = 30, thirst = 5 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["blueberry"] = {
    label = 'Blueberries',
    weight = 50,
    stack = true,
    close = true,
    description = "A Carton of Blueberries"
  },
  ["shortcake_mix"] = {
    label = 'Shortcake Mix',
    weight = 200,
    stack = true,
    close = true,
    description = "A Box containing Shortcake Mix"
  },
  ["vegetable_curry"] = {
    label = "Vegetable Curry",
    weight = 200,
    stack = true,
    close = false,
    description = "A Hearty Vegetable Curry with a medium amount of heat",
    client = {
      status = { hunger = 15, thirst = 15 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["vindaloo_curry"] = {
    label = "Vegetable Curry",
    weight = 100,
    stack = true,
    close = false,
    description = "A Chicken Vindaloo Curry with little heat *wink*",
    client = {
      status = { hunger = 25 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["curry_powder"] = {
    label = 'Curry Powder',
    weight = 25,
    stack = true,
    close = true,
    description = "A tin of Curry Powder"
  },
  ["assort_vegetables"] = {
    label = 'Assorted Vegetables',
    weight = 25,
    stack = true,
    close = true,
    description = "A box of Assorted Vegetables, commonly used for Curry"
  },
  ["herbs_spices"] = {
    label = 'Assorted Herbs & Spices',
    weight = 25,
    stack = true,
    close = true,
    description = "Commonly used in Curry dishes to add flavour"
  },
  ["raw_patty"] = {
    label = "Raw Beef Patty",
    weight = 50,
    stack = true,
    close = false,
    description = "Raw Beef Patty",
  },
  ["vegan_patty"] = {
    label = "Vegan Patty",
    weight = 50,
    stack = true,
    close = false,
    description = "Raw Vegan Patty",
  },
  ["pork_patty"] = {
    label = "Pork Patty",
    weight = 50,
    stack = true,
    close = false,
    description = "Raw Pork Patty",
  },
  ["cheese"] = {
    label = "Cheese",
    weight = 25,
    stack = true,
    close = false,
    description = "CHEEEEEEESE!",
  },
  ["burger_bun"] = {
    label = "Sesame Seed Burger Bun",
    weight = 50,
    stack = true,
    close = false,
    description = "Put your patties between this",
  },
  ["mineral_water"] = {
    label = "Jug of Mineral Water",
    weight = 50,
    stack = true,
    close = false,
    description = "Clean Water",
  },
  ["sugar_sack"] = {
    label = "Sack of Sugar",
    weight = 25,
    stack = true,
    close = false,
    description = "Sugar Sack",
  },
  ["slushie_mix_blueberry"] = {
    label = "Bag of Blueberry Slushie Mix",
    weight = 100,
    stack = true,
    close = false,
    description = "Does this contain crack?",
  },
  ["slushie_mix_strawberry"] = {
    label = "Bag of Strawberry Slushie Mix",
    weight = 100,
    stack = true,
    close = false,
    description = "Potentially contains Strawberries",
  },
  ["raw_chicken"] = {
    label = "Raw Chicken Breast",
    weight = 50,
    stack = true,
    close = false,
    description = "Raw Chicken Breast",
  },
  ["sushi"] = {
    label = "Sushi",
    weight = 200,
    stack = true,
    close = false,
    description = "Sushi", --Not in use
    client = {
      image = "sushi.png",
      status = { hunger = 25 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
      notification = 'You ate a delicious burger'
    },
    consume = 1.0,
  },
  ["tortilla"] = {
    label = "Tortilla",
    weight = 50,
    stack = true, --Not in use
    close = false,
    description = "Tortilla",
  },
  ["orange"] = {
    label = "Orange",
    weight = 50,
    stack = true, --Not in use
    close = false,
    description = "Orange",
  },
  ["orange_chicken"] = {
    label = "Orange Chicken",
    weight = 200,
    stack = true,
    close = false, --Not in use
    description = "Orange Chicken",
    consume = 1.0,
    client = {
      status = { hunger = 25 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
  },
  ["fried_rice"] = {
    label = "Fried Rice",
    weight = 200,
    stack = true,
    close = false,
    description = "Fried Rice", --Not in use
    client = {
      status = { hunger = 25 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ["rice"] = {
    label = "Rice",
    weight = 100,
    stack = true, --Not in use
    close = false,
    description = "Rice",
  },
  ["tomato"] = {
    label = "Tomato",
    weight = 50,
    stack = true,
    close = false,
    description = "Tomato",
  },
  ["lettuce"] = {
    label = "Lettuce",
    weight = 50,
    stack = true,
    close = false,
    description = "Farm Fresh Lettuce",
  },
  ["potato"] = {
    label = "Potato",
    weight = 50,
    stack = true,
    close = false,
    description = "Potatoes from Down Under",
  },
  ["onions"] = {
    label = "Onions",
    weight = 50,
    stack = true,
    close = false,
    description = "Fresh Onions from the Farm",
  },
  ["cooked_chicken"] = {
    label = "Cooked Chicken",
    weight = 50,
    stack = true,
    close = false,
    description = "Cooked Chicken",
  },
  ["cooked_patty"] = {
    label = "Cooked Patty",
    weight = 50,
    stack = true,
    close = false,
    description = "Cooked Patty",
  },
  ["salmon"] = {
    label = "Salmon",
    weight = 1000,
    stack = true,
    close = false,
    description = "",
  },
  ["cooked_salmon"] = {
    label = "Cooked Salmon",
    weight = 1000,
    stack = true, --Not in use
    close = false,
    description = "",
  },
  ["catfish"] = {
    label = "Catfish",
    weight = 1000,
    stack = true,
    close = false,
    description = "",
  },
  ["cooked_catfish"] = {
    label = "Catfish",
    weight = 1000,
    stack = true, --Not in use
    close = false,
    description = "",
  },
  ['tigershark'] = {
    label = 'Tiger Shark',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ["fish_taco"] = {
    label = "Fish Taco",
    weight = 200,
    stack = true,
    close = false, --Not in use
    description = "Fish Taco",
    client = {
      status = { hunger = 25 },
      anim = 'eating',
      prop = nil,
      usetime = 2500,
    },
    consume = 1.0,
  },
  ['redfish'] = {
    label = 'Red Fish',
    weight = 1000,
    stack = true,
    close = true,
    description = "",
    consume = 0,
  },
  ['bluefish'] = {
    label = 'Blue Fish',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['largemouthbass'] = {
    label = 'Large Mouth Bass',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['stripedbass'] = {
    label = 'Striped Bass',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['panties'] = {
    label = 'Knickers',
    weight = 50,
    consume = 0,
    client = {
      status = { thirst = -100000, stress = -25000 },
      anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
      prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
      usetime = 2500,
    }
  },
  ['knife'] = {
    label = 'Knife',
    weight = 150,
  },
  ['lockpick'] = {
    label = 'Lockpick',
    weight = 900,
  },
  ['phone'] = {
    label = 'Phone',
    weight = 200,
    stack = false,
    consume = 0,
    client = {
      add = function(total)
        if total > 0 then
          pcall(function() return exports.npwd:setPhoneDisabled(false) end)
        end
      end,
      remove = function(total)
        if total < 1 then
          pcall(function() return exports.npwd:setPhoneDisabled(true) end)
        end
      end
    }
  },
  ['money'] = {
    label = 'Money',
  },
  ['radio'] = {
    label = 'Radio',
    weight = 1000,
    stack = false,
    allowArmed = true
  },
  ['armour'] = {
    label = 'Bulletproof Vest',
    weight = 3000,
    stack = false,
    client = {
      anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
      usetime = 3500
    }
  },
  ['mastercard'] = {
    label = 'Mastercard',
    stack = false,
    weight = 10,
  },
  ['guntrigger'] = {
    label = 'Gun Trigger',
    weight = 400,
    stack = true,
    close = true,
    description = nil
  },
  ['advancedscrewdriver'] = {
    label = 'Advanced Screwdriver',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['screwdriver'] = {
    label = 'Screwdriver',
    weight = 500,
    stack = true,
    close = false,
    description = ""
  },
  ['blowtorch'] = {
    label = 'Blow Torch',
    weight = 10000,
    stack = true,
    close = false,
    description = ""
  },
  ['bprooftires'] = {
    label = 'Bulletproof Tires',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['tint_supplies'] = {
    label = 'Tinting Supplies',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['mining_washedstone'] = {
    label = 'Washed Stone',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['transmission2'] = {
    label = 'Tier 2 Transmission',
    weight = 2500,
    stack = false,
    close = 1,
    description = ""
  },
  ['stoppedvehicles'] = {
    label = 'Caution Sign',
    weight = 2000,
    stack = true,
    close = true,
    description = "A sign to warn vehicles of other stopped vehicles ahead"
  },
  ['security_card_03'] = {
    label = 'Purple Security Card',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['carcass'] = {
    label = 'Carcass',
    weight = 1500,
    stack = true,
    close = false,
    description = "Animal carcass"
  },
  ['craft1'] = {
    label = 'Crafting Table',
    weight = 5000,
    stack = false,
    close = true,
    description = "Wonder what this could do"
  },
  ['transmission1'] = {
    label = 'Tier 1 Transmission',
    weight = 1500,
    stack = false,
    close = 1,
    description = ""
  },
  ['faberge_egg'] = {
    label = 'Faberge Egg',
    weight = 2500,
    stack = false,
    close = false,
    description = "A Precious Faberge Egg - Property of the Los Santos Art Gallery"
  },
  ['goldchain'] = {
    label = 'Golden Chain',
    weight = 700,
    stack = true,
    close = false,
    description = ""
  },
  ['spoiler'] = {
    label = 'Vehicle Spoiler',
    weight = 1500,
    stack = false,
    close = 1,
    description = ""
  },
  ['rolling_paper'] = {
    label = 'Rolling Paper',
    weight = 50,
    stack = true,
    close = true,
    description = ""
  },
  ['pdcamera'] = {
    label = 'Camera',
    weight = 500,
    stack = false,
    close = true,
    description = "A PD camera for Crime Scene Pictures - Property of the LSPD"
  },
  ['cryptostick'] = {
    label = 'Crypto Stick',
    weight = 200,
    stack = false,
    close = true,
    description = "Why would someone ever buy something that doesn't exist.. Or does it?"
  },
  ['oil_suppressor'] = {
    label = 'Oil Suppressor',
    weight = 900,
    stack = true,
    close = true,
    description = ""
  },
  ['mechboard'] = {
    label = 'Mechanic Sheet',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['launchertube'] = {
    label = 'Launcher Tube',
    weight = 10000,
    stack = true,
    close = false,
    description = ""
  },
  ['gpu'] = {
    label = 'GPU',
    weight = 1000,
    stack = false,
    close = false,
    description = "A Graphics Card"
  },
  ['refinedgp'] = {
    label = 'Refined Gunpowder',
    weight = 2000,
    stack = true,
    close = false,
    description = ""
  },
  ['mining_goldnugget'] = {
    label = 'Golden Nugget',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['fullbag'] = {
    label = 'Fullbag',
    weight = 1,
    stack = false,
    close = false,
    description = ""
  },
  ['iron'] = {
    label = 'Iron',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['steroid'] = {
    label = 'Steroid',
    weight = 100,
    stack = false,
    close = false,
    description = ""
  },
  ['artg_painting6'] = {
    label = 'Painting',
    weight = 500,
    stack = true,
    close = false,
    description = "A stolen painting from the Vinewood Art Gallery"
  },
  ['postop_emptycrate'] = {
    label = 'Empty Shipping Crate',
    weight = 10000,
    stack = false,
    close = false,
    description = "An empty Post OP Shipping Crate.."
  },
  ['crate'] = {
    label = 'Crate',
    weight = 200,
    stack = false,
    close = false,
    description = 'A crate'
  },
  ['weaponcleaningkit'] = {
    label = 'Firearm Cleaning Kit',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['paintballhopper'] = {
    label = 'Paintball Hopper',
    weight = 500,
    stack = true,
    close = false,
    description = ""
  },
  ['empty_tank'] = {
    label = 'Empty Oxygen',
    weight = 3000,
    stack = false,
    close = true,
    description = "Empty Oxygen Tank used for Diving"
  },
  ['cash_roll'] = {
    label = 'Roll with Money',
    weight = 0,
    stack = true,
    close = true,
    description = ""
  },
  ['labkey'] = {
    label = 'Key',
    weight = 500,
    stack = false,
    close = true,
    description = "Key for a lock...?"
  },
  ['silver_ring'] = {
    label = 'Silver Ring',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['engine5'] = {
    label = 'Tier 5 Engine',
    weight = 5000,
    stack = false,
    close = 1,
    description = ""
  },
  ['mechanic_tools'] = {
    label = 'Mechanic Tools',
    weight = 0,
    stack = false,
    close = 1,
    description = "Needed for Vehicle Repairs"
  },
  ['pistolslide'] = {
    label = 'Pistol Slide',
    weight = 500,
    stack = true,
    close = true,
    description = nil
  },
  ['mining_copperfragment'] = {
    label = 'Copper Fragment',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['evidence_report'] = {
    label = 'Evidence Report',
    weight = 300,
    stack = false,
    close = true,
    description = "A report of evidence collected"
  },
  ['goldbar'] = {
    label = 'Gold Bar',
    weight = 7000,
    stack = true,
    close = true,
    description = "If found, return to *Name Scratched Off*"
  },
  ['glasses'] = {
    label = 'Glasses',
    weight = 300,
    stack = false,
    close = true,
    description = "Take your Glasses on and off"
  },
  ['smithingwrench'] = {
    label = 'Weapon Smithing Wrench',
    weight = 2000,
    stack = true,
    close = false,
    description = ""
  },
  ['ruby'] = {
    label = 'Ruby',
    weight = 100,
    stack = true,
    close = false,
    description = "A Ruby that shimmers"
  },
  ['ephedrine'] = {
    label = 'Ephedrine',
    weight = 100,
    stack = true,
    close = false,
    description = "Can treat low blood pressure caused by other medications. It can also improve breathing"
  },
  ['suspension2'] = {
    label = 'Tier 2 Suspension',
    weight = 2000,
    stack = false,
    close = 1,
    description = ""
  },
  ['clothing'] = {
    label = 'Clothing',
    weight = 300,
    stack = false,
    close = true,
    description = "Take your Clothing on and off",
    client = {
      usetime = 1500
    },
    consume = 0
  },
  ['heavyarmor'] = {
    label = 'Heavy armor',
    weight = 5000,
    stack = true,
    close = true,
    description = "Think you need a bit more proection eh?"
  },
  ['sapphire'] = {
    label = 'Sapphire',
    weight = 100,
    stack = true,
    close = false,
    description = "A Sapphire that shimmers"
  },
  ['carcass2'] = {
    label = 'Carcass',
    weight = 1500,
    stack = true,
    close = false,
    description = "Animal carcass"
  },
  ['mining_ironbar'] = {
    label = 'Iron Bar',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['advancedlockpick'] = {
    label = 'Advanced Lockpick',
    weight = 1500,
    stack = true,
    close = true,
    consume = 0.5,
    description = "If you lose your keys a lot this is very useful... Also useful to open your beers"
  },
  ['uzi_drum'] = {
    label = 'Uzi Drum Mag',
    weight = 1000,
    stack = true,
    close = true,
    description = "Use on UZI only"
  },
  ['miningdrill'] = {
    label = 'Mining Drill',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['drifttires'] = {
    label = 'Drift Tires',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['laptop_red'] = {
    label = 'Laptop',
    weight = 2500,
    stack = false,
    close = true,
    description = ""
  },
  ['boostinglaptop'] = {
    label = 'Laptop',
    weight = 2500,
    stack = false,
    close = true,
    description = "Laptop that belonged to a famous racer with the last name Toretti...."
  },
  ['lspd_id'] = {
    label = 'LSPD Badge',
    weight = 2,
    stack = false,
    close = true,
    description = 'Official Los Santos Police Department badge',
  },
  ['boostingdisabler'] = {
    label = 'Tracking Disabler',
    weight = 2500,
    stack = false,
    close = true,
    description = ""
  },

  ['fuel'] = {
    label = 'Fuel',
    weight = 500,
    stack = false,
    close = false,
    description = "Fuel"
  },
  ['certificate'] = {
    label = 'Certificate',
    weight = 50,
    stack = true,
    close = true,
    description = ""
  },
  ['visa'] = {
    label = 'Visa Card',
    weight = 50,
    stack = false,
    close = false,
    description = "Visa Card can be used at an ATM"
  },
  ['suspension3'] = {
    label = 'Tier 3 Suspension',
    weight = 3000,
    stack = false,
    close = 1,
    description = ""
  },
  ['gold_ring'] = {
    label = 'Gold Ring',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['rentalpapers'] = {
    label = 'Rental Documents',
    weight = 100,
    stack = false,
    close = true,
    description = "Paperwork signed by the Rental Company"
  },
  ['generator'] = {
    label = 'Generator',
    weight = 20000,
    stack = true,
    close = true,
    description = "A portable generator to supply power in the field"
  },
  ['redcarcass3'] = {
    label = 'Carcass',
    weight = 1000,
    stack = true,
    close = false,
    description = "Animal carcass of poached animal"
  },
  ['artg_painting5'] = {
    label = 'Painting',
    weight = 500,
    stack = true,
    close = false,
    description = "A stolen painting from the Vinewood Art Gallery"
  },
  ['noscan'] = {
    label = 'Empty NOS Bottle',
    weight = 1500,
    stack = true,
    close = true,
    description = "An Empty bottle of NOS"
  },
  ['drillbit'] = {
    label = 'Drill Bit',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['ducttape'] = {
    label = 'Duct Tape',
    weight = 0,
    stack = true,
    close = 1,
    description = "Good for quick fixes"
  },
  ['diffusedbomb'] = {
    label = 'Diffused Bomb',
    weight = 2000,
    stack = true,
    close = true,
    description = "An actual bomb, but with its wires cut and detonator disabled"
  },
  ['hood'] = {
    label = 'Vehicle Hood',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['mining_goldbar'] = {
    label = 'Gold Bar',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['rolex'] = {
    label = 'Golden Watch',
    weight = 1500,
    stack = true,
    close = true,
    description = "If found, return to *Name Scratched Off*"
  },
  ['sapphire_earring'] = {
    label = 'Sapphire Earrings',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['goldbar2'] = {
    label = 'Gold Bar',
    weight = 500,
    stack = true,
    close = true,
    description = "Property of The Diamond Casino & Resort"
  },
  ['engine4'] = {
    label = 'Tier 4 engine',
    weight = 4500,
    stack = false,
    close = 1,
    description = ""
  },
  ['isifter'] = {
    label = 'Industrial Hand Held Sifter',
    weight = 500,
    stack = true,
    close = true,
    description = nil
  },
  ['copper'] = {
    label = 'Copper',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['markedbills'] = {
    label = 'Marked Money',
    stack = true,
    close = true,
    description = "Money?"
  },
  ['ink'] = {
    label = 'Ink',
    weight = 100,
    stack = false,
    close = true,
    description = "Don't get this on your clothes."
  },
  ['seat'] = {
    label = 'Seat Cosmetics',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['fake_plate'] = {
    label = 'Plate Number',
    weight = 500,
    stack = false,
    close = true,
    description = "A fake plate?"
  },
  ['ruby_earring'] = {
    label = 'Ruby Earrings',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },

  ['sapphire_ring'] = {
    label = 'Sapphire Ring',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['lawyerpass'] = {
    label = 'Lawyer Pass',
    weight = 0,
    stack = false,
    close = false,
    description = ""
  },
  ['xtcbaggy'] = {
    label = 'Bag of XTC',
    weight = 0,
    stack = true,
    close = true,
    description = ""
  },
  ['diamond_earring'] = {
    label = 'Diamond Earrings',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['exhaust'] = {
    label = 'Vehicle Exhaust',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['mining_pan'] = {
    label = 'Washing Pan',
    weight = 500,
    stack = false,
    close = true,
    description = ""
  },
  ['repairkit'] = {
    label = 'Repair Kit',
    weight = 1000,
    stack = true,
    close = true,
    description = "Used to fix automobiles after you let your friend drive"
  },
  ['tent'] = {
    label = 'Canopy',
    weight = 1000,
    stack = true,
    close = true,
    description = "A Portable Tent"
  },
  ['cowshit'] = {
    label = 'Cow Shit',
    weight = 5000,
    stack = true,
    close = true,
    description = "Why would you pick this up with your hands?"
  },
  ['laptop_black'] = {
    label = 'Laptop',
    weight = 2500,
    stack = false,
    close = false,
    description = "A laptop made for hacking"
  },
  ['goldingot'] = {
    label = 'Gold Ingot',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['fitbit'] = {
    label = 'Fitbit',
    weight = 200,
    stack = false,
    close = true,
    description = ""
  },
  ['artg_painting1'] = {
    label = 'Painting',
    weight = 500,
    stack = true,
    close = false,
    description = "A stolen painting from the Vinewood Art Gallery"
  },
  ['customplate'] = {
    label = 'Customized Plates',
    weight = 500,
    stack = false,
    close = 1,
    description = ""
  },
  ['turbo'] = {
    label = 'Supercharger Turbo',
    weight = 10000,
    stack = true,
    close = 1,
    description = "Who doesn't need a 65mm Turbo??"
  },
  ['moneybag'] = {
    label = 'Money Bag',
    weight = 0,
    stack = false,
    close = true,
    description = ""
  },
  ['engine2'] = {
    label = 'Tier 2 Engine',
    weight = 2500,
    stack = false,
    close = 1,
    description = ""
  },
  ['mtlionpelt'] = {
    label = 'Mountain Lion Pelt',
    weight = 1500,
    stack = true,
    close = false,
    description = "Pelt of a Mountain Lion"
  },
  ['cone'] = {
    label = 'Cone',
    weight = 1000,
    stack = true,
    close = true,
    description = "An orange safety cone, or a hat if you've had enough to drink"
  },
  ['bleech'] = {
    label = 'Bleech',
    weight = 100,
    stack = false,
    close = false,
    description = ""
  },
  ['diamond_necklace'] = {
    label = 'Diamond Necklace',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['handcuffs'] = {
    label = 'Handcuffs',
    weight = 100,
    stack = true,
    close = true,
    description = ""
  },
  ['bomb'] = {
    label = 'Bomb',
    weight = 10000,
    stack = true,
    close = true,
    description = "An actual bomb"
  },
  ['gunbolt'] = {
    label = 'Gun Bolt',
    weight = 200,
    stack = true,
    close = true,
    description = nil
  },
  ['screwdriverset'] = {
    label = 'Screwdriver Set',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['uzi_wood_stock'] = {
    label = 'Uzi Wood Stock',
    weight = 1000,
    stack = true,
    close = true,
    description = "Use on UZI only"
  },
  ['ironore'] = {
    label = 'Iron Ore',
    weight = 1000,
    stack = true,
    close = false,
    description = "Iron, a base ore"
  },
  ['emerald_earring'] = {
    label = 'Emerald Earrings',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['antlers'] = {
    label = 'Antlers',
    weight = 1000,
    stack = true,
    close = false,
    description = "Antlers from a deer"
  },
  ['roadblock'] = {
    label = 'Road Block',
    weight = 10000,
    stack = true,
    close = true,
    description = "A large sign to block off a road"
  },
  ['security_card_02'] = {
    label = 'Security Card B',
    weight = 0,
    stack = true,
    close = true,
    description = ""
  },
  ['sapphire_necklace'] = {
    label = 'Sapphire Necklace',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['usb_red'] = {
    label = 'USB Drive',
    weight = 75,
    stack = true,
    close = false,
    description = ""
  },
  ['trojan_usb'] = {
    label = 'Trojan USB Drive',
    weight = 75,
    stack = true,
    close = false,
    description = ""
  },
  ['electronic_kit'] = {
    label = 'Electronic Kit',
    weight = 500,
    stack = true,
    close = false,
    description = ""
  },
  ['raspberry_pi'] = {
    label = 'Rasberry Pi 4 Model B',
    weight = 1000,
    stack = false,
    close = false,
    description = ""
  },
  ['police_toolbox'] = {
    label = 'PD Toolbox',
    weight = 1000,
    stack = false,
    close = 1,
    description = "Car Inspection - Property of the LSPD"
  },
  ['killerwhale'] = {
    label = 'Killer Whale',
    weight = 1100,
    stack = true,
    close = true,
    description = ""
  },
  ['gunstock'] = {
    label = 'Gun Stock',
    weight = 1000,
    stack = true,
    close = true,
    description = nil
  },
  ['prisonmeal'] = {
    label = 'Prison Meal',
    weight = 1,
    stack = false,
    close = false,
    description = ""
  },
  ['cleaningkit'] = {
    label = 'Cleaning Kit',
    weight = 250,
    stack = true,
    close = true,
    description = ""
  },
  ['wood_plank'] = {
    label = 'Wood Plank',
    weight = 50,
    stack = true,
    close = true,
    description = ""
  },
  ['zipties'] = {
    label = 'Zipties',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['firework4'] = {
    label = 'Weeping Willow',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['defib'] = {
    label = 'Defibrillator',
    weight = 2500,
    stack = true,
    close = true,
    description = ""
  },
  ['mud'] = {
    label = 'Mud',
    weight = 1,
    stack = false,
    close = false,
    description = ""
  },
  ['transmission3'] = {
    label = 'Tier 3 Transmission',
    weight = 3500,
    stack = false,
    close = 1,
    description = ""
  },
  ['spikestrip'] = {
    label = 'Spike Strip',
    weight = 2000,
    stack = true,
    close = true,
    description = "No tires for you! - Property of the LSPD/BCSO"
  },
  ['postop_parcel'] = {
    label = 'Parcel',
    weight = 5000,
    stack = false,
    close = false,
    description = "A Post OP Parcel.."
  },
  ['kevlar'] = {
    label = 'Kevlar',
    weight = 1000,
    stack = true,
    close = true,
    description = nil
  },
  ['emerald_ring'] = {
    label = 'Emerald Ring',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['drill'] = {
    label = 'Drill',
    weight = 2000,
    stack = true,
    close = false,
    description = ""
  },
  ['coca'] = {
    label = 'Coca Leaf',
    weight = 100,
    stack = false,
    close = false,
    description = "Coca leaf"
  },
  ['metalscrap'] = {
    label = 'Metal Scrap',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['advweaponcleaningkit'] = {
    label = 'Advanced Firearm Cleaning Kit',
    weight = 1500,
    stack = true,
    close = true,
    description = ""
  },
  ['emerald_necklace'] = {
    label = 'Emerald Necklace',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['brakes1'] = {
    label = 'Tier 1 Brakes',
    weight = 10000,
    stack = false,
    close = 1,
    description = ""
  },
  ['iphone'] = {
    label = 'iphone',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['lowerreceiver'] = {
    label = 'Lower Receiver',
    weight = 600,
    stack = true,
    close = true,
    description = nil
  },
  ['brakes2'] = {
    label = 'Tier 2 Brakes',
    weight = 2000,
    stack = false,
    close = 1,
    description = ""
  },
  ['security_card_04'] = {
    label = 'Black Security Card',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['artg_painting8'] = {
    label = 'Painting',
    weight = 500,
    stack = true,
    close = false,
    description = "A stolen painting from the Vinewood Art Gallery"
  },
  ['jelly'] = { -- look back later happy
    label = 'Jelly',
    weight = 2000,
    stack = false,
    close = true,
    description = "Jelly harvested from the Beehive"
  },
  ['tires'] = {
    label = 'Drift Smoke Tires',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['coughsyrup'] = {
    label = 'Cough Syrup',
    weight = 100,
    stack = true,
    close = false,
    description = "Down Bad"
  },
  ['vpn'] = {
    label = 'VPN',
    weight = 200,
    stack = true,
    close = false,
    degrade = 60 * 24 * 3, -- 3 days
    description = ""
  },
  ['ifaks'] = {
    label = 'IFAK',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['tourniquet'] = {
    label = 'tourniquet',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },

  ['glass'] = {
    label = 'Glass',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['snowball'] = {
    label = 'Snowball',
    weight = 100,
    stack = true,
    close = true,
    description = ""
  },
  ['artg_painting2'] = {
    label = 'Painting',
    weight = 500,
    stack = true,
    close = false,
    description = "A stolen painting from the Vinewood Art Gallery"
  },
  ['roof'] = {
    label = 'Vehicle Roof',
    weight = 1500,
    stack = false,
    close = 1,
    description = ""
  },
  ['artg_painting7'] = {
    label = 'Painting',
    weight = 500,
    stack = true,
    close = false,
    description = "A stolen painting from the Vinewood Art Gallery"
  },
  ['stickynote'] = {
    label = 'Sticky Note',
    weight = 50,
    stack = false,
    close = false,
    description = ""
  },
  ['postop_crate'] = {
    label = 'Shipping Crate',
    weight = 10000,
    stack = false,
    close = true,
    description = "A Post OP Shipping Crate.."
  },
  ['big_drill'] = {
    label = 'Big Drill',
    weight = 20000,
    stack = true,
    close = false,
    description = ""
  },
  ['goldflakes'] = {
    label = 'Gold Flakes',
    weight = 10,
    stack = true,
    close = false,
    description = "A little shimmer in the water"
  },
  ['goldore'] = {
    label = 'Gold ore',
    weight = 100,
    stack = true,
    close = false,
    description = "Gold Ore"
  },
  ['potatochamber'] = {
    label = 'Plastic Chamber',
    weight = 5000,
    stack = true,
    close = false,
    description = ""
  },
  ['rims'] = {
    label = 'Custom Wheel Rims',
    weight = 1500,
    stack = false,
    close = 1,
    description = ""
  },
  ['headlights'] = {
    label = 'Xenon Headlights',
    weight = 800,
    stack = false,
    close = 1,
    description = "8k HID headlights"
  },
  ['silverearring'] = {
    label = 'Silver Earrings',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['toolbox'] = {
    label = 'Toolbox',
    weight = 1000,
    stack = false,
    close = 1,
    description = "Needed for Performance Part removal"
  },
  ['sapphire_necklace_silver'] = {
    label = 'Sapphire Necklace [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['ausb2'] = {
    label = 'Alias USB',
    weight = 3000,
    stack = false,
    close = true,
    description = "BE WHOEVER YOU WANT TO BE..."
  },
  ['uzi_fold_stock'] = {
    label = 'Uzi Folding Stock',
    weight = 1000,
    stack = true,
    close = true,
    description = "Use on UZI only"
  },
  ['aluminum'] = {
    label = 'Aluminium',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['rubber'] = {
    label = 'Rubber',
    weight = 100,
    stack = true,
    close = false,
    description = "Rubber, I believe you can make your own rubber ducky with it :D"
  },
  ['id_card'] = {
    label = 'ID Card',
    weight = 200,
    stack = false,
    close = false,
    description = "A card containing all your information to identify yourself"
  },
  ['techcomp'] = {
    label = 'Tech Components',
    weight = 1000,
    stack = true,
    close = false,
    description = "Pile of tech trash"
  },
  ['trash_paper'] = {
    label = 'Trashed Paper',
    weight = 100,
    stack = true,
    close = false,
    description = "Paper that was thrown away"
  },
  ['trash_newspaper'] = {
    label = 'Newspaper',
    weight = 500,
    stack = true,
    close = false,
    description = "Outdated news"
  },
  ['trash_fags'] = {
    label = 'Cigarette Box',
    weight = 100,
    stack = true,
    close = false,
    description = "Empty cigarette box"
  },
  ['trash_chips'] = {
    label = 'Empty Chips',
    weight = 100,
    stack = true,
    close = false,
    description = "Empty Chip bag"
  },
  ['trash_bread'] = {
    label = 'Moldly Bread',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['trash_burgershot'] = {
    label = 'Empty Fast Food Box',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['fabric'] = {
    label = 'Fabric',
    weight = 1000,
    stack = true,
    close = false,
    description = "A piece of Fabric"
  },
  ['gatecrack'] = {
    label = 'Gatecrack',
    weight = 0,
    stack = true,
    close = true,
    description = ""
  },
  ['redcarcass'] = {
    label = 'Carcass',
    weight = 1500,
    stack = true,
    close = false,
    description = "Animal carcass of poached animal"
  },
  ['mining_ironfragment'] = {
    label = 'Iron Fragment',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['fishingbait'] = {
    label = 'Fish Bait',
    weight = 400,
    stack = true,
    close = true,
    description = ""
  },
  ['laptop_blue'] = {
    label = 'Laptop',
    weight = 2500,
    stack = false,
    close = true,
    description = ""
  },
  ['wax'] = {
    label = 'Wax',
    weight = 2000,
    stack = false,
    close = true,
    description = "Wax harvested from the Beehive"
  },
  ['pistolreciever'] = {
    label = 'Pistol Reciever',
    weight = 1000,
    stack = true,
    close = true,
    description = nil
  },
  ['bumper'] = {
    label = 'Vehicle Bumper',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['mtlionfang'] = {
    label = 'Mountain Lion Fang',
    weight = 1000,
    stack = true,
    close = false,
    description = "The fang of the Mighty Lion"
  },
  ['can'] = {
    label = 'Empty Can',
    weight = 10,
    stack = true,
    close = false,
    description = "An empty can, good for recycling"
  },
  ['livery'] = {
    label = 'Livery Roll',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['artg_painting9'] = {
    label = 'Painting',
    weight = 500,
    stack = true,
    close = false,
    description = "A stolen painting from the Vinewood Art Gallery"
  },
  ['drugbag'] = {
    label = 'Drugbag',
    weight = 1,
    stack = false,
    close = false,
    description = ""
  },
  ['nitrous'] = {
    label = 'Nitrous',
    weight = 1000,
    stack = true,
    close = true,
    description = "Makes car go fast, used by some bald guy in a old charger named Dom"
  },
  ['potatobarrel'] = {
    label = 'Plastic Barrel',
    weight = 3000,
    stack = true,
    close = false,
    description = ""
  },
  ['sparkplugs'] = {
    label = 'Spark Plugs',
    weight = 200,
    stack = false,
    close = true,
    description = ""
  },
  ['firework3'] = {
    label = 'Wipeout Fireworks',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['thermite'] = {
    label = 'Thermite',
    weight = 1000,
    stack = true,
    close = true,
    description = "Some Random guy from the Future - 'We've got a city to burn!'"
  },
  ['skirts'] = {
    label = 'Vehicle Skirts',
    weight = 1000,
    stack = false,
    close = 1,
    description = ""
  },
  ['artg_painting3'] = {
    label = 'Painting',
    weight = 500,
    stack = true,
    close = false,
    description = "A stolen painting from the Vinewood Art Gallery"
  },
  ['methtable'] = {
    label = 'Meth Table',
    weight = 5000,
    stack = true,
    close = false,
    consume = 1,
    description = "Meth Table",
    client = {
      anim = { dict = "anim@narcotics@trash", clip = "drop_front", flags = 16 },
      usetime = 2500,
      disable = {
        move = true,
        car = true,
        combat = true
      }
    }
  },
  ['axleparts'] = {
    label = 'Axle Parts',
    weight = 800,
    stack = true,
    close = true,
    description = ""
  },
  ['foldingchair'] = {
    label = 'Folding Chair',
    weight = 1000,
    stack = true,
    close = false,
    description = "Take a load off"
  },
  ['artg_painting10'] = {
    label = 'Painting',
    weight = 500,
    stack = true,
    close = false,
    description = "A stolen painting from the Vinewood Art Gallery"
  },
  ['plastic'] = {
    label = 'Plastic',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['sparetire'] = {
    label = 'Spare Tire',
    weight = 900,
    stack = false,
    close = 1,
    description = ""
  },
  ['underglow_controller'] = {
    label = 'Neon Controller',
    weight = 500,
    stack = true,
    close = 1,
    description = "RGB LED Vehicle Remote"
  },
  ['noscolour'] = {
    label = 'NOS Colour Injector',
    weight = 500,
    stack = true,
    close = 1,
    description = "Make that purge spray"
  },
  ['light'] = {
    label = 'Mobile Lighting',
    weight = 5000,
    stack = true,
    close = true,
    description = "A portable construction light"
  },
  ['acetone'] = {
    label = 'Acetone',
    weight = 100,
    stack = true,
    close = false,
    description = "Do people read these"
  },
  ['mining_stone'] = {
    label = 'Mined Stone',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['advancedrepairkit'] = {
    label = 'Advanced Repair Kit',
    weight = 4000,
    stack = true,
    close = true,
    description = ""
  },
  ['engine3'] = {
    label = 'Tier 3 Engine',
    weight = 3500,
    stack = false,
    close = 1,
    description = ""
  },
  ['steelplates'] = {
    label = 'Steel Plates',
    weight = 5000,
    stack = true,
    close = false,
    description = ""
  },
  ['rollcage'] = {
    label = 'Roll Cage',
    weight = 1500,
    stack = false,
    close = 1,
    description = ""
  },
  ['barricade'] = {
    label = 'Barricade',
    weight = 5000,
    stack = true,
    close = true,
    description = "A police barricade to close off entry"
  },
  ['jerry_can'] = {
    label = 'Jerrycan 20L',
    weight = 8000,
    stack = true,
    close = true,
    description = ""
  },
  ['batteryacid'] = {
    label = 'Battery Acid',
    weight = 100,
    stack = true,
    close = false,
    description = "Breaking Out"
  },
  ['coca_seed'] = {
    label = 'Coca Plant Seed',
    weight = 100,
    stack = false,
    close = false,
    description = "Coca plant seed"
  },
  ['medbag'] = {
    label = 'Medical Bag',
    weight = 3000,
    stack = true,
    close = true,
    description = "A medical bag with medical supplies"
  },
  ['silverore'] = {
    label = 'Silver Ore',
    weight = 500,
    stack = true,
    close = false,
    description = "Silver Ore"
  },
  ['redcarcass2'] = {
    label = 'Carcass',
    weight = 1500,
    stack = true,
    close = false,
    description = "Animal carcass of poached animal"
  },
  ['vehiclekey'] = {
    label = 'Vehicle key',
    weight = 0,
    stack = false,
    close = true,
    description =
    "This is a car key, take good care of it, if you lose it you probably won't be able to use your car"
  },
  ['diving_gear'] = {
    label = 'Diving Gear',
    weight = 15000,
    stack = false,
    close = true,
    description = ""
  },
  ['nos'] = {
    label = 'NOS Bottle',
    weight = 900,
    stack = false,
    close = 1,
    description = "A full bottle of NOS"
  },
  ['hunting_bait'] = {
    label = 'Hunting Bait',
    weight = 200,
    stack = true,
    close = true,
    description = "Animals Love this stuff..."
  },
  ['dendrogyra_coral'] = {
    label = 'Dendrogyra Coral',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['rawexplosive'] = {
    label = 'Raw Explosive',
    weight = 900,
    stack = true,
    close = false,
    description = ""
  },
  ['artg_painting4'] = {
    label = 'Painting',
    weight = 500,
    stack = true,
    close = false,
    description = "A stolen painting from the Vinewood Art Gallery"
  },
  ['laptop_green'] = {
    label = 'Laptop',
    weight = 2500,
    stack = false,
    close = true,
    description = ""
  },
  ['firework2'] = {
    label = 'Poppelers Fireworks',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['casinochips'] = {
    label = 'Casino Chips',
    weight = 75,
    stack = true,
    close = false,
    description = ""
  },
  ['pickaxe'] = {
    label = 'Pickaxe',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['diving_fill'] = {
    label = 'Diving Tube',
    weight = 3000,
    stack = false,
    close = true,
    description = nil
  },
  ['usb_blue'] = {
    label = 'USB Drive',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['oil'] = {
    label = 'Oil',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['security_card_01'] = {
    label = 'Security Card A',
    weight = 0,
    stack = true,
    close = true,
    description = ""
  },
  ['diamond_ring'] = {
    label = 'Diamond Ring',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['wheelchair'] = {
    label = 'Wheelchair',
    weight = 500,
    stack = false,
    close = true,
    description = "Wheelchair issued by EMS Personnel"
  },
  ['laptop_gold'] = {
    label = 'Laptop',
    weight = 2500,
    stack = false,
    close = true,
    description = ""
  },
  ['upperreceiver'] = {
    label = 'Upper Receiver',
    weight = 800,
    stack = true,
    close = true,
    description = "Upper Receiver"
  },
  ['grenadechamber'] = {
    label = 'Grenade Chamber',
    weight = 5000,
    stack = true,
    close = false,
    description = ""
  },
  ['queen_bee'] = {
    label = 'Queen Bee',
    weight = 2000,
    stack = false,
    close = true,
    description = "The one and only Queen Bee"
  },
  ['reinforcedbarrel'] = {
    label = 'Reinforced Barrel',
    weight = 500,
    stack = true,
    close = true,
    description = nil
  },
  ['goldfish'] = {
    label = 'Gold Fish',
    weight = 1111,
    stack = true,
    close = true,
    description = ""
  },
  ['goldearring'] = {
    label = 'Golden Earrings',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['cutter'] = {
    label = 'Cutters',
    weight = 5000,
    stack = true,
    close = false,
    description = ""
  },
  ['coffee'] = {
    label = 'Coffee',
    weight = 200,
    stack = true,
    close = true,
    description = ""
  },
  ['casino_membership'] = {
    label = 'Casino Membership Card',
    weight = 350,
    stack = true,
    close = true,
    description = ""
  },
  ['shotgunbody'] = {
    label = 'Shotgun Body',
    weight = 500,
    stack = true,
    close = true,
    description = nil
  },
  ['firework1'] = {
    label = '2 Brothers Fireworks',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['driver_license'] = {
    label = 'Drivers License',
    weight = 100,
    stack = false,
    close = false,
    description = "Permit to operate a motor vehicle"
  },
  ['casino_license'] = {
    label = 'Casino License',
    weight = 100,
    stack = false,
    close = false,
    description = "Permit to use a casino",
  },
  ['sulfer'] = {
    label = 'Sulfer',
    weight = 500,
    stack = true,
    close = false,
    description = ""
  },
  ['laptop'] = {
    label = 'Laptop',
    weight = 1000,
    stack = false,
    close = false,
    description = ""
  },
  ['suspension5'] = {
    label = 'Tier 5 Suspension',
    weight = 5000,
    stack = false,
    close = 1,
    description = ""
  },
  ['firstaid'] = {
    label = 'First Aid Kit',
    weight = 300,
    stack = true,
    close = true,
    consume = 1,
    client = {
      anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
      prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
      disable = { move = true, car = true, combat = true },
      usetime = 10000
    }
  },
  ['explosive'] = {
    label = 'Explosive',
    weight = 5000,
    stack = true,
    close = true,
    description = "An improvised explosive of fireworks and thermite"
  },
  ['ingredients'] = {
    label = 'Ingredients',
    weight = 1,
    stack = false,
    close = false,
    description = ""
  },
  ['externals'] = {
    label = 'Exterior Cosmetics',
    weight = 550,
    stack = false,
    close = 1,
    description = ""
  },
  ['goldpan'] = {
    label = 'Gold Panning Tray',
    weight = 10,
    stack = true,
    close = false,
    description = ""
  },
  ['silverchain'] = {
    label = 'Silver Chain',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['forend'] = {
    label = 'Shotgun Forend',
    weight = 500,
    stack = true,
    close = true,
    description = nil
  },
  ['suspension1'] = {
    label = 'Tier 1 Suspension',
    weight = 1000,
    stack = false,
    close = 1,
    description = ""
  },
  ['fishingrod'] = {
    label = 'Fishing Rod',
    weight = 5000,
    stack = true,
    close = true,
    description = "A fishing rod for adventures with friends!!"
  },
  ['carcass3'] = {
    label = 'Carcass',
    weight = 1000,
    stack = true,
    close = false,
    description = "Animal carcass"
  },
  ['baggie'] = {
    label = 'Baggie',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['joint'] = {
    label = 'Joint',
    weight = 150,
    stack = true,
    close = true,
    description = ""
  },
  ['gunpowder'] = {
    label = 'Gunpowder',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['usb_grey'] = {
    label = 'USB drive',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['steelbars'] = {
    label = 'Steel Bars',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['antipatharia_coral'] = {
    label = 'Antipatharia',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['emerald'] = {
    label = 'Emerald',
    weight = 100,
    stack = true,
    close = false,
    description = "A Emerald that shimmers"
  },
  ['armor'] = {
    label = 'Armor',
    weight = 5000,
    stack = true,
    close = true,
    description = "Some protection won't hurt... right?"
  },
  ['charcoal'] = {
    label = 'Charcoal',
    weight = 500,
    stack = true,
    close = false,
    description = ""
  },
  ['gunbarrel'] = {
    label = 'Gun Brrel',
    weight = 2000,
    stack = true,
    close = true,
    description = nil
  },
  ['walkstick'] = {
    label = 'Walking Stick',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['paintcan'] = {
    label = 'Vehicle Spray Can',
    weight = 500,
    stack = false,
    close = 1,
    description = ""
  },
  ['carbattery'] = {
    label = 'Car Battery',
    weight = 500,
    stack = false,
    close = true,
    description = ""
  },
  ['pebbles'] = {
    label = 'Pebbles',
    weight = 50,
    stack = true,
    close = false,
    description = "Little Stones!"
  },
  ['stone'] = {
    label = 'Stone',
    weight = 2000,
    stack = true,
    close = false,
    description = "Stone woo!"
  },
  ['engine1'] = {
    label = 'Tier 1 Engine',
    weight = 1500,
    stack = false,
    close = 1,
    description = ""
  },
  ['carbon'] = {
    label = 'Carbon',
    weight = 1000,
    stack = true,
    close = false,
    description = "Carbon, a base ore"
  },
  ['brakes3'] = {
    label = 'Tier 3 Brakes',
    weight = 3000,
    stack = false,
    close = 1,
    description = ""
  },
  ['bottle'] = {
    label = 'Empty Bottle',
    weight = 10,
    stack = true,
    close = false,
    description = "A glass bottle"
  },
  ['empty_bottle'] = {
    label = 'Empty bottle',
    weight = 100,
    stack = true,
    close = true,
    description = "Empty bottle"
  },
  ['boarmeat'] = {
    label = 'Boar Meat',
    weight = 1000,
    stack = true,
    close = false,
    description = "Boar Meat"
  },
  ['tree_bark'] = {
    label = 'Tree Bark',
    weight = 200,
    stack = true,
    close = true,
    description = ""
  },
  ['horn'] = {
    label = 'Custom Vehicle Horn',
    weight = 850,
    stack = false,
    close = 1,
    description = ""
  },
  ['usb_gold'] = {
    label = 'USB Drive',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['painkillers'] = {
    label = 'Painkillers',
    weight = 200,
    stack = true,
    close = true,
    description = ""
  },
  ['pistoltrigger'] = {
    label = 'Pistol Trigger',
    weight = 800,
    stack = true,
    close = true,
    description = nil
  },
  ['internals'] = {
    label = 'Internal Cosmetics',
    weight = 500,
    stack = false,
    close = 1,
    description = ""
  },
  ['nightvision'] = {
    label = 'Night Vision Goggles',
    weight = 2000,
    stack = true,
    close = false,
    description = "These allow you to see in the dark"
  },
  ['newoil'] = {
    label = 'Car Oil',
    weight = 500,
    stack = false,
    close = true,
    description = ""
  },
  ['pistolbarrel'] = {
    label = 'Pistol Barrel',
    weight = 800,
    stack = true,
    close = true,
    description = nil
  },
  ['iv'] = {
    label = 'IV Bag',
    weight = 200,
    stack = true,
    close = true,
    description = ""
  },
  ['mining_copperbar'] = {
    label = 'Copper Bar',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['cloth'] = {
    label = 'Cloth',
    weight = 100,
    stack = true,
    close = false,
    description = ""
    -------- Blueprint Weapons ---------
  },
  ['blank_bp_paper'] = {
    label = 'Blank Blueprint Paper',
    weight = 100,
    stack = false,
    close = false,
    description = ""
  },
  ['bp_weapon_browning'] = {
    label = 'Browning Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_heavypistol'] = {
    label = 'Heavy Pistol Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_pistol50'] = {
    label = 'Desert Eagle Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_dp9'] = {
    label = 'Diamondback Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_appistol'] = {
    label = 'Glock 18 Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_microsmg2'] = {
    label = 'Uzi Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_minismg2'] = {
    label = 'Skorpion Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_pumpshotgun'] = {
    label = 'IZH-81 Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_assaultrifle'] = {
    label = 'AK-47 Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_assaultrifle2'] = {
    label = 'M70 Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_compactrifle'] = {
    label = 'AKS-74U Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['bp_weapon_militaryrifle'] = {
    label = 'Steyr AUG A3 Blueprint',
    weight = 100,
    stack = false,
    close = false,
    description = "Weapon Blueprint"
  },
  ['blueprintpaper'] = {
    label = 'Scrambed Blueprint',
    weight = 100,
    stack = false,
    close = true,
    description = "Looks to be some sort of puzzle, I wonder what it could be?"
  },
  ['uvlight'] = {
    label = 'UV Flashlight',
    weight = 300,
    stack = false,
    close = true,
    description = "A flashlight to see fingerprints"
  },
  ['coyotepelt'] = {
    label = 'Coyote Pelt',
    weight = 1500,
    stack = true,
    close = false,
    description = "The pelt of a coyote"
  },
  ['tree_lumber'] = {
    label = 'Lumber',
    weight = 1500,
    stack = true,
    close = true,
    description = ""
  },
  ['stingray'] = {
    label = 'Stingray',
    weight = 1111,
    stack = true,
    close = true,
    description = ""
  },
  ['lighter'] = {
    label = 'Lighter',
    weight = 100,
    stack = true,
    close = true,
    description = ""
  },
  ['press'] = {
    label = 'Hand Held Press',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['mininglaser'] = {
    label = 'Mining Laser',
    weight = 900,
    stack = true,
    close = false,
    description = ""
  },
  ['cooler'] = {
    label = 'Drink Cooler',
    weight = 5000,
    stack = true,
    close = true,
    description = "Keep your drinks cool!"
  },
  ['mining_pickaxe'] = {
    label = 'Mining Pickaxe',
    weight = 500,
    stack = false,
    close = true,
    description = ""
  },
  ['steel'] = {
    label = 'Steel',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['electronickit'] = {
    label = 'Electronic Kit',
    weight = 100,
    stack = true,
    close = true,
    description = ""
  },
  ['beehive'] = {
    label = 'Beehive',
    weight = 2000,
    stack = false,
    close = true,
    description = "Beehive"
  },
  ['copperore'] = {
    label = 'Copper Ore',
    weight = 1000,
    stack = true,
    close = false,
    description = "Copper, a base ore."
  },
  ['binoculars'] = {
    label = 'Binoculars',
    weight = 500,
    stack = true,
    close = true,
    description = "Sneaky Beaky..."
  },
  ['lowervaultcodes'] = {
    label = 'Access Codes',
    weight = 0,
    stack = false,
    close = false,
    description = "A copy of the Pacific Bank, lower vault access codes"
  },
  ['police_stormram'] = {
    label = 'Storm Ram',
    weight = 18000,
    stack = true,
    close = true,
    description = ""
  },
  ['rottenapple'] = {
    label = 'Rotten Apple',
    weight = 1,
    stack = false,
    close = false,
    description = ""
  },
  ['deerhide'] = {
    label = 'Deer Hide',
    weight = 1500,
    stack = true,
    close = false,
    description = "Deer Hide"
  },
  ['aluminumoxide'] = {
    label = 'Aluminium Powder',
    weight = 100,
    stack = true,
    close = false,
    description = ""
  },
  ['firearm_license'] = {
    label = 'Firearm License',
    weight = 100,
    stack = false,
    close = false,
    description = "Permit to legally carry a firearm - Not a license to kill"
  },
  ['honey'] = {
    label = 'Honey',
    weight = 2000,
    stack = false,
    close = true,
    description = "Honey harvested from the Beehive"
  },
  ['ruby_necklace'] = {
    label = 'Ruby Necklace',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['transmission4'] = {
    label = 'Tier 4 Transmission',
    weight = 4500,
    stack = false,
    close = 1,
    description = ""
  },
  ['foldingchair2'] = {
    label = 'Folding Chair',
    weight = 2000,
    stack = true,
    close = false,
    description = "Take a load off"
  },
  ['suspension4'] = {
    label = 'Tier 4 Suspension',
    weight = 4000,
    stack = false,
    close = 1,
    description = ""
  },
  ['silverbar'] = {
    label = 'Silver Bar',
    weight = 2000,
    stack = true,
    close = false,
    description = ""
  },
  ['silveringot'] = {
    label = 'Silver Ingot',
    weight = 1000,
    stack = true,
    close = false,
    description = ""
  },
  ['car_armor'] = {
    label = 'Vehicle Armor',
    weight = 0,
    stack = false,
    close = 1,
    description = ""
  },
  ['tv'] = {
    label = 'TV',
    weight = 950,
    stack = false,
    close = false,
    description = ""
  },
  ['tube_tv'] = {
    label = 'TV',
    weight = 950,
    stack = false,
    close = false,
    description = ""
  },
  ["treat"] = {
    label = "Dog Treat",
    weight = 0,
    stack = true,
    close = true,
    description = "A dog treat",
  },
  ['speaker'] = {
    label = 'Boombox',
    weight = 0,
    stack = false,
    close = false,
    description = ""
  },
  ['printer'] = {
    label = 'Printer',
    weight = 0,
    stack = false,
    close = false,
    description = ""
  },
  ['wine'] = {
    label = 'Wine',
    weight = 0,
    stack = false,
    close = false,
    description = ""
  },
  ['keyboard'] = {
    label = 'Keyboard',
    weight = 0,
    stack = false,
    close = false,
    description = ""
  },
  ['lamp'] = {
    label = 'Lamp',
    weight = 0,
    stack = false,
    close = false,
    description = ""
  },
  ['monitor'] = {
    label = 'Computer Monitor',
    weight = 0,
    stack = false,
    close = false,
    description = ""
  },
  ['bong'] = {
    label = 'Flower Vase',
    weight = 0,
    stack = false,
    close = false,
    description = ""
  },
  ["microwave"] = {
    label = "Microwave",
    weight = 1000,
    stack = false,
    close = false,
    description = "A microwave",
  },
  ['ruby_ring'] = {
    label = 'Ruby Ring',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['sniperreceiver'] = {
    label = 'Sniper Receiver',
    weight = 350,
    stack = true,
    close = true,
    description = nil
  },
  ['hacking_device'] = {
    label = 'Hacking Device',
    weight = 500,
    stack = false,
    close = true,
    description = "A multi purpose hacking device"
  },
  ['black_keycard'] = {
    label = 'Black Keycard',
    weight = 0,
    stack = false,
    close = true,
    description = "Used to access a semi-secure area"
  },
  ['pink_keycard'] = {
    label = 'Pink Keycard',
    weight = 0,
    stack = false,
    close = true,
    description = "Used to access a semi-secure area"
  },
  ['laser_drill'] = {
    label = 'Industrial Laser Drill',
    weight = 1000,
    stack = false,
    close = true,
    description = "Capable of penerating even the most secure doors"
  },
  ['blue_keycard'] = {
    label = 'Blue Keycard',
    weight = 0,
    stack = false,
    close = true,
    description = "Used to access a secure area"
  },
  ['scissors'] = {
    label = 'Scissors',
    weight = 0,
    stack = false,
    close = true,
    description = "Hand operated shearing tool"
  },
  ['profertilizer'] = {
    label = 'Crop fertilizer',
    weight = 1111,
    stack = true,
    close = true,
    description = ""
  },
  ['fertilizer'] = {
    label = 'Crop fertilizer',
    weight = 1111,
    stack = true,
    close = true,
    description = ""
  },
  -- Mining Items
  ['uncut_opal'] = {
    label = 'Uncut Opal',
    weight = 200,
    stack = true,
    close = false,
    description = "A rough Opal"
  },
  ['uncut_ruby'] = {
    label = 'Uncut Ruby',
    weight = 200,
    stack = true,
    close = false,
    description = "A rough Ruby"
  },
  ['uncut_sapphire'] = {
    label = 'Uncut Sapphire',
    weight = 200,
    stack = true,
    close = false,
    description = "A rough Sapphire"
  },
  ['uncut_emerald'] = {
    label = 'Uncut Emerald',
    weight = 200,
    stack = true,
    close = false,
    description = "A rough Emerald"
  },
  ['uncut_diamond'] = {
    label = 'Uncut Diamond',
    weight = 200,
    stack = true,
    close = false,
    description = "A rough Diamond"
  },
  ['uncut_amethyst'] = {
    label = 'Uncut Amethyst',
    weight = 200,
    stack = true,
    close = false,
    description = "A rough Amethyst"
  },
  ['uncut_onyx'] = {
    label = 'Uncut Onyx',
    weight = 200,
    stack = true,
    close = false,
    description = "A rough Onyx"
  },
  ['uncut_citrinequartz'] = {
    label = 'Uncut Citrine Quartz',
    weight = 200,
    stack = true,
    close = false,
    description = "A rough Citrine Quartz"
  },
  ['amethyst'] = {
    label = 'Amethyst',
    weight = 200,
    stack = true,
    close = false,
    description = "A Cut Amethyst"
  },
  ['opal'] = {
    label = 'Opal',
    weight = 200,
    stack = true,
    close = false,
    description = "A Opal that shimmers"
  },
  ['diamond'] = {
    label = 'Diamond',
    weight = 200,
    stack = true,
    close = false,
    description = "A Diamond that shimmers"
  },
  ['onyx'] = {
    label = 'Onyx',
    weight = 200,
    stack = true,
    close = false,
    description = "A Cut Onyx"
  },
  ['citrinequartz'] = {
    label = 'Citrine Quartz',
    weight = 200,
    stack = true,
    close = false,
    description = "A Cut Citrine Quartz"
  },
  -- Jewellery
  ['opal_ring_gold'] = {
    label = 'Opal Ring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['opal_ring_silver'] = {
    label = 'Opal Ring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['opal_necklace_gold'] = {
    label = 'Opal Necklace [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['opal_necklace_silver'] = {
    label = 'Opal Necklace [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['opal_earring_gold'] = {
    label = 'Opal Earring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['opal_earring_silver'] = {
    label = 'Opal Earring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['ruby_ring_gold'] = {
    label = 'Ruby Ring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['ruby_ring_silver'] = {
    label = 'Ruby Ring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['ruby_earring_gold'] = {
    label = 'Ruby Earrings [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['ruby_earring_silver'] = {
    label = 'Ruby Earrings [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['ruby_necklace_gold'] = {
    label = 'Ruby Necklace [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['ruby_necklace_silver'] = {
    label = 'Ruby Necklace [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['sapphire_earring_gold'] = {
    label = 'Sapphire Earrings [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['sapphire_earring_silver'] = {
    label = 'Sapphire Earrings [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['sapphire_ring_gold'] = {
    label = 'Sapphire Ring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['sapphire_ring_silver'] = {
    label = 'Sapphire Ring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['sapphire_necklace_gold'] = {
    label = 'Sapphire Necklace [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['emerald_ring_gold'] = {
    label = 'Emerald Ring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['emerald_ring_silver'] = {
    label = 'Emerald Ring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['emerald_necklace_gold'] = {
    label = 'Emerald Necklace [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['emerald_necklace_silver'] = {
    label = 'Emerald Necklace [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['emerald_earring_silver'] = {
    label = 'Emerald Earrings [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['emerald_earring_gold'] = {
    label = 'Emerald Earrings [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['diamond_ring_gold'] = {
    label = 'Diamond Ring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['diamond_ring_silver'] = {
    label = 'Diamond Ring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['diamond_earring_gold'] = {
    label = 'Diamond Earrings [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['diamond_earring_silver'] = {
    label = 'Diamond Earrings [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['diamond_necklace_gold'] = {
    label = 'Diamond Necklace [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['diamond_necklace_silver'] = {
    label = 'Diamond Necklace [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['amethyst_ring_gold'] = {
    label = 'Amethyst Ring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['amethyst_ring_silver'] = {
    label = 'Amethyst Ring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['amethyst_necklace_gold'] = {
    label = 'Amethyst Necklace [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['amethyst_necklace_silver'] = {
    label = 'Amethyst Necklace [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['amethyst_earring_gold'] = {
    label = 'Amethyst Earring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['amethyst_earring_silver'] = {
    label = 'Amethyst Earring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['onyx_ring_gold'] = {
    label = 'Onyx Ring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['onyx_ring_silver'] = {
    label = 'Onyx Ring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['onyx_necklace_gold'] = {
    label = 'Onyx Necklace [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['onyx_necklace_silver'] = {
    label = 'Onyx Necklace [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['onyx_earring_gold'] = {
    label = 'Onyx Earring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['onyx_earring_silver'] = {
    label = 'Onyx Earring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['citrinequartz_ring_gold'] = {
    label = 'Citrine Quartz Ring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['citrinequartz_ring_silver'] = {
    label = 'Citrine Quartz Ring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['citrinequartz_necklace_gold'] = {
    label = 'Citrine Quartz Necklace [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['citrinequartz_necklace_silver'] = {
    label = 'Citrine Quartz Necklace [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['citrinequartz_earring_gold'] = {
    label = 'Citrine Quartz Earring [Gold]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['citrinequartz_earring_silver'] = {
    label = 'Citrine Quartz Earring [Silver]',
    weight = 200,
    stack = true,
    close = false,
    description = ""
  },
  ['acid_bottle'] = {
    label = 'Acid',
    weight = 500,
    stack = true,
    close = true,
    description = "Bottle of acid solution"
  },
  ['alkaline_bottle'] = {
    label = 'Alkaline',
    weight = 500,
    stack = true,
    close = true,
    description = "Bottle of alkaline solution"
  },
  ['tea_seed'] = {
    label = 'Tea Seed',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['tea'] = {
    label = 'Tea',
    weight = 500,
    stack = true,
    close = true,
    description = ""
  },
  ['unopenedchest'] = {
    label = 'Unopened Chest',
    weight = 1000,
    stack = true,
    close = true,
    description = ""
  },
  ['crowbar'] = {
    label = 'Crowbar',
    weight = 0,
    stack = false,
    close = 1,
    description = "A versatile and robust tool designed for leverage, demolition, and heavy-duty tasks"
  },
  ['carcass_boar'] = {
    label = 'Boar Carcass',
    weight = 20000,
    stack = false,
    degrade = 5 * 60,
    client = {
      add = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end,
      remove = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end
    }
  },
  ['carcass_hawk'] = {
    label = 'Hawk Carcass',
    weight = 3000,
    stack = false,
    degrade = 5 * 60,
    client = {
      add = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end,
      remove = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end
    }
  },
  ['carcass_cormorant'] = {
    label = 'Cormorant Carcass',
    weight = 3000,
    stack = false,
    degrade = 5 * 60,
    client = {
      add = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end,
      remove = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end
    }
  },
  ['carcass_coyote'] = {
    label = 'Coyote Carcass',
    weight = 3000,
    stack = false,
    degrade = 5 * 60,
    client = {
      add = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end,
      remove = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end
    }
  },
  ['carcass_deer'] = {
    label = 'Deer Carcass',
    weight = 18000,
    stack = false,
    degrade = 5 * 60,
    client = {
      add = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end,
      remove = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end
    }
  },
  ['carcass_mtlion'] = {
    label = 'Mountain Lion Carcass',
    weight = 16000,
    stack = false,
    degrade = 5 * 60,
    client = {
      add = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end,
      remove = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end
    }
  },
  ['carcass_rabbit'] = {
    label = 'Rabbit Carcass',
    weight = 3000,
    stack = false,
    degrade = 5 * 60,
    client = {
      add = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end,
      remove = function()
        TriggerEvent('mana_hunting:client:carryCarcass')
      end
    }
  },
  ['animal_pelt'] = {
    label = 'Pelt',
    weight = 300,
    stack = true,
  },

  -- Major Items
  ['watch_1'] = {
    label = 'Movado Calendoplan',
    weight = 300,
    stack = true,
  },
  ['watch_2'] = {
    label = 'Rado Centrix',
    weight = 300,
    stack = true,
  },
  ['watch_3'] = {
    label = 'Minnie Mouse Smart Watch',
    weight = 300,
    stack = true,
  },
  ['earring_1'] = {
    label = 'Diamond Halo Stud Earrings',
    weight = 300,
    stack = true,
  },
  ['earring_2'] = {
    label = '14K Gold Diamond Earrings',
    weight = 300,
    stack = true,
  },
  ['earring_3'] = {
    label = 'Tiffany Solitaire Diamond Earrings',
    weight = 300,
    stack = true,
  },
  ['ring_1'] = {
    label = 'Jean Square Cut Ruby',
    weight = 300,
    stack = true,
  },
  ['ring_2'] = {
    label = 'Keith Sqaure Cut Emerald Ring',
    weight = 300,
    stack = true,
  },
  ['ring_3'] = {
    label = 'Marcel Center Cut Black Diamondvv',
    weight = 300,
    stack = true,
  },
  ['necklace_1'] = {
    label = 'Imperial Akoya Pearl Necklace',
    weight = 100,
    stack = true,
  },
  ['necklace_2'] = {
    label = 'Marquise Ruby Heart Pendant',
    weight = 200,
    stack = true,
  },
  ['necklace_3'] = {
    label = 'Diamond Single Frame Teardrop Pendant',
    weight = 300,
    stack = true,
  },
  ['necklace_4'] = {
    label = 'Diamond Double Shadow Frame Pendant',
    weight = 400,
    stack = true,
  },
  ['necklace_5'] = {
    label = 'Oval Emerald Chevron Necklace',
    weight = 500,
    stack = true,
  },
  ['monkeystatue'] = {
    label = 'Monkey Statue',
    weight = 300,
    stack = true,
  },
  ['displayitem2'] = {
    label = 'The forbidden Jumper',
    weight = 100,
    stack = true,
  },
  ['hopediamond'] = {
    label = 'The Hope Diamond',
    weight = 500,
    stack = true,
  },
  ['gold'] = {
    label = 'Gold Bar',
    weight = 500,
    stack = true,
  },

  ['pistol_fireingpin'] = {
    label = 'Pistol Fireing Pin',
    weight = 50,
    stack = true,
  },

  ['smg_fireingpin'] = {
    label = 'SMG Fireing Pin',
    weight = 50,
    stack = true,
  },

  ['shotgun_fireingpin'] = {
    label = 'Shotgun Fireing Pin',
    weight = 50,
    stack = true,
  },

  ['rifle_fireingpin'] = {
    label = 'Rifle Fireing Pin',
    weight = 50,
    stack = true,
  },

  ['special_fireingpin'] = {
    label = 'Special Fireing Pin',
    weight = 50,
    stack = true,
  },
  ['fleeca_keycard'] = {
    label = 'Manager Keycard #1',
    description = 'Access a secure door',
    stack = true,
    weight = 3
  },
  ['pacific_keycard'] = {
    label = 'Manager Keycard #3',
    description = 'Access a secure door',
    stack = true,
    weight = 3
  },
  ['artgallery_keycard'] = {
    label = 'Manager Keycard #2',
    description = 'Access a secure door',
    stack = true,
    weight = 3
  },
  ['commissionslip'] = {
    label = 'Commission Slip',
    description = 'A commission slip to hand in for cash',
    stack = false,
    weight = 3
  }
}

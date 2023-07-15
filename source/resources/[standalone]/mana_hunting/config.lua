Config                  = {}

---@alias CarcassItem 'carcass_boar'|'carcass_hawk'|'carcass_cormorant'|'carcass_coyote'|'carcass_deer'|'carcass_mtlion'|'carcass_rabbit'

---@class CarcassEntity
---@field item CarcassItem
---@field headshotBones number[] bones on the model which should be considered a headshot for grading purposes
---@field drag boolean whether the carcass is heavy enough to require being dragged
---@field xPos number
---@field yPos number
---@field zPos number
---@field xRot number
---@field yRot number
---@field zRot number

---@type table<number, CarcassEntity>
Config.Carcass          = {
  [`a_c_boar`] = { item = 'carcass_boar', headshotBones = { 31086 }, drag = true, xPos = -0.7, yPos = 1.2, zPos = -1.0, xRot = -200.0, yRot = 0.0, zRot = 0.0 },
  [`a_c_chickenhawk`] = { item = 'carcass_hawk', headshotBones = { 39317 }, drag = false, xPos = 0.15, yPos = 0.2, zPos = 0.45, xRot = 0.0, yRot = -90.0, zRot = 0.0 },
  [`a_c_cormorant`] = { item = 'carcass_cormorant', headshotBones = { 24818 }, drag = false, xPos = 0.15, yPos = 0.2, zPos = 0.4, xRot = 0.0, yRot = -90.0, zRot = 0.0 },
  [`a_c_coyote`] = { item = 'carcass_coyote', headshotBones = { 31086 }, drag = false, xPos = -0.2, yPos = 0.15, zPos = 0.45, xRot = 0.0, yRot = -90.0, zRot = 0.0 },
  [`a_c_deer`] = { item = 'carcass_deer', headshotBones = { 31086 }, drag = true, xPos = 0.1, yPos = 1.0, zPos = -1.2, xRot = -200.0, yRot = 30.0, zRot = 0.0 },
  [`a_c_mtlion`] = { item = 'carcass_mtlion', headshotBones = { 31086 }, drag = true, xPos = 0.1, yPos = 0.7, zPos = -1.0, xRot = -210.0, yRot = 0.0, zRot = 0.0 },
  [`a_c_rabbit_01`] = { item = 'carcass_rabbit', headshotBones = { 31086 }, drag = false, xPos = 0.12, yPos = 0.25, zPos = 0.45, xRot = 0.0, yRot = 90.0, zRot = 0.0 },
}

Config.Skin             = {
  [`a_c_boar`] = { item = 'animal_pelt', headshotBones = { 31086 }, identifier = 'Boar' },
  [`a_c_chickenhawk`] = { item = 'animal_pelt', headshotBones = { 39317 }, identifier = 'Chicken Hawk' },
  [`a_c_cormorant`] = { item = 'animal_pelt', headshotBones = { 24818 }, identifier = 'Cormorant' },
  [`a_c_coyote`] = { item = 'animal_pelt', headshotBones = { 31086 }, identifier = 'Coyote' },
  [`a_c_deer`] = { item = 'animal_pelt', headshotBones = { 31086 }, identifier = 'Deer' },
  [`a_c_mtlion`] = { item = 'animal_pelt', headshotBones = { 31086 }, identifier = 'Mountain Lion' },
  [`a_c_rabbit_01`] = { item = 'animal_pelt', headshotBones = { 31086 }, identifier = 'Rabbit' },
}

---@type number[] hash codes of weapons that lead to higher grade carcasses.
Config.GoodWeapon       = {
  ---@diagnostic disable-next-line: assign-type-mismatch
  `WEAPON_SNIPERRIFLE`, `WEAPON_KNIFE`
}

---@type table<CarcassItem, {min: number, max: number}> min and max sell prices per carcass based on durability
Config.SellPrice        = {
  ['carcass_boar'] = { min = 50, max = 250 },
  ['carcass_hawk'] = { min = 45, max = 225 },
  ['carcass_cormorant'] = { min = 30, max = 150 },
  ['carcass_coyote'] = { min = 15, max = 75 },
  ['carcass_deer'] = { min = 25, max = 125 },
  ['carcass_mtlion'] = { min = 40, max = 200 },
  ['carcass_rabbit'] = { min = 20, max = 100 },
  ['animal_pelt'] = { min = 50, max = 75 }
}

Config.Degrade          = true

Config.GradeMultiplier  = {
  ['★☆☆'] = 0.5, -- not killed by a goodWeapon
  ['★★☆'] = 1.0, -- killed by a goodWeapon
  ['★★★'] = 2.0 -- headshot with a goodWeapon
}

---@class AntiFarm
---@field enable boolean
---@field size number
---@field time integer
---@field maxAmount integer
---@field personal boolean
Config.AntiFarm         = {
  enable = true,
  size = 70.0,
  time = 10 * 60,
  maxAmount = 3,
  personal = true
}

Config.EnableSelling    = false

Config.SellingLocations = {
  [1] = {
    ped = `csb_chef`,
    coords = vec4(984.252, -2185.661, 29.977, 90.951),
    -- This is randomly taken off or added to the sell price
    sellModifier = {
      min = 0,
      max = 50
    }
  },
  [2] = {
    ped = `cs_hunter`,
    coords = vec4(1441.556, 1136.211, 114.324, 87.482),
    -- This is randomly taken off or added to the sell price
    sellModifier = {
      min = 0,
      max = 50
    }
  },
  [3] = {
    ped = `s_m_y_dockwork_01`,
    coords = vec4(-335.869, -2455.507, 7.294, 145.941),
    -- This is randomly taken off or added to the sell price
    sellModifier = {
      min = 0,
      max = 50
    }
  },
}

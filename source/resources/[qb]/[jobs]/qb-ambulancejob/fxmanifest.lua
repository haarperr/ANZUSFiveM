fx_version 'cerulean'
game 'gta5'

description 'https://github.com/QBCore-Remastered'
version '1.0.1'

shared_scripts {
  '@qb-core/shared/locale.lua',
  'locales/en.lua',
  'locales/*.lua',
  'config.lua',
  '@ox_lib/init.lua',
}

client_scripts {
  'client/load-unload.lua',
  'client/damage/damage-effects.lua',
  'client/damage/damage.lua',
  'client/hospital.lua',
  'client/main.lua',
  'client/wounding.lua',
  'client/laststand.lua',
  'client/job.lua',
  'client/dead.lua',
  'client/setdownedstate.lua',
}

server_scripts {
  'server/main.lua',
}

dependencies {
  'ox_lib',
  'ox_target',
  'ox_inventory',
  'qb-core',
}

lua54 'yes'

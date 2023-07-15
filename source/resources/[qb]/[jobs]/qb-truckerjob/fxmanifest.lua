fx_version 'cerulean'
game 'gta5'

version '1.0.0'
repository 'https://github.com/QBCore-Remastered/qb-truckerjob'

shared_scripts {
  'config.lua',
  '@qb-core/shared/locale.lua',
  'locales/en.lua',
  '@ox_lib/init.lua'
}

server_scripts {
  '@ag_vehicle/imports/server.lua',
  'server/main.lua'
}

client_script 'client/main.lua'

dependencies {
  'ox_lib',
  'ox_target'
}

provide 'qb-truckerjob'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

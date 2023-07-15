fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

shared_scripts { '@ox_lib/init.lua', 'config.lua' }

server_scripts {
  '@ag_vehicle/imports/server.lua',
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua',
}

client_scripts {
  'client/*.lua',
}

dependencies {
  'npwd'
}

fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ag_scoreboard'
version '1.0.0'
author 'mk3ext'

shared_scripts {
  '@ox_lib/init.lua',
}

client_scripts {
  'client/main.lua',
}

server_scripts {
  'server/main.lua',
}


dependencies {
  '/server:5104',
  '/onesync',
  'ox_lib'
}

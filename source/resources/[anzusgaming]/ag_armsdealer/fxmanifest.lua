fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ag_armsdealer'
version '1.0.0'
author 'mk3ext'

shared_scripts {
  '@ox_lib/init.lua'
}

client_scripts {
  'client/*.lua'
}

server_scripts {
  'config.lua',
  'server/main.lua'
}

dependencies {
  '/server:6279',
  '/onesync',
  'ox_inventory'
}

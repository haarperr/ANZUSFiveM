fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ag_truckrobbery'
version '1.0.0'
author 'mk3ext'

shared_scripts {
  '@ox_lib/init.lua',
}

client_scripts {
  'config/client.lua',
  'client/main.lua',
  'client/doors.lua',
  'client/loot.lua'
}

server_scripts {
  '@ag_vehicle/imports/server.lua',
  'config/server.lua',
  'server/main.lua'
}

files {
  'locales/en.json',
  'client/utils.lua'
}

dependencies {
  '/server:6279',
  '/onesync',
  'ox_lib'
}

fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ag_vehicle'
version '1.0.0'
author 'mk3ext'

shared_scripts {
  '@ox_lib/init.lua',
  'shared/init.lua'
}

client_scripts {
  'client/events.lua',
  'client/plate.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua',
  'server/plate.lua'
}

files {
  'shared/vehicles.lua',
  'shared/files/*.json',
  'shared/*.lua',
  'client/utils.lua'
}

dependencies {
  '/server:6279',
  '/onesync',
  'ox_lib'
}

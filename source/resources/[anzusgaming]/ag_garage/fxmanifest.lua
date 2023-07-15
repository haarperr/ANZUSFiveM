fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ag_garage2'
version '1.0.0'
author 'mk3ext'

shared_scripts {
  '@ox_lib/init.lua',
  'config/shared.lua'
}

client_scripts {
  'client/main.lua',
  'client/impound.lua',
  'client/garage/*.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  '@ag_vehicle/imports/server.lua',
  'server/init.lua',
  'server/main.lua'
}

files {
  'locales/en.json',
  'client/utils.lua',
}

dependencies {
  '/server:6279',
  '/onesync',
  'ox_lib'
}

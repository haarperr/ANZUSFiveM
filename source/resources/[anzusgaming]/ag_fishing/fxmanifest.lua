fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ag_fishing'
version '1.0.0'
author 'mk3ext'

shared_scripts {
  '@ox_lib/init.lua',
  'config/shared.lua'
}

client_scripts {
  'client/main.lua',
  'client/sale.lua'
}

server_scripts {
  'config/server.lua',
  'server/main.lua',
  'server/sale.lua'
}

files {
  'locales/en.json'
}

dependencies {
  '/server:6279',
  '/onesync',
  'ox_lib'
}

fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ag_drugs'
version '1.0.0'
author 'mk3ext'

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}

client_scripts {
  'client/package.lua',
  'client/sell.lua',
  'client/meth.lua'
}

server_scripts {
  'server/main.lua',
  'server/sell.lua',
  'server/meth.lua'
}

files {
  'locales/en.json'
}

dependencies {
  '/server:6279',
  '/onesync',
  'ox_lib'
}

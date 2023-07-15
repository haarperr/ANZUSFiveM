fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ag_dealership'
version '1.0.0'
author 'mk3ext'


ui_page "web/index.html"

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}

client_scripts {
  'client/main.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  '@ag_vehicle/imports/server.lua',
  'server/main.lua'
}

files {
  'web/index.html',
  'web/*.css',
  'web/index.js',
  'web/images/*.png',
}


dependencies {
  '/server:6279',
  '/onesync',
  'ox_lib'
}

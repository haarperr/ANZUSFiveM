fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
author 'YG#0278 | mk3ext'
description 'An custom Crop Dusting Job (edited by mk3ext)'

client_scripts {
  'client/*.lua',
}

server_scripts {
  'server/*.lua',
}

shared_scripts {
  'config.lua',
  '@ox_lib/init.lua',
}

files {
  'locales/en.json'
}

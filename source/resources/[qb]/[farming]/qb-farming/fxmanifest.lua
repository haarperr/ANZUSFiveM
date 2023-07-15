fx_version 'cerulean'
game 'gta5'

author 'Grudge & Snipe'
description 'Script for Planting Weed Plants anywhere in the soil'
version '1.1.0'

lua54 'yes'

ui_page "html/index.html"

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua',
}

server_scripts {
  'server/main.lua',
  'server/server_customise.lua',
}

client_scripts {
  'client/main.lua',
  'client/client_customise.lua',
}

files {
  'html/index.html',
  'html/assets/css/*.css',
  'html/assets/js/*.js',
}


escrow_ignore {
  'config.lua',
  'client/main.lua',
  'server/main.lua',
  'server/server_customise.lua',
  'client/client_customise.lua',
}
dependency '/assetpacks'

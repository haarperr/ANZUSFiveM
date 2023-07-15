fx_version  'cerulean'
game        'gta5'
lua54       'yes'

description 'Properties system for FiveM.'
author      'NoLag Development'
version      '1.0.8'

shared_scripts {
  '@ox_lib/init.lua',
  'furniture.lua',
  'config.lua',
  'shells.lua',
  'ipls.lua',
  'custom/garages/*.lua',
  'custom/weather/*.lua',
  'custom/inventory/*.lua',
  'custom/clothes/*.lua',
}

client_scripts {
  'client/PropertyManager.lua',
  'client/polyzone/client.lua',
  'client/polyzone/BoxZone.lua',
  'client/freecam/utils.lua',
  'client/freecam/config.lua',
  'client/freecam/camera.lua',
  'client/freecam/exports.lua',
  'client/freecam/main.lua',
  'client/frameworks/*.lua',
  'client/creation/*.lua',
  'client/furniture/*.lua',
  'custom/furniture/*.lua',
  'custom/shells/*.lua',
  'client/*.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/frameworks/*.lua',
  'custom/logs/*.lua',
  'server/*.lua',
}

shared_script 'shared/init.lua'

ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/build/**/*',
  'locales/*.json'
}

escrow_ignore {
  'client/frameworks/*.lua',
  'server/frameworks/*.lua',
  'custom/garages/*.lua',
  'custom/weather/*.lua',
  'custom/inventory/*.lua',
  'custom/clothes/*.lua',
  'custom/shells/*.lua',
  'custom/furniture/*.lua',
  'custom/logs/*.lua',
  'locales/*.json',
  'shells.lua',
  'ipls.lua',
  'furniture.lua',
  'config.lua'
}

dependencies {
  '/server:5104',
  '/onesync',
  'ox_lib',
  'bob74_ipl'
}
dependency '/assetpacks'
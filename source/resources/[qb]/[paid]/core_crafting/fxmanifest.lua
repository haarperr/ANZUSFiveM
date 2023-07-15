fx_version 'adamant'
game 'gta5'
description 'core_crafting'
version '2.1.0'

ui_page 'html/form.html'

files {
  'html/form.html',
  'html/css.css',
  'html/water.png',
  'html/algebra-0.2.6.min.js',
  'html/script.js',
  'html/jquery-3.4.1.min.js',
  'html/img/*.png',
}

client_scripts {
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/ComboZone.lua',
  '@PolyZone/CircleZone.lua',
  'client/main.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'config.lua',
  'server/main.lua',
}


shared_scripts {
  '@ox_lib/init.lua',
  'config.lua',
}

lua54 'yes'

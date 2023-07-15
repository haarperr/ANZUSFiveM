fx_version 'cerulean'
game 'gta5'

description 'r14-leo'
version '1.0.0'

shared_scripts {
  '@ox_lib/init.lua',
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/EntityZone.lua',
  '@PolyZone/CircleZone.lua',
  '@PolyZone/ComboZone.lua',
  'config.lua',
}

client_scripts {
  'config.lua',
  'client/*.lua',
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/EntityZone.lua',
  '@PolyZone/CircleZone.lua',
  '@PolyZone/ComboZone.lua',
}

server_script 'server/*.lua'

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/vue.min.js',
  'html/script.js',
  'html/tablet-frame.png',
  'html/fingerprint.png',
  'html/main.css',
  'html/vcr-ocd.ttf'
}

lua54 'yes'

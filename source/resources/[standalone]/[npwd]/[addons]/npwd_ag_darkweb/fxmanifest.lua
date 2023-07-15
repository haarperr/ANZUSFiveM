fx_version "cerulean"
game "gta5"

shared_scripts {
  "@ox_lib/init.lua",
  "config.lua"
}


client_script 'client/client.lua'
server_scripts { '@oxmysql/lib/MySQL.lua', 'server/init.lua', 'server/server.lua' }

ui_page 'web/dist/index.html'

files {
  'web/dist/index.html',
  'web/dist/*.js',
}

lua54 'yes'

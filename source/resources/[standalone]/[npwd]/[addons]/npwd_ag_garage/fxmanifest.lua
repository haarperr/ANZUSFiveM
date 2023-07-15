fx_version "cerulean"
game "gta5"
lua54 "yes"

client_script 'client/client.lua'
server_script {
    '@oxmysql/lib/MySQL.lua',
    '@ag_vehicle/imports/server.lua',
    'server/server.lua',
}
shared_scripts {
    '@ox_lib/init.lua',
}

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/*.js',
}

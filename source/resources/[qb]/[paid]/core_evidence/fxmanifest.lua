fx_version 'adamant'
game 'gta5'

author 'c8re'
description 'Original Evidence system for FiveM'
version '2.2.0'
editor 'mk3ext#6044'

lua54 'yes'

ui_page 'html/form.html'

files {
    'html/form.html',
    'html/img/logo.png',
    'html/img/report.jpg',
    'html/css.css',
    'html/script.js',
    'html/jquery-3.4.1.min.js',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
}

escrow_ignore {
    'client/main.lua',
    'server/main.lua',
    'config.lua'
}

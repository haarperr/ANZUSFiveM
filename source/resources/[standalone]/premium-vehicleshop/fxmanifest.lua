-- Information about this specific resource
name "premium-vehicleshop"
description "Vehicle shop for players to purchase their premium vehicles from once purchased from Tebex"
version '1.0.0'

-- Files that escrow will ignore
escrow_ignore {
    ''
}

-- Scripts that will be run both client side and server side
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

-- Scripts that will be run only on the client side
client_scripts {
    'client/**/*.lua'
}

-- Scripts that will be run only on the server side
server_scripts {
    '@ag_vehicle/imports/server.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/**/*.lua'
}

-- Files that will be downloaded by clients
files {
    'html/index.html'
}

-- Resource dependencies
dependencies {
    '/server:6279',
    'ox_target',
    'ag_vehicle'
}

-- NUI specific data
ui_page 'html/index.html'

-- Loading screen specific data
-- loadscreen { '' }
-- loadscreen_cursor 'yes'
-- loadscreen_manual_shutdown 'yes'

-- Default resource information
author 'Asaayu'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
tebex 'https://asaayu.tebex.io/'

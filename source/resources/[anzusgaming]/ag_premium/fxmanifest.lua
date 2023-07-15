-- Information about this specific resource
name "ag-premium"
description "[AG] Premium monetization resource"
version '1.0.0'

-- Files that escrow will ignore
escrow_ignore {
    ''
}

-- Scripts that will be run both client side and server side
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'locale.lua',
}

-- Scripts that will be run only on the client side
client_scripts {
    'client/**/*.lua'
}

-- Scripts that will be run only on the server side
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ag_vehicle/imports/server.lua',
    'configServer.lua',
    'server/**/*.lua'
}

-- Files that will be downloaded by clients
files {
    '',
}

-- Resource dependencies
dependencies {
    -- ''
}

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

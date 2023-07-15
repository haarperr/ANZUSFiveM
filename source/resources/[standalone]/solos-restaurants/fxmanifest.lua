fx_version 'cerulean'
game 'gta5'

author 'Solos#7777'
description 'solos-restaurants'
version '1.0.0'


shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/delivery.lua',
    'client/client.lua',
    'client/functions.lua',
    'client/notis.lua',
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ag_vehicle/imports/server.lua',
    'server.lua'
}

escrow_ignore {
    'client/client.lua',
    'client/functions.lua',
    'client/notis.lua',
    'config.lua',
    'server.lua'
}

lua54 'yes'
dependency '/assetpacks'

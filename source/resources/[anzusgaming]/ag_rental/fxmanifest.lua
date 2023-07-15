fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ag_rentals'
version '1.0.0'
author 'mk3ext'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@ag_vehicle/imports/server.lua',
    'server/main.lua'
}

dependencies {
    '/server:6279',
    '/onesync',
    'ox_lib',
    'ag_vehicle'
}

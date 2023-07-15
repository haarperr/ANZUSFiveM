fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lionh34rt#4305'
description 'Carboosting and Vinscratching for QBCore'
version '3.0'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/sh_config.lua',
    'locales/en.lua',
    '@qb-garages/config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    'client/cl_main.lua',
    'client/cl_boosting.lua',
    'client/cl_crushing.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ag_vehicle/imports/server.lua',
    'server/sv_main.lua',
    'server/sv_boosting.lua',
    'server/sv_crushing.lua'
}

ui_page 'html/html/index.html'

files {
    'html/html/index.html',
    'html/css/reset.css',
    "html/css/bootstrap-grid.min.css",
    "html/css/bootstrap-reboot.min.css",
    "html/css/bootstrap.min.css",
    "html/js/bootstrap.bundle.min.js",
    "html/js/bootstrap.min.js",
    'html/js/app.js'
}

dependencies {
    'qb-target',
    'PolyZone'
}

escrow_ignore {
    'shared/sh_config.lua',
    'locales/*.lua',
    'client/cl_boosting.lua',
    'client/cl_crushing.lua',
    'server/sv_boosting.lua',
    'server/sv_crushing.lua'
}

dependency '/assetpacks'

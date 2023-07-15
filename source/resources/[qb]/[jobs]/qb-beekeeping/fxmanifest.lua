fx_version 'cerulean'
game 'gta5'

description 'Container Script'
version '1.0'
author 'Snipe'

lua54 'yes'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/client.lua',
    'client/client_customise.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'server/server_customise.lua',
}

escrow_ignore {
    'config.lua',
    'server/server_customise.lua',
    'client/client_customise.lua',
}

data_file 'DLC_ITYP_REQUEST' 'stream/beehive.ytyp'
dependency '/assetpacks'

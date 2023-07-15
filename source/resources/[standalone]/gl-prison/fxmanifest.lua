fx_version 'cerulean'
game 'gta5'

author 'Kallock - The Goodlife RP Server'
version '1.0.0'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

shared_script 'shared.lua'

dependencies "qb-target"

escrow_ignore {
    'client/*.lua',
    'server/*.lua',
    'shared.lua',
}

lua54 'yes'

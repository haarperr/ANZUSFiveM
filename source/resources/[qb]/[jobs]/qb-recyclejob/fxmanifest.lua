fx_version 'cerulean'
game 'gta5'

description 'QB-RecycleJob'
version '2.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependiences {
    'ox_target',
    'ox_lib',
}

lua54 'yes'

fx_version 'cerulean'
game 'gta5'

author 'Kallock - The Goodlife RP Server'
version '1.0.0'

shared_script {
  '@ox_lib/init.lua',
  'shared.lua'
}

client_scripts {
  'client.lua'
}

server_scripts {
  '@ag_vehicle/imports/server.lua',
  'server.lua'
}

dependencies {
  'qb-target'
}

lua54 'yes'

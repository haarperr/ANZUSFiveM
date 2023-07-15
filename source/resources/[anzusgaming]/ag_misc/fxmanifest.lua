fx_version 'cerulean'
game 'gta5'

author 'mk3ext#6044'
description '[AG] Misc'
version '1.0.0'

shared_scripts {
  '@ox_lib/init.lua',
  'shared/*.lua'
}

client_scripts {
  'client/*.lua',
}

server_scripts {
  'server/*.lua',
}

dependencies {
  'ox_lib'
}

lua54 'yes'

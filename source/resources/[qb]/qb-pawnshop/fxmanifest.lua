fx_version 'cerulean'
game 'gta5'

description 'QB-Pawnshop'
version '1.0.0'

shared_scripts {
  '@ox_lib/init.lua',
  '@qb-core/shared/locale.lua',
  'config.lua',
  'locales/en.lua',
}

server_scripts {
  'server/main.lua'
}

client_scripts {
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/ComboZone.lua',
  'client/main.lua'
}

lua54 'yes'

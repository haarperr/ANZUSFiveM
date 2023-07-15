fx_version 'cerulean'
game 'gta5'

description 'https://github.com/QBCore-Remastered'
version '1.0.1'

shared_scripts {
  '@qb-core/shared/locale.lua',
  'locales/en.lua',
  '@ox_lib/init.lua',
  'config.lua',
}
client_script 'client/main.lua'
server_script 'server/main.lua'

lua54 'yes'

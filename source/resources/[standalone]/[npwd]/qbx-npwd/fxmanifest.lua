fx_version 'cerulean'
game 'gta5'

description 'A simple bridge resource for Qbox Compatibility for NPWD'
version '1.0.0'

client_script 'client.lua'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server.lua'
}

shared_script 'config.lua'

lua54 'yes'
use_experimental_fxv2_oal 'yes'
provide 'qb-npwd'

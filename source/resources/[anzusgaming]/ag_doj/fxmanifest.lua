fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ag_doj'
version '1.0.0'
author 'mk3ext'

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}

client_scripts {
  'client/election.lua',
  'client/tax.lua',
  'client/vote.lua',
  'client/duty.lua',
  'client/main.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/init.lua',
  'server/election.lua',
  'server/vote.lua',
  'server/tax.lua',
  'server/duty.lua',
  'server/budgets.lua'
}

dependencies {
  '/server:5104',
  '/onesync',
  'ox_lib',
  'ag_police'
}

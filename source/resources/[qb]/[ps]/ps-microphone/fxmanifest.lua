fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
description 'Project Sloth Microphone Script (edited by mk3ext)'
author 'mk3ext'

client_scripts {
  'client/main.lua',
  'client/megaphone.lua',
}

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua',
}

dependencies {
  '/server:6279',
  '/onesync',
  'ox_lib'
}

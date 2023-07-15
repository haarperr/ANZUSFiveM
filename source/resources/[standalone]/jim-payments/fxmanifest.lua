fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name "Jim-Payments"
author "Jimathy"
version "v2.8.5"
description "Payment Script By Jimathy"

client_scripts { 'client/*.lua', 'locales/*.lua' }
server_scripts { '@oxmysql/lib/MySQL.lua', 'server/*.lua' }
shared_scripts { '@ox_lib/init.lua', 'config.lua', 'shared/*.lua', 'locales/*.lua' }

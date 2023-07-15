fx_version 'cerulean'
games { 'gta5' }

files {
  'index.html',
  'style.css',
  'script.js',
  'videos/*',
  'audio/*',
}

loadscreen 'index.html'

loadscreen_manual_shutdown "yes"

client_script "client.lua"

lua54 'yes'

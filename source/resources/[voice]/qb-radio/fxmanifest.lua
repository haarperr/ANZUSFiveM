fx_version 'cerulean'
game 'gta5'

shared_scripts { '@ox_lib/init.lua', 'config.lua' }

client_scripts {
    'client.lua'
}

server_script 'server.lua'

ui_page('html/ui.html')

files { 'html/ui.html', 'html/js/script.js', 'html/css/style.css', 'html/img/radio.png', 'html/img/radio2.png' }

lua54 'yes'

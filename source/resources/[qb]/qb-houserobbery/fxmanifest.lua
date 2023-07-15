fx_version 'cerulean'
game 'gta5'

description 'QB-HouseRobbery heavily edited'
version '1.2.0'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/tiers/ipl.lua',
    'shared/tiers/ipl/*.lua',
    'shared/tiers/shell.lua',
    'shared/tiers/shell/*.lua',
    'shared/houselocation.lua',
    'shared/config_utils.lua',
    'shared/hack.lua',
}

client_scripts {
    'client/functions/Init.lua',
    'client/functions/Instances.lua',
    'client/functions/LootHandle.lua',
    'client/functions/Minigame.lua',
    'client/functions/Target.lua',
    'client/functions/Utils.lua',
    'client/functions/minigame/*.lua',
    'client/client_utils.lua',
    'client/client.lua'
}
server_script {
    'server/functions/Init.lua',
    'server/functions/LootHandle.lua',
    'server/functions/Routing.lua',
    'server/functions/Utils.lua',
    'server/functions/EntityHandler.lua',
    'server/thread.lua',
    'server/server_utils.lua',
    'server/server.lua',
}

dependencies {
    'ox_lib',
    "Renewed-Weaponscarry",
    "scully_emotemenu",
    "ps-ui",
    "ps-dispatch",
    "bob74_ipl"
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/assets/index.css',
    'html/js/index.js'
}

lua54 'yes'

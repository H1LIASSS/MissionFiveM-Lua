fx_version 'cerulean'
game 'gta5'

author '1S'
description 'Last man standing'
version '1.0'

resource_type 'gametype' { name = 'mission' }

dependencies {
    'NativeUI'
}

client_scripts {
    '@NativeUI/NativeUI.lua',
    'Player.lua',
    'InteractiveBot.lua',
    'EnemyAlly.lua',
    'UIMissionController.lua',
    'EventController.lua',
}

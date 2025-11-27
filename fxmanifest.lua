fx_version 'cerulean'
game 'gta5'

author '1S'
description 'The last man standing'
version '1.0'

resource_type 'gametype' { name = 'The last man standing' }

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

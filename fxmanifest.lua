fx_version 'cerulean' -- Latest FXServer version, replace with 'bodacious' if needed for older builds
game 'gta5'

author 'BloodXGorr'
description 'QBCore Vehicle Glovebox Loot Script'
version '1.0.0'

-- Server-side and Client-side script files
server_scripts {
    '@oxmysql/lib/MySQL.lua', -- Ensure you use this if MySQL is used in your QBCore setup
    'glovebox_sv.lua'
}

client_scripts {
    'glovebox_cl.lua'
}

-- Dependencies
dependencies {
    'qb-core',  -- Core framework
    'qb-inventory' -- Inventory system
}

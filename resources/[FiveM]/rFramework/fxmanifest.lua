fx_version 'adamant'
game 'gta5'

ui_page('html/index.html')

files {
	-- HUD
	'html/index.html',
    'html/js/*.js',
    'html/font/pricedown.ttf',
    'html/css/style.css',
	'html/icons/money.png',
	'html/icons/bank.png',
	'html/icons/dirtymoney.png',
	'html/icons/logo.png',
	-- Loadingscreen
    --'loading/index.html',
    --'loading/style.css',
	--'loading/logo.png',
	--'loading/music.mp3',
	--'loading/script.js'
}

server_scripts {

	'@mysql-async/lib/MySQL.lua',
    'config.lua',
    'items.lua',
	'version.lua',
	'version',
    -- Core
    'server/*.lua',
    'server/core/*.lua',
    -- Anticheat
    'server/anticheat/*.lua',
    -- Player pos update
    'server/player/player_position/server_position.lua',
    -- Inventory
    'server/player/inventory/*.lua',
    -- Society
    'server/society/*.lua',
    -- job handler
    'server/player/job/*.lua',
    -- Locale
    'language/language.lua',
    'language/english.lua',
    'language/portuguese.lua',
}

client_scripts {
    'config.lua',
	-- Core
    'client/core/*.lua',
    'client/*.lua',
    'client/cortana/*.lua',
	-- Player
    'client/player/player_position/client_position.lua',
    'client/player/hungerNthirst/*.lua',
    'client/player/skin/*.lua',
    -- Locale
    'language/language.lua',
    'language/english.lua',
    'language/portuguese.lua',
}

exports {
    "GetOriginalLabel",
    "GetKeyValue",
    "ReloadPlayerCloth",
    "TriggerServerCallback",
}

server_exports { -- not going to use those, i suppose i will remove them
    'getIdentifier',
    '_player_get_identifier',
    '_server_get_player_all_money',
    '_server_refrech_player_money',
    '_player_remove_money',
    '_player_add_money',
    '_player_add_bank_money',
    '_player_remove_bank_money',
    '_player_remove_money',
    '_player_remove_dirty_money',
    '_player_set_dirty_money',
    '_player_remove_money_for_bank',
    '_player_remove_bank_for_money',
    'save_player_position',
    'Config',
    'GetItemWeightWithLabel',
    'GetWeight',
    'AddItemToPlayerInvBypass',
    'RemoveItemFromPlayerInv',
    'RegisterServerCallback',
    'AddPlayerLog',
    'CheckToken',
    'GetPlayerJob',
    'SetPlayerDeathStatus',
    'SendLog',
    'GetItems',
}

dependencies {
	'mysql-async'
}

--loadscreen ('loading/index.html')
fx_version 'cerulean'
games { 'gta5' }

author 'The_Hs5'

description 'Simple fivem drilling minigame by Code Wizards'
version '1.0.0'

depencies {'wizard-lib', 'ox_lib'}

shared_scripts {
	'@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua'
}

files {
    'locales/*.json'
}

lua54 'yes'
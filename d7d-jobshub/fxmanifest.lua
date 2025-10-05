lua54 'yes'
fx_version "cerulean"
games {"gta5"}
lua54 "yes"

client_script 'client/**/*'
server_script 'server/**/*'
shared_script {
   '@ox_lib/init.lua',
   'config.lua'
}

ui_page 'ui/build/index.html'

files {
   'ui/build/index.html',
   'ui/build/**/*'
}
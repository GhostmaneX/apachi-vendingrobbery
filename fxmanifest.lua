fx_version "cerulean"
game "gta5"
lua54 "yes"

description "Apachi shop vending robbery, upgraded by GhostmaneX"
author "Apachi Shop"
version "1.3"

ui_page "html/index.html"

server_scripts {
	"server/*.lua"
}

client_scripts {
	"client/*.lua"
}

shared_scripts {
	"config.lua",
	"locales/en.lua"
}

files {
	"html/js/*.js",
	"html/index.html",
	"html/style.css",
}

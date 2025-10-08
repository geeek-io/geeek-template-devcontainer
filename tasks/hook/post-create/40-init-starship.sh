#!/usr/bin/xbash

echo "\
starship init fish | source\
" | quietee ~/.config/fish/conf.d/starship.fish

starship \
	preset no-nerd-font \
	--output ~/.config/starship.toml

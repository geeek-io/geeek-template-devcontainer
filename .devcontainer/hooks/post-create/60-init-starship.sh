echo "\
starship init fish | source\
" >~/.config/fish/conf.d/40-starship.fish

starship \
	preset no-nerd-font \
	--output ~/.config/starship.toml

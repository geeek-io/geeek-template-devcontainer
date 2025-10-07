echo "\
starship init fish | source\
" | quietee "${HOME}/.config/fish/conf.d/90-starship.fish"

starship \
	preset no-nerd-font \
	--output ~/.config/starship.toml

sudo rm --recursive --force /usr/local/bin/

sudo ln --symbolic \
	"${HOME}/.local/share/aquaproj-aqua/bin" /usr/local/

aqua install

echo "\
aqua completion fish | source\
" >~/.config/fish/conf.d/aqua.fish

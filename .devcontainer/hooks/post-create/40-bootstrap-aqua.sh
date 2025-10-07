sudo rm --recursive --force /usr/local/bin/

sudo ln --symbolic \
	"${HOME}/.local/share/aquaproj-aqua/bin" /usr/local/

unset AQUA_ENFORCE_CHECKSUM
unset AQUA_ENFORCE_REQUIRE_CHECKSUM

aqua install --tags bootstrap

export AQUA_ENFORCE_CHECKSUM=true
export AQUA_ENFORCE_REQUIRE_CHECKSUM=true

echo "\
aqua completion fish | source\
" >~/.config/fish/conf.d/aqua.fish

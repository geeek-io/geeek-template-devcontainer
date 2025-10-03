sudo rm --recursive --force /usr/local/bin/
symlink --force "${HOME}/.local/share/aquaproj-aqua/bin" /usr/local/

unset AQUA_CHECKSUM
unset AQUA_REQUIRE_CHECKSUM
unset AQUA_ENFORCE_CHECKSUM
unset AQUA_ENFORCE_REQUIRE_CHECKSUM

aqua install --tags bootstrap

export AQUA_CHECKSUM=true
export AQUA_REQUIRE_CHECKSUM=true
export AQUA_ENFORCE_CHECKSUM=true
export AQUA_ENFORCE_REQUIRE_CHECKSUM=true

sops exec-env ~/workspace/sec.env 'aqua install'

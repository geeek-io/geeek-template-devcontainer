#!/usr/bin/xbash

#================================================================
# Ensure nonroot user owns files created during the container build
#----------------------------------------------------------------

: # This no-op is preventing shellcheck from disabling SC2154 in entire script

# SC2154 var is referenced but not assigned: DOCKER_HOST is defined in `.devcontainer/compose.yaml`
# shellcheck disable=SC2154
DOCKER_SOCK=$(echo "${DOCKER_HOST}" | sed 's|unix://||')

sudo chown --recursive nonroot:nonroot \
	~/.* \
	"${DOCKER_SOCK}"
#================================================================

#================================================================
# Auto-loading `<workspace-root>/.var.env` into shell environments
#----------------------------------------------------------------
GET_UNCOMMENTED_ENVS="\
sed\
 -e 's/[[:blank:]]*#.*//'\
 -e '/^$/d'\
 ${HOME}/workspace/.var.env\
"

EXPORT_ENVS_BASH="\
eval \$(${GET_UNCOMMENTED_ENVS}\
 | sed 's/^/export /')\
"

eval "${EXPORT_ENVS_BASH}"

echo "${EXPORT_ENVS_BASH}" \
	| sudo quietee /etc/profile.d/0-env.sh

echo "\
${GET_UNCOMMENTED_ENVS}\
 | sed\
 -e 's/=/ /'\
 -e 's/^/set --global --export /'\
 | source\
" | quietee ~/.config/fish/conf.d/0-env.fish
#================================================================

#================================================================
# Bootstrap Aqua
#----------------------------------------------------------------
sudo rm --recursive --force /usr/local/bin

sudo ln --symbolic \
	"${HOME}/.local/share/aquaproj-aqua/bin" /usr/local/

unset AQUA_ENFORCE_CHECKSUM
unset AQUA_ENFORCE_REQUIRE_CHECKSUM

aqua install --tags bootstrap

export AQUA_ENFORCE_CHECKSUM=true
export AQUA_ENFORCE_REQUIRE_CHECKSUM=true
#================================================================

# Run use-defined hooks
task hook:post-create

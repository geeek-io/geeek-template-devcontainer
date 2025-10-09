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
# Although `.var.env` is loaded in `.devcontainer/compose.yaml`,
# we're exporting the variables to shells here,
# so they can be updated without restarting the devcontainer.
#----------------------------------------------------------------
echo "export-env ~/workspace/.var.env" \
	| sudo quietee /etc/profile.d/0-env.sh

echo "\
uncomment ~/workspace/.var.env\
 | sed\
 -e 's/=/ /'\
 -e 's/^/set --global --export /'\
 | source\
" | quietee ~/.config/fish/conf.d/0-env.fish
#================================================================

#================================================================
# Bootstrap Aqua
#----------------------------------------------------------------
unset AQUA_ENFORCE_CHECKSUM
unset AQUA_ENFORCE_REQUIRE_CHECKSUM

aqua install --tags bootstrap

export AQUA_ENFORCE_CHECKSUM=true
export AQUA_ENFORCE_REQUIRE_CHECKSUM=true
#================================================================

# Run use-defined hooks
task hook:post-create

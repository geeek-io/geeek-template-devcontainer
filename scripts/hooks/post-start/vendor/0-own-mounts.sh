: # This no-op is preventing shellcheck from disabling SC2154 in entire script

# SC2154 var is referenced but not assigned: DOCKER_HOST is defined in `.devcontainer/compose.yaml`
# shellcheck disable=SC2154
DOCKER_SOCK=$(echo "${DOCKER_HOST}" | sed 's|unix://||')

sudo chown --recursive nonroot:nonroot \
	~/.* \
	"${DOCKER_SOCK}"

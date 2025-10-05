#!/usr/bin/bash

set -o errexit
set -o noclobber
set -o nounset
set -o verbose
set -o xtrace

# SC2154: var is referenced but not assigned: DOCKER_HOST is defined in Dockerfile.
# shellcheck disable=SC2154
DOCKER_SOCK_PATH=$(echo "${DOCKER_HOST}" | sed 's/^unix:\/\///')

sudo chown --recursive nonroot:nonroot \
	"${DOCKER_SOCK_PATH}" \
	~/.cache/ \
	~/.local/share/aquaproj-aqua/ \
	~/.bun/ \
	~/.cargo/ \
	~/.gnupg/ \
	~/.npm/ \
	~/.password-store/ \
	|| true

quietee() {
	sudo tee "$@" \
		>/dev/null
}

HERE=$(
	CDPATH='' cd "$(dirname -- "$0")"
	pwd
)

HOOK_DIR="${HERE}/${1}"
TASKS=$(ls "${HOOK_DIR}")

for TASK in ${TASKS}; do
	echo "${TASK}: start"

	# SC1090: Can't follow non-constant source: It's impossible to specify location.
	# shellcheck disable=SC1090
	. "${HOOK_DIR}/${TASK}"

	echo "${TASK}: end"
done

#!/usr/bin/bash

set -o errexit
set -o noclobber
set -o nounset
set -o verbose
set -o xtrace

HERE=$(
	CDPATH='' cd "$(dirname -- "$0")"
	pwd
)

HOOK_TYPE="${1}"

source_task() {
	# shellcheck disable=SC1090
	. "${HERE}/${HOOK_TYPE}/${1}.sh"
}

symlink_force() {
	sudo ln --symbolic --force "$@"
}

quietee() {
	sudo tee "${1}"
}

echo "${1}: start"

# shellcheck disable=SC1090
. "${HERE}/${HOOK_TYPE}/main.sh"

echo "${1}: end"

#!/usr/bin/env sh

set -o errexit
set -o noclobber
set -o nounset
set -o verbose
set -o xtrace

HERE=$(
	CDPATH='' cd "$(dirname -- "$0")"
	pwd
)

HOOK_DIR="${HERE}/initialize"
TASKS=$(ls "${HOOK_DIR}")

for TASK in ${TASKS}; do
	echo "${TASK}: start"

	# SC1090: Can't follow non-constant source: It's impossible to specify location.
	# shellcheck disable=SC1090
	. "${HOOK_DIR}/${TASK}"

	echo "${TASK}: end"
done

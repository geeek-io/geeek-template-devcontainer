#!/usr/bin/env sh

set -o errexit
set -o noclobber
set -o nounset
set -o verbose
set -o xtrace

DIR='.devcontainer/initialize-hooks'

run_dir() {
	SCOPE=$1
	SCRIPTS=$(ls "${DIR}/${SCOPE}")

	for SCRIPT in ${SCRIPTS}; do
		# SC1090: Can't follow non-constant source: We can't follow this because it's dynamic.
		# shellcheck disable=SC1090
		. "${DIR}/${SCOPE}/${SCRIPT}"
	done
}

run_dir vendor
run_dir user

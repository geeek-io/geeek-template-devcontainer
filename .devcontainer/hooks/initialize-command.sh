#!/usr/bin/env sh

set -o errexit
set -o noclobber
set -o nounset
set -o verbose
set -o xtrace

DIR='.devcontainer/hooks/initialize'
SCRIPTS=$(ls "${DIR}")

for SCRIPT in ${SCRIPTS}; do
	# SC1090: Can't follow non-constant source: We can't follow this because it's dynamic.
	# shellcheck disable=SC1090
	. "${DIR}/${SCRIPT}"
done

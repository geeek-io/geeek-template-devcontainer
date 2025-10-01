#!/usr/bin/env sh

set -o errexit
set -o noclobber
set -o nounset
set -o verbose
set -o xtrace

WORKSPACE_NAME="$(basename "${PWD}")"

echo "
WORKSPACE_NAME=${WORKSPACE_NAME}
" \
	>|./.devcontainer/.env

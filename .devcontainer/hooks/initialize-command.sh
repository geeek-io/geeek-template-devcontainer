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

CONTAINER_GIT_CONFIG="${PWD}/.gitignore.d/gitconfig"
rm "${CONTAINER_GIT_CONFIG}"

git config --list --global --includes | while read -r line; do
	KEY=$(echo "${line}" | sed 's/=.*//')

	if test "${KEY}" = 'include.path' ||
		test "${KEY}" = 'gpg.ssh.program' ||
		test "${KEY}" = 'gpg.ssh.allowedsignersfile'; then
		continue
	fi

	VALUE=$(echo "${line}" | sed 's/^.*=//')
	# shellcheck disable=SC2086
	git config set -f "${CONTAINER_GIT_CONFIG}" "${KEY}" "${VALUE}"
done

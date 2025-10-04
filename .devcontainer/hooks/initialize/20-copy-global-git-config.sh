# Copy the global git config to the container,
# with incompatible settings removed.

CONTAINER_GIT_CONFIG="${PWD}/.gitignore.d/gitconfig"
rm "${CONTAINER_GIT_CONFIG}"

git config --global --includes --list | while read -r line; do
	KEY=$(echo "${line}" | sed 's/=.*//')

	if test "${KEY}" = 'include.path' ||
		test "${KEY}" = 'gpg.ssh.program' ||
		test "${KEY}" = 'gpg.ssh.allowedsignersfile'; then
		continue
	fi

	VALUE=$(echo "${line}" | sed 's/^.*=//')

	git config set \
		--file "${CONTAINER_GIT_CONFIG}" \
		"${KEY}" "${VALUE}"
done

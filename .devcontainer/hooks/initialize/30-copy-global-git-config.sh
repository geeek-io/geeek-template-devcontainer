# Copy the global git config to the container,
# with incompatible settings removed.

CONTAINER_GIT_CONFIG="${PWD}/.gitignore.d/gitconfig"
rm "${CONTAINER_GIT_CONFIG}"

CONFIG_ALLOWED_SIGNERS_FILE='gpg.ssh.allowedsignersfile'

git config --global --includes --list | while read -r line; do
	KEY=$(echo "${line}" | sed 's/=.*//')

	if test "${KEY}" = 'include.path' ||
		test "${KEY}" = 'gpg.ssh.program' ||
		test "${KEY}" = "${CONFIG_ALLOWED_SIGNERS_FILE}"; then
		continue
	fi

	VALUE=$(echo "${line}" | sed 's/^.*=//')

	git config set \
		--file "${CONTAINER_GIT_CONFIG}" \
		"${KEY}" "${VALUE}"
done

HOST_ALLOWED_SIGNERS_FILE=$(git config "${CONFIG_ALLOWED_SIGNERS_FILE}")
cp "${HOST_ALLOWED_SIGNERS_FILE}" "${PWD}/.gitignore.d/allowed-signers"

git config set \
	--file "${CONTAINER_GIT_CONFIG}" \
	"${CONFIG_ALLOWED_SIGNERS_FILE}" "/home/nonroot/workspace/.gitignore.d/allowed-signers"

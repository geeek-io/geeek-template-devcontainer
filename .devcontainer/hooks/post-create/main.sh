mkdir --parents \
	~/.config

# shellcheck disable=SC2154
symlink_force "${HOME}/${WORKSPACE_NAME}" "${HOME}/workspace"

source_task aqua-install

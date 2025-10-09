# Make a symbolic link to the workspace directory in the home directory,
# to make access easier regardless of the workspace name.

# SC2154: var is referenced but not assigned: WORKSPACE_NAME is set in the Dockerfile
# shellcheck disable=SC2154
ln --symbolic \
	"${HOME}/${WORKSPACE_NAME}" ~/workspace

# Get the directory name and set it as the workspace name,
# which will be used by the devcontainer.

WORKSPACE_NAME=$(basename "${PWD}")

echo "\
WORKSPACE_NAME=${WORKSPACE_NAME}\
" >|./.devcontainer/.env

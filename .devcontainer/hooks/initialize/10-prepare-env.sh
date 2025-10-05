# Prepare environment variables for the build process of the devcontainer.

WORKSPACE_NAME=$(basename "${PWD}")

echo "\
WORKSPACE_NAME=${WORKSPACE_NAME}\
" >|./.devcontainer/.env

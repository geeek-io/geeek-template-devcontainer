# Prepare environment variables for the build process of the devcontainer.

WORKSPACE_NAME=$(basename "${PWD}")

echo "\
_HOME=/home/nonroot
WORKSPACE_NAME=${WORKSPACE_NAME}\
" >| ./.devcontainer/.env

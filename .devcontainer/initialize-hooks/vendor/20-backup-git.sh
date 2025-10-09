# Backup .git to ../.git-backup.d/<workspace-name>,
# in case of AI go wild.

GIT_BACKUP_D="${PWD}/../.git-backup.d"
mkdir -p "${GIT_BACKUP_D}"

# SC2154: var is referenced but not assigned: WORKSPACE_NAME is defined in `./10-prepare-env.sh`
# shellcheck disable=SC2154
GIT_BACKUP_D_WORKSPACE="${GIT_BACKUP_D}/${WORKSPACE_NAME}"

rm -rf "${GIT_BACKUP_D_WORKSPACE}"
cp -R "${PWD}/.git" "${GIT_BACKUP_D_WORKSPACE}"

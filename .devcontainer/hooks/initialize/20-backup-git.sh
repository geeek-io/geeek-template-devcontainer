GIT_BACKUP_D="${PWD}/../.git-backup.d"

mkdir -p "${GIT_BACKUP_D}"

GIT_BACKUP_D_WORKSPACE="${GIT_BACKUP_D}/${WORKSPACE_NAME}"
rm -rf "${GIT_BACKUP_D_WORKSPACE}"

# shellcheck disable=SC2154
cp -R "${PWD}/.git" "${GIT_BACKUP_D_WORKSPACE}"

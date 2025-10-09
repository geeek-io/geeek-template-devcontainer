set -o errexit
set -o noclobber
set -o nounset
set -o verbose
set -o xtrace

DIR=/usr/local/bin
SCRIPTS=$(ls "${DIR}"/*.sh)

for SCRIPT in ${SCRIPTS}; do
	if test -f "${SCRIPT}"; then
		chmod a+x "${SCRIPT}"
		NAME=$(basename "${SCRIPT}" .sh)
		mv "${SCRIPT}" "${DIR}/${NAME}"
	fi
done

#!/usr/bin/xbash

DIR=$1

if ! test -d "${DIR}"; then
	exit 0
fi

SCRIPTS=$(ls "${DIR}")

for SCRIPT in ${SCRIPTS}; do
	echo
	print-colored blue "[Running] /usr/bin/xbash ${DIR}/${SCRIPT}"
	print-colored blue '----------------------------------------------------------------'
	set-color

	set +o errexit

	# SC1090: Can't follow non-constant source: We can't follow this because it's dynamic.
	# shellcheck disable=SC1090
	/usr/bin/xbash "${DIR}/${SCRIPT}"

	STATUS=$?
	set -o errexit

	print-colored blue '----------------------------------------------------------------'
	print-colored blue "[Finished] /usr/bin/xbash ${DIR}/${SCRIPT} (status=${STATUS})"
	echo
done

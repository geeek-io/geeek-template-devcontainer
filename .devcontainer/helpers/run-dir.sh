#!/usr/bin/xbash

DIR=$1
SCRIPTS=$(ls "${DIR}")

for SCRIPT in ${SCRIPTS}; do
	echo
	set-color blue
	echo "[Running] /usr/bin/xbash ${DIR}/${SCRIPT}"
	echo "================================================================"
	set-color

	# SC1090: Can't follow non-constant source: We can't follow this because it's dynamic.
	# shellcheck disable=SC1090
	/usr/bin/xbash "${DIR}/${SCRIPT}"

	STATUS=$?

	set-color blue
	echo "================================================================"
	echo "[Finished] /usr/bin/xbash ${DIR}/${SCRIPT} (status=${STATUS})"
	set-color
	echo
done

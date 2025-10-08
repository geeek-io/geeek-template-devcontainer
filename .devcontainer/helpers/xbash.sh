#!/usr/bin/bash

ARGS="$*"
OPTIONS='-o errexit -o noclobber -o nounset'
STATUS=''

run() {
	# SC2086: Double quote to prevent globbing and word splitting: We want to split options here.
	# shellcheck disable=SC2086
	/usr/bin/bash ${OPTIONS} ${ARGS}
	STATUS=$?
}

run

if test "${STATUS}" != '0'; then
	echo
	set-color red
	echo "################################################################"
	echo "⚠️ The script '$*' failed." > /dev/stderr
	echo "Press enter to run it again with verbose trace, or Ctrl+C to quit."
	echo "################################################################"
	set-color
	read -r _

	OPTIONS="${OPTIONS} -o verbose -o xtrace"
	run
	exit "${STATUS}"
fi

exit 0

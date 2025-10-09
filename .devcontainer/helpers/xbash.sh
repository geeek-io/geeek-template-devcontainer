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

if test -n "${XBASH_EXPORTED:-}"; then
	export XBASH_EXPORTED=true
	export-env ~/workspace/.var.env

	export PATH="\
/home/nonroot/workspace/node_modules/.bin\
:/home/nonroot/.local/share/aquaproj-aqua/bin\
:/home/nonroot/.local/bin\
:${PATH}\
"
fi

run

if test "${STATUS}" != '0'; then
	echo
	print-colored red "################################################################"
	print-colored red "⚠️ The script '$*' failed." > /dev/stderr
	print-colored red "Press enter to run it again with verbose trace, or Ctrl+C to quit."
	print-colored red "################################################################"
	read -r _

	OPTIONS="${OPTIONS} -o verbose -o xtrace"
	run
	exit "${STATUS}"
fi

exit 0

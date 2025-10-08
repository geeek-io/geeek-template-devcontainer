#!/usr/bin/xbash

STDOUT=$(cat -)
FILE="$1"
shift
DIR=$(dirname "${FILE}")
mkdir --parents "${DIR}"

echo "${STDOUT}" \
	| tee "$@" "${FILE}" \
		> /dev/null

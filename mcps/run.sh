#!/usr/bin/sh

set -o errexit
set -o noclobber
set -o nounset
set -o verbose
set -o xtrace

SCRIPT_DIR=$(
	CDPATH=''
	cd "$(dirname -- "$0")"
	pwd
)

MCP_NAME="${1}"
MCP_DIR="${SCRIPT_DIR}/${MCP_NAME}"

COMMAND=''

COMMAND=$(
	sed \
		-e 's/^[[:blank:]]*#.*$//' \
		-e '/^$/d' \
		-e ':a' \
		-e '/\\$/ { N; s/\\\n//; ba }' \
		-e 's/[[:blank:]]\+/ /g' \
		"${MCP_DIR}/command.sh"
)

if test -f "${MCP_DIR}/sec.env"; then
	COMMAND="sops exec-env '${MCP_DIR}/sec.env' '${COMMAND}'"
fi

if test -f "${MCP_DIR}/var.env"; then
	# shellcheck disable=SC1091
	. "${MCP_DIR}/var.env"
fi

eval "${COMMAND}"

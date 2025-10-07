#!/usr/bin/bash

set -o errexit
set -o noclobber
set -o nounset
set -o verbose
set -o xtrace

xdnf() {
	sudo dnf \
		--refresh \
		--assumeyes \
		--best \
		--no-docs \
		--show-new-leaves \
		"$@"
}

echo "$1: start"

# SC1090: Can't follow non-constant source: It's impossible to specify location.
# shellcheck disable=SC1090
. "/layers/$1.sh"

echo "$1: end"

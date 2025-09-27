#!/usr/bin/bash

set -o errexit
set -o noclobber
set -o nounset
set -o verbose
set -o xtrace

# shellcheck disable=SC2329
xdnf() {
	sudo dnf \
		--refresh \
		--assumeyes \
		--best \
		--no-docs \
		--show-new-leaves \
		"${@}"
}

sudo chown --recursive \
	nonroot:nonroot \
	~/docker.sock \
	~/.cache/ \
	~/.local/ ||
	true

echo "[starting] sourcing ${1}"

# shellcheck disable=SC1090
. "${1}"

echo "[finishied] sourcing ${1}"

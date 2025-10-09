#!/usr/local/bin/xbash

dnf \
	--refresh \
	--assumeyes \
	--best \
	--no-docs \
	--show-new-leaves \
	"$@"

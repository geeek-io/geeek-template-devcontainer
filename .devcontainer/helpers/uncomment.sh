#!/usr/local/bin/xbash

sed \
	-e 's/[[:blank:]]*#.*//' \
	-e '/^$/d' \
	"$1"

#!/usr/bin/bash

ESC=$(printf '\033')

case "$1" in
	red) COLOR='31' ;;
	green) COLOR='32' ;;
	yellow) COLOR='33' ;;
	blue) COLOR='34' ;;
	*) COLOR='0' ;; # default
esac

printf '%s[%sm' "${ESC}" "${COLOR}"

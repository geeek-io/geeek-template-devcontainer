#!/usr/bin/bash

COLOR=$(set-color "$1")
RESET=$(set-color)
TEXT=$2

printf '%s%s%s\n' "${COLOR}" "${TEXT}" "${RESET}"

#!/usr/bin/env bash

shfmt \
	--posix \
	--simplify \
	--binary-next-line \
	--case-indent \
	--space-redirects \
	"$@"

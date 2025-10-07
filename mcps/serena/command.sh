# SC2154: var is referenced but not assigned: SERENA_MODE and SERENA_CONTEXT will be injected from `.var.env`.
# shellcheck disable=SC2154

SERENA_MODE_OPTIONS=$(
	for mode in ${SERENA_MODE}; do
		printf " --mode %s" "${mode}"
	done
)

# SC2086: Double quote to prevent globbing and word splitting: We are splitting intentionally here.
# shellcheck disable=SC2086
uvx \
	--from git+https://github.com/oraios/serena \
	serena \
	start-mcp-server \
	--project ~/workspace \
	--context "${SERENA_CONTEXT}" \
	${SERENA_MODE_OPTIONS} \
	--enable-web-dashboard no \
	--enable-gui-log-window no

SERENA_MODE_OPTIONS=$(
	# shellcheck disable=SC2154
	for mode in ${SERENA_MODE}; do
		printf " --mode %s" "${mode}"
	done
)

# shellcheck disable=SC2086,SC2154
uvx \
	--from git+https://github.com/oraios/serena \
	serena \
	start-mcp-server \
	--project "${WORKSPACE_DIR}" \
	--context "${SERENA_CONTEXT}" \
	${SERENA_MODE_OPTIONS} \
	--enable-web-dashboard no \
	--enable-gui-log-window no

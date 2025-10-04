# SC2154: var is referenced but not assigned: COPILOT_MCP_CONTEXT7_API_KEY will be injected from `sec.env`.
# shellcheck disable=SC2154
bunx --bun --yes @upstash/context7-mcp \
	--api-key "${COPILOT_MCP_CONTEXT7_API_KEY}"

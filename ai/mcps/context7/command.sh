: # This no-op is preventing shellcheck from disabling SC2154 in entire script

# SC2154: var is referenced but not assigned: COPILOT_MCP_CONTEXT7_API_KEY will be injected from `.sec.env`.
# shellcheck disable=SC2154
bun run --bun context7-mcp \
	--api-key "${COPILOT_MCP_CONTEXT7_API_KEY}"

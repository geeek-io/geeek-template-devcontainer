uvx mcp-proxy \
	--transport streamablehttp \
	--headers X-MCP-Readonly yes \
	--headers X-MCP-Toolsets context,actions,discussions,issues,notifications,projects,pull_requests,repos \
	https://api.githubcopilot.com/mcp/

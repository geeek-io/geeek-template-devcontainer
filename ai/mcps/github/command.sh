GH_TOKEN=${COPILOT_MCP_GH_TOKEN:-$(sops decrypt --extract '["GH_TOKEN"]' ~/workspace/.gitignore.d/gh-token.env)}

uvx mcp-proxy \
	--transport streamablehttp \
	--headers X-MCP-Readonly yes \
	--headers X-MCP-Toolsets context,actions,discussions,issues,notifications,projects,pull_requests,repos \
	--headers Authorization "Bearer ${GH_TOKEN}" \
	https://api.githubcopilot.com/mcp/

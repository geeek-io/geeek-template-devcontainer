# MCP Context Restoration Prompt

This document summarizes my understanding of the Model Context Protocol (MCP) and its specific implementation within this repository, allowing for quick context restoration in future sessions.

## My Understanding

Based on our previous conversation, I have a strong grasp of the following concepts:

1. **General MCP Knowledge:** I understand the purpose and basic concepts of MCP as outlined in the official documentation.
	* Intro: https://modelcontextprotocol.io/docs/getting-started/intro.md
	* Client Implementations:
		* Gemini CLI: https://raw.githubusercontent.com/google-gemini/gemini-cli/refs/heads/main/docs/tools/mcp-server.md
		* VSCode: https://raw.githubusercontent.com/microsoft/vscode-docs/refs/heads/main/docs/copilot/customization/mcp-servers.md
		* GitHub Copilot Agent: https://raw.githubusercontent.com/github/docs/refs/heads/main/content/copilot/how-tos/use-copilot-agents/coding-agent/extend-coding-agent-with-mcp.md

2. **Repository-Specific MCP Architecture:**
	* **Unified Interface:** The core design principle is to treat all MCP servers (both local and remote) uniformly. This is achieved by proxying remote servers locally, allowing all clients to interact with them via `type: "stdin"`.
	* **Implementation Details:** The structure, mechanics, and instructions for adding new MCP servers are documented in `~/workspace/ai/mcps/README.md`, which I helped create.

3. **Client Configuration:**
	*   This repository is client-agnostic, but provides default configurations for common clients.
	*   **VSCode:** Configured via `~/workspace/.vscode/mcp.json`.
	*   **Gemini CLI:** Configured via `~/workspace/.gemini/settings.json`.

4. **Secrets and Environment Management:**
	* **Secrets:** Sensitive information is stored in `.sec.env`, which is encrypted using `sops`. This ensures secure access for clients like GitHub Copilot, which operates on remote GitHub servers.
	* **Overrides:** Environment-specific settings, particularly for GitHub Copilot, can be overridden using variables prefixed with `COPILOT_MCP_` in the `.var.env` file.

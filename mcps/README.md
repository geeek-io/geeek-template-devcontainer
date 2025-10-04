# Unified MCP Server Management

This directory provides a unified mechanism to manage and run multiple Model Context Protocol (MCP) servers, abstracting the differences between local servers and remote servers. It ensures that any client (like Gemini CLI, VSCode, or a remote GitHub Copilot environment) can interact with any MCP server through a consistent `stdio` interface.

## How It Works

The core of this system is the `run.sh` script, which acts as a universal entry point. Clients are configured to execute this script with the desired server name as an argument.

`./run.sh <server-name>`

The script performs the following steps:
1.  Locates the corresponding server directory at `mcps/<server-name>`.
2.  If `var.env` exists in the directory, it sources the file to load non-secret environment variables.
3.  If `sec.env` exists, it uses `sops exec-env` to decrypt the file and inject secrets (like API keys) into the execution environment.
4.  It reads, and executes the server start command defined in `command.sh` from the server's directory.

This architecture allows clients to remain unaware of the server's implementation details. For example:
- A **local server** (e.g., `serena`) is started directly by its command in `command.sh`.
- A **remote server** (e.g., `github`) is accessed via `uvx mcp-proxy`, which is configured in its `command.sh` to create a local `stdio` proxy to the remote endpoint.

### Configuration Overrides for Different Environments

To accommodate environments like GitHub Copilot that run on remote servers, you can override settings using environment variables in `var.env`. Variables prefixed with `COPILOT_MCP_` are used for this purpose, allowing you to maintain different configurations for local and remote execution while sharing the same encrypted secrets (`sec.env`).

## Adding a New MCP Server

Follow these steps to integrate a new MCP server:

1.  **Create a Server Directory:**
    Create a new directory under `mcps/` with a descriptive name for your server.
    ```sh
    mkdir mcps/my-new-server
    ```

2.  **Define the Start Command:**
    Create a `command.sh` file inside the new directory. This file contains the shell command to start the MCP server.

    - **For a local server:**
      ```sh
      # mcps/my-new-server/command.sh
      my-mcp-binary --port 8080
      ```

    - **For a remote server (via proxy):**
      ```sh
      # mcps/my-new-server/command.sh
      uvx mcp-proxy \
          --transport sse \
          https://my-remote-mcp-server.com/mcp
      ```

3.  **Add Configuration (Optional):**
    If your server requires non-secret configuration (e.g., flags, contexts), create a `var.env` file. These variables can be used in your `command.sh`.
    ```sh
    # mcps/my-new-server/var.env
    MY_SERVER_FLAG="--enable-feature-x"
    ```
    ```sh
    # mcps/my-new-server/command.sh
    # shellcheck disable=SC2154
    my-mcp-binary "${MY_SERVER_FLAG}"
    ```

4.  **Add Secrets (Optional):**
    If your server needs secrets (API keys, tokens), create a `sec.env` file. This file **must** be encrypted with `sops`.
    ```sh
    # 1. Create the plaintext file
    echo "MY_API_KEY=your-secret-key" > mcps/my-new-server/sec.env

    # 2. Encrypt the file in-place
    sops --encrypt --in-place mcps/my-new-server/sec.env
    ```
    The `run.sh` script will automatically decrypt and load these secrets when the server is started.

## Client Configuration Examples

To use a server, you need to configure your specific client to call `run.sh`. The configuration file and format vary depending on the client.

### For VSCode

Add the server definition to the `servers` array in `.vscode/mcp.json`:

```jsonc
{
  "servers": {
		// ... other servers.
    "my-new-server": {
      "type": "stdio",
      "command": "${workspaceFolder}/mcps/run.sh",
      "args": ["some-arg"]
    }
	}
}
```

### For Gemini CLI

Add the server definition to the `mcpServers` object in `.gemini/settings.json`:

```jsonc
{
  "mcpServers": {
		// ... other servers.
    "my-new-server": {
      "command": "./mcps/run.sh",
      "args": ["some-arg"],
      "cwd": "/home/nonroot/workspace",
      "trust": true // When `true`, bypasses all tool call confirmations for this server (default: `false`)
    }
  }
}
```

# Geeek's Dev Container Template

This repository provides a development environment template using [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers). It's designed to offer a consistent, reproducible, and customizable environment.

## ✨ Features

-   📦 **Reproducible Environment**: Defined as code with Docker and Compose for consistent setups.
-   🛠️ **Tool Version Management**: Uses [**mise**](https://mise.jdx.dev/) to manage project-specific tool versions (e.g., Node.js, Python, Go).
-   🐟 **Modern Shell**: Comes pre-configured with the **fish shell**.
-   🛡️ **Secure by Default**: Runs as a `nonroot` user with passwordless `sudo`.
-   ⚙️ **VS Code Integration**: Pre-configured with useful extensions and settings.
-   ⚡ **Performance**: Persists `mise` tools and caches across rebuilds using named Docker volumes.
-   🐳 **Docker-in-Docker Ready**: Easily configured for workflows that require running Docker inside the container.
-   🤫 **Secret Management**: Integrated with `sops` and `age` for securely managing secrets in your repository.
-   🤖 **Model Context Protocol (MCP) Integration**: Extends AI agent capabilities with tools like GitHub, Serena, and Context7 through a unified script-based approach.

## 🚀 Quick Start

### Prerequisites

-   A Docker-compatible environment (e.g., [Docker Desktop](https://www.docker.com/products/docker-desktop/), [OrbStack](https://orbstack.dev/), or a standalone Docker Engine installation) with the [Compose V2](https://docs.docker.com/compose/install/) plugin.
-   [Visual Studio Code](https://code.visualstudio.com/).
-   The [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for VS Code.

### Usage

1.  Clone this repository to your local machine.
2.  Open the cloned folder in VS Code.
3.  When prompted, click **"Reopen in Container"**.

VS Code will build the container image and initialize the environment.

## 🔧 Customization

This template is a starting point. You can customize it by modifying the files in the `.devcontainer` directory.

### Tool Version Management (`mise`)

To manage tool versions (like Node.js, Python, etc.), edit `mise/config.toml` or use the `mise` command in the container's terminal. `mise` will automatically install the specified versions when the container starts.

**Example**: Add Node.js LTS and the latest version of Python.

```sh
# This command updates mise/config.toml
mise use --global node@lts python@latest
```

Commit the `mise/config.toml` file to share the tool configuration with your team.

### System Packages (`dnf`)

You can add system-level packages from Fedora's repositories or custom COPR repositories.

-   **From Fedora Repositories**: Add package names to `.devcontainer/extra-dnf-packages.txt`.
-   **From COPR Repositories**:
    1.  Add the COPR repository to `.devcontainer/extra-dnf-repos.txt`.
    2.  Add the package name to `.devcontainer/extra-dnf-packages.txt`.

After modifying these files, rebuild the container (**View > Command Palette > Dev Containers: Rebuild Container**) to apply the changes.

### Docker-in-Docker

If your workflow requires running Docker commands from within the dev container, you need to mount your host's Docker socket.

1.  Open `.devcontainer/compose.yaml`.
2.  In the `volumes` section of the `dev` service, uncomment the line that mounts the Docker socket suitable for your environment (e.g., OrbStack or general Docker).

### Secret Management (`sops` + `age`)

This template uses `sops` and `age` to encrypt secrets, allowing you to safely commit them to your repository.

1.  **Generate an `age` key**:
    Run the following command in the container's terminal. The key will be stored in a git-ignored file.

    ```sh
    age-keygen -o "$PWD/.gitignore.d/age.txt"
    ```
    This command outputs the public key to the terminal.

2.  **Configure `sops`**:
    Open `.devcontainer/compose.yaml`, go to the `dev` service definition, and set the `SOPS_AGE_RECIPIENTS` environment variable to the public key you just generated.

    ```yaml
    # .devcontainer/compose.yaml
    services:
      dev:
        # ... (other configuration)
        environment:
          SOPS_AGE_RECIPIENTS: "CHANGE-ME" # Paste public key here
					# ... (other environment variables)
    ```

3.  **Editing Secrets**:
    To edit the encrypted file, use the `sops edit` command:

    ```sh
    sops edit $WORKSPACE_DIR/some-secret.env
    ```

    This will open the file in your $EDITOR (ms-edit by default) for you to add or modify secrets. When you save and close the editor, `sops` will automatically re-encrypt the file.

### 🤖 Model Context Protocol (MCP) Integration

This project integrates with MCP servers to extend the capabilities of AI agents. It uses a script-based approach for flexibility.

The configuration is managed in:
-   `.vscode/mcp.json`: For VS Code-based agents.
-   `.gemini/settings.json`: For the Gemini CLI agent.

Both files point to the `./mcps/run.sh` script, which dynamically launches the requested MCP server.

#### Included MCP Servers

-   **`github`**: Provides tools for interacting with the GitHub API.
-   **`context7`**: An external tool for context management.
-   **`serena`**: A local agent for code understanding and manipulation.

#### Adding a New MCP Server

1.  **Create a Server Directory**:
    Create a new subdirectory inside the `mcps/` directory (e.g., `mcps/my-new-mcp/`).

2.  **Define the Command**:
    Inside the new directory, create a `command.sh` file that contains the shell command to start your MCP server.

3.  **Add Secrets or Variables (Optional)**:
    -   If the server requires secrets, create a `sec.env` file in the same directory and encrypt it with `sops`. The `run.sh` script will automatically inject these secrets at runtime.
    -   For non-secret environment variables, create a `var.env` file.

4.  **Register the Server**:
    Add a new entry for your server in `.vscode/mcp.json` and/or `.gemini/settings.json`, pointing to the `run.sh` script with the new server's name as an argument.

    ```json
    // .vscode/mcp.json
    "servers": {
      // ... existing servers
      "my-new-mcp": {
        "command": [
          "./mcps/run.sh",
          "my-new-mcp"
        ]
      }
    }
    ```

## 📁 Project Structure

```
.
├── .devcontainer/      # Dev Container configuration
│   ├── compose.yaml    # Docker Compose definition for the environment
│   ├── devcontainer.json # Dev Container metadata and VS Code settings
│   ├── Dockerfile      # Main Dockerfile for the workspace container
│   ├── extra-dnf-packages.txt # List of system packages to install
│   └── ...
├── .vscode/            # VS Code workspace settings
├── mise/               # mise configuration
│   └── config.toml     # Defines tool versions (e.g., node, python)
└── ...
```

## 📄 License

This template is released under the [Apache License, Version 2.0](LICENSE).

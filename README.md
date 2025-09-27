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
-   🤖 **MCP Gateway**: Includes the [Model Context Protocol (MCP) Gateway](https://hub.docker.com/r/docker/mcp-gateway) for extending the environment with containerized tools.

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
2.  In the `volumes` section of the `mcp-gateway` service, uncomment the line that mounts the Docker socket suitable for your environment (e.g., OrbStack or general Docker).

### Secret Management (`sops` + `age`)

This template uses `sops` and `age` to encrypt secrets, allowing you to safely commit them to your repository.

1.  **Generate an `age` key**:
    Run the following command in the container's terminal. The key will be stored in a git-ignored file.

    ```sh
    age-keygen -o "$PWD/.gitignore.d/age.txt"
    ```
    This command outputs the public key to the terminal.

2.  **Configure `sops`**:
    Open `mise/config.toml` and set the `age_recipients` value to the public key you just generated.

    ```toml
    # mise/config.toml
    [settings.sops]
    age_recipients = "age1..." # Paste your public key here
    ```

Now you can use `sops` to encrypt and decrypt files. See the [mise documentation](https://mise.jdx.dev/environments/secrets.html) for more details.

### 🤖 Extending with MCP Gateway

This template includes the [Model Context Protocol (MCP) Gateway](https://hub.docker.com/r/docker/mcp-gateway), a proxy that allows AI agents to interact with containerized tools called MCP servers.

The gateway is configured in `.devcontainer/compose.yaml` and is enabled by default.

#### Finding MCP Servers

You can find available MCP servers on the official Docker Hub MCP page:

-   **[Docker Hub MCP Catalog](https://hub.docker.com/mcp)**

The catalog includes servers for databases, developer tools, productivity apps, and more.

#### Adding a New MCP Server

To add a new MCP server to your environment, edit the `.devcontainer/compose.yaml` file.

1.  **Enable the server in the gateway**:
    In the `mcp-gateway` service definition, add the server's name to the comma-separated list in the `--servers` flag.

    For example, to add the `github` server:

    ```yaml
    # .devcontainer/compose.yaml
    services:
      mcp-gateway:
        # ... (other gateway configuration)
        command:
          # ... (other flags)
          - --servers=ast-grep,context7,deepwiki,llmtxt,memory,semgrep,sequentialthinking,github # Add 'github' here
    ```

2.  **Rebuild the Dev Container**:
    After saving `compose.yaml`, run **Dev Containers: Rebuild Container** from the Command Palette (`Ctrl+Shift+P`) to apply the changes.

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

# Dev Container Hooks

This document explains the structure and mechanism of the Dev Container lifecycle hooks used in this project.

## Overview

This project uses the standard Dev Container lifecycle hooks (`initializeCommand`, `postCreateCommand`, and `postStartCommand`) to automate setup and configuration tasks. Instead of placing complex logic directly into `devcontainer.json`, we use a directory-based approach to manage scripts for each lifecycle event.

A runner script is associated with each hook, and this script executes all the shell scripts within a corresponding directory.

### Lifecycle Hooks and Directories

| Lifecycle Hook in `devcontainer.json` | Corresponding Directory | Execution Context | Purpose |
| :--- | :--- | :--- | :--- |
| `initializeCommand` | `hooks/initialize/` | **Local machine** | Runs once, before the container is created. Use this for pre-build tasks like setting workspace properties. |
| `postCreateCommand` | `hooks/post-create/` | **Inside the container** | Runs once, after the container is created but before you connect. Ideal for one-time setup like installing dependencies or initializing tools. |
| `postStartCommand` | `hooks/post-start/` | **Inside the container** | Runs every time the container starts. Use for tasks that need to run on every start, like starting services. |

### Execution Mechanism

- The `devcontainer.json` file calls a primary script for each hook (e.g., `initialize-command.sh` or `source.sh`).
- These primary scripts then identify the correct directory based on the hook being run.
- They proceed to execute every `.sh` script found within that directory.
- The scripts are executed in lexicographical (alphabetical) order based on their filenames. This is why the scripts are prefixed with numbers (e.g., `10-script.sh`, `20-another-script.sh`).

## Hooks vs. Docker Layers: When to Use Which

Use lifecycle hooks for setup tasks that **depend on files in your workspace**. The `postCreateCommand`, for example, runs after the container is created and the workspace is mounted.

- **Ideal for:** Installing project-specific dependencies or running setup scripts located in your repository.
- **Example:** Running `npm install` based on a `package.json` file or `pip install -r requirements.txt`.

For installing system-level tools or packages that are independent of the workspace, [use Docker layers](../layers/README.md) instead. This approach leverages Docker's caching mechanism, leading to faster container rebuilds when only workspace files have changed.

## How to Add a New Hook Script

Adding a new script is straightforward.

1.  **Identify the correct lifecycle stage:** Decide when your script needs to run.
    - Before the container is built? -> `initialize`
    - Once, after the container is built? -> `post-create`
    - Every time the container starts? -> `post-start`

2.  **Create a new shell script:** Add a new `.sh` file to the corresponding directory (`hooks/initialize`, `hooks/post-create`, or `hooks/post-start`).

3.  **Name your script:** Prefix the filename with a number to control the execution order. For example, if you have `10-first.sh` and `20-second.sh`, `10-first.sh` will run before `20-second.sh`. If your script should run after them, name it `30-my-new-script.sh`.

    ```sh
    # Example: Adding a script to post-create

    # 1. Navigate to the directory
    cd .devcontainer/hooks/post-create

    # 2. Create and edit your new script
    touch 50-my-new-task.sh
    chmod +x 50-my-new-task.sh
    # ... add your script logic ...
    ```

4.  **Rebuild or Restart:**
    - If you added a script to `initialize` or `post-create`, you will need to rebuild the container for the changes to take effect.
    - If you added a script to `post-start`, simply restarting the container will run your new script.

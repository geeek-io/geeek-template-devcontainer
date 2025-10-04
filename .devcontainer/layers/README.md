# How to Add Container Layers

This directory stores scripts that add layers to the Dev Container's Docker image.

## How it Works

1.  The `.devcontainer/Dockerfile` copies this `layers` directory to `/layers` inside the image.
2.  The `SHELL` instruction in the Dockerfile is configured to use `source.sh` to execute `RUN` commands.
3.  When Docker processes a `RUN <script_name>` instruction, it invokes `source.sh` with `<script_name>` as its argument.
4.  The `source.sh` script then sources and executes the corresponding `/layers/<script_name>.sh` file.

## Layers vs. Hooks: When to Use Which

Use Docker layers for immutable setup steps that run only once when the container image is built. These steps **cannot** access workspace files, as the workspace is mounted after the image is built.

- **Ideal for:** Installing system-wide dependencies, compilers, or specific versions of tools that do not depend on your project's source code.
- **Example:** Installing `build-essential`, `git`, or `zsh`.

For setup tasks that depend on your workspace files (e.g., installing project dependencies from a `package.json` file), [use the `postCreateCommand` lifecycle hook](../hooks/README.md) instead. This separation improves build performance by caching the base image layers.

## Steps to Add a Layer

1.  **Create a Script:**
    *   Add a new shell script (e.g., `my-custom-layer.sh`) to this `layers` directory.
    *   The script does not require execute permissions because it is sourced by `source.sh`, not executed directly.

2.  **Edit the Dockerfile:**
    *   Open `.devcontainer/Dockerfile`.
    *   Add a new `RUN` instruction for your script. The name should not include the `.sh` extension.
        ```dockerfile
        # ... existing RUN instructions ...

        RUN my-custom-layer

        # ... USER nonroot instruction ...
        ```
    *   **Note:** Layers added before the `USER nonroot` instruction run as `root`. Layers added after it run as `nonroot`. Place system-wide modifications before `USER nonroot`.

3.  **Rebuild the Container:**
    *   Run the "Dev Containers: Rebuild Container" command from the VS Code command palette to apply your changes.

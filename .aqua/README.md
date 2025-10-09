# aqua

This directory contains the configuration for [aqua](https://aquaproj.github.io/), a declarative CLI version manager. We use aqua to ensure that all developers and CI environments use the same versions of command-line tools, preventing compatibility issues.

## Configuration Structure

The aqua configuration is split across several files for better organization:

- `aqua.yaml`: The main configuration file. It defines the registries and imports the package files below.
- `packages/`: This directory contains the tool definitions, categorized by their intended environment.
  - `global.yaml`: Defines tools that are considered essential for the project and are used globally.
  - `ci.yaml`: Defines tools specifically required for Continuous Integration (CI) pipelines (e.g., linters).
  - `local.yaml`: Defines tools recommended for local development.

## Usage

[aqua](https://aquaproj.github.io/) is integrated into the development container's shell. Tools are automatically installed when you open the container or a new shell.

**Note:** In remote AI environments such as GitHub Copilot Agent, only tools tagged with `global` and `ci` are installed by default to optimize the environment.

To manually install all tools defined in the configuration, run:

```shell
aqua install
```

You can also install tools from a specific category (tag):

```shell
# Install only local development tools
aqua install -t local

# Install only CI tools
aqua install -t ci
```

## Further Reading

For more detailed information on how to use aqua, add new tools, or update existing ones, please refer to the [official aqua documentation](https://aquaproj.github.io/docs/).

FROM docker.io/library/fedora:43

ARG \
	WORKSPACE_NAME

# General-purpose environment variables.
# They should be independent of the mounted workspace and tools installed via postStart hooks.
ENV \
	DO_NOT_TRACK='1' \
	TZ='Asia/Tokyo' \
	LC_ALL='C.UTF-8' \
	LANG='en_US.UTF-8' \
	LANGUAGE='en_US.UTF-8' \
	WORKSPACE_NAME=${WORKSPACE_NAME}

COPY --chmod=555 ./.devcontainer/helpers/* /usr/bin/

RUN \
	--mount=type=bind,source=./.devcontainer/layers/prepare-helpers.sh,destination=/layer.sh \
	/layer.sh

# Use a wrapper script, which sets strict environment,
# as the shell for subsequent RUN instructions.
SHELL ["/usr/bin/xbash"]

RUN \
	--mount=type=cache,target=/var/cache/dnf \
	--mount=type=bind,source=./.devcontainer/layers/base.sh,destination=/layer.sh \
	/layer.sh

RUN \
	--mount=type=cache,target=/var/cache/dnf \
	--mount=type=bind,source=./.devcontainer/layers/dnf-extra.sh,destination=/layer.sh \
	--mount=type=bind,source=./.devcontainer/extra-dnf-repos.txt,destination=/extra-dnf-repos.txt \
	--mount=type=bind,source=./.devcontainer/extra-dnf-packages.txt,destination=/extra-dnf-packages.txt \
	/layer.sh

# Use a nonroot user, which is created in `.devcontainer/layers/base.sh`, to avoid running as root.
# It can `sudo` without a password.
USER nonroot

RUN \
	--mount=type=bind,source=./.devcontainer/layers/nonroot-etc.sh,destination=/layer.sh \
	/layer.sh

# Set the default shell for subsequent build steps (e.g., devcontainer features).
# Enables verbose and xtrace options for easier debugging of those steps.
SHELL ["/usr/bin/bash", "-c", \
	"-o", "verbose", \
	"-o", "xtrace"]

# Wrap the entrypoint with bash and enable verbose/xtrace options.
# This helps debug container startup issues by showing every command being executed.
ENTRYPOINT ["/usr/bin/bash", "-c", \
	"-o", "verbose", \
	"-o", "xtrace"]

# To keep the devcontainer running.
CMD ["sleep infinity"]

# Define build-time arguments for paths used in subsequent ENV instructions.
# This simplifies the management of common paths within this Dockerfile.
ARG \
	HOME='/home/nonroot' \
	WORKSPACE='/home/nonroot/workspace'

# Environment variables are defined here to ensure they are available during the build process,
# and for all processes within the running container, including those not launched via a shell.
# To add or override variables, use the "<workspace-root>/.var.env" file.
ENV \
	EDITOR='code --wait' \
	VISUAL='code --wait' \
	DOCKER_HOST="unix://${HOME}/docker.sock" \
	SOPS_AGE_KEY_FILE="${WORKSPACE}/.gitignore.d/age.txt" \
	GIT_CONFIG_GLOBAL="${WORKSPACE}/.gitignore.d/gitconfig" \
	GHTKN_CONFIG="${WORKSPACE}/.ghtkn.yaml" \
	AQUA_GLOBAL_CONFIG="${WORKSPACE}/.aqua/aqua.yaml" \
	AQUA_CONFIG="${WORKSPACE}/.aqua/aqua.yaml" \
	AQUA_VACUUM_DAYS=40 \
	AQUA_PROGRESS_BAR=true \
	AQUA_ENFORCE_CHECKSUM=true \
	AQUA_ENFORCE_REQUIRE_CHECKSUM=true

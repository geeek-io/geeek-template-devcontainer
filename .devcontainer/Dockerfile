FROM docker.io/library/fedora:42

ENV \
	DO_NOT_TRACK='1' \
	NO_BROWSER='1' \
	TZ='Asia/Tokyo' \
	LC_ALL='C.UTF-8' \
	LANG='en_US.UTF-8' \
	LANGUAGE='en_US.UTF-8'

COPY ./.devcontainer/layers /layers

SHELL ["/layers/source.sh"]

RUN \
	--mount=type=cache,target=/var/cache/dnf/ \
	base

RUN \
	--mount=type=cache,target=/var/cache/dnf/ \
	--mount=type=bind,source=./.devcontainer/extra-dnf-repos.txt,destination=/extra-dnf-repos.txt \
	--mount=type=bind,source=./.devcontainer/extra-dnf-packages.txt,destination=/extra-dnf-packages.txt \
	dnf-extra

USER nonroot

WORKDIR /home/nonroot

SHELL ["/usr/bin/bash", "-c", \
	"-o", "verbose", \
	"-o", "xtrace"]

ENTRYPOINT ["/usr/bin/bash", "-c", \
	"-o", "verbose", \
	"-o", "xtrace"]

CMD ["sleep infinity"]

ARG \
	HOME='/home/nonroot' \
	WORKSPACE='/home/nonroot/workspace' \
	WORKSPACE_NAME

# Most environment variables are configured in the Dockerfile
# so they are reliably available during the build and within the resulting container,
# no matter the method of its startup or the way processes are run inside it.
ENV \
	WORKSPACE_NAME="${WORKSPACE_NAME}" \
	BAT_PAGER='ov --regexp-search --smart-case-sensitive --tab-width 2' \
	PAGER="bat --tabs 0 --italic-text always --theme 'Visual Studio Dark+' --style full" \
	GIT_PAGER='delta' \
	EDITOR='edit' \
	VISUAL='code --wait' \
	DOCKER_HOST="unix://${HOME}/docker.sock" \
	SOPS_AGE_KEY_FILE="${WORKSPACE}/.gitignore.d/age.txt" \
	GIT_CONFIG_GLOBAL="${WORKSPACE}/.gitignore.d/gitconfig" \
	AQUA_GLOBAL_CONFIG="${WORKSPACE}/.aqua/aqua.yaml" \
	AQUA_CONFIG="${WORKSPACE}/.aqua/aqua.yaml" \
	AQUA_DISABLE_LAZY_INSTALL='true' \
	AQUA_VACUUM_DAYS='40' \
	AQUA_CHECKSUM=true \
	AQUA_REQUIRE_CHECKSUM=true \
	AQUA_ENFORCE_CHECKSUM=true \
	AQUA_ENFORCE_REQUIRE_CHECKSUM=true

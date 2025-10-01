FROM docker.io/library/fedora:42

ENV \
	DO_NOT_TRACK='1' \
	NO_BROWSER='1' \
	TZ='Asia/Tokyo' \
	LC_ALL='C.UTF-8' \
	LANG='en_US.UTF-8' \
	LANGUAGE='en_US.UTF-8'

COPY ./.devcontainer/source.sh /source.sh
COPY ./.devcontainer/layers /layers

SHELL ["/source.sh"]

RUN \
	--mount=type=cache,target=/var/cache/dnf/ \
	/layers/1-base.sh

RUN \
	--mount=type=cache,target=/var/cache/dnf/ \
	--mount=type=bind,source=./.devcontainer/extra-dnf-repos.txt,destination=/extra-dnf-repos.txt \
	--mount=type=bind,source=./.devcontainer/extra-dnf-packages.txt,destination=/extra-dnf-packages.txt \
	/layers/2-dnf-extra.sh

USER nonroot

WORKDIR /home/nonroot

SHELL ["/usr/bin/bash", "-c", \
	"-o", "verbose", \
	"-o", "xtrace"]

ENTRYPOINT ["/usr/bin/bash", "-c", \
	"-o", "verbose", \
	"-o", "xtrace"]

CMD ["sleep infinity"]

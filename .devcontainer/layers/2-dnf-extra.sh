EXTRA_DNF_REPOS=$(sed 's/#.*//' /extra-dnf-repos.txt)

for repo in ${EXTRA_DNF_REPOS}; do
	xdnf copr enable "${repo}"
done

EXTRA_DNF_PACKAGES=$(sed 's/#.*//' /extra-dnf-packages.txt)

if test -n "${EXTRA_DNF_PACKAGES}"; then
	# shellcheck disable=SC2086
	xdnf install ${EXTRA_DNF_PACKAGES}
fi

# Edit `.devcontainer/extra-dnf-{repos,packages}.txt`,
# to add any additional repositories or packages you need.

remove_comment() {
	sed \
		-e 's/[[:blank:]]*#.*//' \
		-e '/^$/d' \
		"$1"
}

EXTRA_DNF_REPOS=$(remove_comment /extra-dnf-repos.txt)

for repo in ${EXTRA_DNF_REPOS}; do
	xdnf copr enable "${repo}"
done

EXTRA_DNF_PACKAGES=$(remove_comment /extra-dnf-packages.txt)

if test -n "${EXTRA_DNF_PACKAGES}"; then
	# SC2086: Double quote to prevent globbing and word splitting: We are splitting intentionally here.
	# shellcheck disable=SC2086
	xdnf install ${EXTRA_DNF_PACKAGES}
fi

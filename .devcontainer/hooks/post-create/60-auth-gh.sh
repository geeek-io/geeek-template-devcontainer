set +o xtrace
set +o verbose

GH_TOKEN_FILE=~/workspace/.gitignore.d/gh-token.env

# shellcheck disable=SC2218
if ! test -f "${GH_TOKEN_FILE}"; then
	gh_hard_logout() {
		gh auth logout || true
		rm --recursive --force ~/.cache/gh
	}

	gh_hard_logout
	echo '⚠️ GitHub authentication required.'
	gh auth login --insecure-storage --skip-ssh-key --web --git-protocol https
	_GH_TOKEN=$(gh auth token)
	gh_hard_logout
	GH_TOKEN="${_GH_TOKEN}"
	export GH_TOKEN

	echo "GH_TOKEN=${GH_TOKEN}" \
		>~/workspace/.gitignore.d/gh-token.env

	sops --encrypt --in-place ~/workspace/.gitignore.d/gh-token.env
fi

wrap_with_sops() {
	echo "sops exec-env ${HOME}/workspace/.gitignore.d/gh-token.env \"$1 $2\""
}

wrapped_sh_function() {
	WRAPPED_FUNCTION=$(wrap_with_sops "$1" '$*')
	echo "$1() {
	${WRAPPED_FUNCTION}
}"
}

WRAPPED_SH_GH=$(wrapped_sh_function gh)
eval "${WRAPPED_SH_GH}"

WRAPPED_SH_AQUA=$(wrapped_sh_function aqua)
eval "${WRAPPED_SH_AQUA}"

echo "${WRAPPED_SH_GH}" | quietee --append /etc/bashrc
echo "${WRAPPED_SH_AQUA}" | quietee --append /etc/bashrc

add_wrapped_fish_function() {
	# shellcheck disable=SC2016
	WRAPPED_FUNCTION=$(wrap_with_sops "$1" '$argv')
	echo "function $1
	${WRAPPED_FUNCTION}
end" >"${HOME}/.config/fish/functions/$1.fish"
}

add_wrapped_fish_function gh
add_wrapped_fish_function aqua

gh auth setup-git

set -o xtrace
set -o verbose

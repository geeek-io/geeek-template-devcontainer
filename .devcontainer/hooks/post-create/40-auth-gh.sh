GH_TOKEN_FILE=~/workspace/.gitignore.d/gh-token.env

if ! test -f "${GH_TOKEN_FILE}"; then
	gh_hard_logout() {
		gh auth logout \
			|| true

		rm --recursive --force ~/.cache/gh
	}

	gh_hard_logout

	set +o xtrace
	set +o verbose

	echo '⚠️ GitHub authentication required.'
	gh auth login --insecure-storage --skip-ssh-key --web --git-protocol https

	set -o xtrace
	set -o verbose

	_GH_TOKEN=$(gh auth token)
	gh_hard_logout
	GH_TOKEN="${_GH_TOKEN}"
	export GH_TOKEN

	echo "GH_TOKEN=${GH_TOKEN}" \
		> "${GH_TOKEN_FILE}"

	sops encrypt --in-place "${GH_TOKEN_FILE}"
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

echo "${WRAPPED_SH_GH}" \
	| quietee /etc/profile.d/40-alias-gh.sh

WRAPPED_SH_AQUA=$(wrapped_sh_function aqua)
eval "${WRAPPED_SH_AQUA}"

echo "${WRAPPED_SH_AQUA}" \
	| quietee /etc/profile.d/40-alias-aqua.sh

WRAPPED_SH_ACT=$(wrapped_sh_function act)
eval "${WRAPPED_SH_ACT}"

echo "${WRAPPED_SH_ACT}" \
	| quietee /etc/profile.d/40-alias-act.sh

add_wrapped_fish_function() {
	# SC2016: Expressions don't expand in single quotes: We want to keep $argv as is.
	# shellcheck disable=SC2016
	WRAPPED_FUNCTION=$(wrap_with_sops "$1" '$argv')
	echo "\
function $1
	${WRAPPED_FUNCTION}
end\
" | quietee "${HOME}/.config/fish/functions/$1.fish"
}

add_wrapped_fish_function gh
add_wrapped_fish_function aqua
add_wrapped_fish_function act

gh auth setup-git

mkdir --parents \
	~/.config/fish/conf.d/ \
	~/.config/fish/completions/

# shellcheck disable=SC2016
echo '
. "${WORKSPACE_DIR}/var.env"
export MISE_SOPS_AGE_KEY_FILE="${SOPS_AGE_KEY_FILE}"
export MISE_SOPS_AGE_RECIPIENTS="${SOPS_AGE_RECIPIENTS}"

eval "$(mise activate bash --shims)"
	' >>~/.bash_profile

# shellcheck disable=SC2016
echo '
eval "$(mise activate bash)"
	' >>~/.bashrc

# shellcheck disable=SC2016
echo '
sed -e "/^\$/d" -e "s/=/ /1" -e "s/^/set --global --export /" "$WORKSPACE_DIR/var.env" | source
set --global --export MISE_SOPS_AGE_KEY_FILE "$SOPS_AGE_KEY_FILE"
set --global --export MISE_SOPS_AGE_RECIPIENTS "$SOPS_AGE_RECIPIENTS"

mise activate fish --shims | source
mise activate fish | source
	' >~/.config/fish/conf.d/0-mise.fish

# shellcheck disable=SC2154
cd "${WORKSPACE_DIR}" || {
	echo 'cd error'
	exit 1
}

# shellcheck disable=SC1091
. "${WORKSPACE_DIR}/var.env"
# shellcheck disable=SC2154
export MISE_SOPS_AGE_KEY_FILE="${SOPS_AGE_KEY_FILE}"
# shellcheck disable=SC2154
export MISE_SOPS_AGE_RECIPIENTS="${SOPS_AGE_RECIPIENTS}"

mise install

MISE_ACTIVATE_BASH_SHIMS="$(mise activate bash --shims)"
eval "${MISE_ACTIVATE_BASH_SHIMS}"

MISE_ACTIVATE_BASH="$(mise activate bash)"
eval "${MISE_ACTIVATE_BASH}"

starship preset --output ~/.config/starship.toml no-nerd-font

echo '
starship init fish | source
	' >~/.config/fish/conf.d/starship.fish

bat --completion fish \
	>~/.config/fish/completions/bat.fish

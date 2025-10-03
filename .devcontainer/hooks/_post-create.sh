# shellcheck disable=SC1091,SC2154
. "${WORKSPACE_DIR}/var.env"

export MISE_SOPS_AGE_KEY_FILE="${SOPS_AGE_KEY_FILE}"
export MISE_SOPS_AGE_RECIPIENTS="${SOPS_AGE_RECIPIENTS}"

mise install aqua:getsops/sops

MISE_ACTIVATE_BASH_SHIMS="$(mise activate bash --shims)"
eval "${MISE_ACTIVATE_BASH_SHIMS}"

MISE_ACTIVATE_BASH="$(mise activate bash)"
eval "${MISE_ACTIVATE_BASH}"

sops exec-env "${WORKSPACE_DIR}/sec.env" 'mise install'

mise reshim --force
sudo ln -s ~/.local/share/mise/shims/* /usr/local/bin/

# shellcheck disable=SC2016
echo '
eval $(sed "s/^/export /" "${WORKSPACE_DIR}/var.env")

export MISE_SOPS_AGE_KEY_FILE="${SOPS_AGE_KEY_FILE}"
export MISE_SOPS_AGE_RECIPIENTS="${SOPS_AGE_RECIPIENTS}"

eval "$(mise activate bash --shims)"
eval "$(mise activate bash)"

mise() {
	sops exec-env ${WORKSPACE_DIR}/sec.env "mise $*"
}
	' | sudo tee --append /etc/bashrc \
	>/dev/null

# shellcheck disable=SC2016
echo '
sed -e "/^\$/d" -e "s/=/ /1" -e "s/^/set --global --export /" "$WORKSPACE_DIR/var.env" | source
set --global --export MISE_SOPS_AGE_KEY_FILE "$SOPS_AGE_KEY_FILE"
set --global --export MISE_SOPS_AGE_RECIPIENTS "$SOPS_AGE_RECIPIENTS"

mise activate fish --shims | source
mise activate fish | source
	' | sudo tee /etc/fish/conf.d/0-mise.fish \
	>/dev/null

# shellcheck disable=SC2016
echo '
function mise
	sops exec-env $WORKSPACE_DIR/sec.env "mise $argv"
end
	' | sudo tee /etc/fish/functions/mise.fish \
	>/dev/null

echo '
starship init fish | source
	' | sudo tee /etc/fish/conf.d/starship.fish \
	>/dev/null

bat --completion fish |
	sudo tee /etc/fish/completions/bat.fish \
		>/dev/null

mkdir ~/.config

starship preset --output ~/.config/starship.toml no-nerd-font

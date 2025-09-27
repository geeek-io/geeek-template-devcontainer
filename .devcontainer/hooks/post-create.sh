mkdir --parents \
	~/.config/fish/conf.d/ \
	~/.config/fish/completions/

# shellcheck disable=SC2016
echo '
eval "$(mise activate bash --shims)"
	' >>~/.bash_profile

# shellcheck disable=SC2016
echo '
eval "$(mise activate bash)"
	' >>~/.bashrc

echo '
if status is-interactive
	mise activate fish | source
end
	' >~/.config/fish/conf.d/0-mise.fish

# shellcheck disable=SC2154
cd "${WORKSPACE_FOLDER}" || {
	echo 'cd error'
	exit 1
}

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

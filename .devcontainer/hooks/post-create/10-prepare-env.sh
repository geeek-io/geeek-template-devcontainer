# Load `<workspace-root>/.var.env` for this build process,
# and also make them available to the shell.

GET_UNCOMMENTED_ENVS="\
sed\
 -e 's/[[:blank:]]*#.*//'\
 -e '/^$/d'\
 ${HOME}/workspace/.var.env\
"

GET_ENVS_BASH="\
eval \$(${GET_UNCOMMENTED_ENVS}\
 | sed 's/^/export /')\
"

eval "${GET_ENVS_BASH}"

echo "${GET_ENVS_BASH}" \
	| sudo quietee /etc/profile.d/20-env.sh

echo "\
${GET_UNCOMMENTED_ENVS}\
 | sed\
 -e 's/=/ /'\
 -e 's/^/set --global --export /'\
 | source\
" | quietee ~/.config/fish/conf.d/20-env.fish

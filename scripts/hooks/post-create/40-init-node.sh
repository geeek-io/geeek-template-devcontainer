corepack disable

if ! command -v pnpm; then
	PNPM=$(jq --raw-output '.packageManager' package.json)
	mv package.json _package.json
	npm install --no-save "${PNPM}"
	mv _package.json package.json
fi

NODE_MODULES_BIN="${PWD}/node_modules/.bin"
ADD_PATH_SH="export PATH='${NODE_MODULES_BIN}:${PATH}'"
eval "${ADD_PATH_SH}"

echo "${ADD_PATH_SH}" \
	| sudo quietee /etc/profile.d/10-node-modules.sh

echo "\
fish_add_path --global '${NODE_MODULES_BIN}'\
" | quietee ~/.config/fish/conf.d/10-node-modules.fish

pnpm install
rm --recursive --force node_modules/.ignored

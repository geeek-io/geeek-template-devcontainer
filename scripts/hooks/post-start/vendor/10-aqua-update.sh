# To install pnpm correctly, we need to disable corepack first.

if command -v corepack; then
	corepack disable
fi

aqua update-checksum --prune
aqua install --only-link

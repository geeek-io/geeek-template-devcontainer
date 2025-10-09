# To install pnpm correctly, we need to disable corepack first.
corepack disable

aqua update-checksum --prune
aqua install --only-link

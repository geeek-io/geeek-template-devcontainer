set +o xtrace
set +o verbose

# shellcheck disable=SC2154
if ! test -f "${SOPS_AGE_KEY_FILE}"; then
	echo "⚠️ age key file not found: ${SOPS_AGE_KEY_FILE}"
	echo "If a key for this repository already exists (e.g., held by another committer), place it at the path above."
	echo "Press Enter to continue. If the key is not found, a new one will be generated."
	read -r _

	if ! test -f "${SOPS_AGE_KEY_FILE}"; then
		echo "Key not found. Generating a new age key..."
		mkdir -p "$(dirname "${SOPS_AGE_KEY_FILE}")"
		age-keygen --output "${SOPS_AGE_KEY_FILE}"
		echo "Successfully generated a new key at: ${SOPS_AGE_KEY_FILE}"
		sed '/SOPS_AGE_RECIPIENTS/d' ~/workspace/.var.env
		SOPS_AGE_RECIPIENTS=$(age-keygen -y "${SOPS_AGE_KEY_FILE}")
		export SOPS_AGE_RECIPIENTS

		echo "SOPS_AGE_RECIPIENTS=${SOPS_AGE_RECIPIENTS}" \
			>>~/workspace/.var.env
	fi
fi

set -o xtrace
set -o verbose

PASS_SECRET_SERVICE_DIR=/home/nonroot/workspace/.gitignore.d/pass-secret-service

if test -d "${PASS_SECRET_SERVICE_DIR}"; then
	cd "${PASS_SECRET_SERVICE_DIR}" || exit 1
	git pull
else
	git clone \
		https://github.com/grimsteel/pass-secret-service.git \
		"${PASS_SECRET_SERVICE_DIR}"
	cd "${PASS_SECRET_SERVICE_DIR}" || exit 1
fi

cargo build --release
sudo cp ./target/release/pass-secret-service /usr/bin/pass-secret-service

cd - || true

xdnf upgrade
xdnf autoremove

xdnf copr enable jdxcode/mise

xdnf install \
	fish \
	git \
	gnupg2 \
	mise \
	ov

useradd \
	--create-home \
	--user-group \
	--groups wheel \
	nonroot

echo '
	%wheel	ALL=(ALL)	NOPASSWD: ALL
' >/etc/sudoers.d/wheel-nopasswd

chown --recursive \
	nonroot:nonroot \
	/source.sh \
	/layers

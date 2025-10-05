xdnf upgrade
xdnf autoremove

xdnf install \
	cargo \
	dbus \
	git \
	pass

useradd --create-home --user-group \
	--groups wheel \
	nonroot

echo "\
%wheel	ALL=(ALL)	NOPASSWD: ALL\
" >/etc/sudoers.d/wheel-nopasswd

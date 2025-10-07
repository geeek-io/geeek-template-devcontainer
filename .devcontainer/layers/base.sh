xdnf upgrade
xdnf autoremove

xdnf install \
	git

useradd --create-home --user-group \
	--groups wheel \
	nonroot

echo "\
%wheel	ALL=(ALL)	NOPASSWD: ALL\
" >/etc/sudoers.d/wheel-nopasswd

ln --force --symbolic \
	~/workspace

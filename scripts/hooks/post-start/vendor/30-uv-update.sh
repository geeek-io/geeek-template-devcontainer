uv --managed-python python install

uncomment .uv-tools.txt \
	| xargs -l uv --managed-python tool install

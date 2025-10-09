add_completion() {
	cat - | quietee ~/.config/fish/completions/"$1".fish
}

docker completion fish \
	| add_completion docker

aqua completion fish \
	| add_completion aqua

gh completion --shell fish \
	| add_completion gh

task --completion fish \
	| add_completion task

zizmor --completions fish \
	| add_completion zizmor

curl https://raw.githubusercontent.com/oven-sh/bun/refs/heads/main/completions/bun.fish \
	| add_completion bun

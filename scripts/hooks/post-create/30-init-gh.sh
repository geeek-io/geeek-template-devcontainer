#!/usr/bin/xbash

echo "\
gh completion --shell fish | source\
" | quietee ~/.config/fish/conf.d/gh.fish

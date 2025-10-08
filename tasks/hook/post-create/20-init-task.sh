#!/usr/bin/xbash

echo "\
task --completion fish | source\
" | quietee ~/.config/fish/conf.d/task.fish

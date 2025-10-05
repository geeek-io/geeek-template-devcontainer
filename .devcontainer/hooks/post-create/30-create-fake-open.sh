echo "\
#!/usr/bin/bash
code --openExternal \$@
" | quietee /usr/bin/xdg-open

sudo chmod a+x /usr/bin/xdg-open

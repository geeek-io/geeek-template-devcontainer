# Create a fake xdg-open that opens URLs in VS Code.
echo '#!/usr/bin/bash
code --openExternal $@
' > /usr/bin/xdg-open

chmod a+x /usr/bin/xdg-open

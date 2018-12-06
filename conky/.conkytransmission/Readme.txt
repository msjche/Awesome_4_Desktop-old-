# To make this work:
# 1) install conky
# 2) install transmission-cli and uninstall transmission-daemon if installed
# 3) in the transmission GUI, go to edit/preferences/Web-tab and enable the web client
# 4) in your ~/.conkyrc file, ABOVE the TEXT area add a line like:
#    lua_load /path/to/conkytransmission.lua
# 5) Below the TEXT area in ~/.conkyrc add a line like:
#    ${execpi 3 /path/to/conkytransmission.py}
# 6) Start conky and transmission and download some torrents!



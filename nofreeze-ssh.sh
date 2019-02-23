#!/bin/bash
set -e

echo -e "
Enter integer to set AliveInterval for
    1) client
    2) server
" 
read CHOICE

SSH_CONFIG=/etc/ssh/ssh_config
CLIENT="\n# nofreeze\nHost *\nServerAliveInterval 100\n"
SERVER="\n# nofreze\nClientAliveInterval 60\nTCPKeepAlive yes\nClientAliveCountMax 10000\n"

if [ $CHOICE -eq 1 ]; then
echo Client
if [ ! grep -qPzo $CLIENT $SSH_CONFIG ]; then
sudo echo -e $CLIENT >> $SSH_CONFIG
fi
fi

if [ $CHOICE -eq 2 ]; then
if [ ! grep -qPzo $SERVER $SSH_CONFIG ]; then
echo Server
sudo echo -e $SERVER >> $SSH_CONFIG
fi
fi

echo Done.

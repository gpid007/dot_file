#!/bin/bash
set -e

sudo echo -e "
Enter integer to set AliveInterval for
    1) Client
    2) Server
" 
read CHOICE

SSH_CONFIG=/etc/ssh/ssh_config
CLIENT="    ServerAliveInterval 100"
SERVER="# nofreze KeepAlive
ClientAliveInterval 60
TCPKeepAlive yes
ClientAliveCountMax 10000"

if [ $CHOICE -eq 1 ]; then
echo Client
if ! grep -qPzo $CLIENT $SSH_CONFIG; then
cat <<EOF | sudo tee -a $SSH_CONFIG
$CLIENT
EOF
fi
fi

if [ $CHOICE -eq 2 ]; then
if ! grep -qPzo $SERVER $SSH_CONFIG; then
echo Server
cat <<EOF | sudo tee -a $SSH_CONFIG 
$SERVER
EOF
fi
fi

echo Done.

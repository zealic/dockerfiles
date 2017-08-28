#!/bin/bash
# Run as client
CONFIG=/etc/frpc.ini
if [ -f $CONFIG ]; then
    exec /usr/local/bin/frpc -c $CONFIG
fi

# Run as server
CONFIG=/etc/frps.ini
if [ -f $CONFIG ]; then
    exec /usr/local/bin/frps -c $CONFIG
fi

# Run as server with SERVER_PORT
SERVER_PORT=${SERVER_PORT:-7000}
cat > $CONFIG <<EOF
[common]
bind_port = ${SERVER_PORT}
EOF
exec /usr/local/bin/frps -c $CONFIG

#!/bin/sh
if [ "$DEBUG" == "1" ]; then
  set -x
fi

set -e

# Create device
mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
  mknod /dev/net/tun c 10 200
fi

# Run ShadowVPN
if [ "$#" -gt 0 ]; then
  exec shadowvpn "$@"
else
  exec shadowvpn -c /etc/shadowvpn/server.conf
fi

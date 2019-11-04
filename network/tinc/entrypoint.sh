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

# Run with command
if [ "$#" -gt 0 ]; then
  exec /usr/sbin/tincd "$@"
fi

exec /usr/sbin/tincd start -D -U nobody

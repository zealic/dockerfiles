#!/bin/sh
if [ "$DEBUG" == "1" ]; then
  set -x
fi

set -e

# Create device
if [ ! -d /dev/net ]; then
  mkdir -p /dev/net
fi
if [ ! -c /dev/net/tun ]; then
  mknod /dev/net/tun c 10 200
fi

exec /usr/local/bin/tincd $@

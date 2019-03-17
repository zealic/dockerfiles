#!/bin/sh
if [ ! -e /dev/net/tun ]; then
  if [ ! -d /dev/net ]; then
    mkdir -p /dev/net
  fi
  mknod /dev/net/tun c 10 200
fi

if [[ ! -z ZEROTIER_NETWORK ]]; then
  mkdir -p /var/lib/zerotier-one/networks.d
  touch /var/lib/zerotier-one/networks.d/$ZEROTIER_NETWORK.conf
fi

exec /usr/local/bin/zerotier-one

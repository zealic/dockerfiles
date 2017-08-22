#!/bin/bash
if [ "$DEBUG" == "1" ]; then
  set -x
fi

set -e

ARGS=("--config" "$OPENVPN/openvpn.conf")
if [ -e "$OPENVPN/env.sh" ]; then
  source "$OPENVPN/env.sh"
fi

# Create device
mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
  mknod /dev/net/tun c 10 200
fi

# Run OpenVPN
if [ "$#" -gt 0 ]; then
  exec openvpn "$@"
else
  exec openvpn ${ARGS[@]}
fi

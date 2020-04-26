#!/bin/sh
if [ "$DEBUG" == "1" ]; then
  set -x
fi

set -e

exec /usr/local/bin/udp2raw $@

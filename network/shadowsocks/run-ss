#!/bin/bash
SS_PROGRAM=/usr/local/bin/ss-server

ARGS=(
  "-u"
  "-s" "${SERVER_ADDR:-0.0.0.0}"
  "-p" "${SERVER_PORT:-8388}"
  "-k" "${PASSWORD:-$(hostname)}"
  "-m" "${METHOD:-aes-256-cfb}"
  "-t" "${TIMEOUT:-60}"
  "-d" "${DNS_ADDR:-8.8.4.4}"
)

if [[ "$#" -gt 0 ]]; then
  exec $SS_PROGRAM "$@"
else
  exec $SS_PROGRAM ${ARGS[@]}
fi

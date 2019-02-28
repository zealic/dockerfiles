#!/bin/sh
FILECOIN_DATA_DIR=${FILECOIN_DATA_DIR:-/var/lib/filecoin}
NICKNAME=

set -e

# Initialize
INIT_OPTS=
if [[ ! -z $TESTNET ]]; then
  INIT_OPTS="$INIT_OPTS --genesisfile=http://user.kittyhawk.wtf:8020/genesis.car"
fi
ln -sf $FILECOIN_DATA_DIR/ ~/.filecoin
if [[ ! -e $FILECOIN_DATA_DIR/config.json ]]; then
  go-filecoin init $INIT_OPTS
fi


# Configure
# Add to monitoring https://stats.kittyhawk.wtf
if [[ ! -z $TESTNET ]]; then
  : go-filecoin config heartbeat.beatTarget "/dns4/stats-infra.kittyhawk.wtf/tcp/8080/ipfs/QmUWmZnpZb6xFryNDeNU7KcJ1Af5oHy7fB9npU67sseEjR"
fi
if [[ ! -z $NICKNAME ]]; then
  NICKNAME=$HOSTNAME
fi
: go-filecoin config heartbeat.nickname "$NICKNAME"

# Exec daemon
exec /usr/local/bin/go-filecoin $@

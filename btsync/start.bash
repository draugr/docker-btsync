#!/bin/bash

BITSYNC="/bitsync"
OVERRIDE="/btsync-override"

CONFIG="btsync.conf"
SHARES="shares"
echo "declared variables"

# Symlink data directory.
mkdir -p "$OVERRIDE/$SHARES"
rm -fr "$SHARES"
ln -s "$OVERRIDE/$SHARES" "$SHARES"
echo "symlinked datadir"

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
fi
echo "symlinked config"

# Start btsync
chown -R btsync:btsync /data /bitsync /btsync-override
echo "chownd"
su btsync << EOF
cd "$BITSYNC"
pwd
echo "starting deamon"
/btsync --nodaemon --config /data/btsync.conf
EOF

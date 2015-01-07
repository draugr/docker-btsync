#!/bin/bash

BITSYNC="/bitsync"
OVERRIDE="/btsync-override"

CONFIG="btsync.conf"
SHARES="shares"
echo -n "declared variables"

cd "$BTSYNC"

# Symlink data directory.
mkdir -p "$OVERRIDE/$SHARES"
rm -fr "$SHARES"
ln -s "$OVERRIDE/$SHARES" "$SHARES"
echo -n "symlinked datadir"

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
fi
echo -n "symlinked config"

# Start btsync
chown -R btsync:btsync /data /bitsync /btsync-override
echo -n "chownd"
su btsync << EOF
cd "$BITSYNC"
/btsync --nodaemon --config /data/btsync.conf
EOF

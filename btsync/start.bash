#!/bin/bash

BTSYNC="/btsync"
OVERRIDE="/btsync-override"

CONFIG="btsync.conf"
SHARES="shares"


cd "$BTSYNC"

# Symlink data directory.
mkdir -p "$OVERRIDE/$SHARES"
rm -fr "$SHARES"
ln -s "$OVERRIDE/$SHARES" "$SHARES"


# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
fi


# Start Ghost
chown -R btsync:btsync /data /btsync /btsync-override
su btsync << EOF
cd "$BTSYNC"
/btsync --nodaemon --config /data/btsync.conf
EOF

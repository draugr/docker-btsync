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
echo "symlinked datadir:"
echo "$OVERRIDE/$SHARES -> $SHARES"

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
  echo "config overridden:"
  echo "$OVERRIDE/$CONFIG -> $CONFIG"
fi

# Start btsync
chown -R btsync:btsync /data /bitsync /btsync-override
echo "chownd"
su btsync << EOF
echo "switched user to btsync"
cd "$BITSYNC"
pwd
ls -la
echo "starting deamon"
/btsync --nodaemon --config /bitsync/btsync.conf
EOF

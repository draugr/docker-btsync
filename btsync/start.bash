#!/bin/bash

BITSYNC="/bitsync"
OVERRIDE="/btsync-override"

CONFIG="btsync.conf"
SHARES="shares"
MISCFILES="misc"
ls -la
# Symlink data directory.
mkdir -p "$OVERRIDE/$SHARES"
rm -fr "$SHARES"
ln -s "$OVERRIDE/$SHARES" "$SHARES"
echo "symlinked datadir:"
echo "$OVERRIDE/$SHARES -> $SHARES"

# Symlink MISCFILES directory.
mkdir -p "$OVERRIDE/$MISCFILES"
rm -fr "$MISCFILES"
ln -s "$OVERRIDE/$MISCFILES" "$MISCFILES"
echo "symlinked MISCFILES:"
echo "$OVERRIDE/$MISCFILES -> $MISCFILES"


# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
  echo "config overridden:"
  echo "$OVERRIDE/$CONFIG -> $CONFIG"
fi
ls -la
# Start btsync
chown -R btsync:btsync /bitsync /btsync-override
echo "chownd:"
ls -la
su btsync << EOF
echo "switched user to btsync"
cd "$BITSYNC"
pwd
ls -la
echo "starting deamon"
/btsync --nodaemon --config /bitsync/btsync.conf
EOF

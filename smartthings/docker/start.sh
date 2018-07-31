#!/usr/bin/env sh

set -e

rm -rf $MOUNT_VOL/config.yml
cp $MOUNT_CFG/config.yml $MOUNT_VOL/

CONFIG_DIR=$MOUNT_VOL npm start
#!/usr/bin/env bash

# https://github.com/open-estuary/test-definitions/blob/5c0aa273e8/auto-test/apps/server/lemp/test.sh

### ubuntu
packages1=`apt list --installed | grep -i "qt5-default"| awk -F '/' '{print $1}'`

### alpine
packages1=`apk info | grep -i "zlib" | awk -F '/' '{print $1}'`
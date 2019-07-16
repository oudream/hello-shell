#!/usr/bin/env bash

npm install -f packages-win32.json

# 您还可以通过以下方式嗅出操作系统：
# nodejs:
# const _isWin = /^win/.test( process.platform )

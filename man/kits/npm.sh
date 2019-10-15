#!/usr/bin/env bash

npm install -f packages-win32.json

# 您还可以通过以下方式嗅出操作系统：
# nodejs:
# const _isWin = /^win/.test( process.platform )

### 安装 32位
# 需要编译的
node-gyp clean configure build --verbose --arch=ia32
#方式一：直接 npm 安装
npm install --arch=ia32 electron@1.4.14
#方式二：配置 .npmrc
#arch=ia32
#registry=https://registry.npm.taobao.org
#方式三：配置 package.json
#{
#  "config": {
#    "arch": "ia32",
#    "registry": "https://registry.npm.taobao.org"
#  },
#  "devDependencies": {
#    "electron": "1.4.14"
#  }
#}